## D. Kunjungan Pengobatan Bulanan

Saat pasien melakukan kunjungan perawatan TB setiap bulannya selama proses pengobatan (_sesuai desain integrasi SITB hasil dilaporkan pada bulan 2, 3 dan 5_). Setiap kunjungan harus dibungkus dengan Resource Encounter dengan menyebutkan referensi ID EpisodeOfCare pada tiap Encounter tersebut untuk menandakan kunjungan dalam satu episode yang sama.

![alt text](https://raw.githubusercontent.com/kemkes/fhir-ig-tb-assets/main/images/tb-frame-2.jpg "Kunjungan Pengobatan TB Bulanan")

### I. Berbasis Resouce
**Entry Resources yang digunakan**

| No  | Nama Resource          | Entry Mandatory | Metode               |
| --- |:-----------------------| --------------- |:---------------------|
| 1   | __Encounter__          | __Required__    | __BUAT BARU (POST)__ |
| 2   | __DiagnosticReport__   | __Required__    | __BUAT BARU (POST)__ |
| 3   | __Observation__        | __Required__    | __BUAT BARU (POST)__ |
| 4   | __Medication__         | _Optional_      | __BUAT BARU (POST)__ |
| 5   | __MedicationRequest__  | _Optional_      | __BUAT BARU (POST)__ |

#### 1. Encouter
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-13" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-13" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-13" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
</ul>
<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-13">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:Encounter-Create}}
        </div>
    </div>
    <div role="tabpanel" class="tab-pane" id="data-13">
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Encounter",
    "identifier": [
        {
            "system": "http://sys-ids.kemkes.go.id/encounter/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_LOCAL_CODE&rcub;&rcub;</strong>"
        }
    ],
    "status": "arrived",
    "class": {
        "system": "http://terminology.hl7.org/CodeSystem/v3-ActCode",
        "code": "AMB",
        "display": "ambulatory"
    },
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>",
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "participant": [
        {
            "type": [
                {
                    "coding": [
                        {
                            "system": "http://terminology.hl7.org/CodeSystem/v3-ParticipationType",
                            "code": "ATND",
                            "display": "attender"
                        }
                    ]
                }
            ],
            "individual": {
                "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_IHS_NUMBER&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_NAME&rcub;&rcub;</strong>"
            }
        }
    ],
    "period": {
        "start": "<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_PERIOD1_START&rcub;&rcub;</strong>"
    },
    "location": [
        {
            "location": {
                "reference": "Location/<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_LOCATION_ID&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_LOCATION_NAME&rcub;&rcub;</strong>"
            }
        }
    ],
    "statusHistory": [
        {
            "status": "arrived",
            "period": {
                "start": "<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_PERIOD1_START&rcub;&rcub;</strong>",
                "end": "<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_PERIOD1_END&rcub;&rcub;</strong>"
            }
        }
    ],
    "serviceProvider": {
        "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>"
    }
}
        </pre>
    </div>
    <div role="tabpanel" class="tab-pane" id="variabel-13" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ENCOUNTER_LOCAL_CODE__   | ID Lokal untuk Kunjungan/Encounter |
| __PATIENT_IHS_NUMBER__     | SATUSEHAT ID Number untuk Pasien |
| __PATIENT_NAME__           | Nama Pasien |
| __DOCTOR_IHS_NUMBER__      | SATUSEHAT ID untuk Dokter/Nakes |
| __DOCTOR_NAME__            | Nama Dokter/Nakes |
| __FACILITY_IHS_NUMBER__    | SATUSEHAT ID untuk FASYANKES |
| __ENCOUNTER_PERIOD1_START__| Waktu mulai/check-in kunjungan |
| __ENCOUNTER_PERIOD1_END__  | Waktu mulai/check-out kunjungan |
| __ENCOUNTER_LOCATION_ID__  | ID Location tempat kunjungan dilakukan |
| __ENCOUNTER_LOCATION_NAME__| Nama Location tempat kunjungan dilakukan |
</div>
    </div>
</div>

