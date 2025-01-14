## C. Verifikasi Kasus

Data verifikasi kasus temuan merupakan kumpulan data hasil pemeriksaan lab dan diagnosis kasus TB yang terbungkus melalui resource Encounter (kunjungan). 

Pembuatan Resource EpisodeOfCare bergantung pada hasil asesmen kasus TB. Jika asesmen menyatakan bahwa kasus **Terkonfirmasi Bakteriologis** atau **Terdiagnosis Klinis** maka entry resource EpisodeOfCare harus dipersiapkan terlebih dahulu sebagai wadah referensi untuk tiap Encounter yang dibuat baik pada tahap verifikasi kasus maupun saat melakukan kunjungan perawatan TB. Jika hasil asesmen tidak merujuk pada kesimpulan tersebut maka tidak perlu dibuatkan EpisodeOfCare, MedicationStatement dan QuestionnaireResponse untuk melengkapi pencatatan TB. Dengan demikian maka kasus dapat ditutup.

### I. Berbasis Resouce
**Entry Resources yang digunakan**

| No  | Nama Resource          | Entry Mandatory | Metode               |
| --- |:-----------------------|-----------------|:---------------------|
| 1   | __Condition__          | __Required__    | __BUAT BARU (POST)__ |
| 2   | __EpisodeOfCare__      | __Required__    | __BUAT BARU (POST)__ |
| 3   | __Encounter__          | __Required__    | __UPDATE (PUT)__ |
| 4   | __Medication__         | _Optional_      | __BUAT BARU (POST)__ |
| 5   | __MedicationRequest__  | _Optional_      | __BUAT BARU (POST)__ |
| 6   | __QuestionnaireResponse__ | __Required__    | __BUAT BARU (POST)__ |

#### 1. Condition
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-7" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-7" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-7" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-7" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>
<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-7">
        <h4 style="font-weight: bold;">Diagnosis Primer</h4>
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:example-TB-Condition-Create-Primer}}
        </div>
        <h4 style="font-weight: bold;">Diagnosis Sekunder (Opsional)</h4>
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:example-TB-Condition-Create-Sekunder}}
        </div>
    </div>
    <div role="tabpanel" class="tab-pane" id="data-7">
        <h4 style="font-weight: bold;">Diagnosis Primer</h4>
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Condition",
    "clinicalStatus": {
        "coding": [
            {
                "system": "http://terminology.hl7.org/CodeSystem/condition-clinical",
                "code": "active",
                "display": "Active"
            }
        ]
    },
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/condition-category",
                    "code": "encounter-diagnosis",
                    "display": "Encounter Diagnosis"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://hl7.org/fhir/sid/icd-10",
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;CONDITION1_ICD_CODE&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;CONDITION1_ICD_DISPLAY&rcub;&rcub;</strong>"
            }
        ]
    },
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>",
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "encounter": {
        "reference": "Encounter/<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_REFERENCE_ID&rcub;&rcub;</strong>"
    },
    "onsetDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;CONDITION1_ONSET_DATETIME&rcub;&rcub;</strong>",
    "recordedDate": "<strong style="color:#00a7ff">&lcub;&lcub;CONDITION1_RECORDED_DATETIME&rcub;&rcub;</strong>"
}
        </pre>
        <h4 style="font-weight: bold;">Diagnosis Sekunder (Opsional)</h4>
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Condition",
    "clinicalStatus": {
        "coding": [
            {
                "system": "http://terminology.hl7.org/CodeSystem/condition-clinical",
                "code": "active",
                "display": "Active"
            }
        ]
    },
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/condition-category",
                    "code": "encounter-diagnosis",
                    "display": "Encounter Diagnosis"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://hl7.org/fhir/sid/icd-10",
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;CONDITION2_ICD_CODE&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;CONDITION2_ICD_DISPLAY&rcub;&rcub;</strong>"
            }
        ]
    },
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>",
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "encounter": {
        "reference": "Encounter/<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_REFERENCE_ID&rcub;&rcub;</strong>"
    },
    "onsetDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;CONDITION2_ONSET_DATETIME&rcub;&rcub;</strong>",
    "recordedDate": "<strong style="color:#00a7ff">&lcub;&lcub;CONDITION2_RECORDED_DATETIME&rcub;&rcub;</strong>"
}
        </pre>
    </div>
    <div role="tabpanel" class="tab-pane" id="variabel-7" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                  | Deskripsi |
