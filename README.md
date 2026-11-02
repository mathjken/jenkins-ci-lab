# Jenkins CI Pipeline Lab

## Overview

This project demonstrates a Continuous Integration (CI) pipeline using Jenkins, GitHub, Python, and pytest. Jenkins checks the GitHub repository for changes, runs automated tests, packages the application, and archives the build artifact.

## Technologies

- Jenkins — pipeline automation
- Docker — runs Jenkins in a container
- Python — application code
- pytest — automated testing
- Git and GitHub — source control
- JUnit XML — test report format
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

## Test Report

pytest generates the JUnit XML report:

`test-results.xml`

Jenkins publishes the report using:

```groovy
junit 'test-results.xml'
```

## Build Artifact

The pipeline archives:

`dist/jenkins-ci-lab.zip`

The artifact can be downloaded from the Jenkins build page.
Note: The current Deploy stage archives the ZIP in Jenkins; it does not deploy the application to a live environment.


## Jenkins Environment

Jenkins runs in Docker using a custom image defined in `Dockerfile.jenkins`. The image includes Python, pip, virtual-environment support, and zip.Jenkins configuration and job data are persisted in the jenkins_home Docker volume.

## Skills Demonstrated

- Declarative Jenkins Pipeline
- GitHub source control integration
- Automated build triggers using Poll SCM
- Python virtual environments and dependency management
- Automated testing with pytest
- JUnit test report publishing
- Build artifact archiving
- Docker image customization

## Future Improvements

- Add code quality checks.
- Run tests before packaging the release artifact.
- Introduce a deployment stage to a test environment.
- Explore GitHub webhooks using a securely accessible Jenkins endpoint.


## GitHub Actions CI Pipeline

This repository also uses GitHub Actions to automate Python testing.

### Workflow Configuration

The workflow is defined in:

`.github/workflows/ci.yml`

### Workflow Triggers

The pipeline runs automatically when:

- Code is pushed to the `main` branch.
- A pull request targets the `main` branch.

### Workflow Steps

1. **Checkout:** Retrieves the repository source code.
2. **Set up Python:** Configures Python 3.13.
3. **Dependency caching:** Caches pip dependencies to speed up subsequent runs.
4. **Install dependencies:** Installs packages from `requirements.txt`.
5. **Run tests:** Executes automated tests using pytest and generates a JUnit XML report.

### Execution Environment

- Platform: GitHub-hosted Ubuntu runner.
- Python: 3.13.
- Testing framework: pytest 8.4.2.
- GitHub Actions: checkout v5 and setup-python v6.

### Test Results

The workflow successfully executed both automated tests:

- `test_add_numbers`
- `test_add_negative_numbers`

Result: 2 tests passed.

Both push and pull-request triggers were tested successfully.

### Skills Demonstrated

- GitHub Actions workflow configuration using YAML.
- CI automation using push and pull-request events.
- GitHub-hosted runners.
- Python environment configuration.
- Dependency caching.
- Automated testing with pytest.
- Git branching and pull-request workflows.
- CI execution monitoring and troubleshooting.
