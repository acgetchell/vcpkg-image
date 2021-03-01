# vcpkg-image
A small [Alpine Linux] image with [gcc-10] and [vcpkg].

`vcpkg` is located in `/vcpkg`, and user-wide integration (`vcpkg integrate install`) has been applied.

[CMake] projects should use: `"-DCMAKE_TOOLCHAIN_FILE=/vcpkg/scripts/buildsystems/vcpkg.cmake"`.

For background see [Using multi-stage containers for C++ development][1].

[Alpine Linux]:https://alpinelinux.org
[gcc-10]:https://gcc.gnu.org/gcc-10/
[vcpkg]:https://vcpkg.readthedocs.io/en/latest/
[CMake]:https://cmake.org
[1]:https://devblogs.microsoft.com/cppblog/using-multi-stage-containers-for-c-development/
