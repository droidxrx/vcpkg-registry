vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO droidxrx/imgui-android
    REF ${VERSION}
    SHA512 97db7fe2320dc8f5164c32850a52da61435a7e10eb23f165381f633435b45a1f24102bdde35fd2e2d1efc6fa88e5d40399108142d4a9afe715423324e7be9978
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