## B. Pemeriksaan Penunjang

Pada tahap ini dilakukan pencatatan terhadap hasil pemeriksaan penunjang laboratorium atau radiologis berupa DiagnosticReport.

> `CATATAN:`
> Hasil pemeriksaan penunjang tersebut dapat mereferensi ke Encounter (kunjungan) yang sama dengan Encounter registrasi, jika hasil pemeriksaan dapat diperoleh di kunjungan (hari) yang sama. Jika hasil pemeriksaan tidak bisa segera didapatkan dan harus kembali di kunjungan berikutnya maka dapat membuat Encounter baru sesuai kunjungan tersebut.

### I. Berbasis Resource
**Entry Resources yang digunakan**

| No  | Nama Resource         | Entry Mandatory | Metode               |
| --- |:----------------------|-----------------|:---------------------|
| 1   | __Encounter__         | __Required__    | __UPDATE(PUT)__ jika pemeriksaan dilakukan dikunjungan yang sama atau __BUAT BARU(POST)__ jika berbeda kunjungan |
| 2   | __Observation__       | __Required__    | __BUAT BARU(POST)__ |
| 3   | __DiagnosticReport__  | __Required__    | __BUAT BARU(POST)__ |

#### 1. Encouter
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
</ul>
<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:Encounter-Create}}
        </div>
    </div>
    <div role="tabpanel" class="tab-pane active" id="data-3">
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
    <div role="tabpanel" class="tab-pane" id="variabel-3" style="border: 1px solid #e8edee; padding: 15px 10px;">
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

#### 2. Observation
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-5" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-5" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-5" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-5" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>
<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-5">
        <h4 style="font-weight: bold;">Hasil Pemeriksaan Mikroskopis</h4>
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:Observation-Create-BTA1}}
        </div>
        <h4 style="font-weight: bold;">Hasil Pemeriksaan Test Cepat Molekuler</h4>
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:Observation-Create-TCM}}
        </div>
        <h4 style="font-weight: bold;">Hasil Pemeriksaan Biakan</h4>
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:Observation-Create-Sputum}}
        </div>
        <h4 style="font-weight: bold;">Hasil Pemeriksaan Foto Thorax</h4>
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:Observation-Create-Thorax}}
        </div>
    </div>
    <div role="tabpanel" class="tab-pane" id="data-5">
        <h4 style="font-weight: bold;">Hasil Pemeriksaan Mikroskopis</h4>
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
        <h4 style="font-weight: bold;">Hasil Pemeriksaan Test Cepat Molekuler</h4>
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "identifier": [
        {
            "system": "http://sys-ids.kemkes.go.id/observation/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION3_LOCAL_CODE&rcub;&rcub;</strong>"
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
                "code": "88874-3",
                "display": "Mycobacterium tuberculosis complex DNA [Presence] in Isolate or Specimen by Molecular genetics method"
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
                "system": "http://loinc.org",
                "code": "LA11882-0",
                "display": "Detected"
            }
        ]
    },
    "referenceRange": [
        {
            "text": "Undetected"
        }
    ]
}
        </pre>
        <h4 style="font-weight: bold;">Hasil Pemeriksaan Biakan</h4>
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "identifier": [
        {
            "system": "http://sys-ids.kemkes.go.id/observation/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION7_LOCAL_CODE&rcub;&rcub;</strong>"
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
                "code": "539-7",
                "display": "Mycobacterium sp identified in Sputum by Organism specific culture"
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
    "dataAbsentReason": {
        "coding": [
            {
                "system": "http://terminology.hl7.org/CodeSystem/data-absent-reason",
                "code": "not-performed",
                "display": "Not Performed"
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
        <h4 style="font-weight: bold;">Hasil Pemeriksaan Foto Thorax</h4>
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "identifier": [
        {
            "system": "http://sys-ids.kemkes.go.id/observation/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION8_LOCAL_CODE&rcub;&rcub;</strong>"
        }
    ],
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/v2-0074",
                    "code": "RAD",
                    "display": "Radiology"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://loinc.org",
                "code": "24648-8",
                "display": "XR Chest PA upright"
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
    "bodySite": {
        "coding": [
            {
                "system": "http://snomed.info/sct",
                "code": "51185008",
                "display": "Chest"
            }
        ]
    },
    "valueString": "Uraian hasil pemeriksaan: foto thorax, proyeksi PA, posisi erect, asimetris, inspirasi dan kondisi cukup dengan hasil: 1) tampak cavitas inhomogen di proyeksi pulmo bilateral terutama dextra, batas tak tegas disertai penebalan fibrotic, cavitas (+), 2) tak tampak pemadatan limfonodi hilus bilateral, 3) tampak kedua costofrenicus lancip, 4) tampak kedua diafragma licin dan tak mendatar, 5) cor CTR tak valid dinilai (asimetri), tampak kalsifikasi di arcus aorta dengan bentuk crescent, 6) sistem tulang yang tervisualisasi intact. Kesan: TB paru lama aktif, besar cor tak valid dinilai, aortosclerosis",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_IHS_NUMBER&rcub;&rcub;</strong>"
        },
        {
            "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "interpretation": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation",
                    "code": "POS",
                    "display": "Positive"
                }
            ]
        }
    ],
    "referenceRange": [
        {
            "text": "No abnormalities found"
        }
    ]
}
        </pre>
    </div>
    <div role="tabpanel" class="tab-pane" id="variabel-5" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                  | Deskripsi |
