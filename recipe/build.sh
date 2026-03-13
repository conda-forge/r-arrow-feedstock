#!/bin/bash
set -ex

export DISABLE_AUTOBREW=1

# Add CXX20 if not set by toolchain
if [[ -z "$("${R}" CMD config CXX20 2>/dev/null)" ]]; then
    r_makevars_user="$(mktemp)"
    cat > "${r_makevars_user}" <<EOF
CXX20=${CXX}
CXX20STD=-std=gnu++20
CXX20FLAGS=${CXXFLAGS}
CXX20PICFLAGS=-fpic
EOF
    export R_MAKEVARS_USER="${r_makevars_user}"
fi

# arrow uses C++20
export ARROW_R_CXXFLAGS="${ARROW_R_CXXFLAGS} -std=c++20"
export LIBARROW_BUILD=false

if [[ "${target_platform}" == osx-* ]]; then
    # See https://conda-forge.org/docs/maintainer/knowledge_base.html#newer-c-features-with-old-sdk
    export ARROW_R_CXXFLAGS="${ARROW_R_CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"
fi

# ${R_ARGS} necessary to support cross-compilation
${R} CMD INSTALL --build r/. ${R_ARGS}
