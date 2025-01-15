#!/bin/bash

INPUT_JAVA_VALIDATION_ENABLED=true
INPUT_PATH_TO_CONFORMANCE_RESOURCES=Conformance-resources
GITHUB_WORKSPACE=.
PATH_TO_EXAMPLES=Examples
INPUT_EXPECTED_FAILS=
FHIR_VERSION=4.0
INPUT_JAVA_VALIDATION_OPTIONS="-output-style compact"



# Define color codes
ERROR=$'\033[0;31m'
WARN=$'\033[0;33m'
INFO=$'\033[0;34m'
OK=$'\033[0;32m'
NC=$'\033[0m'

if $INPUT_JAVA_VALIDATION_ENABLED; then
  IG_DEPENDENCIES=$(jq -r '(.dependencies + .["zts-dependencies"]) | to_entries | map("-ig " + .key + "#" + .value) | join(" ")' package.json)
  for p in $INPUT_PATH_TO_CONFORMANCE_RESOURCES; do # Get combined path to conformance resources, we want to validate against the current version of the conformance resources
    COMBINED_IG_PARAMETERS+="-ig $GITHUB_WORKSPACE/$p "
  done

  for p in $PATH_TO_EXAMPLES; do

    # Ensure directory ends with "/"
    if [[ ! "$p" =~ .*/$ ]]; then
      p="$p/"
    fi

    UNESCPAED_IG_DEPENDENCIES=$(echo $IG_DEPENDENCIES | tr -d '"')

    if echo $INPUT_EXPECTED_FAILS | grep -w -q VALIDATION_EXAMPLES_JAVA; then
      echo "javaValidatorOutput=\$(java -jar FHIR-validator/validator_cli.jar $GITHUB_WORKSPACE/$p*.xml $GITHUB_WORKSPACE/$p*.json -version $FHIR_VERSION $INPUT_JAVA_VALIDATION_OPTIONS $UNESCPAED_IG_DEPENDENCIES $COMBINED_IG_PARAMETERS || true)"
    else
      echo "javaValidatorOutput=\$(java -jar FHIR-validator/validator_cli.jar $GITHUB_WORKSPACE/$p*.xml $GITHUB_WORKSPACE/$p*.json -version $FHIR_VERSION $INPUT_JAVA_VALIDATION_OPTIONS $UNESCPAED_IG_DEPENDENCIES $COMBINED_IG_PARAMETERS)"
    fi

    # javaValidatorOutput=$(echo "$javaValidatorOutput" | sed -E "
    #           s/(:[[:space:]]*)Error([[:space:]]+-)/\1${ERROR}Error${NC}\2/g;
    #           s/(:[[:space:]]*)Warning([[:space:]]+-)/\1${WARN}Warning${NC}\2/g;
    #           s/(:[[:space:]]*)Information([[:space:]]+-)/\1${INFO}Information${NC}\2/g;
    #           s/(-[[:space:]]+)All OK/\1${OK}All OK${NC}/g
    #         ")
    # echo -e "$javaValidatorOutput"

  done
fi