#### 2. DiagnosticReport
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-15" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-15" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-15" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-15" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>
<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-15">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:DiagnosticReport-Create-BTA1}}
        </div>
    </div>
    <div role="tabpanel" class="tab-pane" id="data-15">
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "DiagnosticReport",
    "identifier": [
        {
            "system": "http://sys-ids.kemkes.go.id/diagnostic/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>/lab",
            "use": "official",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;DIAGNOSTICREPORT_LOCAL_CODE&rcub;&rcub;</strong>"
        }
    ],
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/v2-0074",
                    "code": "MB",
                    "display": "Microbiology"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://loinc.org",
                "code": "11477-7",
                "display": "Microscopic observation [Identifier] in Sputum by Acid fast stain"
            }
        ]
    },
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>"
    },
    "encounter": {
        "reference": "Encounter/<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_REFERENCE_ID&rcub;&rcub;</strong>"
    },
    "effectiveDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_EFFECTIVE_DATETIME&rcub;&rcub;</strong>",
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_IHS_NUMBER&rcub;&rcub;</strong>"
        },
        {
            "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "result": [
        {
            "reference": "Observation/<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION1_REFERENCE_ID&rcub;&rcub;</strong>",
            "display": "Microscopic observation [Identifier] in Sputum by Acid fast stain"
        }
    ],
    "conclusionCode": [
        {
            "coding": [
                {
                    "system": "http://snomed.info/sct",
                    "code": "260347006",
                    "display": "+"
                }
            ]
        }
    ]
}
        </pre>
    </div>
    <div role="tabpanel" class="tab-pane" id="variabel-15" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                  | Deskripsi |
| ------------------------- | --------- |
| __$GENERATED_UUID_DIAGNOSTIC_REPORT__ | UUID DiagnosticReport yang digenerate |
| __$GENERATED_UUID_OBSERVATION_1__ | UUID pemeriksaan mikroskopis yang digenerate |
| __$GENERATED_UUID_ENCOUNTER__ | UUID Encounter yang digenerate |
| __$IHS_NUMBER_PASIEN__    | SATUSEHAT ID Number untuk Pasien |
| __$IHS_NUMBER_FASYANKES__ | SATUSEHAT ID Number untuk FASYANKES |
| __$NAMA_FASYANKES__ | Nama FASYANKES |
</div>
    </div>
    <div role="tabpanel" class="tab-pane" id="valueset-15" style="border: 1px solid #e8edee; padding: 15px 10px;">
        <div>
        </div>
    </div>
</div>

#### 3. Observation
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-16" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-16" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-16" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-16" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>
<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-16">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:Observation-Create-BTA1}}
        </div>
    </div>
    <div role="tabpanel" class="tab-pane" id="data-16">
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "identifier": [
        {
            "system": "http://sys-ids.kemkes.go.id/observation/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION1_LOCAL_CODE&rcub;&rcub;</strong>"
        }
    ],
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "laboratory",
                    "display": "Laboratory"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://loinc.org",
                "code": "11477-7",
                "display": "Microscopic observation [Identifier] in Sputum by Acid fast stain"
            }
        ]
    },
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>"
    },
    "encounter": {
        "reference": "Encounter/<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_REFERENCE_ID&rcub;&rcub;</strong>"
    },
    "effectiveDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_EFFECTIVE_DATETIME&rcub;&rcub;</strong>",
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_IHS_NUMBER&rcub;&rcub;</strong>"
        },
        {
            "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueCodeableConcept": {
        "coding": [
            {
                "system": "http://snomed.info/sct",
                "code": "260347006",
                "display": "+"
            }
        ]
    },
    "referenceRange": [
        {
            "text": "Negative"
        }
    ]
}
        </pre>
    </div>
    <div role="tabpanel" class="tab-pane" id="variabel-16" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                  | Deskripsi |
| ------------------------- | --------- |
| __$GENERATED_UUID_ENCOUNTER__ | UUID Encounter yang digenerate |
| __$CODE_OBSERVATION_1__   | CodeSystem pemeriksaan mikroskopis |
| __$VALUE_OBSERVATION_1__  | Value pemeriksaan mikroskopis |
</div>
    </div>
    <div role="tabpanel" class="tab-pane" id="valueset-16" style="border: 1px solid #e8edee; padding: 15px 10px;">
        <div>
        </div>
    </div>
</div>

