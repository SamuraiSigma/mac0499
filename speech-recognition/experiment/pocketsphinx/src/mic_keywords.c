/*-------------------------------------------------------------------*
 | Continuously reads data from the microphone, checking if any      |
 | words said match keywords from a file. This keywords file must be |
 | specified as the first argument of the program.                   |
 |                                                                   |
 | Uses the default microphone if no command line argument is        |
 | used. If the user wishes to use a different microphone, it        |
 | must be specified as the first argument of the program.           |
 |                                                                   |
 | For more details on how to use the program, run it with no        |
 | arguments.                                                        |
 |                                                                   |
 | Based on Pocketsphinx source code, available on GitHub:           |
 | /cmusphinx/pocketsphinx/blob/master/src/programs/continuous.c     |
 *-------------------------------------------------------------------*/

#include <stdio.h>   // printf(), puts()

#if defined(_WIN32) && !defined(__CYGWIN__)
#include <windows.h>     // Sleep()
#else
#include <sys/select.h>  // select()
#endif

#include "sphinxbase/err.h"
#include "sphinxbase/ad.h"
#include "pocketsphinx.h"

// Microphone recorder buffer size
#define BUFFER_SIZE 2048

// Time, in msecs, to wait before listening to microphone again
#define SLEEP_TIME 100

/*
 * Adds the -adcdev option as a possible command line argument.
 * This argument corresponds to the microphone name.
 */
static arg_t cont_args_def[] = {
    POCKETSPHINX_OPTIONS,
    // Microphone
    {"-adcdev",
     ARG_STRING,
     NULL,
     "Name of audio device to use for input."},
    CMDLN_EMPTY_OPTION
};

/*--------------------------------------------------------------------*
 * Shows how to use this program, which has the specified name.
 */

static void usage(char *program_name) {
    puts("DESCRIPTION\n"
         "\tContinuously reads data from the microphone, checking if any words "
         "said match keywords from a file.\n");

    printf("USAGE\n"
           "\t%s <keywords file> [mic name]\n\n", program_name);

    puts("ARGUMENTS\n"
         "\tkeywords file: File containing keywords and their thresholds.\n"
         "\tmic name: If not specified, uses default system microphone.\n\n"
         "\tExample of keywords file (threshold values must be between '/' "
         "characters):\n"
         "\t\tup/1e-2/\n"
         "\t\tdown/1e-5/\n"
         "\t\tleft/1e-5/\n"
         "\t\tright/1e-6/");
}

/*--------------------------------------------------------------------*
 * Creates and returns a Pocketsphinx configuration object, which is
 * used for initializing other variables from the library. If an error
 * occurs, returns NULL.
 */

static cmd_ln_t *init_config(int argc, char *argv[]) {
    // Create basic configuration object
    cmd_ln_t *config = cmd_ln_init(NULL, ps_args(), TRUE,
                                   "-hmm", MODELDIR "/en-us/en-us",
                                   "-dict", MODELDIR "/en-us/cmudict-en-us.dict",
                                   "-kws", argv[1],
                                   NULL);

    if (config == NULL) {
        E_FATAL("Failed to create configuration object!\n");
        return NULL;
    }

    // Update basic configuration with custom one for mic
    config = cmd_ln_init(config, cont_args_def, TRUE, NULL);
    if (config == NULL) {
        E_FATAL("Failed to create configuration object!\n");
        return NULL;
    }

    if (argc >= 3) {
        // If specified, use custom microphone from command line
        cmd_ln_set_str_r(config, "-adcdev", argv[2]);
    }

    return config;
}

/*--------------------------------------------------------------------*
 * Creates and returns a Pocketsphinx sound recorder object by using
 * a configuration variable. If an error occurs, returns NULL.
 */

static ad_rec_t *init_recorder(cmd_ln_t *config) {
    ad_rec_t *recorder = ad_open_dev(cmd_ln_str_r(config, "-adcdev"),
                                     (int) cmd_ln_float32_r(config, "-samprate"));

    if (recorder == NULL)
        E_FATAL("Failed to open audio device!\n");

    return recorder;
}

