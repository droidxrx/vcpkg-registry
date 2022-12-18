cmake_minimum_required(VERSION 3.20)

set(PROJECT_VERSION 1.89.2)
project(imgui-android VERSION ${PROJECT_VERSION} LANGUAGES CXX)

set(CMAKE_DEBUG_POSTFIX d)

add_library(${PROJECT_NAME} "")
target_link_libraries(${PROJECT_NAME} PUBLIC EGL log GLESv3)

target_include_directories(
    ${PROJECT_NAME}
    PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
    $<INSTALL_INTERFACE:include>
)

target_sources(
    ${PROJECT_NAME} PRIVATE
    "${CMAKE_CURRENT_SOURCE_DIR}/imgui.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/imgui_demo.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/imgui_draw.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/imgui_tables.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/imgui_widgets.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/misc/cpp/imgui_stdlib.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/backends/imgui_impl_android.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/backends/imgui_impl_opengl3.cpp"
)

if(IMGUI_FREETYPE)
    find_package(freetype CONFIG REQUIRED)
    target_link_libraries(${PROJECT_NAME} PUBLIC freetype)
    target_sources(${PROJECT_NAME} PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}/misc/freetype/imgui_freetype.cpp")
    target_compile_definitions(${PROJECT_NAME} PUBLIC IMGUI_ANDROID_USE_FREETYPE)
endif()

if(NOT IMGUI_SKIP_HEADERS)
    install(FILES "${CMAKE_CURRENT_SOURCE_DIR}/imgui-android.h" DESTINATION "include")
    install(FILES
        "${CMAKE_CURRENT_SOURCE_DIR}/imgui.h"
        "${CMAKE_CURRENT_SOURCE_DIR}/imconfig.h"
        "${CMAKE_CURRENT_SOURCE_DIR}/imgui_internal.h"
        "${CMAKE_CURRENT_SOURCE_DIR}/imstb_textedit.h"
        "${CMAKE_CURRENT_SOURCE_DIR}/imstb_rectpack.h"
        "${CMAKE_CURRENT_SOURCE_DIR}/imstb_truetype.h"
        "${CMAKE_CURRENT_SOURCE_DIR}/misc/cpp/imgui_stdlib.h"
        "${CMAKE_CURRENT_SOURCE_DIR}/backends/imgui_impl_android.h"
        "${CMAKE_CURRENT_SOURCE_DIR}/backends/imgui_impl_opengl3.h"
        DESTINATION "include/${PROJECT_NAME}"
    )

    if(IMGUI_FREETYPE)
        install(FILES "${CMAKE_CURRENT_SOURCE_DIR}/misc/freetype/imgui_freetype.h" DESTINATION "include/${PROJECT_NAME}")
    endif()
endif()

include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

install(
    TARGETS ${PROJECT_NAME}
    EXPORT ${PROJECT_NAME}_target
)

configure_package_config_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/imgui-android-config.cmake.in ${CMAKE_CURRENT_BINARY_DIR}/imgui-android-config.cmake
    INSTALL_DESTINATION ${CMAKE_INSTALL_DATADIR}/imgui-android
    NO_SET_AND_CHECK_MACRO)

write_basic_package_version_file(
    ${CMAKE_CURRENT_BINARY_DIR}/imgui-android-config-version.cmake
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY SameMajorVersion)

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/imgui-android-config.cmake ${CMAKE_CURRENT_BINARY_DIR}/imgui-android-config-version.cmake
    DESTINATION ${CMAKE_INSTALL_DATADIR}/imgui-android)

install(EXPORT ${PROJECT_NAME}_target FILE "${PROJECT_NAME}-targets.cmake" DESTINATION "${CMAKE_INSTALL_DATADIR}/${PROJECT_NAME}")