# Project for Programming Course (AA 2025)

This repository contains the instruction and the files ncessary to perform the analysis required in the project. It includes a pre-configured Docker container that installs all the necessary R packages and dependencies to perform the analysis described in the `project_DE_LISA_PAOLA.Rmd`.

## Getting Started

Follow these steps to set up the project and run the analysis.

### 1. Build the Docker Image

Once Docker is installed, navigate to the folder containing the `Dockerfile` and other project files, then run the following command to build the Docker image:

```bash
docker build -t project .
This will create a Docker image with all the required software and packages for the analysis.
```

### 2. Run the Docker Container
To execute the analysis, run the following command. This will mount your local directory to the container and automatically generate the .html report:

```bash
docker run -it -v "$PWD":/home/project project
```

This will render the project_DE_LISA_PAOLA.Rmd file and generate the output in the local directory.

### Files included
Dockerfile: The configuration to build the Docker image with the necessary software and libraries.

project_DE_LISA_PAOLA.Rmd: The main R Markdown script used to perform the analysis and generate the report.

data/: A folder containing the input data files that are required for the analysis.


### Known Issues or Limitations
Rendering may fail on machines with limited memory. If you encounter memory issues, try running the analysis interactively (by entering the container) or increase the memory allocation for Docker.

-Start the container in interactive mode:

```bash
docker run -it -v "$PWD":/home/project project bash
```

-Open R inside the container

-Run

```bash
rmarkdown::render('project_DE_LISA_PAOLA.Rmd')
```
