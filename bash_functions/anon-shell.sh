
function anon-shell {
    echo  "You are now off record."

    bash --rcfile $ENV_SETUP_DIR/no_history.sh

    echo  "Exiting anonymous shell."
}