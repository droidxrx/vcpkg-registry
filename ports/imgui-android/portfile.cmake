vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO droidxrx/imgui-android
    REF ${VERSION}
    SHA512 651bdad8c9f974afaf250f792bdec178aed908109776d8eeb81752f8fefdb17f5ca00aa0cecb6d289b2cff7b8662329dabd563259f025daebbda3cf846254e22
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