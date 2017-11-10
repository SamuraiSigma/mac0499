void mic_loop() {
    int buffer[BUFFER_SIZE];
    bool utt_started = false;
    int n;

    ad_start_rec(recorder);
    ps_start_utt(decoder);

    puts("Ready (press Ctrl+C to exit)...");

    while (true) {
        // n stores how much data was read
        n = ad_read(recorder, buffer, BUFFER_SIZE);
        ps_process_raw(decoder, buffer, n, false, false);

        // If speech was captured during silence, start new utterance
        if (ps_get_in_speech(decoder) && !utt_started) {
            utt_started = true;
            puts("Listening...");
        }

        // Speech stopped while in an utterance
        if (!ps_get_in_speech(decoder) && utt_started) {
            ps_end_utt(decoder);

            hyp = ps_get_hyp(decoder, NULL);
            if (hyp != NULL) {
                printf(">> %s\n", hyp);
            }

            ps_start_utt(decoder);
            utt_started = false;
            puts("Ready (press Ctrl+C to exit)...");
        }
    }

    ad_stop_rec(recorder);
}
