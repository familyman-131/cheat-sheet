#delete all between ''
sed "s/.*'\(.*\)'.*/\1/g"
#delete empty lines
sed '/^\s*$/d'
#delete tabs at beginning of the line
sed 's/[ \t]*//')
#delete spaces
sed 's/ //g'
