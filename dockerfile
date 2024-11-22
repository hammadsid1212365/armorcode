# Use a base image that includes Git
FROM ubuntu:20.04

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Clone the GitHub repository (replace with your repository URL)
RUN git clone https://github.com/hammadsid1212365/armorcode.git /opt/repository

# Set the working directory to where the repository is cloned
WORKDIR /opt/repository

# Example: Print a specific file (e.g., README.md)
CMD cat README.md

