/*-------------------------------------------------------------------*
 | Searches for keywords in an audio file. Both are specified as     |
 | command line arguments (run the program with no arguments for     |
 | more information).                                                |
 *-------------------------------------------------------------------*/

#include <stdio.h>  // printf(), puts()
#include "pocketsphinx.h"

/*--------------------------------------------------------------------*
 * Shows how to use this program, which has the specified name.
 */

static void usage(char *program_name) {
    puts("DESCRIPTION\n"
         "\tSearches for keywords in a raw audio file according to their "
         "threshold values.\n");

    printf("USAGE\n"
           "\t%s <sound file> <keywords file>\n\n", program_name);

    puts("ARGUMENTS\n"
         "\tsound file: A 16 bit, 16000Hz sound file to be read.\n"
         "\tkeywords file: File containing keywords and their thresholds.\n\n"
         "\tExample of keywords file (threshold values must be between '/' "
         "characters):\n"
         "\t\tup/1e-2/\n"
         "\t\tdown/1e-5/\n"
         "\t\tleft/1e-5/\n"
         "\t\tright/1e-6/");
}

/*--------------------------------------------------------------------*/

int main(int argc, char *argv[]) {
    ps_decoder_t *decoder = NULL;
    cmd_ln_t *config = NULL;

    int16 buf[512];
    int score;
    const char *hyp = NULL;

    if (argc < 3) {
        usage(argv[0]);
        return EXIT_FAILURE;
    }

    // Create basic configuration object
    config = cmd_ln_init(NULL,
                         ps_args(),
                         TRUE,
                         "-hmm", MODELDIR "/en-us/en-us",
                         "-dict", MODELDIR "/en-us/cmudict-en-us.dict",
                         "-kws", argv[2],
                         NULL);

    decoder = ps_init(config);
    ps_start_utt(decoder);

    FILE *fh = fopen(argv[1], "r");

    // Listen for keywords while audio file isn't over
    while (TRUE) {
        size_t nsamp;
        nsamp = fread(buf, 2, 512, fh);

        // Process read sound
        if (nsamp) ps_process_raw(decoder, buf, nsamp, FALSE, FALSE);
        else break;

        // Check if a word was recognized
        hyp = ps_get_hyp(decoder, &score);
        if (hyp != NULL) {
            printf("Keyword found: '%s'\n", hyp);
            ps_end_utt(decoder);
            ps_start_utt(decoder);
        }
    }

    fclose(fh);
    ps_end_utt(decoder);

    ps_free(decoder);
    cmd_ln_free_r(config);

    return 0;
}
