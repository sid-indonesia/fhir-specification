# {{page-title}}
Defines the ID Core constraints and extensions on the CarePlan resource for the minimal set of data to query and retrieve care plan information.

## Usage
This profile describes the intention of how one or more practitioners intend to deliver care for a particular patient, group or community for a period of time, possibly limited to care for a specific condition or set of conditions.

Care Plans are used in many areas of healthcare with a variety of scopes. They can be as simple as a general practitioner keeping track of when their patient is next due for a tetanus immunization through to a detailed plan for an oncology patient covering diet, chemotherapy, radiation, lab work and counseling with detailed timing relationships, pre-conditions and goals. They may be used in veterinary care or clinical research to describe the care of a herd or other collection of animals. In public health, they may describe education or immunization campaigns.

This resource takes an intermediate approach to complexity. It captures basic details about who is involved and what actions are intended without dealing in discrete data about dependencies and timing relationships. These can be supported where necessary using the extension mechanism.

## URL
|Type|URL|
|-
|Canonical|https://fhir.kemkes.go.id/r4/StructureDefinition/CarePlan|

## Structure
### Snapshot
<div>
{{tree:id-fhir/careplan, snapshot}}
</div>

## Dictionary
{{dict:id-fhir/careplan}} 