| ------------------------- | --------- |
| __$GENERATED_UUID_ENCOUNTER__ | UUID Encounter yang digenerate |
| __$CODE_OBSERVATION_1__   | CodeSystem pemeriksaan mikroskopis |
| __$CODE_OBSERVATION_2__   | CodeSystem pemeriksaan test cepat  |
| __$CODE_OBSERVATION_3__   | CodeSystem pemeriksaan biakan |
| __$CODE_OBSERVATION_4__   | CodeSystem pemeriksaan foto thorax |
| __$VALUE_OBSERVATION_1__  | Value pemeriksaan mikroskopis |
| __$VALUE_OBSERVATION_2__  | Value pemeriksaan test cepat |
| __$VALUE_OBSERVATION_3__  | Value pemeriksaan biakan |
| __$VALUE_OBSERVATION_4__  | Value pemeriksaan foto thorax |
</div>
    </div>
    <div role="tabpanel" class="tab-pane" id="valueset-5" style="border: 1px solid #e8edee; padding: 15px 10px;">
        <div>
        </div>
    </div>
</div>

### 3. DiagnosticReport
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-6" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-6" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-6" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-6" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>
<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-6">
        <h4 style="font-weight: bold;">Hasil Pemeriksaan Mikroskopis</h4>
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:DiagnosticReport-Create-BTA1}}
        </div>
        <h4 style="font-weight: bold;">Hasil Pemeriksaan Test Cepat Molekuler</h4>
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:DiagnosticReport-Create-TCM}}
        </div>
        <h4 style="font-weight: bold;">Hasil Pemeriksaan Biakan</h4>
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:DiagnosticReport-Create-Sputum}}
        </div>
        <h4 style="font-weight: bold;">Hasil Pemeriksaan Foto Thorax</h4>
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:DiagnosticReport-Create-Thorax}}
        </div>
    </div>
    <div role="tabpanel" class="tab-pane" id="data-6">
        <h4 style="font-weight: bold;">Hasil Pemeriksaan Mikroskopis</h4>
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
        <h4 style="font-weight: bold;">Hasil Pemeriksaan Test Cepat Molekuler</h4>
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
                "code": "647-8",
                "display": "Microscopic observation [Identifier] in Sputum by Acid fast stain.Ziehl-Neelsen"
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
            "reference": "Observation/<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION3_REFERENCE_ID&rcub;&rcub;</strong>",
            "display": "Mycobacterium tuberculosis complex DNA [Presence] in Isolate or Specimen by Molecular genetics method"
        },
        {
            "reference": "Observation/<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION5_REFERENCE_ID&rcub;&rcub;</strong>",
            "display": "Mycobacterium tuberculosis complex rpoB gene rifAMPin resistance mutation [Presence] by Molecular method"
        }
    ],
    "conclusionCode": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation",
                    "code": "S",
                    "display": "Susceptible"
                }
            ]
        }
    ]
}
        </pre>
        <h4 style="font-weight: bold;">Hasil Pemeriksaan Biakan</h4>
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
                "code": "647-8",
                "display": "Microscopic observation [Identifier] in Sputum by Acid fast stain.Ziehl-Neelsen"
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
            "reference": "Observation/<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION6_REFERENCE_ID&rcub;&rcub;</strong>",
            "display": "Mycobacterium sp identified in Sputum by Organism specific culture"
        }
    ],
    "conclusionCode": [
        {
            "coding": [
                {
                    "system": "http://loinc.org",
                    "code": "LA6577-6",
                    "display": "Negative"
                }
            ]
        }
    ]
}        
        </pre>
        <h4 style="font-weight: bold;">Hasil Pemeriksaan Foto Thorax</h4>
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "DiagnosticReport",
    "identifier": [
        {
            "system": "http://sys-ids.kemkes.go.id/diagnostic/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>/radiology",
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
                    "code": "RAD",
                    "display": "Radiology"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                "code": "imaging",
                "display": "Imaging"
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
            "reference": "Observation/<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION8_REFERENCE_ID&rcub;&rcub;</strong>",
            "display": "XR Chest PA upright"
        }
    ],
    "conclusionCode": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation",
                    "code": "POS",
                    "display": "Positive"
                }
            ]
        }
    ]
}
        </pre>
    </div>
    <div role="tabpanel" class="tab-pane" id="variabel-6" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                  | Deskripsi |
| ------------------------- | --------- |
| __$GENERATED_UUID_DIAGNOSTIC_REPORT__ | UUID DiagnosticReport yang digenerate |
| __$GENERATED_UUID_OBSERVATION_1__ | UUID pemeriksaan mikroskopis yang digenerate |
| __$GENERATED_UUID_OBSERVATION_2__ | UUID pemeriksaan test cepat yang digenerate |
| __$GENERATED_UUID_OBSERVATION_3__ | UUID pemeriksaan biakan yang digenerate |
| __$GENERATED_UUID_OBSERVATION_4__ | UUID pemeriksaan foto thorax yang digenerate |
| __$IHS_NUMBER_PASIEN__    | SATUSEHAT ID Number untuk Pasien |
| __$IHS_NUMBER_DOKTER__    | SATUSEHAT ID Number untuk Dokter/Nakes |
| __$IHS_NUMBER_FASYANKES__ | SATUSEHAT ID Number untuk FASYANKES |
| __$NAMA_FASYANKES__       | Nama FASYANKES |
| __$SNOMEDCT_TB_CONCLUSION__    | Kode SNOMED CT hasil diagnosa |
| __$SNOMEDCT_TB_CONCLUSION_DISPLAY__ | Teks SNOMED CT hasil diagnosa |
</div>
    </div>
    <div role="tabpanel" class="tab-pane" id="valueset-6" style="border: 1px solid #e8edee; padding: 15px 10px;">
        <div>
        </div>
    </div>
</div>

### II. Berbasis Bundle