| ------------------------- | --------- |
| __$GENERATED_UUID_DIAGNOSIS__ | UUID untuk Diagnosis ICD-10 TB yang digenerate |
| __$CODE_ICD10__ | Kode ICD-10 untuk diagnosis Tuberculosis |
</div>
    </div>
    <div role="tabpanel" class="tab-pane" id="valueset-7" style="border: 1px solid #e8edee; padding: 15px 10px;">
        <div>
        </div>
    </div>
</div>

#### 2. EpisodeOfCare
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-8" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-8" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-8" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-8" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>
<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-8">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:example-TB-EpisodeOfCare-Create}}
        </div>
    </div>
    <div role="tabpanel" class="tab-pane" id="data-8">
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "EpisodeOfCare",
    "identifier": [
        {
            "system": "http://sys-ids.kemkes.go.id/episode-of-care/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>/",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;EPISODEOFCARE_LOCAL_CODE&rcub;&rcub;</strong>"
        }
    ],
    "status": "active",
    "statusHistory": [
        {
            "status": "active",
            "period": {
                "start": "<strong style="color:#00a7ff">&lcub;&lcub;EPISODEOFCARE_PERIOD1_START&rcub;&rcub;</strong>",
                "end": "<strong style="color:#00a7ff">&lcub;&lcub;EPISODEOFCARE_PERIOD1_END&rcub;&rcub;</strong>"
            }
        }
    ],
    "type": [
        {
            "coding": [
                {
                    "system": "https://terminology.kemkes.go.id/CodeSystem/episodeofcare-type",
                    "code": "<strong style="color:#00a7ff">&lcub;&lcub;EPISODEOFCARE_TYPE_CODE&rcub;&rcub;</strong>",
                    "display": "<strong style="color:#00a7ff">&lcub;&lcub;EPISODEOFCARE_TYPE_DISPLAY&rcub;&rcub;</strong>"
                }
            ]
        }
    ],
    "diagnosis": [
        {
            "condition": {
                "reference": "Condition/<strong style="color:#00a7ff">&lcub;&lcub;CONDITION1_REFERENCE_ID&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;CONDITION1_ICD_DISPLAY&rcub;&rcub;</strong>"
            },
            "role": {
                "coding": [
                    {
                        "system": "http://terminology.hl7.org/CodeSystem/diagnosis-role",
                        "code": "DD",
                        "display": "Discharged Diagnosis"
                    }
                ]
            },
            "rank": 1
        }
    ],
    "patient": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>",
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "managingOrganization": {
        "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>"
    },
    "period": {
        "start": "<strong style="color:#00a7ff">&lcub;&lcub;EPISODEOFCARE_PERIOD1_START&rcub;&rcub;</strong>",
        "end": "<strong style="color:#00a7ff">&lcub;&lcub;EPISODEOFCARE_PERIOD1_END&rcub;&rcub;</strong>"
    },
    "careManager": {
        "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_IHS_NUMBER&rcub;&rcub;</strong>",
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_NAME&rcub;&rcub;</strong>"
    }
}
        </pre>
    </div>
    <div role="tabpanel" class="tab-pane" id="variabel-8" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                  | Deskripsi |
