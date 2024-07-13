cmake_minimum_required(VERSION 3.22)

if (DEFINED MO2_VERSIONS_INCLUDED)
	return()
endif()


set(MO2_QT_VERSION_MAJOR 6)
set(MO2_QT_VERSION_MINOR 7)
set(MO2_QT_VERSION_PATCH 0)
set(MO2_QT_VERSION "${MO2_QT_VERSION_MAJOR}.${MO2_QT_VERSION_MINOR}.${MO2_QT_VERSION_PATCH}")

set(MO2_PYTHON_VERSION "3.12")

set(MO2_PYQT_VERSION ${MO2_QT_VERSION})
set(MO2_SIP_VERSION "6.8.5")


# mark as included
set(MO2_VERSIONS_INCLUDED TRUE)
