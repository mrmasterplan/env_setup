

function setup_arc {
    #    source /Applications/ARC.app/Contents/MacOS/arc-client-setup.sh
    # Set the ARC_LOCATION environment variable. Needed since ARC is installed in a non default location.
    export ARC_LOCATION="/Applications/ARC.app/Contents/MacOS/"

    # Include path to ARC client executables in PATH environment variable. Also add path to the Python executable which was linked against.
    export PATH="${ARC_LOCATION}/bin:${PATH}"
    # export PATH="${ARC_LOCATION}/bin:/System/Library/Frameworks/Python.framework/Versions/2.6/bin:${PATH}"

    # Set the ARC_PLUGIN_PATH enviroment path to the location of ARC modules.
    export ARC_PLUGIN_PATH="${ARC_LOCATION}/lib/arc"
    # For the ARC Globus modules to work the GLOBUS_LOCATION environment variable need to be set. 
    export GLOBUS_LOCATION="${ARC_LOCATION}"
    # For the ARC Python bindings to work the PYTHONPATH need to be set.
    export PYTHONPATH="${ARC_LOCATION}/lib/python2.6/site-packages"
    # Set the path to the directory containing CA Certificates
    export X509_CERT_DIR="${ARC_LOCATION}/etc/grid-security/certificates"

}

function gridenv {
	export X509_CERT_DIR="$(dirname "$(which arcproxy)")/../etc/grid-security/certificates/"
	export X509_USER_PROXY=$(arcproxy -I 2>/dev/null|grep ^Proxy | head -1 |sed 's/Proxy .*: //')
}