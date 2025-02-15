# Base image https://hub.docker.com/u/rocker/
FROM rocker/shiny:latest

# system libraries of general use
## install debian packages
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    libxml2-dev \
    libcairo2-dev \
    libsqlite3-dev \
    libmariadbd-dev \
    libpq-dev \
    libssh2-1-dev \
    unixodbc-dev \
    libcurl4-openssl-dev \
    libssl-dev

## update system libraries
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean

# Make a directory in the container
RUN mkdir /home/shiny-app

# Install R dependencies
RUN R -e 'install.packages("httr")'
RUN R -e 'install.packages("remotes")'

RUN R -e 'remotes::install_github("berthetclement/shiny_golem", dependencies = TRUE)'


# Copy Rprofile.site file to init options in "R_GlobalEnv"
COPY Rprofile.site /usr/local/lib/R/etc

# Expose the application port (see Rprofile.site file)
EXPOSE 3838

# Run the R Shiny app
CMD ["R", "-e testGolem::run_app()"]

