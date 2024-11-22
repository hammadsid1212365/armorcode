# Use the official Jenkins base image
FROM jenkins/jenkins:lts

# Set environment variables
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

# Install additional tools (e.g., Docker CLI for managing Docker inside Jenkins)
USER root
RUN apt-get update && apt-get install -y \
    docker.io \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set permissions back to Jenkins user
USER jenkins

# Expose Jenkins default port
EXPOSE 8080

# Expose Jenkins agent port
EXPOSE 50000

# Entry point for Jenkins
ENTRYPOINT ["/usr/bin/tini", "--", "/usr/local/bin/jenkins.sh"]

