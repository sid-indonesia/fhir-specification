#!/bin/bash
java \
  -Dfile.encoding=UTF-8 \
  -jar FHIR-validator/validator_cli.jar \
  ./Examples/Correct/*.xml \
  ./Examples/Correct/*.json \
  ./Examples/Correct/NonFHIRToFHIR/ePus/*.xml \
  ./Examples/Correct/NonFHIRToFHIR/ePus/*.json \
  ./Examples/Correct/NonFHIRToFHIR/sidKobo/*.xml \
  ./Examples/Correct/NonFHIRToFHIR/sidKobo/*.json \
  -version 4.0 \
  -output-style compact \
  \
  && \
  # -ig ./Conformance-resources/satusehat-usecase \
  # -ig ./Conformance-resources/satusehat-usecase/StructureDefinition \
  # -ig ./Conformance-resources/id-fhir \
  # -ig ./Conformance-resources/id-fhir/example \
  # -ig ./Conformance-resources/id-fhir/guides \
  # -ig ./Conformance-resources/satusehat-usecase \
  # -ig ./Conformance-resources/satusehat-usecase/ANC \
  # -ig ./Conformance-resources/satusehat-usecase/covid \
  # -ig ./Conformance-resources/satusehat-usecase/example \
  # -ig ./Conformance-resources/satusehat-usecase/guides \
  # -ig ./Conformance-resources/satusehat-usecase/HealthFinancibng/01KlaimBPJS \
  # -ig ./Conformance-resources/satusehat-usecase/StructureDefinition \
  # -ig ./Conformance-resources/satusehat-usecase/StructureDefinition/complex-type \

echo "Success run FHIR Validator"
