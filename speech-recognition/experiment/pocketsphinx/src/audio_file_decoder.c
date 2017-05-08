/*-------------------------------------------------------------------*
 | Performs a speech to text operation on an audio file, which is    |
 | specified as a command line argument. For more information, run   |
 | the program with no arguments.                                    |
 *-------------------------------------------------------------------*/

#include <stdio.h>  // printf(), puts()
#include "pocketsphinx.h"

/*--------------------------------------------------------------------*
 * Shows how to use this program, which has the specified name.
 */

static void usage(char *program_name) {
    puts("DESCRIPTION\n"
         "\tPerforms a speech to text operation on a raw audio file.\n");

    printf("USAGE\n"
           "\t%s <sound file>\n\n", program_name);

    puts("ARGUMENTS\n"
         "\tsound file: A 16 bit, 16000Hz sound file to be read.");
}

/*--------------------------------------------------------------------*/

int main(int argc, char *argv[]) {
    ps_decoder_t *decoder = NULL;
    cmd_ln_t *config = NULL;
    int16 buf[512];
    int score;

    if (argc < 2) {
        usage(argv[0]);
        return EXIT_FAILURE;
    }

    // Create basic configuration object
    config = cmd_ln_init(NULL,
                         ps_args(),
                         TRUE,
                         "-hmm", MODELDIR "/en-us/en-us",
                         "-lm", MODELDIR "/en-us/en-us.lm.bin",
                         "-dict", MODELDIR "/en-us/cmudict-en-us.dict",
                         NULL);

    decoder = ps_init(config);
    ps_start_utt(decoder);

    FILE *fh = fopen(argv[1], "r");

    // Perform speech to text while audio file isn't over
    while (!feof(fh)) {
        size_t nsamp;
        nsamp = fread(buf, 2, 512, fh);

        // Process read sound
        ps_process_raw(decoder, buf, nsamp, FALSE, FALSE);
    }

    fclose(fh);
    ps_end_utt(decoder);

    // Output understood text from audio file
    const char *hyp = ps_get_hyp(decoder, &score);
    printf("Recognized: %s (score = %d)\n", hyp, score);

    ps_free(decoder);
    cmd_ln_free_r(config);

    return 0;
}
