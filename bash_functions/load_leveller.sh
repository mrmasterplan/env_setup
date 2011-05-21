
if [ ! -z "$(which llq 2>/dev/null)" ]
then
	alias myllq="llq -f %id %jn %dq %st %c %h -u simonhe | grep -v CA"
fi