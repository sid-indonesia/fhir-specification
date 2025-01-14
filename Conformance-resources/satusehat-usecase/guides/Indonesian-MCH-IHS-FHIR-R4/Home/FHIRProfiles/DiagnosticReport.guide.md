# {{page-title}}
Defines the ID Core constraints and extensions on the DiagnosticReport resource for the minimal set of data to query and retrieve diagnostic reports associated with laboratory results for a patient.

## Usage
A diagnostic report is the set of information that is typically provided by a diagnostic service when investigations are complete. The information includes a mix of atomic results, text reports, images, and codes. The mix varies depending on the nature of the diagnostic procedure, and sometimes on the nature of the outcomes for a particular investigation.

The DiagnosticReport resource has information about the diagnostic report itself, and about the subject and, in the case of laboratory tests, the specimen of the report. It can also refer to the request details and atomic observations details or image instances. Report conclusions can be expressed as a simple text blob, structured coded data or as an attached fully formatted report such as a PDF.

The DiagnosticReport resource is suitable for the following kinds of diagnostic reports:

- Laboratory (Clinical Chemistry, Hematology, Microbiology, etc.)
- Pathology / Histopathology / related disciplines
- Imaging Investigations (x-ray, CT, MRI etc.)
- Other diagnostics - Cardiology, Gastroenterology etc.

[1]: http://hl7.org/fhir/StructureDefinition/DiagnosticReport "DiagnosticReport"
[2]: http://hl7.org/fhir/StructureDefinition/Observation "Observation"
Laboratory results are grouped and summarized using the [DiagnosticReport][1] resource which typically reference [Observation][2] resource(s). Each Observation resource represents an individual laboratory test and result value or component result values, or a “nested” panel which references other observations. They can also be presented in report form or as free text (e.g. radiology expertise).

The DiagnosticReport resource is not intended to support cumulative result presentation (tabular presentation of past and present results in the resource).

## URL
|Type|URL|
|-
|Canonical|https://fhir.kemkes.go.id/r4/StructureDefinition/DiagnosticReport|

## Structure
### Snapshot
<div>
{{tree:id-fhir/diagnosticreport, snapshot}}
</div>

## Examples

## Dictionary
{{dict:id-fhir/diagnosticreport}} 
