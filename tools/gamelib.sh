ThisFileDirectory="$(cd "$(dirname "$0")" ; pwd -P)"
EXECUTE_DIR=`pwd`
setSYS_NAME() {
    case $(uname | tr '[:upper:]' '[:lower:]') in
    linux*)
        SYS_NAME=linux ;;
    darwin*)
        SYS_NAME=osx ;;
    msys*)
        SYS_NAME=windows ;;
    mingw*)
        SYS_NAME=windows ;;
    *)
        SYS_NAME=notset ;;
    esac
}
setSYS_NAME

if [ "${SYS_NAME}" = "windows" ]; then
  PYTHON=PY
  SCRIPT_PATH="$ThisFileDirectory/internal/windows"
  if ! which python3 >&/dev/null; then
    msg="ERROR: This script requires python3. See https://www.python.org/downloads/windows/ for installation instructions."
    echo "$(tput setaf 1)$msg$(tput sgr0)" >&2
    exit 1
  fi
else
  PYTHON=python3
  SCRIPT_PATH="$ThisFileDirectory/internal/mobile"
  if ! which python3 >&/dev/null; then
  if ! which brew >&/dev/null; then
    msg="ERROR: This script requires brew. See https://brew.sh for installation instructions."
    echo "$(tput setaf 1)$msg$(tput sgr0)" >&2
    exit 1
  fi
  echo "Installing python3"
  brew install python >&/dev/null
  fi
fi

cd "$SCRIPT_PATH"
PIPENV_IS_NOT_EXISTS=`$PYTHON -m pipenv |& grep -q "No module named" && echo 'not exists' || echo ''`
if [ -n "$PIPENV_IS_NOT_EXISTS" ]; then
 $PYTHON -m pip install pipenv
fi
FIRE_IS_NOT_EXISTS=`$PYTHON -m pipenv run python -m fire |& grep -q "No module named" && echo 'not exists' || echo ''`
echo $FIRE_IS_NOT_EXISTS
if [ -n "$FIRE_IS_NOT_EXISTS" ]; then
 echo "Not found dependencies modules"
 $PYTHON -m pipenv --rm
 $PYTHON -m pipenv install
fi

if printf '%s\n' $@ | grep -q 'help'; then
  `WGINTER=1 DEVELOP="$DEVELOP" EXECUTE_DIR="$EXECUTE_DIR" $PYTHON -m pipenv run python "./gamelib.sh" $@`
  exit 0
fi

WGINTER=1 DEVELOP="$DEVELOP" EXECUTE_DIR="$EXECUTE_DIR" $PYTHON -m pipenv run python "./gamelib.sh" $@
