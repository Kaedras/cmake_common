cmake_minimum_required(VERSION 3.22)

if (DEFINED MO2_INCLUDED)
	return()
endif()

include(${CMAKE_CURRENT_LIST_DIR}/mo2_utils.cmake)

# setup path for find_package(), etc.
if (WIN32)
	mo2_required_variable(NAME BOOST_ROOT TYPE PATH)
	mo2_required_variable(NAME PYTHON_ROOT TYPE PATH)
else()
	if(NOT DEFINED QT_ROOT)
		# try to set QT_ROOT to a sensible default, should work in most cases
		if (EXISTS /usr/lib64/qt6)
			set(QT_ROOT /usr/lib64/qt6)
		elseif(EXISTS /usr/lib/qt6)
			set(QT_ROOT /usr/lib/qt6)
		endif()
	endif()
endif()

mo2_required_variable(NAME QT_ROOT TYPE PATH)
mo2_required_variable(NAME CMAKE_INSTALL_PREFIX TYPE PATH)

get_filename_component(MO2_BUILD_PATH "${CMAKE_CURRENT_LIST_DIR}/../.." REALPATH)
get_filename_component(MO2_SUPER_PATH "${MO2_BUILD_PATH}/modorganizer_super" REALPATH)
get_filename_component(MO2_UIBASE_PATH "${MO2_SUPER_PATH}/uibase" REALPATH)
get_filename_component(MO2_INSTALL_PATH "${MO2_SUPER_PATH}/../../install" REALPATH)
get_filename_component(MO2_INSTALL_LIBS_PATH "${MO2_INSTALL_PATH}/libs" REALPATH)

if (WIN32)
	list(APPEND CMAKE_PREFIX_PATH
		${QT_ROOT}/lib/cmake
		${BOOST_ROOT}/build
		${MO2_BUILD_PATH}/googletest/build/lib/cmake/GTest)

	# find Qt major version and set QT_DEFAULT_MAJOR_VERSION to avoid issues
	# when including LinguistTools without a QtCore
	mo2_find_qt_version(QT_VERSION)
	string(REPLACE "." ";" QT_VERSION_LIST ${QT_VERSION})
	list(GET QT_VERSION_LIST 0 QT_MAJOR_VERSION)

	# we add the Qt DLL to the paths for some tools
	set(ENV{PATH} "${QT_ROOT}/bin;$ENV{PATH}")
else()
	# workaround
	set(QT_MAJOR_VERSION 6)
endif()
# custom property, used to keep track of the type of target
define_property(
	TARGET PROPERTY MO2_TARGET_TYPE INHERITED
	BRIEF_DOCS  "Target type for MO2 C++ target."
	FULL_DOCS "Automatically set when using mo2_configure_XXX functions.")

set(Boost_USE_STATIC_RUNTIME OFF)
if (WIN32)
	set(Boost_USE_STATIC_LIBS ON)
endif()
set(CMAKE_VS_INCLUDE_INSTALL_TO_DEFAULT_BUILD 1)

set_property(GLOBAL PROPERTY USE_FOLDERS ON)
set_property(GLOBAL PROPERTY AUTOGEN_SOURCE_GROUP autogen)
set_property(GLOBAL PROPERTY AUTOMOC_SOURCE_GROUP autogen)
set_property(GLOBAL PROPERTY AUTORCC_SOURCE_GROUP autogen)

include(${CMAKE_CURRENT_LIST_DIR}/mo2_cpp.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/mo2_python.cmake)

# mark as included
set(MO2_DEFINED true)
