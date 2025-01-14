<img src="https://raw.githubusercontent.com/kemkes/fhir-ig-tb-assets/main/images/tb-frame-1.jpg" alt="alt text" title="Tuberculosis Workflow" style="width: 100%;">

*__Perekaman awal kasus Tuberkulosis:__ dimulai dari Registrasi Kasus, Pemeriksaan Penunjang dan diakhiri oleh Verifikasi Kasus Temuan*

## A. Registrasi Kasus

Proses ini secara khusus untuk meregistrasikan data kunjungan pasien, fasyankes tempat pemeriksaan serta permintaan pemeriksaan laboratorium atau radiologis.
Karena data pasien di dalam SATUSEHAT sudah terdaftar lebih dulu, sehingga registrasi data pasien baru tidak perlukan. Dengan demikian maka entry data untuk resource Patient tidak perlu diikutsertakan dalam bundle data yang dikirim.

Disamping itu terkait dengan data FASYANKES tempat dilakukannya perawatan TB juga tidak perlu dikirimkan data alamat seperti provinsi, dan kabupaten/kota karena data sudah tersedia pada Facility Master Index yang ada di SATUSEHAT. Referensi terkait data FASYANKES dapat dilakukan menggunakan kode referensi SATUSEHAT Number FASYANKES untuk menandai EpisodeOfCare.managingOrganization dan Encounter.serviceProvider.

### I. Berbasis Resource
**Entry Resources yang digunakan**

| No  | Nama Resource         | Entry Mandatory | Metode               |
| --- |:----------------------| --------------- |:---------------------|
| 1   | __Encounter__         | __Required__    | __BUAT BARU (POST)__ |

#### 1. Encouter

<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-1" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-1" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-1" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
</ul>
<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-1">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:Encounter-Create}}
        </div>
    </div>
    <div role="tabpanel" class="tab-pane" id="data-1">
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
    <div role="tabpanel" class="tab-pane" id="variabel-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
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

### II. Berbasis Bundle
