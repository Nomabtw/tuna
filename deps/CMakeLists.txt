set(LIBMPDCLIENT_INCLUDE_DIRS "${CMAKE_CURRENT_SOURCE_DIR}/libmpdclient/include" CACHE STRING "" FORCE)
set(TAGLIB_INCLUDE_DIRS "${CMAKE_CURRENT_SOURCE_DIR}/taglib")

set(MAJOR_VERSION 2)
set(MINOR_VERSION 19)
set(PATCH_VERSION 0)

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/libmpdclient/include/mpd/version.h.in
    ${CMAKE_CURRENT_SOURCE_DIR}/libmpdclient/include/mpd/version.h)

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/taglib/taglib/taglib_config.h.cmake
    ${CMAKE_CURRENT_SOURCE_DIR}/taglib/taglib/taglib_config.h)

file(GLOB libmpdclient_SRC "${CMAKE_CURRENT_SOURCE_DIR}/libmpdclient/src/*.h" "${CMAKE_CURRENT_SOURCE_DIR}/libmpdclient/src/.c")
file(GLOB_RECURSE taglib_HDR "${CMAKE_CURRENT_SOURCE_DIR}/taglib/taglib/*.h")
file(GLOB_RECURSE taglib_SRC "${CMAKE_CURRENT_SOURCE_DIR}/taglib/taglib/*.cpp")

include_directories(
    ${TAGLIB_INCLUDE_DIRS}/taglib
    ${TAGLIB_INCLUDE_DIRS}/taglib/toolkit
    ${TAGLIB_INCLUDE_DIRS}/taglib/asf
    ${TAGLIB_INCLUDE_DIRS}/taglib/mpeg
    ${TAGLIB_INCLUDE_DIRS}/taglib/ogg
    ${TAGLIB_INCLUDE_DIRS}/taglib/ogg/flac
    ${TAGLIB_INCLUDE_DIRS}/taglib/flac
    ${TAGLIB_INCLUDE_DIRS}/taglib/mpc
    ${TAGLIB_INCLUDE_DIRS}/taglib/mp4
    ${TAGLIB_INCLUDE_DIRS}/taglib/ogg/vorbis
    ${TAGLIB_INCLUDE_DIRS}/taglib/ogg/speex
    ${TAGLIB_INCLUDE_DIRS}/taglib/ogg/opus
    ${TAGLIB_INCLUDE_DIRS}/taglib/mpeg/id3v2
    ${TAGLIB_INCLUDE_DIRS}/taglib/mpeg/id3v2/frames
    ${TAGLIB_INCLUDE_DIRS}/taglib/mpeg/id3v1
    ${TAGLIB_INCLUDE_DIRS}/taglib/ape
    ${TAGLIB_INCLUDE_DIRS}/taglib/wavpack
    ${TAGLIB_INCLUDE_DIRS}/taglib/trueaudio
    ${TAGLIB_INCLUDE_DIRS}/taglib/riff
    ${TAGLIB_INCLUDE_DIRS}/taglib/riff/aiff
    ${TAGLIB_INCLUDE_DIRS}/taglib/riff/wav
    ${TAGLIB_INCLUDE_DIRS}/taglib/mod
    ${TAGLIB_INCLUDE_DIRS}/taglib/s3m
    ${TAGLIB_INCLUDE_DIRS}/taglib/it
    ${TAGLIB_INCLUDE_DIRS}/taglib/xm
    ${TAGLIB_INCLUDE_DIRS}/taglib/dsf
    ${TAGLIB_INCLUDE_DIRS}/taglib/dsdiff
    ${CMAKE_CURRENT_SOURCE_DIR}/taglib/3rdparty
)

add_library(tag STATIC ${taglib_SRC} ${taglib_HDR})
add_library(mpdclient STATIC ${libmpdclient_SRC})

set_property(TARGET tag PROPERTY POSITION_INDEPENDENT_CODE 1)
set_property(TARGET mpdclient PROPERTY POSITION_INDEPENDENT_CODE 1)

set_target_properties(mpdclient PROPERTIES LINKER_LANGUAGE C)
set_target_properties(tag PROPERTIES LINKER_LANGUAGE CXX)
