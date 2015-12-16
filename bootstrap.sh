#!/bin/sh

REPO_ROBOTO="https://github.com/google/roboto.git"
REPO_SOURCE_SANS_PRO="https://github.com/adobe-fonts/source-sans-pro/archive/2.020R-ro/1.075R-it.tar.gz"
REPO_SOURCE_SERIF_PRO="https://github.com/adobe-fonts/source-serif-pro/archive/1.017R.tar.gz"
REPO_SOURCE_CODE_PRO="https://github.com/adobe-fonts/source-code-pro/archive/2.010R-ro/1.030R-it.tar.gz"
REPO_SOURCE_HAN_SANS="https://github.com/adobe-fonts/source-han-sans/archive/1.004R.tar.gz"

SYSTEM=`uname -s`

if [ "x$SYSTEM" == "xDarwin" ]; then
  SCRIPTPATH=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd)
else
  SCRIPTPATH=$(dirname $(readlink -f "$0"))
fi

TMPDIR=`mktemp -d`
FONTDIR="${SCRIPTPATH}/fonts"

mkdir -p $FONTDIR || exit 1

trap "{ cd -; rm -rf $TMPDIR; exit 255; }" SIGINT

cd $TMPDIR  # switch to temp dir
echo "Change to ${TMPDIR}"

# Get Google Roboto fonts
git clone ${REPO_ROBOTO}
cp -f roboto/out/*/*.ttf ${FONTDIR}

# Get Adobe Source Sans Pro
curl -L ${REPO_SOURCE_SANS_PRO} | tar zx
cp -f source-sans-pro-*/OTF/*.otf ${FONTDIR}

# Get Adobe Source Serif Pro
curl -L ${REPO_SOURCE_SERIF_PRO} | tar zx
cp -f source-serif-pro-*/OTF/*.otf ${FONTDIR}

# Get Adobe Code Pro
curl -L ${REPO_SOURCE_CODE_PRO} | tar zx
cp -f source-code-pro-*/OTF/*.otf ${FONTDIR}

# Get Source Han Sans
curl -L ${REPO_SOURCE_HAN_SANS} | tar zx
cp -f source-han-sans-*/OTF/SimplifiedChinese/*.otf ${FONTDIR}

cd -  # back to current folder
rm -rf $TMPDIR

exit 0