| ------------------------- | --------- |
| __$GENERATED_UUID_EPISODEOFCARE__ | UUID EpisodeOfCare yang digenerate |
| __$DATETIME_MULAI_PENGOBATAN__ | DateTime mulai pengobatan TB |
| __$IHS_NUMBER_PASIEN__    | SATUSEHAT ID Number untuk Pasien |
| __$NAMA_PASIEN__          | Nama Pasien |
| __$IHS_NUMBER_DOKTER__    | SATUSEHAT ID Number untuk Dokter/Nakes |
| __$IHS_NUMBER_FASYANKES__ | SATUSEHAT ID Number untuk FASYANKES |
</div>
    </div>
    <div role="tabpanel" class="tab-pane" id="valueset-8" style="border: 1px solid #e8edee; padding: 15px 10px;">
        <div>
        </div>
    </div>
</div>

#### 3. Encounter
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-9" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-9" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-9" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
</ul>
<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-9">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:example-TB-Encounter-Update}}
        </div>
    </div>
    <div role="tabpanel" class="tab-pane" id="data-9">
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Encounter",
    "id": "<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_REFERENCE_ID&rcub;&rcub;</strong>",
    "identifier": [
        {
            "system": "http://sys-ids.kemkes.go.id/encounter/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_LOCAL_CODE&rcub;&rcub;</strong>"
        }
    ],
    "status": "finished",
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
        "start": "<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_PERIOD3_START&rcub;&rcub;</strong>",
        "end": "<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_PERIOD3_END&rcub;&rcub;</strong>"
    },
    "location": [
        {
            "location": {
                "reference": "Location/<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_LOCATION_ID&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_LOCATION_NAME&rcub;&rcub;</strong>"
            }
        }
    ],
    "diagnosis": [
        {
            "condition": {
                "reference": "Condition/<strong style="color:#00a7ff">&lcub;&lcub;CONDITION1_REFERENCE_ID&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;CONDITION1_ICD_DISPLAY&rcub;&rcub;</strong>"
            },
            "use": {
                "coding": [
                    {
                        "system": "http://terminology.hl7.org/CodeSystem/diagnosis-role",
                        "code": "DD",
                        "display": "Discharge diagnosis"
                    }
                ]
            },
            "rank": 1
        },
        {
            "condition": {
                "reference": "Condition/<strong style="color:#00a7ff">&lcub;&lcub;CONDITION2_REFERENCE_ID&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;CONDITION2_ICD_DISPLAY&rcub;&rcub;</strong>"
            },
            "use": {
                "coding": [
                    {
                        "system": "http://terminology.hl7.org/CodeSystem/diagnosis-role",
                        "code": "DD",
                        "display": "Discharge diagnosis"
                    }
                ]
            },
            "rank": 2
        }
    ],
    "statusHistory": [
        {
            "status": "arrived",
            "period": {
                "start": "<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_PERIOD1_START&rcub;&rcub;</strong>",
                "end": "<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_PERIOD1_END&rcub;&rcub;</strong>"
            }
        },
        {
            "status": "in-progress",
            "period": {
                "start": "<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_PERIOD2_START&rcub;&rcub;</strong>",
                "end": "<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_PERIOD2_END&rcub;&rcub;</strong>"
            }
        },
        {
            "status": "finished",
            "period": {
                "start": "<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_PERIOD3_START&rcub;&rcub;</strong>",
                "end": "<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_PERIOD3_END&rcub;&rcub;</strong>"
            }
        }
    ],
    "serviceProvider": {
        "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>"
    },
    "episodeOfCare": [
        {
            "reference": "EpisodeOfCare/<strong style="color:#00a7ff">&lcub;&lcub;EPISODEOFCARE_REFERENCE_ID&rcub;&rcub;</strong>"
        }
    ]
}
        </pre>
    </div>
    <div role="tabpanel" class="tab-pane" id="variabel-9" style="border: 1px solid #e8edee; padding: 15px 10px;">
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

#### 4. Medication
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-26" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-26" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-26" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-26" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>
<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-26">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:example-TB-Medication-Create-FDC}}
        </div>
    </div>
    <div role="tabpanel" class="tab-pane" id="data-26">
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
    <div role="tabpanel" class="tab-pane" id="variabel-26" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                  | Deskripsi |
