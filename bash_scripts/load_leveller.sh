
if [ ! -z "$(which llq)" ]
then
	alias myllq="llq -f %id %jn %dq %st %c %h -u simonhe | grep -v CA"
fi