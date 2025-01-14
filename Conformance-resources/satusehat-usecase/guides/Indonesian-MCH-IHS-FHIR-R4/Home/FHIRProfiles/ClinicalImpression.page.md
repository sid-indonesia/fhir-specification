# {{page-title}}
Defines the ID Core constraints and extension on the record of a clinical assessment performed to determine what problem(s) may affect the patient and before planning the treatments or management strategies that are best to manage a patient's condition. Assessments are often 1:1 with a clinical consultation / encounter, but this varies greatly depending on the clinical workflow. This resource is called "ClinicalImpression" rather than "ClinicalAssessment" to avoid confusion with the recording of assessment tools such as Apgar score.

## Usage
Performing a clinical assessment is a fundamental part of a clinician's workflow, performed repeatedly throughout the day. In spite of this - or perhaps, because of it - there is wide variance in how clinical impressions are recorded. Some clinical assessments simply result in an impression recorded as a single text note in the patient 'record' (e.g. "Progress satisfactory, continue with treatment"), while others are associated with careful, detailed record keeping of the evidence gathered and the reasoning leading to a differential diagnosis, and there is a continuum between these. This resource is intended to be used to cover all these use cases.

The assessment is intimately linked to the process of care. It may occur in the context of a care plan, and it very often results in a new (or revised) care plan. Normally, clinical assessments are part of an ongoing process of care, and the patient will be re-assessed repeatedly. For this reason, the clinical impression can explicitly reference both care plans (preceding and resulting) and reference a previous impression that this impression follows.

An impression is a clinical summation of information and/or an opinion formed, which is the outcome of the clinical assessment process. The ClinicalImpression may lead to a statement of a Condition about a patient.

## URL
|Type|URL|
|-
|Canonical|https://fhir.kemkes.go.id/r4/StructureDefinition/ClinicalImpression|

## Structure
### Snapshot
<div>
{{tree:id-fhir/clinicalimpression, snapshot}}
</div>

## Examples

## Dictionary
{{dict:id-fhir/clinicalimpression}} 
