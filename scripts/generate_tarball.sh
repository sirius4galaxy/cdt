#! /bin/bash

NAME=$1
OS=$2
CDT_PREFIX=${PREFIX}/${SUBPREFIX}
mkdir -p ${PREFIX}/bin/
mkdir -p ${PREFIX}/lib/cmake/${PROJECT}
mkdir -p ${CDT_PREFIX}/bin
mkdir -p ${CDT_PREFIX}/include
mkdir -p ${CDT_PREFIX}/lib/cmake/${PROJECT}
mkdir -p ${CDT_PREFIX}/cmake
mkdir -p ${CDT_PREFIX}/scripts
mkdir -p ${CDT_PREFIX}/licenses

#echo "${PREFIX} ** ${SUBPREFIX} ** ${CDT_PREFIX}"

# install binaries
cp -R ${BUILD_DIR}/bin/* ${CDT_PREFIX}/bin || exit 1
cp -R ${BUILD_DIR}/licenses/* ${CDT_PREFIX}/licenses || exit 1

# install cmake modules
sed "s/_PREFIX_/\/${SPREFIX}/g" ${BUILD_DIR}/modules/CDTMacrosPackage.cmake &> ${CDT_PREFIX}/lib/cmake/${PROJECT}/CDTMacros.cmake || exit 1
sed "s/_PREFIX_/\/${SPREFIX}/g" ${BUILD_DIR}/modules/CDTWasmToolchainPackage.cmake &> ${CDT_PREFIX}/lib/cmake/${PROJECT}/CDTWasmToolchain.cmake || exit 1
sed "s/_PREFIX_/\/${SPREFIX}\/${SSUBPREFIX}/g" ${BUILD_DIR}/modules/${PROJECT}-config.cmake.package &> ${CDT_PREFIX}/lib/cmake/${PROJECT}/${PROJECT}-config.cmake || exit 1

# install scripts
cp -R ${BUILD_DIR}/scripts/* ${CDT_PREFIX}/scripts  || exit 1

# install misc.
cp ${BUILD_DIR}/cdt.imports ${CDT_PREFIX} || exit 1

# install wasm includes
cp -R ${BUILD_DIR}/include/* ${CDT_PREFIX}/include || exit 1

# install wasm libs
cp ${BUILD_DIR}/lib/*.a ${CDT_PREFIX}/lib || exit 1

# install libc++.so
if [[ "$OS" == "ubuntu-16.04" ]]; then
    cp /usr/lib/libc++.so.1.0 ${CDT_PREFIX}/lib || exit 1
    cp /usr/lib/libc++abi.so.1.0 ${CDT_PREFIX}/lib || exit 1
    DIR=`pwd`
    cd ${CDT_PREFIX}/lib || exit 1
    ln -sf libc++.so.1.0 libc++.so.1 || exit 1
    ln -sf libc++abi.so.1.0 libc++abi.so.1 || exit 1
    cd ${DIR} || exit 1
fi

# make symlinks
pushd ${PREFIX}/lib/cmake/${PROJECT} &> /dev/null
ln -sf ../../../${SUBPREFIX}/lib/cmake/${PROJECT}/${PROJECT}-config.cmake ${PROJECT}-config.cmake || exit 1
ln -sf ../../../${SUBPREFIX}/lib/cmake/${PROJECT}/CDTWasmToolchain.cmake CDTWasmToolchain.cmake || exit 1
ln -sf ../../../${SUBPREFIX}/lib/cmake/${PROJECT}/CDTMacros.cmake CDTMacros.cmake || exit 1
popd &> /dev/null

create_symlink() {
   ln -sf ../${SUBPREFIX}/bin/$1 ${PREFIX}/bin/$2 || exit 1
}

create_symlink flon-cc flon-cc
create_symlink flon-cpp flon-cpp
create_symlink flon-ld flon-ld
create_symlink flon-pp flon-pp
create_symlink flon-init flon-init
create_symlink flon-wasm2wast flon-wasm2wast
create_symlink flon-wast2wasm flon-wast2wasm
create_symlink flon-wasm2wast cdt-wasm2wast
create_symlink flon-wast2wasm cdt-wast2wasm
create_symlink flon-ar flon-ar
create_symlink flon-abidiff flon-abidiff
create_symlink flon-nm flon-nm
create_symlink flon-objcopy flon-objcopy
create_symlink flon-objdump flon-objdump
create_symlink flon-ranlib flon-ranlib
create_symlink flon-readelf flon-readelf
create_symlink flon-strip flon-strip
create_symlink antler-proj antler-proj
create_symlink antler-proj cdt-proj

echo "Generating Tarball $NAME.tar.gz..."
tar -cvzf $NAME.tar.gz ./${PREFIX}/* || exit 1
rm -r ${PREFIX} || exit 1
