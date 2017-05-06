#include <stdio.h>
#include <stdlib.h>
#include "pocketsphinx.h"

int main(int argc, char *argv[]) {
    ps_decoder_t *decoder = NULL;  // Decoder
    cmd_ln_t *config = NULL;       // Configuration object
    int score;

    if (argc < 2) {
        puts("DESCRIPTION\n"
             "\tPerforms a speech to text operation on a raw audio file.\n");
        printf("USAGE\n"
               "\t%s <sound file>\n\n", argv[0]);
        puts("ARGUMENTS\n"
             "\tsound file: A 16 bit, 16000Hz sound file to be read.");
        exit(1);
    }

    config = cmd_ln_init(NULL,
                         ps_args(),
                         TRUE,
                         "-hmm", MODELDIR "/en-us/en-us",
                         "-lm", MODELDIR "/en-us/en-us.lm.bin",
                         "-dict", MODELDIR "/en-us/cmudict-en-us.dict",
                         NULL);

    decoder = ps_init(config);
    ps_start_utt(decoder);

    int16 buf[512];
    FILE *fh = fopen(argv[1], "r");
    while (!feof(fh)) {
        size_t nsamp;
        nsamp = fread(buf, 2, 512, fh);
        ps_process_raw(decoder, buf, nsamp, FALSE, FALSE);
    }
    fclose(fh);

    ps_end_utt(decoder);

    const char *hyp = ps_get_hyp(decoder, &score);
    printf("Recognized: %s (score = %d)\n", hyp, score);

    // Free decoder configuration objects
    ps_free(decoder);
    cmd_ln_free_r(config);

    return 0;
}
