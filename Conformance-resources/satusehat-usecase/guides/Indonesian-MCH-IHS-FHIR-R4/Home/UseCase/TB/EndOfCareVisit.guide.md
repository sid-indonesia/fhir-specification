## E. Kunjungan Akhir Pengobatan

Proses ini digunakan untuk mencatat hasil akhir dari perawatan TB. diharapkan pada akhir proses pengobatan TB dikirimkan bundle yang berisi update dari informasi periode EpisodeOfCare serta Resource Encounter yang menyatakan hasil pemeriksaan pada akhir periode tersebut. Resource Encounter diberlakukan sama seperti bundle lainnya yaitu tetap menyebutkan referensi ID EpisodeOfCare.

![alt text](https://raw.githubusercontent.com/kemkes/fhir-ig-tb-assets/main/images/tb-frame-3.jpg "Kunjungan Pengobatan TB Bulanan")

### I. Berbasis Resource
**Entry Resources yang digunakan**

| No  | Nama Resource           | Entry Mandatory | Metode               |
| --- |:------------------------| --------------- |:---------------------|
| 1   | __EpisodeOfCare__       | __Required__    | __UPDATE(PUT)__      |
| 2   | __Encounter__           | __Required__    | __BUAT BARU(POST)__  |
| 3   | __DiagnosticReport__    | __Required__    | __BUAT BARU(POST)__  |
| 4   | __Observation__         | __Required__    | __BUAT BARU(POST)__  |
| 5   | __QuestionnaireResponse__ | __Required__    | __UPDATE(PUT)__      |

#### 1. EpisodeOfCare
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-17" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-17" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-17" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-17" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>
<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-17">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:example-TB-EpisodeOfCare-Update}}
        </div>
    </div>
    <div role="tabpanel" class="tab-pane" id="data-17">
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "EpisodeOfCare",
    "id": "<strong style="color:#00a7ff">&lcub;&lcub;EPISODEOFCARE_REFERENCE_ID&rcub;&rcub;</strong>",
    "identifier": [
        {
            "system": "http://sys-ids.kemkes.go.id/episode-of-care/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>/",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;EPISODEOFCARE_LOCAL_CODE&rcub;&rcub;</strong>"
        }
    ],
    "status": "finished",
    "statusHistory": [
        {
            "status": "active",
            "period": {
                "start": "<strong style="color:#00a7ff">&lcub;&lcub;EPISODEOFCARE_PERIOD1_START&rcub;&rcub;</strong>",
                "end": "<strong style="color:#00a7ff">&lcub;&lcub;EPISODEOFCARE_PERIOD1_END&rcub;&rcub;</strong>"
            }
        },
        {
            "status": "finished",
            "period": {
                "start": "<strong style="color:#00a7ff">&lcub;&lcub;EPISODEOFCARE_PERIOD2_START&rcub;&rcub;</strong>",
                "end": "<strong style="color:#00a7ff">&lcub;&lcub;EPISODEOFCARE_PERIOD2_END&rcub;&rcub;</strong>"
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
        "start": "<strong style="color:#00a7ff">&lcub;&lcub;EPISODEOFCARE_PERIOD2_START&rcub;&rcub;</strong>",
        "end": "<strong style="color:#00a7ff">&lcub;&lcub;EPISODEOFCARE_PERIOD2_END&rcub;&rcub;</strong>"
    },
    "careManager": {
        "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_IHS_NUMBER&rcub;&rcub;</strong>",
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_NAME&rcub;&rcub;</strong>"
    }
}
        </pre>
    </div>
    <div role="tabpanel" class="tab-pane" id="variabel-17" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                  | Deskripsi |
| ------------------------- | --------- |
| __$GENERATED_UUID_EPISODEOFCARE__ | UUID EpisodeOfCare |
| __$IHS_NUMBER_PASIEN__    | SATUSEHAT ID Number untuk Pasien |
| __$NAMA_PASIEN__          | Nama Pasien |
| __$IHS_NUMBER_DOKTER__    | SATUSEHAT ID Number untuk Dokter/Nakes |
| __$IHS_NUMBER_FASYANKES__ | SATUSEHAT ID Number untuk FASYANKES |
</div>
    </div>
    <div role="tabpanel" class="tab-pane" id="valueset-17" style="border: 1px solid #e8edee; padding: 15px 10px;">
        <div>
        </div>
    </div>
</div>

#### 2. Encounter
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-18" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-18" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-18" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
</ul>
<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-18">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:Encounter-Create}}
        </div>
    </div>
    <div role="tabpanel" class="tab-pane" id="data-18">
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
    <div role="tabpanel" class="tab-pane" id="variabel-18" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                  | Deskripsi |
| ------------------------- | --------- |
| __$ID_ENCOUNTER_1__       | UUID Encounter yang digenerate |
| __$ID_ENCOUNTER_2__       | UUID Encounter yang digenerate |
| __$IHS_NUMBER_PASIEN__    | SATUSEHAT ID Number untuk Pasien |
| __$NAMA_PASIEN__          | Nama Pasien |
| __$IHS_NUMBER_DOKTER__    | SATUSEHAT ID Number untuk Dokter/Nakes |
| __$IHS_NUMBER_FASYANKES__ | SATUSEHAT ID Number untuk FASYANKES |
</div>
    </div>
</div>

#### 3. DiagnosticReport
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-20" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-20" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-20" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-20" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>
<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-20">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:DiagnosticReport-Create-Thorax}}
        </div>
    </div>
    <div role="tabpanel" class="tab-pane" id="data-20">
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
    <div role="tabpanel" class="tab-pane" id="variabel-20" style="border: 1px solid #e8edee; padding: 15px 10px;">
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
    <div role="tabpanel" class="tab-pane" id="valueset-20" style="border: 1px solid #e8edee; padding: 15px 10px;">
        <div>
        </div>
    </div>
</div>

#### 4. Observation
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-21" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-21" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-21" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-21" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>
<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-21">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:Observation-Create-Thorax}}
        </div>
    </div>
    <div role="tabpanel" class="tab-pane" id="data-21">
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
    <div role="tabpanel" class="tab-pane" id="variabel-21" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                  | Deskripsi |
| ------------------------- | --------- |
| __$GENERATED_UUID_ENCOUNTER__ | UUID Encounter yang digenerate |
| __$CODE_OBSERVATION_1__   | CodeSystem pemeriksaan mikroskopis |
| __$VALUE_OBSERVATION_1__  | Value pemeriksaan mikroskopis |
</div>
    </div>
    <div role="tabpanel" class="tab-pane" id="valueset-21" style="border: 1px solid #e8edee; padding: 15px 10px;">
        <div>
        </div>
    </div>
</div>

#### 5. QuestionnaireResponse
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-23" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-23" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-23" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-23" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>
<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-23">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:example-TB-QuestionnaireResponse-Update}}
        </div>
    </div>
    <div role="tabpanel" class="tab-pane" id="data-23">
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "QuestionnaireResponse",
    "id": "<strong style="color:#00a7ff">&lcub;&lcub;QUESTRESPONSE_REFERENCE_ID&rcub;&rcub;</strong>",
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
        },
        {
            "linkId": "4",
            "text": "Hasil akhir pengobatan tuberkulosis",
            "answer": [
                {
                    "valueCoding": {
                        "system": "https://terminology.kemkes.go.id/CodeSystem/tb-outcome-class",
                        "code": "<strong style="color:#00a7ff">&lcub;&lcub;QUESTRESPONSE_ITEM4_CODE&rcub;&rcub;</strong>",
                        "display": "<strong style="color:#00a7ff">&lcub;&lcub;QUESTRESPONSE_ITEM4_DISPLAY&rcub;&rcub;</strong>"
                    }
                }
            ]
        }
    ]
}
        </pre>
    </div>
    <div role="tabpanel" class="tab-pane" id="variabel-23" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                  | Deskripsi |
