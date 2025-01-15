#!/bin/bash
java -jar FHIR-validator/validator_cli.jar ./Examples/*.xml ./Examples/*.json -version 4.0 -output-style compact -ig hl7.fhir.id.core#0.1.0 -ig ./Conformance-resources
