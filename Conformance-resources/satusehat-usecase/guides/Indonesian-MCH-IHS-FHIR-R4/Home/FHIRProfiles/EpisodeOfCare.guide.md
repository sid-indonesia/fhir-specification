# {{page-title}}
Defines the ID Core constraints and extensions on the EpisodeOfCare resource for the minimal set of data to query and retrieve episode of care information.


## Usage
This profile allows exchange of information about an association between a patient and an organisation / healthcare provider(s) during which time encounters may occur. The managing organisation assumes a level of responsibility for the individual during this time.

## Relation with the Encounter
The EpisodeOfCare Resource contains information about an association of a Patient with a Healthcare Provider for a period of time under which related healthcare activities may occur.

In many cases, this represents a period of time where the Healthcare Provider has some level of responsibility for the care of the patient regarding a specific condition or problem, even if not currently participating in an encounter.

These resources are typically known in existing systems as:
- EpisodeOfCare: Case, Program, Problem, Episode
- Encounter: Visit, Contact.


## URL
|Type|URL|
|-
|Canonical|https://fhir.kemkes.go.id/r4/StructureDefinition/EpisodeOfCare|

## Structure
### Snapshot
<div>
{{tree:id-fhir/episodeofcare, snapshot}}
</div>

## Examples

## Dictionary
{{dict:id-fhir/episodeofcare}} 
