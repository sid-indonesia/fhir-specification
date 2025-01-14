# {{page-title}}
Defines the ID Core constraints and extensions on the ServiceRequest resource for the minimal set of data to query and retrieve record of a proposal/plan or order for a service to be performed.

## Usage
ServiceRequest is a record of a request for a procedure or diagnostic or other service to be planned, proposed, or performed, as distinguished by the ServiceRequest.intent field value, with or on a patient. The procedure will lead to either a Procedure or DiagnosticReport, which in turn may reference one or more Observations, which summarize the performance of the procedures and associated documentation such as observations, images, findings that are relevant to the treatment/management of the subject. This resource may be used to share relevant information required to support a referral or a transfer of care request from one practitioner or organization to another when a patient is required to be referred to another provider for a consultation/second opinion and/or for short term or longer term management of one or more health issues or problems.

## URL
|Type|URL|
|-
|Canonical|https://fhir.kemkes.go.id/r4/StructureDefinition/ServiceRequest|

## Structure
### Snapshot
<div>
{{tree:id-fhir/servicerequest, snapshot}}
</div>

## Examples

## Dictionary
{{dict:id-fhir/servicerequest}} 
