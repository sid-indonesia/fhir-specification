# {{page-title}}
Defines the ID Core constraints and extensions on the Observation resource for the minimal set of data to query and retrieve observation value associated with laboratory results for a patient.

## Usage
The purpose of this profile is to provide detailed information about measurements and simple assertions made about a patient, device or other subject.

[1]: http://hl7.org/fhir/StructureDefinition/DiagnosticReport "DiagnosticReport"
[2]: http://hl7.org/fhir/StructureDefinition/Observation "Observation"
Observations are a central element in healthcare, used to support diagnosis, monitor progress, determine baselines and patterns and even capture demographic characteristics. Most observations are simple name/value pair assertions with some metadata, but some observations group other observations together logically, or even are multi-component observations. Note that the [DiagnosticReport][1] resource provides a clinical or workflow context for a set of observations and the [Observation][2] resource is referenced by DiagnosticReport to represent laboratory, imaging, and other clinical and diagnostic data to form a complete report.

## URL
|Type|URL|
|-
|Canonical|https://fhir.kemkes.go.id/r4/StructureDefinition/Observation|

## Structure
### Snapshot
<div>
{{tree:id-fhir/observation, snapshot}}
</div>

## Examples

## Dictionary
{{dict:id-fhir/observation}} 
