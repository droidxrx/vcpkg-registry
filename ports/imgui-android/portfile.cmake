vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO droidxrx/imgui-android
    REF ${VERSION}
    SHA512 8ffd6bd752a7caed8a606e21335025a7c43be1fd1a1a06e609a3febfab17cc05a20f682fcf284576c113c994f1a50b58f3aa34c29374ff688cea92d19d0b09ee
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