| ------------------------- | --------- |
| __$IHS_NUMBER_PASIEN__    | SATUSEHAT ID Number untuk Pasien |
| __$NAMA_PASIEN__          | Nama Pasien |
| __$GENERATED_UUID_ENCOUNTER__ | UUID Encounter yang digenerate |
| __$TIMESTAMP_AUTHORED__   | Tanggal dan waktu Questionnaire dibuat |
| __$IHS_NUMBER_DOKTER__    | SATUSEHAT ID Number untuk Dokter/Nakes |
| __$CODE_TB_OUTCOME__      | Kode hasil akhir Pengobatan (lihat <a href="#valueset-23" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>) |
| __$DISPLAY_TB_OUTCOME__   | Teks display hasil akhir Pengobatan (lihat <a href="#valueset-23" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>) |
</div>
    </div>
    <div role="tabpanel" class="tab-pane" id="valueset-23" style="border: 1px solid #e8edee; padding: 15px 10px;">


##### Hasil akhir pengobatan tuberkulosis

|                 |                           |
|-----------------|---------------------------|
| __Code System__ | https://terminology.kemkes.go.id/CodeSystem/tb-outcome-class |
| __Value Set url__ | https://terminology.kemkes.go.id/ValueSet/tb-outcome-class |

| Kode        | Teks Display                |
|:-----------:| --------------------------- |
| cured | Sembuh |
| cmpl | Pengobatan Lengkap |
| failed | Pengobatan Gagal |
| died | Meninggal |
| loss-to-follow-up | Putus Obat |
| not-eval | Tidak dievaluasi |

</div>
</div>

### II. Berbasis Bundle