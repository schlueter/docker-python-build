# Build python with Docker
This repo enables production of python tarballs via builds within a Docker container.

## Walkthrough
First, build the container which will build python:
```
docker build . -t python-build
```
Then build python:
```
docker run --rm --env python_version=2.7.15 --mount type=bind,source="$(pwd)",target=/build python-build
```
Any python version from https://www.python.org/ftp/python/ may be selected, though some may not build successfully.
Running this command will produce a tarball *python-{{ python_version }}-{{ linux_distro }}.tgz* in the current
directory. The tarball may be extracted on a target host with:
```
sudo tar -xvf python-${python_version}-${linux_distro}.tgz -C /
```
