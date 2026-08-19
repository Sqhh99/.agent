#!/usr/bin/env bash
# Generic Unix entry. Copy to repo root and chmod +x.
# Usage: ./build.sh [debug|release|tests|benchmark|configure|rebuild|clean|run|help]
set -euo pipefail
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUILD_ROOT="$SOURCE_DIR/build"
COMMAND=build
BUILD_CONFIG=release
VCPKG_ROOT="${VCPKG_ROOT:-}"
if [[ -z "$VCPKG_ROOT" && -f "$SOURCE_DIR/third_party/vcpkg/scripts/buildsystems/vcpkg.cmake" ]]; then
  VCPKG_ROOT="$SOURCE_DIR/third_party/vcpkg"
fi

while [[ $# -gt 0 ]]; do
  case "$1" in
    release) BUILD_CONFIG=release ;;
    debug) BUILD_CONFIG=debug ;;
    tests) COMMAND=tests ;;
    benchmark) COMMAND=benchmark ;;
    configure) COMMAND=configure ;;
    rebuild) COMMAND=rebuild ;;
    clean) COMMAND=clean ;;
    run) COMMAND=run ;;
    help|-h|--help)
      echo "./build.sh [debug|release|tests|benchmark|configure|rebuild|clean|run|help]"
      exit 0
      ;;
    *) echo "Unknown argument: $1" >&2; exit 1 ;;
  esac
  shift
done

BUILD_DIR="$BUILD_ROOT/$BUILD_CONFIG"
if [[ "$COMMAND" == clean ]]; then
  rm -rf "$BUILD_ROOT"
  echo "Removed $BUILD_ROOT"
  exit 0
fi
if [[ "$COMMAND" == rebuild ]]; then
  rm -rf "$BUILD_DIR"
fi

EXTRA=()
if [[ -n "$VCPKG_ROOT" ]]; then
  EXTRA+=("-DCMAKE_TOOLCHAIN_FILE=$VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake")
fi
if [[ "$COMMAND" == tests || "$COMMAND" == benchmark ]]; then
  EXTRA+=("-DBUILD_TESTING=ON")
fi
if [[ "$COMMAND" == benchmark ]]; then
  EXTRA+=("-DBUILD_BENCHMARK=ON")
fi

mkdir -p "$BUILD_DIR"
cmake -S "$SOURCE_DIR" -B "$BUILD_DIR" -DCMAKE_BUILD_TYPE="${BUILD_CONFIG^}" "${EXTRA[@]}"
if [[ "$COMMAND" == configure ]]; then
  exit 0
fi
cmake --build "$BUILD_DIR"
if [[ "$COMMAND" == tests ]]; then
  ctest --test-dir "$BUILD_DIR" --output-on-failure
fi
if [[ "$COMMAND" == benchmark ]]; then
  ctest --test-dir "$BUILD_DIR" -R benchmark --output-on-failure
fi
if [[ "$COMMAND" == run ]]; then
  echo "Launch the app from $BUILD_DIR — set APP_EXE in this script."
fi
