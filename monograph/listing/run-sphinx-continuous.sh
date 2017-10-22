# Diretório contendo arquivos para reconhecimento de voz (modelos, etc.)
MODELDIR=pocketsphinx/model

./pocketsphinx/src/programs/pocketsphinx_continuous \
-inmic yes \                                 # Acionar uso do microfone
-hmm   $MODELDIR/en-us/en-us/mdef \          # Diretório do modelo acústico
-dict  $MODELDIR/en-us/cmudict-en-us.dict \  # Arquivo do dicionário
-lm    $MODELDIR/en-us/en-us.lm.bin          # Arquivo do modelo da língua
