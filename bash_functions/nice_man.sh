pman () {
    man -t "${1}" | open -f -a /Applications/Preview.app
}
tman () {
  MANWIDTH=160 MANPAGER='col -bx' man $@ | mate
}