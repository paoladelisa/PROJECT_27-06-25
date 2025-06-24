FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# 1. System dependencies (R, BioC, compilation, graphics support)
RUN apt-get update && apt-get install -y \
    software-properties-common \
    gnupg \
    curl \
    git \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libgit2-dev \
    libreadline-dev \
    libncurses5 \
    libbz2-dev \
    liblzma-dev \
    xz-utils \
    zlib1g-dev \
    pandoc \
    build-essential \
    libpng-dev \
    libjpeg-dev \
    libtiff5-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libgsl-dev \
    libhdf5-dev \
    libfftw3-dev \
    libssh2-1-dev \
    && apt-get clean

# 2. Add CRAN repository and install R
RUN curl -fsSL https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc \
    | gpg --dearmor -o /usr/share/keyrings/cran-key.gpg

RUN echo "deb [signed-by=/usr/share/keyrings/cran-key.gpg] https://cloud.r-project.org/bin/linux/ubuntu jammy-cran40/" \
    > /etc/apt/sources.list.d/cran.list

RUN apt-get update && apt-get install -y r-base

# 3. Set default CRAN mirror
RUN echo 'options(repos = c(CRAN = "https://cloud.r-project.org"))' >> /etc/R/Rprofile.site

# 4. Install CRAN packages
RUN R -e "install.packages(c('Seurat', 'ggplot2', 'dplyr', 'data.table', 'Matrix', 'rmarkdown', 'devtools', 'BiocManager'))"

# 5. Install Bioconductor packages separately
RUN R -e "BiocManager::install('IRanges', ask = FALSE, update = TRUE)"
RUN R -e "BiocManager::install('S4Vectors', ask = FALSE, update = TRUE)"
RUN R -e "BiocManager::install('GenomeInfoDb', ask = FALSE, update = TRUE)"
RUN R -e "BiocManager::install('GenomicRanges', ask = FALSE, update = TRUE)"
RUN R -e "BiocManager::install('Rsamtools', ask = FALSE, update = TRUE)"

# 6. Install Signac from GitHub 
RUN R -e "devtools::install_github('stuart-lab/signac', upgrade = 'never', quiet = FALSE)"

# 7. Working directory
WORKDIR /home/project

COPY . .

# 8. Report rendering
CMD ["Rscript", "-e", "rmarkdown::render('project_DE_LISA_PAOLA.Rmd')"]
