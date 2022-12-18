vcpkg_check_linkage(ONLY_STATIC_LIBRARY)
vcpkg_minimum_required(VERSION 2022-11-10)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO ocornut/imgui
    REF 91b356cf8e3f56c5457100ddbe93785e54048f22
    SHA512 81b93ff52202bc70865c54c3cf2df9cfc78eb0c1603fb3043bdb5537fcbd4310e1a6e31a669ac05ac6e4f306cb53b6b5da7cbc4f558d3ad47ae40322f5210cb9
    HEAD_REF master
    PATCHES imconfig.h.patch imgui_internal.h.patch
)

file(COPY "${CMAKE_CURRENT_LIST_DIR}/imgui-android.h" DESTINATION "${SOURCE_PATH}")
file(COPY "${CMAKE_CURRENT_LIST_DIR}/imgui-android-config.cmake.in" DESTINATION "${SOURCE_PATH}")
file(COPY "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" DESTINATION "${SOURCE_PATH}")

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
    freetype IMGUI_FREETYPE
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
    ${FEATURE_OPTIONS}
    -DCMAKE_CXX_STANDARD=11 -DCMAKE_CXX_STANDARD_REQUIRED=ON -DCMAKE_CXX_EXTENSIONS=OFF
    OPTIONS_DEBUG
    -DIMGUI_SKIP_HEADERS=ON
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup()

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")