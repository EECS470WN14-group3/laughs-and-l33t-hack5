#!/usr/bin/env sh
################################################################################
## GNU Parallel - Local Install Script ...  ?'s --> @knksmith57               ##
################################################################################

_install() {
  # going to install GNU parallel into ~/.local, so make that directory
  mkdir -p $HOME/.local
  cd $HOME/.local

  # download the binary from the wayne mirror
  wget -O gnu-parallel.tar.bz2 http://ftp.wayne.edu/gnu/parallel/parallel-20100424.tar.bz2

  # extract the archive
  tar -xjvf gnu-parallel.tar.bz2
  cd "$(find . -name "configure*" | head -1 | xargs -I {} dirname {})"

  # configure the build and install
  ./configure --prefix=$HOME/.local
  make
  make install

  # add this new local bin to $PATH
  echo "PATH=\$PATH:\$HOME/.local/bin" >> $HOME/.profile
}

main() {
  # first make sure parallels isn't already installed
  local parallelBinary="$(which parallel 2> /dev/null)"
  if (( $? )); then
    _install;
  else
    echo "GNU Parallel is already installed! (${parallelBinary})"
    exit 1
  fi

  cat <<'EOT'

# now you can use parallel to run things IN PARALLEL HOLY SHIT DUDE
# ie:
parallel "echo {}" ::: 1 2 3 4 5 6 7 8 9 10

# outputs 1-10 in some super random order...

EOT
}

main "$@"
