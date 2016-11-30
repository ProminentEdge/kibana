#! /bin/bash
# exit if anything returns failure
set -e

# return 1 if global command line program installed, else 0
function program_is_installed {
  # set to 1 initially
  local return_=1
  # set to 0 if not found
  type $1 >/dev/null 2>&1 || { local return_=0; }
  # return value
  echo "$return_"
}

function run {
  if [ `program_is_installed 'fpm'` -eq "0" ]; then
    echo "  Error: fpm is not installed. You can install it by running 'sudo gem install fpm -g'"
    exit;
  fi

  if [ `program_is_installed 'pleaserun'` -eq "0" ]; then
    echo "  Error: pleaserun is not installed. You can install it by running 'sudo gem install pleaserun -g'"
    exit;
  fi

  if [ `program_is_installed 'gnu-tar'` -eq "0" ]; then
    echo "  Error: gnu-tar is not installed. You can install it by running 'sudo gem install gnu-tar -g'"
    exit;
  fi

  # build the deb package
  npm run build -- --deb

  #TODO push kibana/target/kibana-5.0.1-SNAPSHOT-amd64.deb to S3 files.prominentedge.com bucket

}

run