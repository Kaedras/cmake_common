cmake_minimum_required(VERSION 3.28)

# at least one language is required to populate CMAKE_SYSTEM_NAME
project(mo2-cmake VERSION 3.0.0 LANGUAGES CXX)

include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

set(MO2_CMAKE_INSTALL_DIR ${CMAKE_INSTALL_DATADIR}/mo2-cmake)
set(MO2_CMAKE_CONFIG_INSTALL_DIR ${CMAKE_INSTALL_LIBDIR}/cmake/mo2-cmake)

configure_package_config_file(
    mo2-cmake-config.cmake.in
    ${CMAKE_CURRENT_BINARY_DIR}/mo2-cmake-config.cmake
    INSTALL_DESTINATION ${MO2_CMAKE_CONFIG_INSTALL_DIR}
    PATH_VARS MO2_CMAKE_INSTALL_DIR
)

write_basic_package_version_file(
    ${CMAKE_CURRENT_BINARY_DIR}/mo2-cmake-configVersion.cmake
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY AnyNewerVersion
)

install(
    DIRECTORY cmake/
    DESTINATION ${MO2_CMAKE_INSTALL_DIR}
    FILES_MATCHING PATTERN "*.cmake"
)

install(
    FILES
        ${CMAKE_CURRENT_BINARY_DIR}/mo2-cmake-config.cmake
        ${CMAKE_CURRENT_BINARY_DIR}/mo2-cmake-configVersion.cmake
    DESTINATION ${MO2_CMAKE_CONFIG_INSTALL_DIR}
)
