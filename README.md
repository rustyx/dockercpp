
This is a blank project for doing C++ development in Docker.

It generates a Docker container with GCC, cmake and a running ssh daemon.

To build: `docker build -t dev .`

To start (example): `docker run -it --rm -p 32781:22 -v c:/Projects:/mnt/data dev`

