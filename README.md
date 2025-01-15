# FHIR Specification template repository

[![FHIR Project on Simplifier.net](https://img.shields.io/badge/FHIR_project_on_Simplifier.net-id--fhir-green)](https://simplifier.net/id-fhir) [![Firely Validation](https://github.com/sid-indonesia/fhir-specification/actions/workflows/main.yml/badge.svg)](https://github.com/sid-indonesia/fhir-specification/actions/workflows/main.yml)

A template repository for the management of your FHIR specification in GitHub.com.

## FHIR Validation with the Firely Terminal GitHub Action

The template repository includes a preconfigured GitHub Action to validate your resources against the FHIR specification and custom validation rules with [Firely Terminal](https://fire.ly/products/firely-terminal/). Any push or pull request to the `main` branch will automatically run the [Firely Validation pipeline](https://github.com/FirelyTeam/firely-terminal-pipeline), containing [bulk validation and custom business rule validation](https://fire.ly/2021/03/04/quality-control-how-to-validate-full-fhir-specifications-in-one-click/) with Firely Terminal.

## Synchronization with Simplifier.net FHIR projects

The template repository can be connected to a [Simplifier.net](http://simplifier.net) project for easy visualization, documentation and publishing. For the current project the `main` branch automatically synchronizes with [this Simplifier.net FHIR project](https://simplifier.net/id-fhir) on every commit. Learn how to set up [Simplifier.net GitHub synchronization](https://docs.fire.ly/projects/Simplifier/simplifierGithub.html).

## How to make use of the CI within the remote GitHub repository

1. Create / copy the FHIR resources (resulting from the conversion scripts) into a new/existing folder within [sid-indonesia/fhir-specification/Examples/Correct/NonFHIRToFHIR](https://github.com/sid-indonesia/fhir-specification/tree/main/Examples/Correct/NonFHIRToFHIR) (e.g. for conversion results from Kobo can be placed within [this folder](https://github.com/sid-indonesia/fhir-specification/tree/main/Examples/Correct/NonFHIRToFHIR/sidKobo))
2. Git commit the changes to a new/existing branch other than `main`/`master` and push it to the remote repository
3. Open a Pull Request from that branch to the `main` branch.
4. Monitor the [workflow runs](https://github.com/sid-indonesia/fhir-specification/actions/)
   - [Guide on monitoring workflows](https://docs.github.com/en/actions/monitoring-and-troubleshooting-workflows/monitoring-workflows/viewing-workflow-run-history)
   - Fix the errors as suggested by the FHIR validator, then repeat step 2, then step 4.

## How to run the FHIR validator locally

### Prerequisites

- `java` version 21 installed, preferably via https://sdkman.io/.
- [`jq`](https://jqlang.github.io/jq/download/) installed
- Java FHIR Validator JAR downloaded and put into folder `FHIR-validator`, see [here](https://github.com/sid-indonesia/fhir-specification/tree/main/FHIR-validator).

### Steps

- Within a command line (e.g. [Git Bash](https://www.atlassian.com/git/tutorials/git-bash)), go to the root folder of the project (`fhir-specification`)
- Optionally, within `scripts/validate_locally_examples.sh` change the `PATH_TO_EXAMPLES` value to only the folder containing all the FHIR resources that you want to check for their validity.
- Execute `./scripts/validate_locally_examples.sh`