#### 4. Medication
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-29" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-29" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-29" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-29" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>
<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-29">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:example-TB-Medication-Create-FDC}}
        </div>
    </div>
    <div role="tabpanel" class="tab-pane" id="data-29">
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Medication",
    "identifier": [
        {
            "system": "http://sys-ids.kemkes.go.id/medication/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "use": "official",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION1_LOCAL_CODE&rcub;&rcub;</strong>"
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://sys-ids.kemkes.go.id/kfa",
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION1_CODE_CODE&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION1_CODE_DISPLAY&rcub;&rcub;</strong>"
            }
        ]
    },
    "status": "active",
    "manufacturer": {
        "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>"
    },
    "form": {
        "coding": [
            {
                "system": "https://terminology.kemkes.go.id/CodeSystem/medication-form",
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION1_FORM_CODE&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION1_FORM_DISPLAY&rcub;&rcub;</strong>"
            }
        ]
    },
    "ingredient": [
        {
            "itemCodeableConcept": {
                "coding": [
                    {
                        "system": "http://sys-ids.kemkes.go.id/kfa",
                        "code": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION1_INGREDIENT1_CODE&rcub;&rcub;</strong>",
                        "display": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION1_INGREDIENT1_DISPLAY&rcub;&rcub;</strong>"
                    }
                ]
            },
            "isActive": true,
            "strength": {
                "numerator": {
                    "value": <strong style="color:#00a7ff">&lcub;&lcub;MEDICATION1_INGREDIENT1_NUMERATOR_VALUE&rcub;&rcub;</strong>,
                    "system": "http://unitsofmeasure.org",
                    "code": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION_INGREDIENT_NUMERATOR_CODE&rcub;&rcub;</strong>"
                },
                "denominator": {
                    "value": <strong style="color:#00a7ff">&lcub;&lcub;MEDICATION1_INGREDIENT1_DENUMERATOR_VALUE&rcub;&rcub;</strong>,
                    "system": "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm",
                    "code": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION_INGREDIENT_DENUMERATOR_CODE1&rcub;&rcub;</strong>"
                }
            }
        },
        {
            "itemCodeableConcept": {
                "coding": [
                    {
                        "system": "http://sys-ids.kemkes.go.id/kfa",
                        "code": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION1_INGREDIENT2_CODE&rcub;&rcub;</strong>",
                        "display": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION1_INGREDIENT2_DISPLAY&rcub;&rcub;</strong>"
                    }
                ]
            },
            "isActive": true,
            "strength": {
                "numerator": {
                    "value": <strong style="color:#00a7ff">&lcub;&lcub;MEDICATION1_INGREDIENT2_DENUMERATOR_VALUE&rcub;&rcub;</strong>,
                    "system": "http://unitsofmeasure.org",
                    "code": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION_INGREDIENT_NUMERATOR_CODE&rcub;&rcub;</strong>"
                },
                "denominator": {
                    "value": <strong style="color:#00a7ff">&lcub;&lcub;MEDICATION1_INGREDIENT2_DENUMERATOR_VALUE&rcub;&rcub;</strong>,
                    "system": "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm",
                    "code": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION_INGREDIENT_DENUMERATOR_CODE1&rcub;&rcub;</strong>"
                }
            }
        },
        {
            "itemCodeableConcept": {
                "coding": [
                    {
                        "system": "http://sys-ids.kemkes.go.id/kfa",
                        "code": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION1_INGREDIENT3_CODE&rcub;&rcub;</strong>",
                        "display": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION1_INGREDIENT3_DISPLAY&rcub;&rcub;</strong>"
                    }
                ]
            },
            "isActive": true,
            "strength": {
                "numerator": {
                    "value": <strong style="color:#00a7ff">&lcub;&lcub;MEDICATION1_INGREDIENT3_DENUMERATOR_VALUE&rcub;&rcub;</strong>,
                    "system": "http://unitsofmeasure.org",
                    "code": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION_INGREDIENT_NUMERATOR_CODE&rcub;&rcub;</strong>"
                },
                "denominator": {
                    "value": <strong style="color:#00a7ff">&lcub;&lcub;MEDICATION1_INGREDIENT3_DENUMERATOR_VALUE&rcub;&rcub;</strong>,
                    "system": "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm",
                    "code": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION_INGREDIENT_DENUMERATOR_CODE1&rcub;&rcub;</strong>"
                }
            }
        },
        {
            "itemCodeableConcept": {
                "coding": [
                    {
                        "system": "http://sys-ids.kemkes.go.id/kfa",
                        "code": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION1_INGREDIENT4_CODE&rcub;&rcub;</strong>",
                        "display": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION1_INGREDIENT4_DISPLAY&rcub;&rcub;</strong>"
                    }
                ]
            },
            "isActive": true,
            "strength": {
                "numerator": {
                    "value": <strong style="color:#00a7ff">&lcub;&lcub;MEDICATION1_INGREDIENT4_DENUMERATOR_VALUE&rcub;&rcub;</strong>,
                    "system": "http://unitsofmeasure.org",
                    "code": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION_INGREDIENT_NUMERATOR_CODE&rcub;&rcub;</strong>"
                },
                "denominator": {
                    "value": <strong style="color:#00a7ff">&lcub;&lcub;MEDICATION1_INGREDIENT4_DENUMERATOR_VALUE&rcub;&rcub;</strong>,
                    "system": "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm",
                    "code": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION_INGREDIENT_DENUMERATOR_CODE1&rcub;&rcub;</strong>"
                }
            }
        }
    ],
   "extension": [
       {
           "url": "https://fhir.kemkes.go.id/r4/StructureDefinition/MedicationType",
           "valueCodeableConcept": {
               "coding": [
                   {
                       "system": "https://terminology.kemkes.go.id/CodeSystem/medication-type",
                       "code": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION1_TYPE_CODE&rcub;&rcub;</strong>",
                       "display": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION1_TYPE_DISPLAY&rcub;&rcub;</strong>"
                   }
               ]
           }
       }
   ]
}
        </pre>
    </div>
    <div role="tabpanel" class="tab-pane" id="variabel-29" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                  | Deskripsi |
