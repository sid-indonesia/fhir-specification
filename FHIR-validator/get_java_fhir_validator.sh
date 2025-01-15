#!/bin/bash
JAVA_VALIDATOR_VERSION=6.5.5
JAVA_VALIDATOR_DOWNLOAD_LOCATION=https://github.com/hapifhir/org.hl7.fhir.core/releases/download/$JAVA_VALIDATOR_VERSION/validator_cli.jar
FHIR_VALIDATOR_JAR_FOLDER=FHIR-validator

CHECK_JAVA_VERSION=$(java -version 2>&1 | head -1 | cut -d'"' -f2)
echo "JAVA_VERSION: $CHECK_JAVA_VERSION"
echo "JAVA_VALIDATOR_VERSION: $JAVA_VALIDATOR_VERSION"
JAVA_VALIDATOR_DOWNLOAD_LOCATION=$(eval echo "$JAVA_VALIDATOR_DOWNLOAD_LOCATION")
echo "JAVA_VALIDATOR_DOWNLOAD_LOCATION: $JAVA_VALIDATOR_DOWNLOAD_LOCATION"

wget -q $JAVA_VALIDATOR_DOWNLOAD_LOCATION -O ${FHIR_VALIDATOR_JAR_FOLDER}/validator_cli.jar
# https://github.com/hapifhir/org.hl7.fhir.core/releases/download/6.5.5/validator_cli.jar
