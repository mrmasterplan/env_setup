
if [ x"$LOCALNAME" == x"SIMON_MBP" ]; then
    function froot {
        ssh -X -Y -t fend02 "source ~/.bashrc; module load hep root; root -l $@"
    }
fi