## <b>ILI (Influenza-like Illness)</b>

*Last Updated: 2024/01/03*

## A. Pendahuluan

Tahapan alur integrasi dan resource yang digunakan untuk integrasi pelaporan kasus ILI dapat dilihat pada gambar dibawah ini.

<center>
<img src="https://victoriatjia.github.io/Guideline/SatuSehat/Specs%20Format%20FHIR/covid_pelaporan_ili_v2.0.png" alt="covid-skema-pelaporan-ili" title="Pelaporan Kasus ILI Workflow" width="100%" style="max-width: 850px;">

_Gambar 2. Alur Integrasi Pelaporan ILI (Influenza-like Illness)_

</center>

## B. Strategi Pengiriman Data ke SATUSEHAT

SATUSEHAT menyediakan dua pilihan cara mengirimkan data use case ILI:

### 1. Berbasis Resource

Data dapat dikirimkan secara berurutan sesuai resource yang terlibat pada alur pelayanan terkait. Sebagai contoh: ketika mengirimkan data registrasi kasus saja yang berisikan resource Encounter dan Condition, maka implementor mengirimkan resource-resource tersebut ke SATUSEHAT secara berurutan sesuai dependensinya.

### 2. Berbasis Bundle

Data dapat dikirimkan seluruh resource yang terlibat pada alur pelayanan terkait dengan menggunakan satu langkah pengiriman data ke SATUSEHAT menggunakan profil FHIR bernama Bundle.

Resource-resource yang terlibat di setiap tahapan alur pelayanan untuk use case ILI adalah sebagai berikut:

<style>
.table-fhir-resources {
    border-collapse: collapse;
}
.table-fhir-resources, .table-fhir-resources th, .table-fhir-resources td {
   border: 1px solid black;
}

.table-fhir-resources th, .table-fhir-resources td {
   padding: 5px;
}
</style>

<table class="table-fhir-resources">
<tr>
	<th>Category</th>
	<th>No</th>
	<th>Resource</th>
	<th>Entry Mandatory</th>
</tr>
<tr>
	<td rowspan="5">Base</td>
	<td>1</td>
	<td>Patient</td>
	<td><b>Required</b></td>
</tr>
<tr>
	<td>2</td>
	<td>Practitioner</td>
	<td><b>Required</b></td>
</tr>

<tr>
	<td>3</td>
	<td>Organization</td>
	<td><b>Required</b></td>
</tr>

<tr>
	<td>4</td>
	<td>Location</td>
	<td><b>Required</b></td>
</tr>
<tr>
	<td>5</td>
	<td>Encounter *</td>
	<td><b>Required</b></td>
</tr>
<tr>
	<td rowspan="8">Clinical</td>
	<td>6</td>
	<td>Condition</td>
	<td><b>Required</b></td>
</tr>
<tr>
	<td>7</td>
	<td>Observation</td>
	<td><b>Required</b></td>
</tr>
<tr>
	<td>8</td>
	<td>ServiceRequest</td>
	<td><b>Required</b></td>
</tr>
<tr>
	<td>9</td>
	<td>Specimen</td>
	<td><b>Required</b></td>
</tr>
<tr>
	<td>10</td>
	<td>QuestionnaireResponse</td>
	<td><b>Required</b></td>
</tr>
<tr>
	<td>11</td>
	<td>DiagnosticReport</td>
	<td><i><b>Required</b></i></td>
</tr>
<tr>
	<td>12</td>
	<td>Composition</td>
	<td><i><b>Required</b></i></td>
</tr>
</table>

<br>_Notes:_<br>

1. \*) Profile Resource yang direkomendasikan tersedia pada proses pencatatan
2. **Required**: Entry resource harus dilibatkan setiap kali mengirimkan bundle
3. _Optional_: Entry resource dapat tidak dilibatkan setiap kali mengirimkan bundle

## C. Langkah-Langkah Pengiriman Data ke SATUSEHAT

### <div id="SearchPatientPractitionerOrganization"> [Pre-Use Case Requirement] Pencarian Data Pasien</div>

<div style="margin-left: 30px;">
<p>Apabila melakukan pengiriman data kesehatan melalui SATUSEHAT yang memiliki elemen data terkait pasien, maka diperlukan informasi {patient-ihs-number} dari pasien yang bersangkutan. {patient-ihs-number} seorang pasien didapatkan dari Master Patient Index (MPI) Kementerian Kesehatan. MPI menyimpan data-data demografi pasien berskala nasional, mulai dari nama, tanggal lahir, alamat, IDentitas resmi yang diterbitkan pemerintah, dan lain lain. Setelah mendapatkan {patient-ihs-number}, ID dapat disimpan secara di masing-masing sistem internal fasyankes maupun partner non-fasyankes. {patient-ihs-number} akan mempermudah pelaporan pelayanan kesehatan yang berhubungan dengan pasien, karena partner tidak diwajibkan menyertakan data diri setiap ada pengiriman data {patient-ihs-number} juga dapat digunakan untuk melihat data diri pasien secara menyeluruh.</p>