/*--------------------------------------------------------------------*
 * Creates and returns a Pocketsphinx sound decoder object by using a
 * configuration variable. If an error occurs, returns NULL.
 */
static ps_decoder_t *init_decoder(cmd_ln_t *config) {
    ps_decoder_t *decoder = ps_init(config);

    if (decoder == NULL)
        E_FATAL("Failed to create decoder!\n");

    return decoder;
}

/*--------------------------------------------------------------------*
 * Makes the program sleep for the specified number of msecs.
 */

static void msleep(int32 ms) {
// Windows
#if (defined(_WIN32) && !defined(GNUWINCE)) || defined(_WIN32_WCE)
    Sleep(ms);

// Unix
#else
    struct timeval tmo;

    tmo.tv_sec = 0;
    tmo.tv_usec = ms * 1000;

    select(0, NULL, NULL, NULL, &tmo);
#endif
}

/*--------------------------------------------------------------------*
 * Continously obtains input from the user's microphone, converting it
 * to text. Uses a previously created recorder and decoder objects for
 * this task.
 *
 * The function ends if the special end string (END_STR) is recognized,
 * or if an error occurs.
 */

static int mic_loop(ad_rec_t *recorder, ps_decoder_t *decoder) {
    int16 buffer[BUFFER_SIZE];
    uint8 utt_started;
    int32 n;

    int score;
    const char *hyp;

    // Start recording
    if (ad_start_rec(recorder) < 0) {
        E_FATAL("Failed to start recording\n");
        return EXIT_FAILURE;
    }

    // Start utterance
    if (ps_start_utt(decoder) < 0) {
        E_FATAL("Failed to start utterance\n");
        return EXIT_FAILURE;
    }

    utt_started = FALSE;
    puts("Ready (press Ctrl+C to exit)...");

    while (TRUE) {
        // Read data from microphone
        if ((n = ad_read(recorder, buffer, BUFFER_SIZE)) < 0) {
            E_FATAL("Failed to read audio\n");
            return EXIT_FAILURE;
        }

        // Process captured sound
        ps_process_raw(decoder, buffer, n, FALSE, FALSE);

        // If speech was captured while in silent state, start new utterance
        if (ps_get_in_speech(decoder) && !utt_started) {
            utt_started = TRUE;
            puts("Listening...");
        }

        // Speech stopped while in an utterance
        if (!ps_get_in_speech(decoder) && utt_started) {
            // End this utterance phase
            ps_end_utt(decoder);

            // Show hypothesis (what was said in microphone)
            hyp = ps_get_hyp(decoder, &score);
            if (hyp != NULL) {
                printf(">> %s (score = %d)\n", hyp, score);
            }

            // Start new utterance
            if (ps_start_utt(decoder) < 0) {
                E_FATAL("Failed to start utterance!\n");
                return EXIT_FAILURE;
            }
            utt_started = FALSE;
            puts("Ready (press Ctrl+C to exit)...");
        }

        // Wait msecs until next microphone input is captured
        msleep(SLEEP_TIME);
    }

    // Stop recording
    if (ad_stop_rec(recorder) < 0) {
        E_FATAL("Failed to stop recording\n");
        return EXIT_FAILURE;
    }

    return EXIT_SUCCESS;
}

/*-------------------------------------------------------------------*/

int main(int argc, char *argv[]) {
    cmd_ln_t *config;
    ad_rec_t *recorder;
    ps_decoder_t *decoder;

    // No Pocketsphinx-related output
    // err_set_logfp(NULL);

    if (argc < 2) {
        usage(argv[0]);
        return EXIT_FAILURE;
    }

    if ((config = init_config(argc, argv)) == NULL)
        return EXIT_FAILURE;

    if ((recorder = init_recorder(config)) == NULL) {
        cmd_ln_free_r(config);
        return EXIT_FAILURE;
    }

    if ((decoder = init_decoder(config)) == NULL) {
        ad_close(recorder);
        cmd_ln_free_r(config);
        return EXIT_FAILURE;
    }

    mic_loop(recorder, decoder);

    ad_close(recorder);
    ps_free(decoder);
    cmd_ln_free_r(config);

    return 0;
}
