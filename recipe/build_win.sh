#!/bin/bash

set -exuo pipefail

export BUILD_PREFIX_SH=${BUILD_PREFIX//\\//}
export BUILD_PREFIX_SH=/${BUILD_PREFIX_SH//:}

# Patch Makeconf
sed -i -e "s;g++;${BUILD_PREFIX_SH}/Library/bin/clang++.exe;g" $BUILD_PREFIX/Lib/R/etc/x64/Makeconf
sed -i -e "s;nm;${BUILD_PREFIX_SH}/Library/bin/llvm-nm.exe;g" $BUILD_PREFIX/Lib/R/etc/x64/Makeconf
sed -i -e "s;gnu++11;gnu++14;g" $BUILD_PREFIX/Lib/R/etc/x64/Makeconf

# Patch Rcpp
sed -i -e 's;abs;std::abs;g' $BUILD_PREFIX/Lib/R/library/Rcpp/include/Rcpp/DataFrame.h

pushd "${BUILD_PREFIX}/lib/R/bin/x64"
gendef R.dll
dlltool -d R.def -l R.lib
popd
