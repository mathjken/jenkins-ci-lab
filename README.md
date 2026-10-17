# Jenkins CI Pipeline Lab

## Overview

This project demonstrates a Continuous Integration (CI) pipeline using Jenkins, GitHub, Python, and pytest. Jenkins checks the GitHub repository for changes, runs automated tests, packages the application, and archives the build artifact.

## Technologies

- Jenkins — pipeline automation
- Docker — runs Jenkins in a container
- Python — application code
- pytest — automated testing
- Git and GitHub — source control
- Poll SCM — periodic repository change detection

## Pipeline Stages

1. **Checkout:** Retrieves source code from GitHub.
2. **Build:** Packages the application files into `dist/jenkins-ci-lab.zip`.
3. **Test:** Creates a Python virtual environment, installs dependencies, and runs pytest.
4. **Deploy:** Archives the ZIP file in Jenkins as a build artifact.

## Automated Build Trigger

Poll SCM is configured with `H/5 * * * *`, so Jenkins checks the repository approximately every five minutes. When it detects a new commit, it can trigger a pipeline build automatically.

## Tests

The test suite verifies:
- Adding two positive numbers.
- Adding two negative numbers.

## Build Artifact

The pipeline archives:

`dist/jenkins-ci-lab.zip`

## Jenkins Environment

Jenkins runs in Docker using a custom image defined in `Dockerfile.jenkins`. The image includes Python, pip, virtual-environment support, and zip.

## Skills Demonstrated

- Declarative Jenkins Pipeline
- GitHub source control integration
- Automated build triggers using Poll SCM
- Python virtual environments and dependency management
- Automated testing with pytest
- Artifact archiving
- Docker image customization

## Future Improvements

- Publish test reports in Jenkins.
- Add code quality checks.
- Introduce a deployment stage to a test environment.
- Explore GitHub webhooks using a securely accessible Jenkins endpoint.
