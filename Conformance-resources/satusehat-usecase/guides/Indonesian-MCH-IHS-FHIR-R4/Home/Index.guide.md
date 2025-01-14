# Indonesia FHIR R4 Implementation Guide 0.1.0
This Implementation Guide is Pre-Release 0.1.0 of SATUSEHAT FHIR R4 (ID Core).

This implementation guide provides support for integrating HL7 FHIR to SATUSEHAT. It includes functional business context and design guidance for implementing FHIR profiles to consume and update patients data.

This implementation guide is based on FHIR R4.

This guidance is under active development by Digital Trasformation Office, Ministry of Health, Government of Indonesia (DTO) and content may be added or updated on a regular basis.

**Note:** Work In Progress. This Implementation Guide's content is immediately published when written and may contain errors, incomplete text, inconsistent content, etc.

## Background
SATUSEHAT (formerly known as Indonesian Health Services (IHS)) is a platform and repository that stores identifiers and clinical data pertaining to patients who have received health care in Indonesia. It enables organizations to uniquely identify patients based on their local or global identifiers (e.g. MRN or IHS Digital Number or NIK) and demographic information. The repository also enables the merging of duplicate records from a variety of contributing sources, leading to improved quality of client information across different health care organizations.

## Scope
The Scope of this pre-release is only to provide FHIR assets and guidance for external review. This guide MUST not be implemented, and there is NO current release that can be used for that purpose yet.

## Intended Audience
The audience for this specification includes vendors or organizations implementing the specifications contained in this guide as part of the Indonesia Health Service platform development. This includes technical and business audiences who will use it to develop implementations and validate that they conform to the specifications and requirements of stakeholder organizations.

Readers are expected to have a basic understanding of HL7 FHIR, general health data exchange, and the RESTful HL7 FHIR paradigm.

## Document Control
This electronic version of the implementation guide is recognized as the only valid version.

## Disclaimer
You understand that the information in this specification may be subject to change at any time and that we cannot be responsible for the completeness, currency, accuracy, or applicability of this specification, or any information contained in it, to your needs or the needs of any other party.

## License
This Implementation Guide is licensed under a Creative Commons Attribution-NoDerivatives 4.0 International License; you may not use this file except in compliance with the License. You may obtain a copy of the License at http://creativecommons.org/licenses/by-nd/4.0.

HL7® FHIR® standard Copyright © 2011+ HL7 The HL7® FHIR® standard is used under the FHIR license. You may obtain a copy of the FHIR license at https://www.hl7.org/fhir/license.html.

## Publisher
Developed and authored by USAID Country Health Information Systems and Data Use (CHISU) to support Digital Transformation Office (DTO) Ministry of Health Republic of Indonesia.<br>
<img src="https://victoriatjia.github.io/Guideline/SatuSehat/Simplifier/logo_usaid_chisu_kemkes.png"  style="width: 70%;">

<!--<img src="https://victoriatjia.github.io/Guideline/SatuSehat/Specs%20Format%20FHIR/logo_kemkes.png" style="width: 17%;">
<img src="https://victoriatjia.github.io/Guideline/SatuSehat/Specs%20Format%20FHIR/logo_usaid.png" style="width: 20%; margin-left: 30px;">
<img src="https://victoriatjia.github.io/Guideline/SatuSehat/Specs%20Format%20FHIR/logo_chisu.png" style="width: 14%; margin-left: 30px;">-->