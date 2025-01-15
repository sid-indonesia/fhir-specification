#!/bin/bash
java \
  -Dfile.encoding=UTF-8 \
  -jar FHIR-validator/validator_cli.jar \
  ./Conformance-resources/satusehat-usecase/*.xml \
  ./Conformance-resources/satusehat-usecase/*.json \
  ./Conformance-resources/satusehat-usecase/StructureDefinition/*.xml \
  ./Conformance-resources/satusehat-usecase/StructureDefinition/*.json \
  -version 4.0 \
  -output-style compact \
  \
  -ig ./Conformance-resources/satusehat-usecase \
  -ig ./Conformance-resources/satusehat-usecase/StructureDefinition \
  && \
  # -ig ./Conformance-resources/id-fhir \
  # -ig ./Conformance-resources/id-fhir/example \
  # -ig ./Conformance-resources/id-fhir/guides \
  # -ig ./Conformance-resources/satusehat-usecase/ANC \
  # -ig ./Conformance-resources/satusehat-usecase/covid \
  # -ig ./Conformance-resources/satusehat-usecase/example \
  # -ig ./Conformance-resources/satusehat-usecase/guides \
  # -ig ./Conformance-resources/satusehat-usecase/HealthFinancibng/01KlaimBPJS \

echo "Success run FHIR Validator"
