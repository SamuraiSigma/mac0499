#include <stdio.h>
#include <stdlib.h>
#include "pocketsphinx.h"

int main(int argc, char *argv[]) {
    ps_decoder_t *ps = NULL;  // Decoder
    cmd_ln_t *config = NULL;  // Configuration object
    int score;

    if (argc < 2) {
        printf("Must specify a 16 bit, 16000Hz audio file as an argument!\n");
        exit(1);
    }

    config = cmd_ln_init(NULL,
                         ps_args(),
                         TRUE,
                         "-hmm", MODELDIR "/en-us/en-us",
                         "-lm", MODELDIR "/en-us/en-us.lm.bin",
                         "-dict", MODELDIR "/en-us/cmudict-en-us.dict",
                         NULL);

    ps = ps_init(config);
    ps_start_utt(ps);

    int16 buf[512];
    FILE *fh = fopen(argv[1], "r");
    while (!feof(fh)) {
        size_t nsamp;
        nsamp = fread(buf, 2, 512, fh);
        ps_process_raw(ps, buf, nsamp, FALSE, FALSE);
    }
    fclose(fh);

    ps_end_utt(ps);

    const char *hyp = ps_get_hyp(ps, &score);
    printf("Recognized: %s (score = %d)\n", hyp, score);

    // Free decoder configuration objects
    ps_free(ps);
    cmd_ln_free_r(config);

    return 0;
}
