# Deletar a maioria dos arquivos/diretórios supérfluos de Sphinxbase
$ find . -not -name "src" \
  -a -not -name "include" \
  -a -not -wholename "./src/libsphinxbase*" \
  -a -not -wholename "./src/libsphinxad*" \
  -a -not -wholename "./include*" \
  -a -not -name "LICENSE" \
  -delete

# Eliminar arquivos supérfluos restantes
$ find "src" "include" -name "Makefile*" -delete \
  -o -name "*.in" -delete
