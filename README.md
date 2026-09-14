# Architecture Diagrams for Volunsphere

This repository contains the code for generating the architecture diagrams via C4.
Currently we are using the Structurizr CLI to generate the diagrams.
This allows us to quickly iterate over them. The src folder contains the workspace.dsl where the C4 source code is defined. Structurizr automatically generated and updates the workspace.json, on any saved change in workspace.dsl, whoch is them used for generating the images.


## Usage

1. Install [Docker](https://www.docker.com/) if not already installed.
1. Run `docker compose up`.
1. Open [localhost:8080](http://localhost:8080) in a browser.
