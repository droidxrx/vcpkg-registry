vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO droidxrx/imgui-android
    REF ${VERSION}
    SHA512 5d9381cfa7ec68b1dbb317f5a7680a6399720734bab0757b333e7362e1888428f6c580427b432639ea6cc7d4c9261eef3b1ba8022081d2d1fa7e13e6b8c878c8
    HEAD_REF master
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
    glesv2 USE_OPENGL_ES2
    glesv3 USE_OPENGL_ES3
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS ${FEATURE_OPTIONS}
    PREFER_NINJA
)

vcpkg_install_cmake()
vcpkg_fixup_cmake_targets()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(
    INSTALL "${SOURCE_PATH}/LICENSE"
    DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
    RENAME copyright)