| ------------------------- | --------- |
| __$GENERATED_UUID_MEDICATION_DISPENSE__ | UUID MedicationRequest yang digenerate |
| __$GENERATED_UUID_MEDICATION_REQUEST__ | UUID MedicationRequest yang digenerate |
| __$IHS_NUMBER_PASIEN__    | SATUSEHAT ID Number untuk Pasien |
| __$NAMA_PASIEN__          | Nama Pasien |
| __$IHS_NUMBER_DOKTER__    | SATUSEHAT ID Number untuk Dokter/Nakes |
| __$GENERATED_UUID_EPISODEOFCARE__ | UUID EpisodeOfCare yang digenerate |
| __$GENERATED_UUID_MEDICATION__ | UUID Medication yang digenerate |
| __$DATETIME_OBAT_DISIAPKAN__          | Tanggal dan jam obat disiapkan |
| __$DATETIME_OBAT_DIBERIKAN__          | Tanggal dan jam obat diberikan |
| __$DATE_MULAI_PENGOBATAN__          | Tanggal mulai pemberian obat |
| __$DATE_KUNJUNGAN_BULANAN_BERIKUTNYA__          | Tanggal kunjungan ulang (kontrol) bulan berikutnya |

</div>
    </div>
    <div role="tabpanel" class="tab-pane" id="valueset-29" style="border: 1px solid #e8edee; padding: 15px 10px;">
        <div>
        </div>
    </div>
</div>

