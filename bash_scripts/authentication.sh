
ck () {
   echo "Authenticating CERN Kerberos, supply password: "
   read -s pass 
   kdestroy -q
   echo ${pass} | kinit heisterk@CERN.CH
   echo ${pass} | klog heisterk@CERN.CH

}

nk () {
   echo "Authenticating NBI Kerberos"
   kdestroy -q
   kinit simonhe@NBI.KU.DK
}