| ------------------------- | --------- |
| __$CODE_OBAT_TB__         | Kode obat sesuai kategori perawatan TB |
| __$CODE_NAMA_OBAT_TB__    | Nama obat sesuai kategori perawatan TB |
| __$KODE_BENTUK_SEDIAAN__  | Kode bentuk sediaan obat |
| __$NAMA_BENTUK_SEDIAAN__  | Nama bentuk sedian obat |
</div>
    </div>
    <div role="tabpanel" class="tab-pane" id="valueset-26" style="border: 1px solid #e8edee; padding: 15px 10px;">
        <div>
        </div>
    </div>
</div>

#### 5. MedicationRequest
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-10" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-10" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-10" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-10" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>
<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-10">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:example-TB-MedicationRequest-Create}}
        </div>
    </div>
    <div role="tabpanel" class="tab-pane" id="data-10">
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
    <div role="tabpanel" class="tab-pane" id="variabel-10" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                  | Deskripsi |
| ------------------------- | --------- |
| __$GENERATED_UUID_MEDICATION_REQUEST__ | UUID MedicationRequest yang digenerate |
| __$IHS_NUMBER_PASIEN__    | SATUSEHAT ID Number untuk Pasien |
| __$GENERATED_UUID_EPISODEOFCARE__ | UUID EpisodeOfCare yang digenerate |
| __$GENERATED_UUID_MEDICATION__ | UUID Medication yang digenerate |
| __$GENERATED_UUID_CAREPLAN__ | UUID CarePlan yang digenerate |

</div>
    </div>
    <div role="tabpanel" class="tab-pane" id="valueset-10" style="border: 1px solid #e8edee; padding: 15px 10px;">
        <div>
        </div>
    </div>
</div>

#### 6. QuestionnaireResponse
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-12" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-12" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-12" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-12" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>
<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-12">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:example-TB-QuestionnaireResponse-Create}}
        </div>
    </div>
    <div role="tabpanel" class="tab-pane" id="data-12">
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "QuestionnaireResponse",
    "questionnaire": "https://fhir.kemkes.go.id/Questionnaire/Q0001",
    "status": "completed",
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>",
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "encounter": {
        "reference": "Encounter/<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_REFERENCE_ID&rcub;&rcub;</strong>"
    },
    "authored": "<strong style="color:#00a7ff">&lcub;&lcub;QUESTRESPONSE_AUTHORED&rcub;&rcub;</strong>",
    "author": {
        "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_IHS_NUMBER&rcub;&rcub;</strong>"
    },
    "source": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>"
    },
    "item": [
        {
            "linkId": "1",
            "text": "Tipe diagnosis tuberkulosis",
            "answer": [
                {
                    "valueCoding": {
                        "system": "https://terminology.kemkes.go.id/CodeSystem/tb-case-definition",
                        "code": "<strong style="color:#00a7ff">&lcub;&lcub;QUESTRESPONSE_ITEM1_CODE&rcub;&rcub;</strong>",
                        "display": "<strong style="color:#00a7ff">&lcub;&lcub;QUESTRESPONSE_ITEM1_DISPLAY&rcub;&rcub;</strong>"
                    }
                }
            ]
        },
        {
            "linkId": "2",
            "text": "Klasifikasi tuberkulosis berdasarkan lokasi anatomis",
            "answer": [
                {
                    "valueCoding": {
                        "system": "https://terminology.kemkes.go.id/CodeSystem/tb-anatomical",
                        "code": "<strong style="color:#00a7ff">&lcub;&lcub;QUESTRESPONSE_ITEM2_CODE&rcub;&rcub;</strong>",
                        "display": "<strong style="color:#00a7ff">&lcub;&lcub;QUESTRESPONSE_ITEM2_DISPLAY&rcub;&rcub;</strong>"
                    }
                }
            ]
        },
        {
            "linkId": "3",
            "text": "Klasifikasi tuberkulosis berdasarkan riwayat pengobatan",
            "answer": [
                {
                    "valueCoding": {
                        "system": "https://terminology.kemkes.go.id/CodeSystem/prev-tb-treatment",
                        "code": "<strong style="color:#00a7ff">&lcub;&lcub;QUESTRESPONSE_ITEM3_CODE&rcub;&rcub;</strong>",
                        "display": "<strong style="color:#00a7ff">&lcub;&lcub;QUESTRESPONSE_ITEM3_DISPLAY&rcub;&rcub;</strong>"
                    }
                }
            ]
        }
    ]
}
        </pre>
    </div>
    <div role="tabpanel" class="tab-pane" id="variabel-12" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                  | Deskripsi |