> `CATATAN:`
> Proses pencarian `{patient-ihs-number}` dari pasien dapat dilakukan melalui FHIR API dengan metode GET. Untuk metode pencarian data pasien di SATUSEHAT secara detail dapat dilihat dalam _resource_ [`Patient`](https://satusehat.kemkes.go.id/platform/docs/id/fhir/resources/patient/#patient) dan terkait panduan/playbook MPI dapat dilihat dalam dokumen <a href="https://satusehat.kemkes.go.id/platform/docs/id/master-data/master-patient-index/preliminary/#prem-mpi" target="_blank">Master Patient Index</a>.
</div>

### <div id="">Step 1. Pendaftaran Kunjungan Pasien</div>

<div style="margin-left: 30px;">
Kunjungan pasien dapat didefinisikan sebagai interaksi pasien terhadap suatu layanan fasyankes. Sebagai contoh, dalam satu rangkaian rawat jalan, seluruh rangkaian dapat didefinisikan sebagai satu “Encounter”. Data-data kunjungan pasien yang direkam meliputi kapan pertemuan tersebut mulai dan selesai, siapa tenaga kesehatan yang melayani, siapa subjek dari pelayanannya, dan informasi pendukung lainnya.

<!--Part 1-1 Variable Pendataan Kunjungan Rawat Jalan-->
<h4 style="font-weight: bold;">Pendataan Kunjungan Rawat Jalan</h4>

<ul class="nav nav-tabs" role="tablist">
<li role="presentation" class="active">
<a href="#example-1-1" aria-controls="example" role="tab" data-toggle="tab">Example</a>
</li>
<li role="presentation">
<a href="#data-1-1" aria-controls="data" role="tab" data-toggle="tab">Template</a>
</li>
<li role="presentation">
<a href="#variabel-1-1" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
</li>
<li role="presentation">
<a href="#valueset-1-1" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
</li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
<div role="tabpanel" class="tab-pane active" id="example-1-1">
<div style="background: #F6F8F8;border: 1px solid #e8edee;">
{{json:covid-ILI-Encounter-Create-PendataanKunjunganRawatJalan}}
</div>
</div>

<div role="tabpanel" class="tab-pane" id="data-1-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

<pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Encounter",
    "identifier":  [
        {
            "use": "temp",
            "system": "http://sys-ids.kemkes.go.id/encounter/<strong style="color:#00a7ff">&lcub;&lcub;ORGANIZATION_IHS_NUMBER&rcub;&rcub;</strong>",
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
    "participant":  [
        {
            "type":  [
                {
                    "coding":  [
                        {
                            "system": "http://terminology.hl7.org/CodeSystem/v3-ParticipationType",
                            "code": "ATND",
                            "display": "attender"
                        }
                    ]
                }
            ],
            "individual": {
                "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_NAME&rcub;&rcub;</strong>"
            }
        }
    ],
    "period": {
        "start": "<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_PERIOD1_START&rcub;&rcub;</strong>"
    },
    "location":  [
        {
            "location": {
                "reference": "Location/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_LOCATION&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_LOCATION_NAME&rcub;&rcub;</strong>"
            }
        }
    ],
    "statusHistory":  [
        {
            "status": "arrived",
            "period": {
                "start": "<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_PERIOD1_START&rcub;&rcub;</strong>"
            }
        }
    ],
    "serviceProvider": {
        "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;ORGANIZATION_IHS_NUMBER&rcub;&rcub;</strong>"
    }
}
</pre>

</div>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-1-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                   | Deskripsi |
| ---------------------------| --------- |
| __ORGANIZATION_IHS_NUMBER__    | {organization-ihs-number} pada SATUSEHAT |
| __ENCOUNTER_LOCAL_CODE__   | ID Lokal untuk Kunjungan/Encounter |
| __PATIENT_IHS_NUMBER__     | {patient-ihs-number} pada SATUSEHAT |
| __PATIENT_NAME__           | Nama Pasien |
| __PRACTITIONER_IHS_NUMBER__      | {practitioner-ihs-number} pada SATUSEHAT |
| __DOCTOR_NAME__            | Nama Dokter/Nakes |
| __ENCOUNTER_PERIOD1_START__| Waktu mulai/check-in kunjungan |
| __ENCOUNTER_PERIOD1_END__  | Waktu mulai/check-out kunjungan |
| __ID_RESOURCE_LOCATION__  | ID Location tempat kunjungan dilakukan |
| __ENCOUNTER_LOCATION_NAME__| Nama Location tempat kunjungan dilakukan |

</div>
</div>

<div role="tabpanel" class="tab-pane" id="valueset-1-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
[none]
</div>
</div>
</div>
<!--END Part 1-1-->
</div>

### <div id="">Step 2. Pengiriman Data Medis terkait Kondisi Pasien</div>

<div style="margin-left: 30px;">
Data terkait kondisi pasien pada modul ILI mencakup informasi sebagai berikut:<br>
1. Suhu (resource Observation)<br>
2. Frekuensi napas (resource Observation)<br>
3. Gejala + Tanda Mulai Sakit/Gejala (resource Condition)<br>
4. Kondisi medis (resource Observation)<br>
5. Faktor Penularan & Alasan Tidak Mau Diambil Spesimen (resource QuestionnaireResponse)<br>

<!--Part 2-1-->
<h4 style="font-weight: bold;">Suhu</h4>

<ul class="nav nav-tabs" role="tablist">
<li role="presentation" class="active">
<a href="#example-2-1" aria-controls="example" role="tab" data-toggle="tab">Example</a>
</li>
<li role="presentation">
<a href="#data-2-1" aria-controls="data" role="tab" data-toggle="tab">Template</a>
</li>
<li role="presentation">
<a href="#variabel-2-1" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
</li>
<li role="presentation">
<a href="#valueset-2-1" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
</li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
<div role="tabpanel" class="tab-pane active" id="example-2-1">
<div style="background: #F6F8F8;border: 1px solid #e8edee;">
{{json:covid-ILI-Observation-Create-BodyTemperature}}
</div>
</div>

<div role="tabpanel" class="tab-pane" id="data-2-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "vital-signs",
                    "display": "Vital Signs"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://loinc.org",
                "code": "8310-5",
                "display": "Body temperature"
            }
        ]
    },
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>"
    },
    "encounter": {
        "reference": "Encounter/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_ENCOUNTER&rcub;&rcub;</strong>"
    },
    "effectiveDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_EFFECTIVE_DATETIME&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        },
        {
            "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;ORGANIZATION_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueQuantity": {
		"value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
		"unit": "C",
		"system": "http://unitsofmeasure.org",
		"code": "Cel"
	}
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-2-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| {organization-ihs-number} pada SATUSEHAT |
| __PATIENT_IHS_NUMBER__      			| {patient-ihs-number} pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| {id-resource-Encounter} pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __PRACTITIONER_IHS_NUMBER__    				| {practitioner-ihs-number} pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi untuk suhu tubuh pasien dalam satuan Celcius |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
</div>

<div role="tabpanel" class="tab-pane" id="valueset-2-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
[none]
</div>
</div>
</div>
<br>
<!--END Part 2-1-->

<!--Part 2-2-->
<h4 style="font-weight: bold;">Frekuensi Napas</h4>

<ul class="nav nav-tabs" role="tablist">
<li role="presentation" class="active">
<a href="#example-2-2" aria-controls="example" role="tab" data-toggle="tab">Example</a>
</li>
<li role="presentation">
<a href="#data-2-2" aria-controls="data" role="tab" data-toggle="tab">Template</a>
</li>
<li role="presentation">
<a href="#variabel-2-2" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
</li>
<li role="presentation">
<a href="#valueset-2-2" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
</li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
<div role="tabpanel" class="tab-pane active" id="example-2-2">
<div style="background: #F6F8F8;border: 1px solid #e8edee;">
{{json:covid-ILI-Observation-Create-RespiratoryRate}}
</div>
</div>

<div role="tabpanel" class="tab-pane" id="data-2-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "vital-signs",
                    "display": "Vital Signs"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://loinc.org",
                "code": "9279-1",
                "display": "Respiratory rate"
            }
        ]
    },
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>"
    },
    "encounter": {
        "reference": "Encounter/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_ENCOUNTER&rcub;&rcub;</strong>"
    },
    "effectiveDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_EFFECTIVE_DATETIME&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        },
        {
            "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;ORGANIZATION_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueQuantity": {
		"value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
		"unit": "/min",
        "system": "http://unitsofmeasure.org",
        "code": "/min"
	}
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-2-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| {organization-ihs-number} pada SATUSEHAT |
| __PATIENT_IHS_NUMBER__      			| {patient-ihs-number} pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| {id-resource-Encounter} pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __PRACTITIONER_IHS_NUMBER__    				| {practitioner-ihs-number} pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi untuk pernapasan tubuh pasien dalam satuan per menit|

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
</div>

<div role="tabpanel" class="tab-pane" id="valueset-2-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
[none]
</div>
</div>
</div>
<br>
<!--END Part 2-2-->

<!--Part 2-3-->
<h4 style="font-weight: bold;">Gejala + Tanda Mulai Sakit/Gejala</h4>
<h5>Gejala batuk</h5>
<ul class="nav nav-tabs" role="tablist">
<li role="presentation" class="active">
<a href="#example-2-3" aria-controls="example" role="tab" data-toggle="tab">Example</a>
</li>
<li role="presentation">
<a href="#data-2-3" aria-controls="data" role="tab" data-toggle="tab">Template</a>
</li>
<li role="presentation">
<a href="#variabel-2-3" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
</li>
<li role="presentation">
<a href="#valueset-2-3" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
</li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
<div role="tabpanel" class="tab-pane active" id="example-2-3">
<div style="background: #F6F8F8;border: 1px solid #e8edee;">
{{json:covid-ILI-Condition-Create-Cough}}
</div>
</div>

<div role="tabpanel" class="tab-pane" id="data-2-3" style="border: 1px solid #e8edee; padding: 15px 10px;">
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
                    "code": "problem-list-item",
                    "display": "Problem List Item"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://snomed.info/sct",
                "code": "49727002",
                "display": "Cough"
            }
        ]
    },
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>",
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "encounter": {
        "reference": "Encounter/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_ENCOUNTER&rcub;&rcub;</strong>"
    },
    "onsetDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;CONDITION_ONSET_DATETIME&rcub;&rcub;</strong>",
    "recordedDate": "<strong style="color:#00a7ff">&lcub;&lcub;CONDITION_RECORDED_DATETIME&rcub;&rcub;</strong>"
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-2-3" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __PATIENT_IHS_NUMBER__      | &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __PATIENT_NAME__           | Nama Pasien |
| __CONDITION_ONSET_DATETIME__ | Tanggal perkiraan atau tanggal aktual atau tanggal-waktu kondisi mulai, menurut pendapat dokter.|
| __CONDITION_RECORDED_DATETIME__ | 	Tanggal kapan kondisi/keluhan ini tercatat dalam sistem (tanggal yang dibuat oleh sistem)|

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
</div>

