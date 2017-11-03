# Deletar a maioria dos arquivos/diretórios supérfluos de Sphinxbase
$ find . -not -name "src" \
  -a -not -name "include" \
  -a -not -wholename "./src/libpocketsphinx*" \
  -a -not -wholename "./include*" \
  -a -not -name "LICENSE" \
  -delete

# Como sobra apenas um diretório dentro de src/, movemos seu conteúdo
$ mv src/libpocketsphinx/* src && rmdir src/libpocketsphinx

# Eliminar arquivos supérfluos restantes
$ find "src" "include" -name "Makefile*" -delete \
  -o -name "*.in" -delete
