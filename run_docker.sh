#!/bin/bash

# Example docker run command that mounts the current directory to /tutorial in the container.
# This allows the output files created in the docker container to be persisted on the host machine.
docker run -p 8888:8888 -v $(pwd):/tutorial -w /tutorial johnkpark/openmm:tutorial-msbs