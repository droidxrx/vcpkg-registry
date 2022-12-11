vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO droidxrx/imgui-android
    REF ${VERSION}
    SHA512 bf47546162b6c407a4ad0a9a7188fd5875cde115b8814c7a798b937f1fbb9edbbad8d2f00b21724961c6bd49b0efa3a699df0637cbc8545bf8767d34dfa4a10c
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)

vcpkg_install_cmake()
vcpkg_fixup_cmake_targets()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(
	INSTALL "${SOURCE_PATH}/LICENSE"
	DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
	RENAME copyright)