<div role="tabpanel" class="tab-pane" id="valueset-2-3" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
[none]
</div>
</div>
</div>
<br>
<!--END Part 2-3-->

<!--Part 2-4-->
<h4 style="font-weight: bold;">Kondisi Medis</h4>
<h5>Merokok</h5>
<ul class="nav nav-tabs" role="tablist">
<li role="presentation" class="active">
<a href="#example-2-4" aria-controls="example" role="tab" data-toggle="tab">Example</a>
</li>
<li role="presentation">
<a href="#data-2-4" aria-controls="data" role="tab" data-toggle="tab">Template</a>
</li>
<li role="presentation">
<a href="#variabel-2-4" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
</li>
<li role="presentation">
<a href="#valueset-2-4" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
</li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
<div role="tabpanel" class="tab-pane active" id="example-2-4">
<div style="background: #F6F8F8;border: 1px solid #e8edee;">
{{json:covid-ILI-Observation-Create-RiskFactor-Smoke}}
</div>
</div>

<div role="tabpanel" class="tab-pane" id="data-2-4" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "social-history",
                    "display": "Social History"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://snomed.info/sct",
                "code": "80943009",
                "display": "Risk factor"
            }
        ]
    },
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>"
    },
    "encounter": {
        "reference": "Encounter/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_ENCOUNTER&rcub;&rcub;</strong>"
    },
    "effectiveDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_EFFECTIVE_DATETIME&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        },
        {
            "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;ORGANIZATION_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueCodeableConcept": {
        "coding": [
            {
                "system": "http://snomed.info/sct",
                "code": "77176002",
                "display": "Smoker"
            }
        ]
    }
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-2-4" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
</div>

<div role="tabpanel" class="tab-pane" id="valueset-2-4" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
[none]
</div>
</div>
</div>
<br>
<!--END Part 2-4-->

<!--Part 2-5 Variable Wawancara Faktor Penularan-->
<h4 style="font-weight: bold;">Faktor Penularan & Alasan Tidak Mau Diambil Spesimen</h4>
Selain melakukan anamnesis dan pemeriksaan fisik, wawancara faktor penularan adalah kegiatan yang penting dilakukan untuk memberikan informasi epidemiologis. Data dari proses pemeriksaan dapat dikirimkan resource QuestionnaireResponse

<ul class="nav nav-tabs" role="tablist">
<li role="presentation" class="active">
<a href="#example-2-5" aria-controls="example" role="tab" data-toggle="tab">Example</a>
</li>
<li role="presentation">
<a href="#data-2-5" aria-controls="data" role="tab" data-toggle="tab">Template</a>
</li>
<li role="presentation">
<a href="#variabel-2-5" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
</li>
<li role="presentation">
<a href="#valueset-2-5" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
</li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
<div role="tabpanel" class="tab-pane active" id="example-2-5">
<div style="background: #F6F8F8;border: 1px solid #e8edee;">
{{json:covid-ILI-QuestionnaireResponse-Create-WawancaraFaktorPenularan}}
</div>
</div>

<div role="tabpanel" class="tab-pane" id="data-2-5" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "QuestionnaireResponse",
    "questionnaire": "https://fhir.kemkes.go.id/Questionnaire/Q0008",
    "status": "completed",
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>"
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "encounter": {
        "reference": "Encounter/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_ENCOUNTER&rcub;&rcub;</strong>"
    },
    "authored": "<strong style="color:#00a7ff">&lcub;&lcub;AUTHORED_DATETIME&rcub;&rcub;</strong>",
    "author": {
        "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
    },
    "source": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>"
    },
    "item": [
        {
            "linkId": "1",
            "text": "Faktor Penularan",
            "item": [
                {
                    "linkId": "1.1",
                    "text": "Apakah dalam dua minggu terakhir, anda bepergian keluar negeri?",
                    "answer": [
                        {
                            "valueBoolean": <strong style="color:#00a7ff">&lcub;&lcub;ANSWER_1_1&rcub;&rcub;</strong>
                        },
                        {
                            "item": [
                                {
                                    "linkId": "1.1.1",
                                    "text": "Sebutkan Negaranya",
                                    "answer": [
                                        {
                                            "valueCoding": {
                                                "system": "<strong style="color:#00a7ff">&lcub;&lcub;ANSWER_1_1_1&rcub;&rcub;</strong>",
                                                "code": "<strong style="color:#00a7ff">&lcub;&lcub;ANSWER_1_1_1&rcub;&rcub;</strong>",
                                                "display": "<strong style="color:#00a7ff">&lcub;&lcub;ANSWER_1_1_1&rcub;&rcub;</strong>"
                                            }
                                        }
                                    ]
                                }
                            ]
                        }
                    ]
                },
                {
                    "linkId": "1.2",
                    "text": "Ada orang serumah yang menderita sakit sepulang dari bepergian ke luar negeri?",
                    "answer": [
                        {
                            "valueBoolean": <strong style="color:#00a7ff">&lcub;&lcub;ANSWER_1_2&rcub;&rcub;</strong>
                        },
                        {
                            "item": [
                                {
                                    "linkId": "1.2.1",
                                    "text": "Sebutkan Negaranya",
                                    "answer": [
                                        {
                                            "valueCoding": {
                                                "system": "<strong style="color:#00a7ff">&lcub;&lcub;ANSWER_1_2_1&rcub;&rcub;</strong>",
                                                "code": "<strong style="color:#00a7ff">&lcub;&lcub;ANSWER_1_2_1&rcub;&rcub;</strong>",
                                                "display": "<strong style="color:#00a7ff">&lcub;&lcub;ANSWER_1_2_1&rcub;&rcub;</strong>"
                                            }
                                        }
                                    ]
                                }
                            ]
                        }
                    ]
                },
                {
                    "linkId": "1.3",
                    "text": "Dalam 2 minggu terakhir, apakah pernah kontak dengan unggas mati mendadak?",
                    "answer": [
                        {
                            "valueBoolean": <strong style="color:#00a7ff">&lcub;&lcub;ANSWER_1_3&rcub;&rcub;</strong>
                        }
                    ]
                },
                {
                    "linkId": "1.4",
                    "text": "Apakah rumah pasien dekat dengan peternakan unggas (< 100m)?",
                    "answer": [
                        {
                            "valueBoolean": <strong style="color:#00a7ff">&lcub;&lcub;ANSWER_1_4&rcub;&rcub;</strong>
                        }
                    ]
                },
                {
                    "linkId": "1.5",
                    "text": "Apakah sudah melakukan vaksinasi influenza 12 bulan terakhir?",
                    "answer": [
                        {
                            "valueBoolean": <strong style="color:#00a7ff">&lcub;&lcub;ANSWER_1_5&rcub;&rcub;</strong>
                        }
                    ]
                },
                {
                    "linkId": "1.6",
                    "text": "Apakah sudah melakukan vaksinasi COVID-19 12 bulan terakhir?",
                    "answer": [
                        {
                            "valueBoolean": <strong style="color:#00a7ff">&lcub;&lcub;ANSWER_1_6&rcub;&rcub;</strong>
                        }
                    ]
                }
            ]
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-2-5" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __PATIENT_NAME__      			| Nama pasien |
| __ORGANIZATION_IHS_NUMBER__   			| &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __AUTHORED_DATETIME__ 				| Waktu di mana jawaban kuesioner didapatkan dengan tipe data dateTime, dengan format yang diperbolehkan YYYY-MM-DDThh:mm:ss+zz:zz|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __ANSWER_1_1__      		|  Pernyataan apakah pasien bepergian keluar negeri dalam 2 minggu terakhir dengan tipe data boolean |
| __ANSWER_1_1_1__      		| Negara yang dikunjungi pasien dalam 2 minggu terakhir dengan kode ISO 3166 |
| __ANSWER_1_2__      		| Pernyataan apakah ada orang serumah yang menderita sakit sepulang dari bepergian ke luar negeri dengan tipe data boolean |
| __ANSWER_1_2_1__      		| Negara yang dikunjungi orang serumah dengan kode ISO 3166 |
| __ANSWER_1_3__      		|  Pernyataan apakah pasien pernah kontak dengan unggas mati mendadak dalam 2 minggu terakhir dengan tipe data boolean |
| __ANSWER_1_4__      		|  Pernyataan apakah rumah pasien dekat dengan peternakan unggas (< 100m) dengan tipe data boolean |
| __ANSWER_1_5__      		|  Pernyataan apakah sudah melakukan vaksinasi influenza 12 bulan terakhir dengan tipe data boolean |
| __ANSWER_1_6__      		|  Pernyataan apakah sudah melakukan vaksinasi COVID-19 12 bulan terakhir dengan tipe data boolean |
</div>
</div>

<div role="tabpanel" class="tab-pane" id="valueset-2-5" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
[none]
</div>
</div>
</div>
<br>
<!--END Part 2-5-->
</div>
<!--END Part 2-->

<!--Part 3-->

### <div id="labRequest">Step 3. Permintaan Pemeriksaan (Laboratorium Pemeriksa/Dituju)</div>

<div style="margin-left: 30px;">
Data mengenai permintaan pemeriksaan swab nasal ataupun tenggorokan dapat dikirimkan dengan resource ServiceRequest.

<!--Part 3-1-->
<h4 style="font-weight: bold;">A. Rujukan dari Faskes Sentinel ke Lab Terpilih</h4>
<h5>Permintaan Pemeriksaan COVID-19 PCR</h5>
<ul class="nav nav-tabs" role="tablist">
<li role="presentation" class="active">
<a href="#example-3-1" aria-controls="example" role="tab" data-toggle="tab">Example</a>
</li>
<li role="presentation">
<a href="#data-3-1" aria-controls="data" role="tab" data-toggle="tab">Template</a>
</li>
<li role="presentation">
<a href="#variabel-3-1" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
</li>
<li role="presentation">
<a href="#valueset-3-1" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
</li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
<div role="tabpanel" class="tab-pane active" id="example-3-1">
<div style="background: #F6F8F8;border: 1px solid #e8edee;">
{{json:covid-ILI-ServiceRequest-Create-PermintaanPemeriksaanCOVID-19PCR}}
</div>
</div>

<div role="tabpanel" class="tab-pane" id="data-3-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "ServiceRequest",
	"identifier": [
        {
            "system": "http://sys-ids.kemkes.go.id/servicerequest/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;SERVICEREQUEST_LOCAL_CODE&rcub;&rcub;</strong>"
        }
    ],
    "status": "active",
    "intent": "original-order",
    "category":  [
        {
            "coding":  [
                {
                    "system": "http://snomed.info/sct",
                    "code": "108252007",
                    "display": "Laboratory procedure"
                }
            ]
        },
        {
            "coding":  [
                {
                    "system": "http://snomed.info/sct",
                    "code": "3457005",
                    "display": "Patient referral"
                }
            ]
        }
    ],
    "priority": "routine",
    "code": {
        "coding":  [
            {
                "system": "http://loinc.org",
                "code": "94500-6",
                "display": "SARS-CoV-2 (COVID-19) RNA [Presence] in Respiratory specimen by NAA with probe detection"
            }
        ]
    },
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>"
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "encounter": {
        "reference": "Encounter/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_ENCOUNTER&rcub;&rcub;</strong>"
    },
    "occurrenceDateTime":  "<strong style="color:#00a7ff">&lcub;&lcub;SERVICEREQUEST_OCCURRENCE_DATETIME&rcub;&rcub;</strong>",
    "requester": {
        "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>"
    },
    "performer":  [
        {
            "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "locationCode":  [
        {
            "coding":  [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/v3-RoleCode",
                    "code": "HLAB",
                    "display": "hospital laboratory"
                }
            ]
        }
    ],
    "locationReference":  [
        {
            "reference": "Location/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_LOCATION&rcub;&rcub;</strong>",
        }
    ],
    "reasonCode":  [
        {
            "text": "<strong style="color:#00a7ff">&lcub;&lcub;REASON_FOR_SERVICEREQUEST&rcub;&rcub;</strong>"
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __SERVICEREQUEST_LOCAL_CODE__   | Kode atau ID lokal/nomor service request lokal yang disimpan di sistem internal masing-masing organisasi |
| __PATIENT_IHS_NUMBER__     | ID Patient yang didapatkan dari master pasien indeks |
| __PATIENT_NAME__           | Nama Pasien |

| __ID_RESOURCE_ENCOUNTER__      		| {id-resource-Encounter} pada SATUSEHAT untuk data kunjungan |
| __SERVICEREQUEST_OCCURRENCE_DATETIME__           | Berisi data informasi kapan kontrol harus terlaksana dengan tipe data dateTime, dengan format yang diperbolehkan YYYY-MM-DDThh:mm:ss+zz:zz |
| __ORGANIZATION_IHS_NUMBER__    | ID organisasi induk yang didapatkan dari master sarana indeks |
| __ID_RESOURCE_LOCATION__      		| {id-resource-Location} pada SATUSEHAT untuk data lokasi faskes |
| __REASON_FOR_SERVICEREQUEST__      |Berisi data yang berkaitan dengan penjelasan atau justifikasi mengenai mengapa pelayanan ini diminta dalam bentuk kode atau teks |
</div>
</div>

<div role="tabpanel" class="tab-pane" id="valueset-3-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
[none]
</div>
</div>
</div>
<br>
<!--END Part 3-1-->

<!--Part 3-1-2-->
<h5>Permintaan Pemeriksaan Influenza A</h5>
<ul class="nav nav-tabs" role="tablist">
<li role="presentation" class="active">
<a href="#example-3-1-2" aria-controls="example" role="tab" data-toggle="tab">Example</a>
</li>
<li role="presentation">
<a href="#data-3-1-2" aria-controls="data" role="tab" data-toggle="tab">Template</a>
</li>
<li role="presentation">
<a href="#variabel-3-1-2" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
</li>
<li role="presentation">
<a href="#valueset-3-1-2" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
</li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
<div role="tabpanel" class="tab-pane active" id="example-3-1-2">
<div style="background: #F6F8F8;border: 1px solid #e8edee;">
{{json:covid/ili/ServiceRequest-Create-PermintaanPemeriksaanInfluenzaA.json}}
</div>
</div>

<div role="tabpanel" class="tab-pane" id="data-3-1-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "ServiceRequest",
	"identifier": [
        {
            "system": "http://sys-ids.kemkes.go.id/servicerequest/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;SERVICEREQUEST_LOCAL_CODE&rcub;&rcub;</strong>"
        }
    ],
    "status": "active",
    "intent": "original-order",
    "category":  [
        {
            "coding":  [
                {
                    "system": "http://snomed.info/sct",
                    "code": "108252007",
                    "display": "Laboratory procedure"
                }
            ]
        },
        {
            "coding":  [
                {
                    "system": "http://snomed.info/sct",
                    "code": "3457005",
                    "display": "Patient referral"
                }
            ]
        }
    ],
    "priority": "routine",
    "code": {
        "coding":  [
            {
                "system": "http://loinc.org",
                "code": "92142-9",
                "display": "Influenza virus A RNA [Presence] in Respiratory system specimen by NAA with probe detection"
            }
        ]
    },
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>"
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "encounter": {
        "reference": "Encounter/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_ENCOUNTER&rcub;&rcub;</strong>"
    },
    "occurrenceDateTime":  "<strong style="color:#00a7ff">&lcub;&lcub;SERVICEREQUEST_OCCURRENCE_DATETIME&rcub;&rcub;</strong>",
    "requester": {
        "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>"
    },
    "performer":  [
        {
            "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "locationCode":  [
        {
            "coding":  [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/v3-RoleCode",
                    "code": "HLAB",
                    "display": "hospital laboratory"
                }
            ]
        }
    ],
    "locationReference":  [
        {
            "reference": "Location/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_LOCATION&rcub;&rcub;</strong>",
        }
    ],
    "reasonCode":  [
        {
            "text": "<strong style="color:#00a7ff">&lcub;&lcub;REASON_FOR_SERVICEREQUEST&rcub;&rcub;</strong>"
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-1-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __SERVICEREQUEST_LOCAL_CODE__   | Kode atau ID lokal/nomor service request lokal yang disimpan di sistem internal masing-masing organisasi |
| __PATIENT_IHS_NUMBER__     | ID Patient yang didapatkan dari master pasien indeks |
| __PATIENT_NAME__           | Nama Pasien |

| __ID_RESOURCE_ENCOUNTER__      		| {id-resource-Encounter} pada SATUSEHAT untuk data kunjungan |
| __SERVICEREQUEST_OCCURRENCE_DATETIME__           | Berisi data informasi kapan kontrol harus terlaksana dengan tipe data dateTime, dengan format yang diperbolehkan YYYY-MM-DDThh:mm:ss+zz:zz |
| __ORGANIZATION_IHS_NUMBER__    | ID organisasi induk yang didapatkan dari master sarana indeks |
| __ID_RESOURCE_LOCATION__      		| {id-resource-Location} pada SATUSEHAT untuk data lokasi faskes |
| __REASON_FOR_SERVICEREQUEST__      |Berisi data yang berkaitan dengan penjelasan atau justifikasi mengenai mengapa pelayanan ini diminta dalam bentuk kode atau teks |
</div>
</div>

<div role="tabpanel" class="tab-pane" id="valueset-3-1-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
[none]
</div>
</div>
</div>
<br>
<!--END Part 3-1-2-->


<!--Part 3-1-3-->
<h5>Permintaan Pemeriksaan Influenza B</h5>
<ul class="nav nav-tabs" role="tablist">
<li role="presentation" class="active">
<a href="#example-3-1-3" aria-controls="example" role="tab" data-toggle="tab">Example</a>
</li>
<li role="presentation">
<a href="#data-3-1-3" aria-controls="data" role="tab" data-toggle="tab">Template</a>
</li>
<li role="presentation">
<a href="#variabel-3-1-3" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
</li>
<li role="presentation">
<a href="#valueset-3-1-3" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
</li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
<div role="tabpanel" class="tab-pane active" id="example-3-1-3">
<div style="background: #F6F8F8;border: 1px solid #e8edee;">
{{json:covid/ili/ServiceRequest-Create-PermintaanPemeriksaanInfluenzaB.json}}
</div>
</div>

<div role="tabpanel" class="tab-pane" id="data-3-1-3" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "ServiceRequest",
	"identifier": [
        {
            "system": "http://sys-ids.kemkes.go.id/servicerequest/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;SERVICEREQUEST_LOCAL_CODE&rcub;&rcub;</strong>"
        }
    ],
    "status": "active",
    "intent": "original-order",
    "category":  [
        {
            "coding":  [
                {
                    "system": "http://snomed.info/sct",
                    "code": "108252007",
                    "display": "Laboratory procedure"
                }
            ]
        },
        {
            "coding":  [
                {
                    "system": "http://snomed.info/sct",
                    "code": "3457005",
                    "display": "Patient referral"
                }
            ]
        }
    ],
    "priority": "routine",
    "code": {
        "coding":  [
            {
                "system": "http://loinc.org",
                "code": "92141-1",
                "display": "Influenza virus B RNA [Presence] in Respiratory system specimen by NAA with probe detection"
            }
        ]
    },
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>"
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "encounter": {
        "reference": "Encounter/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_ENCOUNTER&rcub;&rcub;</strong>"
    },
    "occurrenceDateTime":  "<strong style="color:#00a7ff">&lcub;&lcub;SERVICEREQUEST_OCCURRENCE_DATETIME&rcub;&rcub;</strong>",
    "requester": {
        "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>"
    },
    "performer":  [
        {
            "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "locationCode":  [
        {
            "coding":  [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/v3-RoleCode",
                    "code": "HLAB",
                    "display": "hospital laboratory"
                }
            ]
        }
    ],
    "locationReference":  [
        {
            "reference": "Location/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_LOCATION&rcub;&rcub;</strong>",
        }
    ],
    "reasonCode":  [
        {
            "text": "<strong style="color:#00a7ff">&lcub;&lcub;REASON_FOR_SERVICEREQUEST&rcub;&rcub;</strong>"
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-1-3" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __SERVICEREQUEST_LOCAL_CODE__   | Kode atau ID lokal/nomor service request lokal yang disimpan di sistem internal masing-masing organisasi |
| __PATIENT_IHS_NUMBER__     | ID Patient yang didapatkan dari master pasien indeks |
| __PATIENT_NAME__           | Nama Pasien |

| __ID_RESOURCE_ENCOUNTER__      		| {id-resource-Encounter} pada SATUSEHAT untuk data kunjungan |
| __SERVICEREQUEST_OCCURRENCE_DATETIME__           | Berisi data informasi kapan kontrol harus terlaksana dengan tipe data dateTime, dengan format yang diperbolehkan YYYY-MM-DDThh:mm:ss+zz:zz |
| __ORGANIZATION_IHS_NUMBER__    | ID organisasi induk yang didapatkan dari master sarana indeks |
| __ID_RESOURCE_LOCATION__      		| {id-resource-Location} pada SATUSEHAT untuk data lokasi faskes |
| __REASON_FOR_SERVICEREQUEST__      |Berisi data yang berkaitan dengan penjelasan atau justifikasi mengenai mengapa pelayanan ini diminta dalam bentuk kode atau teks |
</div>
</div>

<div role="tabpanel" class="tab-pane" id="valueset-3-1-3" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
[none]
</div>
</div>
</div>
<br>
<!--END Part 3-1-3-->

<!--Part 3-2-->
<h4 style="font-weight: bold;">B. Permintaan Pemeriksaan Laboratorium Dalam Faskes</h4>
<h5>Permintaan Pemeriksaan COVID-19 PCR</h5>
<ul class="nav nav-tabs" role="tablist">
<li role="presentation" class="active">
<a href="#example-3-2" aria-controls="example" role="tab" data-toggle="tab">Example</a>
</li>
<li role="presentation">
<a href="#data-3-2" aria-controls="data" role="tab" data-toggle="tab">Template</a>
</li>
<li role="presentation">
<a href="#variabel-3-2" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
</li>
<li role="presentation">
<a href="#valueset-3-2" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
</li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
<div role="tabpanel" class="tab-pane active" id="example-3-2">
<div style="background: #F6F8F8;border: 1px solid #e8edee;">
{{json:covid-ILI-ServiceRequest-Create-PermintaanPemeriksaanCOVID-19PCR-2}}
</div>
</div>

<div role="tabpanel" class="tab-pane" id="data-3-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "ServiceRequest",
	"identifier": [
        {
            "system": "http://sys-ids.kemkes.go.id/servicerequest/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;SERVICEREQUEST_LOCAL_CODE&rcub;&rcub;</strong>"
        }
    ],
    "status": "active",
    "intent": "original-order",
    "category":  [
        {
            "coding":  [
                {
                    "system": "http://snomed.info/sct",
                    "code": "108252007",
                    "display": "Laboratory procedure"
                }
            ]
        }
    ],
    "priority": "routine",
    "code": {
        "coding":  [
            {
                "system": "http://loinc.org",
                "code": "94500-6",
                "display": "SARS-CoV-2 (COVID-19) RNA [Presence] in Respiratory specimen by NAA with probe detection"
            }
        ]
    },
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>"
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "encounter": {
        "reference": "Encounter/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_ENCOUNTER&rcub;&rcub;</strong>"
    },
    "occurrenceDateTime":  "<strong style="color:#00a7ff">&lcub;&lcub;SERVICEREQUEST_OCCURRENCE_DATETIME&rcub;&rcub;</strong>",
    "requester": {
        "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_IHS_NUMBER&rcub;&rcub;</strong>"
    },
    "performer":  [
        {
            "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "locationCode":  [
        {
            "coding":  [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/v3-RoleCode",
                    "code": "HLAB",
                    "display": "hospital laboratory"
                }
            ]
        }
    ],
    "locationReference":  [
        {
            "reference": "Location/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_LOCATION&rcub;&rcub;</strong>",
        }
    ],
    "reasonCode":  [
        {
            "text": "<strong style="color:#00a7ff">&lcub;&lcub;REASON_FOR_SERVICEREQUEST&rcub;&rcub;</strong>"
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __SERVICEREQUEST_LOCAL_CODE__   | Kode atau ID lokal/nomor service request lokal yang disimpan di sistem internal masing-masing organisasi |
| __PATIENT_IHS_NUMBER__     | ID Patient yang didapatkan dari master pasien indeks |
| __PATIENT_NAME__           | Nama Pasien |

| __ID_RESOURCE_ENCOUNTER__      		| {id-resource-Encounter} pada SATUSEHAT untuk data kunjungan |
| __SERVICEREQUEST_OCCURRENCE_DATETIME__           | Berisi data informasi kapan kontrol harus terlaksana dengan tipe data dateTime, dengan format yang diperbolehkan YYYY-MM-DDThh:mm:ss+zz:zz |
| __DOCTOR_IHS_NUMBER__      | ID Nakes organisasi induk yang didapatkan dari master Nakes indeks |
| __ORGANIZATION_IHS_NUMBER__    | ID organisasi induk yang didapatkan dari master sarana indeks |
| __ID_RESOURCE_LOCATION__      		| {id-resource-Location} pada SATUSEHAT untuk data lokasi faskes |
| __REASON_FOR_SERVICEREQUEST__      |Berisi data yang berkaitan dengan penjelasan atau justifikasi mengenai mengapa pelayanan ini diminta dalam bentuk kode atau teks |
</div>
</div>

<div role="tabpanel" class="tab-pane" id="valueset-3-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
[none]
</div>
</div>
</div>
<br>
<!--END Part 3-2-->


<!--Part 3-2-2-->
<h5>Permintaan Pemeriksaan Influenza A</h5>
<ul class="nav nav-tabs" role="tablist">
<li role="presentation" class="active">
<a href="#example-3-2-2" aria-controls="example" role="tab" data-toggle="tab">Example</a>
</li>
<li role="presentation">
<a href="#data-3-2-2" aria-controls="data" role="tab" data-toggle="tab">Template</a>
</li>
<li role="presentation">
<a href="#variabel-3-2-2" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
</li>
<li role="presentation">
<a href="#valueset-3-2-2" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
</li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
<div role="tabpanel" class="tab-pane active" id="example-3-2-2">
<div style="background: #F6F8F8;border: 1px solid #e8edee;">
{{json:covid/ili/ServiceRequest-Create-PermintaanPemeriksaanInfluenzaA-2.json}}
</div>
</div>

<div role="tabpanel" class="tab-pane" id="data-3-2-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "ServiceRequest",
	"identifier": [
        {
            "system": "http://sys-ids.kemkes.go.id/servicerequest/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;SERVICEREQUEST_LOCAL_CODE&rcub;&rcub;</strong>"
        }
    ],
    "status": "active",
    "intent": "original-order",
    "category":  [
        {
            "coding":  [
                {
                    "system": "http://snomed.info/sct",
                    "code": "108252007",
                    "display": "Laboratory procedure"
                }
            ]
        }
    ],
    "priority": "routine",
    "code": {
        "coding":  [
            {
                "system": "http://loinc.org",
                "code": "92142-9",
                "display": "Influenza virus A RNA [Presence] in Respiratory system specimen by NAA with probe detection"
            }
        ]
    },
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>"
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "encounter": {
        "reference": "Encounter/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_ENCOUNTER&rcub;&rcub;</strong>"
    },
    "occurrenceDateTime":  "<strong style="color:#00a7ff">&lcub;&lcub;SERVICEREQUEST_OCCURRENCE_DATETIME&rcub;&rcub;</strong>",
    "requester": {
        "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_IHS_NUMBER&rcub;&rcub;</strong>"
    },
    "performer":  [
        {
            "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "locationCode":  [
        {
            "coding":  [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/v3-RoleCode",
                    "code": "HLAB",
                    "display": "hospital laboratory"
                }
            ]
        }
    ],
    "locationReference":  [
        {
            "reference": "Location/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_LOCATION&rcub;&rcub;</strong>",
        }
    ],
    "reasonCode":  [
        {
            "text": "<strong style="color:#00a7ff">&lcub;&lcub;REASON_FOR_SERVICEREQUEST&rcub;&rcub;</strong>"
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-2-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __SERVICEREQUEST_LOCAL_CODE__   | Kode atau ID lokal/nomor service request lokal yang disimpan di sistem internal masing-masing organisasi |
| __PATIENT_IHS_NUMBER__     | ID Patient yang didapatkan dari master pasien indeks |
| __PATIENT_NAME__           | Nama Pasien |

| __ID_RESOURCE_ENCOUNTER__      		| {id-resource-Encounter} pada SATUSEHAT untuk data kunjungan |
| __SERVICEREQUEST_OCCURRENCE_DATETIME__           | Berisi data informasi kapan kontrol harus terlaksana dengan tipe data dateTime, dengan format yang diperbolehkan YYYY-MM-DDThh:mm:ss+zz:zz |
| __DOCTOR_IHS_NUMBER__      | ID Nakes organisasi induk yang didapatkan dari master Nakes indeks |
| __ORGANIZATION_IHS_NUMBER__    | ID organisasi induk yang didapatkan dari master sarana indeks |
| __ID_RESOURCE_LOCATION__      		| {id-resource-Location} pada SATUSEHAT untuk data lokasi faskes |
| __REASON_FOR_SERVICEREQUEST__      |Berisi data yang berkaitan dengan penjelasan atau justifikasi mengenai mengapa pelayanan ini diminta dalam bentuk kode atau teks |
</div>
</div>

<div role="tabpanel" class="tab-pane" id="valueset-3-2-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
[none]
</div>
</div>
</div>
<br>
<!--END Part 3-2-2-->


<!--Part 3-2-3-->
<h5>Permintaan Pemeriksaan Influenza B</h5>
<ul class="nav nav-tabs" role="tablist">
<li role="presentation" class="active">
<a href="#example-3-2-3" aria-controls="example" role="tab" data-toggle="tab">Example</a>
</li>
<li role="presentation">
<a href="#data-3-2-3" aria-controls="data" role="tab" data-toggle="tab">Template</a>
</li>
<li role="presentation">
<a href="#variabel-3-2-3" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
</li>
<li role="presentation">
<a href="#valueset-3-2-3" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
</li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
<div role="tabpanel" class="tab-pane active" id="example-3-2-3">
<div style="background: #F6F8F8;border: 1px solid #e8edee;">
{{json:covid/ili/ServiceRequest-Create-PermintaanPemeriksaanInfluenzaB-2.json}}
</div>
</div>

<div role="tabpanel" class="tab-pane" id="data-3-2-3" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "ServiceRequest",
	"identifier": [
        {
            "system": "http://sys-ids.kemkes.go.id/servicerequest/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;SERVICEREQUEST_LOCAL_CODE&rcub;&rcub;</strong>"
        }
    ],
    "status": "active",
    "intent": "original-order",
    "category":  [
        {
            "coding":  [
                {
                    "system": "http://snomed.info/sct",
                    "code": "108252007",
                    "display": "Laboratory procedure"
                }
            ]
        }
    ],
    "priority": "routine",
    "code": {
        "coding":  [
            {
                "system": "http://loinc.org",
                "code": "92141-1",
                "display": "Influenza virus B RNA [Presence] in Respiratory system specimen by NAA with probe detection"
            }
        ]
    },
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>"
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "encounter": {
        "reference": "Encounter/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_ENCOUNTER&rcub;&rcub;</strong>"
    },
    "occurrenceDateTime":  "<strong style="color:#00a7ff">&lcub;&lcub;SERVICEREQUEST_OCCURRENCE_DATETIME&rcub;&rcub;</strong>",
    "requester": {
        "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_IHS_NUMBER&rcub;&rcub;</strong>"
    },
    "performer":  [
        {
            "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "locationCode":  [
        {
            "coding":  [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/v3-RoleCode",
                    "code": "HLAB",
                    "display": "hospital laboratory"
                }
            ]
        }
    ],
    "locationReference":  [
        {
            "reference": "Location/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_LOCATION&rcub;&rcub;</strong>",
        }
    ],
    "reasonCode":  [
        {
            "text": "<strong style="color:#00a7ff">&lcub;&lcub;REASON_FOR_SERVICEREQUEST&rcub;&rcub;</strong>"
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-2-3" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __SERVICEREQUEST_LOCAL_CODE__   | Kode atau ID lokal/nomor service request lokal yang disimpan di sistem internal masing-masing organisasi |
| __PATIENT_IHS_NUMBER__     | ID Patient yang didapatkan dari master pasien indeks |
| __PATIENT_NAME__           | Nama Pasien |

| __ID_RESOURCE_ENCOUNTER__      		| {id-resource-Encounter} pada SATUSEHAT untuk data kunjungan |
| __SERVICEREQUEST_OCCURRENCE_DATETIME__           | Berisi data informasi kapan kontrol harus terlaksana dengan tipe data dateTime, dengan format yang diperbolehkan YYYY-MM-DDThh:mm:ss+zz:zz |
| __DOCTOR_IHS_NUMBER__      | ID Nakes organisasi induk yang didapatkan dari master Nakes indeks |
| __ORGANIZATION_IHS_NUMBER__    | ID organisasi induk yang didapatkan dari master sarana indeks |
| __ID_RESOURCE_LOCATION__      		| {id-resource-Location} pada SATUSEHAT untuk data lokasi faskes |
| __REASON_FOR_SERVICEREQUEST__      |Berisi data yang berkaitan dengan penjelasan atau justifikasi mengenai mengapa pelayanan ini diminta dalam bentuk kode atau teks |
</div>
</div>

<div role="tabpanel" class="tab-pane" id="valueset-3-2-3" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
[none]
</div>
</div>
</div>
<br>
<!--END Part 3-2-3-->

</div>
<!--END Part 3-->

<!--Part 4-->

### <div id="specimen">Step 4. Spesimen</div>

<div style="margin-left: 30px;">
<!--Part 4-1-->
<h4 style="font-weight: bold;">Specimen Keadaan Baik</h4>
<ul class="nav nav-tabs" role="tablist">
<li role="presentation" class="active">
<a href="#example-4-1" aria-controls="example" role="tab" data-toggle="tab">Example</a>
</li>
<li role="presentation">
<a href="#data-4-1" aria-controls="data" role="tab" data-toggle="tab">Template</a>
</li>
<li role="presentation">
<a href="#variabel-4-1" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
</li>
<li role="presentation">
<a href="#valueset-4-1" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
</li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
<div role="tabpanel" class="tab-pane active" id="example-4-1">
<div style="background: #F6F8F8;border: 1px solid #e8edee;">
{{json:covid-ILI-Specimen-Create-GoodCondition}}
</div>
</div>

<div role="tabpanel" class="tab-pane" id="data-4-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
#tba
</div>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-4-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
#tba
</div>
</div>

<div role="tabpanel" class="tab-pane" id="valueset-4-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
[none]
</div>
</div>
</div>
<br>
<!--END Part 4-1-->

<!--Part 4-2-->
<h4 style="font-weight: bold;">Specimen Keadaan Tidak Baik</h4>
<ul class="nav nav-tabs" role="tablist">
<li role="presentation" class="active">
<a href="#example-4-2" aria-controls="example" role="tab" data-toggle="tab">Example</a>
</li>
<li role="presentation">
<a href="#data-4-2" aria-controls="data" role="tab" data-toggle="tab">Template</a>
</li>
<li role="presentation">
<a href="#variabel-4-2" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
</li>
<li role="presentation">
<a href="#valueset-4-2" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
</li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
<div role="tabpanel" class="tab-pane active" id="example-4-2">
<div style="background: #F6F8F8;border: 1px solid #e8edee;">
{{json:covid-ILI-Specimen-Create-BadCondition}}
</div>
</div>

<div role="tabpanel" class="tab-pane" id="data-4-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
#tba
</div>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-4-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
#tba
</div>
</div>

<div role="tabpanel" class="tab-pane" id="valueset-4-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
[none]
</div>
</div>
</div>
<br>
<!--END Part 4-2-->
</div>
<!--END Part 4-->

<!--Part 5-->

### <div id="specimen">Step 5. Hasil Pemeriksaan Laboratorium</div>

<div style="margin-left: 30px;">
<!--Part 5-1-->
<h4 style="font-weight: bold;">A. COVID-19 PCR</h4>
<h5>COVID-19 PCR - Positif</h5>
<ul class="nav nav-tabs" role="tablist">
<li role="presentation" class="active">
<a href="#example-5-1" aria-controls="example" role="tab" data-toggle="tab">Example</a>
</li>
<li role="presentation">
<a href="#data-5-1" aria-controls="data" role="tab" data-toggle="tab">Template</a>
</li>
<li role="presentation">
<a href="#variabel-5-1" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
</li>
<li role="presentation">
<a href="#valueset-5-1" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
</li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
<div role="tabpanel" class="tab-pane active" id="example-5-1">
<div style="background: #F6F8F8;border: 1px solid #e8edee;">
{{json:covid-ILI-Observation-Create-HasilPemeriksaanLab-Covid19}}
</div>
</div>

<div role="tabpanel" class="tab-pane" id="data-5-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
#tba
</div>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-5-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
#tba
</div>
</div>

<div role="tabpanel" class="tab-pane" id="valueset-5-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
[none]
</div>
</div>
</div>
<br>
<!--END Part 5-1-->

<!--Part 5-2-1-->
<h4 style="font-weight: bold;">B. Influenza A</h4>
<h5>Influenza A - Positif</h5>
<ul class="nav nav-tabs" role="tablist">
<li role="presentation" class="active">
<a href="#example-5-2-1" aria-controls="example" role="tab" data-toggle="tab">Example</a>
</li>
<li role="presentation">
<a href="#data-5-2-1" aria-controls="data" role="tab" data-toggle="tab">Template</a>
</li>
<li role="presentation">
<a href="#variabel-5-2-1" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
</li>
<li role="presentation">
<a href="#valueset-5-2-1" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
</li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
<div role="tabpanel" class="tab-pane active" id="example-5-2-1">
<div style="background: #F6F8F8;border: 1px solid #e8edee;">
{{json:covid-ILI-Observation-Create-HasilPemeriksaanLab-InfluenzaA-Positif}}
</div>
</div>

<div role="tabpanel" class="tab-pane" id="data-5-2-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
#tba
</div>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-5-2-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
#tba
</div>
</div>

<div role="tabpanel" class="tab-pane" id="valueset-5-2-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
[none]
</div>
</div>
</div>
<br>
<!--END Part 5-2-1-->

<!--Part 5-2-2-->
<h5>Influenza A - Subtype</h5>
<ul class="nav nav-tabs" role="tablist">
<li role="presentation" class="active">
<a href="#example-5-2-2" aria-controls="example" role="tab" data-toggle="tab">Example</a>
</li>
<li role="presentation">
<a href="#data-5-2-2" aria-controls="data" role="tab" data-toggle="tab">Template</a>
</li>
<li role="presentation">
<a href="#variabel-5-2-2" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
</li>
<li role="presentation">
<a href="#valueset-5-2-2" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
</li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
<div role="tabpanel" class="tab-pane active" id="example-5-2-2">
<div style="background: #F6F8F8;border: 1px solid #e8edee;">{{json:covid-ILI-Observation-Create-HasilPemeriksaanLab-InfluenzaA-Subtype}}
</div>
</div>

<div role="tabpanel" class="tab-pane" id="data-5-2-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
#tba
</div>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-5-2-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
#tba
</div>
</div>

<div role="tabpanel" class="tab-pane" id="valueset-5-2-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
[none]
</div>
</div>
</div>
<br>
<!--END Part 5-2-2-->

<!--Part 5-2-3-->
<h5>Influenza A - Invalid</h5>
<ul class="nav nav-tabs" role="tablist">
<li role="presentation" class="active">
<a href="#example-5-2-3" aria-controls="example" role="tab" data-toggle="tab">Example</a>
</li>
<li role="presentation">
<a href="#data-5-2-3" aria-controls="data" role="tab" data-toggle="tab">Template</a>
</li>
<li role="presentation">
<a href="#variabel-5-2-3" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
</li>
<li role="presentation">
<a href="#valueset-5-2-3" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
</li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
<div role="tabpanel" class="tab-pane active" id="example-5-2-3">
<div style="background: #F6F8F8;border: 1px solid #e8edee;">{{json:covid-ILI-Observation-Create-HasilPemeriksaanLab-InfluenzaA-Invalid}}
</div>
</div>

<div role="tabpanel" class="tab-pane" id="data-5-2-3" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
#tba
</div>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-5-2-3" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
#tba
</div>
</div>

<div role="tabpanel" class="tab-pane" id="valueset-5-2-3" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
[none]
</div>
</div>
</div>
<br>
<!--END Part 5-2-3-->

</div>

### <div id=""> Step 6. Laporan Hasil Pemeriksaan Laboratorium (Waktu Verifikasi Hasil)</div>

<div style="margin-left: 30px;">

<!--Part 6-1-->
<h4 style="font-weight: bold;">A. Covid 19</h4>
<h5>Covid 19 - Positif</h5>
<ul class="nav nav-tabs" role="tablist">
<li role="presentation" class="active">
<a href="#example-6-1" aria-controls="example" role="tab" data-toggle="tab">Example</a>
</li>
<li role="presentation">
<a href="#data-6-1" aria-controls="data" role="tab" data-toggle="tab">Template</a>
</li>
<li role="presentation">
<a href="#variabel-6-1" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
</li>
<li role="presentation">
<a href="#valueset-6-1" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
</li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
<div role="tabpanel" class="tab-pane active" id="example-6-1">
<div style="background: #F6F8F8;border: 1px solid #e8edee;">{{json:covid-ILI-DiagnosticReport-Create-Laporan-Covid19}}
</div>
</div>

<div role="tabpanel" class="tab-pane" id="data-6-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
#tba
</div>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-6-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
#tba
</div>
</div>

<div role="tabpanel" class="tab-pane" id="valueset-6-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
[none]
</div>
</div>
</div>
<br>
<!--END Part 6-1-->

<!--Part 6-2-->
<h4 style="font-weight: bold;">B. Influenza A</h4>
<h5>Influenza A - Positif</h5>
<ul class="nav nav-tabs" role="tablist">
<li role="presentation" class="active">
<a href="#example-6-2" aria-controls="example" role="tab" data-toggle="tab">Example</a>
</li>
<li role="presentation">
<a href="#data-6-2" aria-controls="data" role="tab" data-toggle="tab">Template</a>
</li>
<li role="presentation">
<a href="#variabel-6-2" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
</li>
<li role="presentation">
<a href="#valueset-6-2" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
</li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
<div role="tabpanel" class="tab-pane active" id="example-6-2">
<div style="background: #F6F8F8;border: 1px solid #e8edee;">{{json:covid-ILI-DiagnosticReport-Create-Laporan-InfluenzaA}}
</div>
</div>

<div role="tabpanel" class="tab-pane" id="data-6-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
#tba
</div>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-6-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
#tba
</div>
</div>

<div role="tabpanel" class="tab-pane" id="valueset-6-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
[none]
</div>
</div>
</div>
<br>
<!--END Part 6-2-->

<!--Part 6-3-->
<h5>Influenza A Subtype</h5>
<ul class="nav nav-tabs" role="tablist">
<li role="presentation" class="active">
<a href="#example-6-3" aria-controls="example" role="tab" data-toggle="tab">Example</a>
</li>
<li role="presentation">
<a href="#data-6-3" aria-controls="data" role="tab" data-toggle="tab">Template</a>
</li>
<li role="presentation">
<a href="#variabel-6-3" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
</li>
<li role="presentation">
<a href="#valueset-6-3" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
</li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
<div role="tabpanel" class="tab-pane active" id="example-6-3">
<div style="background: #F6F8F8;border: 1px solid #e8edee;">{{json:covid-ILI-DiagnosticReport-Create-Laporan-InfluenzaA-Subtype}}
</div>
</div>

<div role="tabpanel" class="tab-pane" id="data-6-3" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
#tba
</div>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-6-3" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
#tba
</div>
</div>

<div role="tabpanel" class="tab-pane" id="valueset-6-3" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
[none]
</div>
</div>
</div>
<br>
<!--END Part 6-3-->
</div>

### <div id=""> Step 7. Update Data Kunjungan</div>

<div style="margin-left: 30px;">

<!--Part 7-1-->
<h4 style="font-weight: bold;">Pasien Pulang</h4>
<ul class="nav nav-tabs" role="tablist">
<li role="presentation" class="active">
<a href="#example-7-1" aria-controls="example" role="tab" data-toggle="tab">Example</a>
</li>
<li role="presentation">
<a href="#data-7-1" aria-controls="data" role="tab" data-toggle="tab">Template</a>
</li>
<li role="presentation">
<a href="#variabel-7-1" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
</li>
<li role="presentation">
<a href="#valueset-7-1" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
</li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
<div role="tabpanel" class="tab-pane active" id="example-7-1">
<div style="background: #F6F8F8;border: 1px solid #e8edee;">{{json:covid/ILI/Encounter-Update-PasienPulang.json}}
</div>
</div>

<div role="tabpanel" class="tab-pane" id="data-7-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
#tba
</div>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-7-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
#tba
</div>
</div>

<div role="tabpanel" class="tab-pane" id="valueset-7-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
[none]
</div>
</div>
</div>
<br>
<!--END Part 7-1-->
</div>

### <div id="">Step 8. Kuesioner Kasus ILI</div>

<div style="margin-left: 30px;">

<!--Part 8-1-->
<ul class="nav nav-tabs" role="tablist">
<li role="presentation" class="active">
<a href="#example-8-1" aria-controls="example" role="tab" data-toggle="tab">Example</a>
</li>
<li role="presentation">
<a href="#data-8-1" aria-controls="data" role="tab" data-toggle="tab">Template</a>
</li>
<li role="presentation">
<a href="#variabel-8-1" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
</li>
<li role="presentation">
<a href="#valueset-8-1" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
</li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
<div role="tabpanel" class="tab-pane active" id="example-8-1">
<div style="background: #F6F8F8;border: 1px solid #e8edee;">{{json:covid-ILI-Composition-Create-Kuesioner-Kasus-ILI}}
</div>
</div>

<div role="tabpanel" class="tab-pane" id="data-8-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
#tba
</div>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-8-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
#tba
</div>
</div>

<div role="tabpanel" class="tab-pane" id="valueset-8-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
[none]
</div>
</div>
</div>
<br>
<!--END Part 8-1-->

</div>