#### 5. MedicationRequest
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-30" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-30" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-30" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-30" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>
<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-30">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:example-TB-MedicationRequest-Create}}
        </div>
    </div>
    <div role="tabpanel" class="tab-pane" id="data-30">
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "MedicationRequest",
    "identifier": [
        {
            "system": "http://sys-ids.kemkes.go.id/prescription/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "use": "official",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATIONREQ_LOCAL1_CODE&rcub;&rcub;</strong>"
        },
        {
            "system": "http://sys-ids.kemkes.go.id/prescription-item/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "use": "official",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATIONREQ_LOCAL2_CODE&rcub;&rcub;</strong>"
        }
    ],
    "status": "completed",
    "statusReason": {
        "coding": [
            {
                "system": "http://terminology.hl7.org/CodeSystem/medicationrequest-status-reason",
                "code": "clarif",
                "display": "Prescription requires clarification"
            }
        ]
    },
    "intent": "order",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/medicationrequest-category",
                    "code": "outpatient",
                    "display": "Outpatient"
                }
            ]
        }
    ],
    "priority": "routine",
    "medicationReference": {
        "reference": "Medication/<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION1_RERERENCE_ID&rcub;&rcub;</strong>",
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION1_CODE_DISPLAY&rcub;&rcub;</strong>"
    },
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>",
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "encounter": {
        "reference": "Encounter/<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_REFERENCE_ID&rcub;&rcub;</strong>"
    },
    "authoredOn": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATIONREQ_AUTHOREDON&rcub;&rcub;</strong>",
    "requester": {
        "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_IHS_NUMBER&rcub;&rcub;</strong>",
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_NAME&rcub;&rcub;</strong>"
    },
    "performerType": {
        "coding": [
            {
                "system": "http://snomed.info/sct",
                "code": "309343006",
                "display": "Physician"
            }
        ]
    },
    "reasonCode": [
        {
            "coding": [
                {
                    "system": "http://hl7.org/fhir/sid/icd-10",
                    "code": "<strong style="color:#00a7ff">&lcub;&lcub;CONDITION1_ICD_CODE&rcub;&rcub;</strong>",
                    "display": "<strong style="color:#00a7ff">&lcub;&lcub;CONDITION1_ICD_DISPLAY&rcub;&rcub;</strong>"
                }
            ]
        }
    ],
    "courseOfTherapyType": {
        "coding": [
            {
                "system": "http://terminology.hl7.org/CodeSystem/medicationrequest-course-of-therapy",
                "code": "continuous",
                "display": "Continuing long term therapy"
            }
        ]
    },
    "dosageInstruction": [
        {
            "sequence": 1,
            "text": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATIONREQ_DOSAGE_TEXT&rcub;&rcub;</strong>",
            "additionalInstruction": [
                {
                    "text": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATIONREQ_DOSAGE_TEXT_ADD&rcub;&rcub;</strong>"
                }
            ],
            "patientInstruction": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATIONREQ_DOSAGE_TEXT_INSTRUCTION&rcub;&rcub;</strong>",
            "timing": {
                "repeat": {
                    "frequency": 1,
                    "period": 1,
                    "periodUnit": "d"
                }
            },
            "route": {
                "coding": [
                    {
                        "system": "http://www.whocc.no/atc",
                        "code": "O",
                        "display": "Oral"
                    }
                ]
            },
            "doseAndRate": [
                {
                    "type": {
                        "coding": [
                            {
                                "system": "http://terminology.hl7.org/CodeSystem/dose-rate-type",
                                "code": "ordered",
                                "display": "Ordered"
                            }
                        ]
                    },
                    "doseQuantity": {
                        "value": 4,
                        "unit": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATIONREQ_DOSE_UNIT&rcub;&rcub;</strong>",
                        "system": "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm",
                        "code": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATIONREQ_DOSE_UNIT&rcub;&rcub;</strong>"
                    }
                }
            ]
        }
    ],
    "dispenseRequest": {
        "dispenseInterval": {
            "value": <strong style="color:#00a7ff">&lcub;&lcub;MEDICATIONREQ_DISPENSE_INTERVAL&rcub;&rcub;</strong>,
            "unit": "days",
            "system": "http://unitsofmeasure.org",
            "code": "d"
        },
        "validityPeriod": {
            "start": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATIONREQ_DISPENSE_START&rcub;&rcub;</strong>",
            "end": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATIONREQ_DISPENSE_END&rcub;&rcub;</strong>"
        },
        "numberOfRepeatsAllowed": 0,
        "quantity": {
            "value": <strong style="color:#00a7ff">&lcub;&lcub;MEDICATIONREQ_DISPENSE_QUANTITY&rcub;&rcub;</strong>,
            "unit": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATIONREQ_DOSE_UNIT&rcub;&rcub;</strong>",
            "system": "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm",
            "code": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATIONREQ_DOSE_UNIT&rcub;&rcub;</strong>"
        },
        "expectedSupplyDuration": {
            "value": <strong style="color:#00a7ff">&lcub;&lcub;MEDICATIONREQ_DISPENSE_DURATION&rcub;&rcub;</strong>,
            "unit": "days",
            "system": "http://unitsofmeasure.org",
            "code": "d"
        }
    }
}
        </pre>
    </div>
    <div role="tabpanel" class="tab-pane" id="variabel-30" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                  | Deskripsi |
| ------------------------- | --------- |
| __$GENERATED_UUID_MEDICATION_DISPENSE__ | UUID MedicationRequest yang digenerate |
| __$GENERATED_UUID_MEDICATION_REQUEST__ | UUID MedicationRequest yang digenerate |
| __$IHS_NUMBER_PASIEN__    | SATUSEHAT ID Number untuk Pasien |
| __$NAMA_PASIEN__          | Nama Pasien |
| __$IHS_NUMBER_DOKTER__    | SATUSEHAT ID Number untuk Dokter/Nakes |
| __$GENERATED_UUID_EPISODEOFCARE__ | UUID EpisodeOfCare yang digenerate |
| __$GENERATED_UUID_MEDICATION__ | UUID Medication yang digenerate |
| __$DATETIME_OBAT_DISIAPKAN__          | Tanggal dan jam obat disiapkan |
| __$DATETIME_OBAT_DIBERIKAN__          | Tanggal dan jam obat diberikan |
| __$DATE_MULAI_PENGOBATAN__          | Tanggal mulai pemberian obat |
| __$DATE_KUNJUNGAN_BULANAN_BERIKUTNYA__          | Tanggal kunjungan ulang (kontrol) bulan berikutnya |

</div>
    </div>
    <div role="tabpanel" class="tab-pane" id="valueset-30" style="border: 1px solid #e8edee; padding: 15px 10px;">
        <div>
        </div>
    </div>
</div>

### II. Berbasis Bundle