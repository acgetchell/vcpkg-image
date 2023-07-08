# vcpkg-image

A small [Alpine] or [Ubuntu] Linux image with [gcc-13] and [vcpkg], plus prerequisites to install
packages such as `gmp`, `boost`, and `cgal`.

[vcpkg] is located in `/vcpkg` (available via `$VCPKG_ROOT`), and user-wide integration (`vcpkg integrate install`)
has been applied.
[vcpkg] is also required to use system-installed [CMake] and [Ninja] rather than downloading it's own copies.

As [vcpkg] requires [CMake] 3.21 or later, the latest stable version of [CMake] is downloaded and installed.

[CMake] projects should use:

```bash
"-D CMAKE_TOOLCHAIN_FILE=$VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake"
```

## Building

```bash
docker build -t vcpkg-image .
```

## Running

```bash
docker run -it --name vcpkg vcpkg-image
```

For background see [Using multi-stage containers for C++ development][1].

[Alpine]:https://alpinelinux.org
[Ubuntu]:https://ubuntu.com
[gcc-13]:https://gcc.gnu.org/gcc-13/
[vcpkg]:https://vcpkg.readthedocs.io/en/latest/
[CMake]:https://cmake.org
[Ninja]:https://ninja-build.org
[1]:https://devblogs.microsoft.com/cppblog/using-multi-stage-containers-for-c-development/