| ------------------------- | --------- |
| __$IHS_NUMBER_PASIEN__    | SATUSEHAT ID Number untuk Pasien |
| __$NAMA_PASIEN__          | Nama Pasien |
| __$GENERATED_UUID_ENCOUNTER__ | UUID Encounter yang digenerate |
| __$TIMESTAMP_AUTHORED__   | Tanggal dan waktu Questionnaire dibuat |
| __$IHS_NUMBER_DOKTER__    | SATUSEHAT ID Number untuk Dokter/Nakes |
| __$CODE_TB_CASE__         | Kode Tipe diagnosis TB (lihat <a href="#valueset-12" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>) |
| __$DISPLAY_TB_CASE__      | Teks display Tipe diagnosis TB (lihat <a href="#valueset-12" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>) |
| __$CODE_TB_ANATOMICAL__   | Kode klasifikasi Anatomis (lihat <a href="#valueset-12" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>) |
| __$DISPLAY_TB_ANATOMICAL__ | Teks display klasifikasi Anatomis (lihat <a href="#valueset-12" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>) |
| __$CODE_TB_TREATMENT__    | Kode riwayat pengobatan (lihat <a href="#valueset-12" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>) |
| __$DISPLAY_TB_TREATMENT__ | Teks display riwayat pengobatan (lihat <a href="#valueset-12" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>) |
</div>
    </div>
    <div role="tabpanel" class="tab-pane" id="valueset-12" style="border: 1px solid #e8edee; padding: 15px 10px;">

##### Tipe diagnosis tuberkulosis

|                 |                           |
|-----------------|---------------------------|
| __Code System__ | https://terminology.kemkes.go.id/CodeSystem/tb-case-definition |
| __Value Set url__ | https://terminology.kemkes.go.id/ValueSet/tb-case-definition |

| Kode        | Teks Display                |
|:-----------:| --------------------------- |
| tb-bac      | Terkonfirmasi bakteriologis |
| tb-clin     | Terdiagnosis klinis         |

##### Klasifikasi tuberkulosis berdasarkan lokasi anatomis

|                 |                           |
|-----------------|---------------------------|
| __Code System__ | https://terminology.kemkes.go.id/CodeSystem/tb-anatomical |
| __Value Set url__ | https://terminology.kemkes.go.id/ValueSet/tb-anatomical |

| Kode        | Teks Display                |
|:-----------:| --------------------------- |
| PTB         | TB Paru |
| EPTB        | TB Ekstraparu         |

##### Klasifikasi tuberkulosis berdasarkan riwayat pengobatan
|                 |                           |
|-----------------|---------------------------|
| __Code System__ | https://terminology.kemkes.go.id/CodeSystem/prev-tb-treatment |
| __Value Set url__| https://terminology.kemkes.go.id/ValueSet/prev-tb-treatment |

| Kode        | Teks Display                |
|:-----------:| --------------------------- |
| new | Kasus Baru |
| relapse | Kasus Kambuh |
| failure | Kasus Pengobatan Setelah Gagal |
| failure-cat1 | Kasus Pengobatan Setelah Gagal Kategori 1 |
| failure-cat2 | Kasus Pengobatan Setelah Gagal Kategori 2 |
| failure-2line | Kasus Pengobatan Setelah Gagal lini 2 |
| loss-to-follow-up | Kasus Setelah Loss To Follow Up |
| other | Kasus lain-lain |
| unknown | Kasus dengan riwayat pengobatan tidak diketahui |

</div>
</div>

### II. Berbasis Bundle