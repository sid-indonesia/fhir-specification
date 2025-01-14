# Implementasi Use Case Antenatal Care
*Last Updated: 2023/12/12*

## A. Pendahuluan

Implementasi pelaporan pemeriksaan *antenatal care* (ANC) secara umum dapat dibagi menjadi 14 bagian:
1. Pendaftaran Pasien
2. Pendaftaran Kunjungan Pasien
3. Pengiriman Data Status Obstetri
4. Pengiriman Data Kunjungan Kehamilan
5. Pengiriman Data Pelayanan Kehamilan (Hasil Pemeriksaan Ibu dan Janin)
6. Pengiriman Data Tindakan
7. Pengiriman Data Tema Konseling/Temu Wicara/Edukasi
8. Pengiriman Data Pemeriksaan Penunjang (Laboratorium dan Radiologi)
9. Pengiriman Data Peresepan Obat
10. Pengiriman Data Pengeluaran Obat
11. Pengiriman Data Diagnosis
12. Pengiriman Data Kondisi Saat Meninggalkan Faskes
13. Pengiriman Data Rencana Tindak lanjut / Cara Keluar
14. Pengiriman Data Menutup Episode Kehamilan

Rangkaian proses pelayanan antenatal dimulai ketika pasien Ibu datang ke fasyankes untuk mendapatkan pelayanan antenatal. Pemeriksaan ibu akan dilakukan secara berkala hingga 6 kali pertemuan. Setiap pertemuan tersebut akan mencakup proses pemeriksaan, pengobatan, dan pelaporan keadaan ibu. Hasil pemeriksaan ini berperan dalam proses pemantauan kehamilan ibu dan juga sebagai dasar tatalaksana medis selama masa kehamilan hingga nifas. 

Alur proses kegiatan ANC dapat direpresentasikan dengan alur di bawah ini:
<center>
{{render:anc-skema}}

*Gambar 1. Skema Pelayanan ANC beserta *FHIR resource* yang terlibat*
</center>

Data setiap kunjungan pasien akan dicatat dan dikirim sesuai dengan kunjungan pasien secara rutin. Kemudian pada kunjungan akhir perawatan ANC dilakukan pencatatan hasil akhir dan dikirimkan ke SATUSEHAT.

## B. Strategi Pengiriman data ke SATUSEHAT
SATUSEHAT menyediakan dua pilihan cara mengirimkan data use case Pelayanan Antenatal:

### 1. Berbasis Resource
Data dapat dikirimkan secara berurutan sesuai resource yang terlibat pada alur pelayanan terkait. Sebagai contoh: ketika mengirimkan data registrasi  saja yang berisikan resource Encounter dan Condition, maka implementor mengirimkan resource-resource tersebut ke SATUSEHAT secara berurutan sesuai dependensinya.

### 2. Berbasis Bundle
Data dapat dikirimkan seluruh resource yang terlibat pada alur pelayanan terkait dengan menggunakan satu langkah pengiriman data ke SATUSEHAT menggunakan profil FHIR bernama Bundle.

---

Resource-resource yang terlibat di setiap tahapan alur pelayanan untuk use case pelayanan Antenatal adalah sebagai berikut:


<style>
.table-fhir-resources {
    border-collapse: collapse;
}

.table-fhir-resources, .table-fhir-resources th, .table-fhir-resources td {
   border: 1px solid black;
}

.table-fhir-resources th, .table-fhir-resources td {
   padding: 5px;
   word-wrap: break-word;
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
	<td rowspan="13">Clinical</td>
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
	<td><i>Optional</i></td>
</tr>
<tr>
	<td>9</td>
	<td>Specimen</td>
	<td><i>Optional</i></td>
</tr>
<tr>
	<td>10</td>
	<td>QuestionnaireResponse</td>
	<td><i>Optional</i></td>
</tr>
<tr>
	<td>11</td>
	<td>Medication</td>
	<td><i>Optional</i></td>
</tr>
<tr>
	<td>12</td>
	<td>MedicationRequest</td>
	<td><i>Optional</i></td>
</tr>
<tr>
	<td>13</td>
	<td>MedicationDispense</td>
	<td><i>Optional</i></td>
</tr>
<tr>
	<td>14</td>
	<td>DiagnosticReport</td>
	<td><i>Optional</i></td>
</tr>
<tr>
	<td>15</td>
	<td>FamilyMemberHistory</td>
	<td><i>Optional</i></td>
</tr>
<tr>
	<td>16</td>
	<td>EpisodeOfCare</td>
	<td><i>Optional</i></td>
</tr>
<tr>
	<td>17</td>
	<td>Immunization</td>
	<td><i>Optional</i></td>
</tr>
<tr>
	<td>18</td>
	<td>Procedure</td>
	<td><i>Optional</i></td>
</tr>
</table>

<br>_Notes:_<br>
1. *) Profile Resource yang direkomendasikan tersedia pada proses pencatatan
2. __Required__: Entry resource harus dilibatkan setiap kali mengirimkan bundle
3. _Optional_: Entry resource dapat tidak dilibatkan setiap kali mengirimkan bundle

## C. Langkah-Langkah Pengiriman Data ke SATUSEHAT
<!--Part 1-->
### <div id="CreatePatient" style="font-weight: bold"> Step 1. Pendaftaran Pasien</div>

<div style="margin-left: 30px;">
Apabila melakukan pengiriman data kesehatan melalui SATUSEHAT yang memiliki elemen data terkait pasien, maka diperlukan informasi &lcub;patient-ihs-number&rcub; dari pasien yang bersangkutan. &lcub;patient-ihs-number&rcub; seorang pasien didapatkan dari Master Patient Index (MPI) Kementerian Kesehatan. MPI menyimpan data-data demografi pasien berskala nasional, mulai dari nama, tanggal lahir, alamat, IDentitas resmi yang diterbitkan pemerintah, dan lain lain. Setelah mendapatkan &lcub;patient-ihs-number&rcub;, ID dapat disimpan secara di masing-masing sistem internal fasyankes maupun partner non-fasyankes. &lcub;patient-ihs-number&rcub; akan mempermudah pelaporan pelayanan kesehatan yang berhubungan dengan pasien, karena partner tidak diwajibkan menyertakan data diri setiap ada pengiriman data &lcub;patient-ihs-number&rcub; juga dapat digunakan untuk melihat data diri pasien secara menyeluruh.<br>

> `CATATAN:`
>  Proses pencarian `&lcub;patient-ihs-number&rcub;` dari pasien dapat dilakukan melalui FHIR API dengan metode GET. Untuk metode pencarian data pasien di SATUSEHAT secara detail dapat dilihat dalam _resource_ [`Patient`](https://satusehat.kemkes.go.id/platform/docs/id/fhir/resources/patient/#patient) dan terkait panduan/playbook MPI dapat dilihat dalam dokumen  <a href="https://satusehat.kemkes.go.id/platform/docs/id/master-data/master-patient-index/preliminary/#prem-mpi" target="_blank">Master Patient Index</a>.
</div>
<!--END Part 1-->

<!--Part 2-->
### <div id="CreateEncounter" style="font-weight: bold"> Step 2. Pendaftaran Kunjungan Pasien</div>

<div style="margin-left: 30px;">

<!--Part 2-1-->
<h4 style="font-weight: bold;">Pembuatan Kunjungan Baru</h4>

Kunjungan pasien dapat didefinisikan sebagai interaksi pasien terhadap suatu layanan fasyankes. Sebagai contoh, dalam satu rangkaian rawat jalan, seluruh rangkaian dapat didefinisikan sebagai satu `Encounter`. Data-data kunjungan pasien yang direkam meliputi kapan pertemuan tersebut mulai dan selesai, siapa tenaga kesehatan yang melayani, siapa subjek dari pelayanannya, dan informasi pendukung lainnya.

> `CATATAN:`
>  Penjelasan tipe mandatoris, deskripsi dan format pengisian dari setiap elemen data/_path_ di dalam _resource_ `Encounter` (data pendaftaran kunjungan pasien), dapat dilihat dalam _resource_ [`Encounter`](https://satusehat.kemkes.go.id/platform/docs/id/fhir/resources/encounter/#encounter).

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
        {{json:ANC-Encounter-Create-Pembuatan-Kunjungan-Baru-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-2-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Encounter",
    "identifier": [
        {
            "system": "http://sys-ids.kemkes.go.id/encounter/<strong style="color:#00a7ff">&lcub;&lcub;ORGANIZATION_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_LOCAL_CODE&rcub;&rcub;</strong>"
        },
        {
            "system": "http://terminology.kemkes.go.id/CodeSystem/episodeofcare/ANC",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;STATUS_KUNJUNGAN_ANC&rcub;&rcub;</strong>"
        }
    ],
    "status": "arrived",
    "statusHistory": [
        {
            "status": "arrived",
            "period": {
                "start": "<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_PERIOD1_START&rcub;&rcub;</strong>",
            }
        }
    ],
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
    "serviceProvider": {
        "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;ORGANIZATION_IHS_NUMBER&rcub;&rcub;</strong>"
    }
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-2-1" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__    | ID organisasi induk yang didapatkan dari master sarana indeks |
| __ENCOUNTER_LOCAL_CODE__   | Kode atau ID lokal/nomor kunjungan lokal yang disimpan di sistem internal masing-masing organisasi |
| __STATUS_KUNJUNGAN_ANC__   | __(*)__ Status kunjungan ANC yang menyatakan apakah kunjungan tersebut masuk kedalam kunjungan K1 akses, kunjungan K1 murni, kunjungan K2 dan lain sebagainya. Referensi ke value set "Status Kunjungan ANC"|
| __ENCOUNTER_PERIOD1_START__| Waktu mulai, sama dengan waktu kedatangan pasien |
| __ENCOUNTER_PERIOD1_END__  | Waktu selesai, sama dengan waktu berakhirnya suatu status kunjungan |
| __PATIENT_IHS_NUMBER__     | ID Patient yang didapatkan dari master pasien indeks |
| __PATIENT_NAME__           | Nama Pasien |
| __DOCTOR_IHS_NUMBER__      | ID Nakes organisasi induk yang didapatkan dari master Nakes indeks |
| __DOCTOR_NAME__            | Nama Nakes |
| __ENCOUNTER_LOCATION_ID__  | Berisi data lokasi dari pertemuan pasien. Dapat diisi oleh ruangan periksa pasien / poli pemeriksaannya dengan tipe data Reference, yang direferensikan ke ID Location yang didapatkan dari server |
| __ENCOUNTER_LOCATION_NAME__| Nama lokasi dari pertemuan pasien |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-2-1" style="border: 1px solid #e8edee; padding: 15px 10px;">

<div>Status kunjungan ANC</div>

| No | Kode | Display | System  |
|-|-|-|-|
| 1 | K1A | Kunjungan K1 akses | [http://terminology.kemkes.go.id/CodeSystem/episodeofcare/ANC](http://terminology.kemkes.go.id/CodeSystem/episodeofcare/ANC)  |
| 2 | K1M | Kunjungan K1 murni | http://terminology.kemkes.go.id/CodeSystem/episodeofcare/ANC  |
| 3 | K2 | Kunjungan K2 | http://terminology.kemkes.go.id/CodeSystem/episodeofcare/ANC  |
| 4 | K3 | Kunjungan K3 | http://terminology.kemkes.go.id/CodeSystem/episodeofcare/ANC  |
| 5 | K4 | Kunjungan K4 | http://terminology.kemkes.go.id/CodeSystem/episodeofcare/ANC  |
| 6 | K5 | Kunjungan K5 | http://terminology.kemkes.go.id/CodeSystem/episodeofcare/ANC  |
| 7 | K6 | Kunjungan K6 | http://terminology.kemkes.go.id/CodeSystem/episodeofcare/ANC  |

</div>
</div>
<br>
<!--END Part 2-1-->


<!--Part 2-3-->
<h4 style="font-weight: bold;">Masuk ke ruang pemeriksaan</h4>

Kunjungan pasien dapat didefinisikan sebagai interaksi pasien terhadap suatu layanan fasyankes. Sebagai contoh, dalam satu rangkaian rawat jalan, seluruh rangkaian dapat didefinisikan sebagai satu `Encounter`. Data-data kunjungan pasien yang direkam meliputi kapan pertemuan tersebut mulai dan selesai, siapa tenaga kesehatan yang melayani, siapa subjek dari pelayanannya, dan informasi pendukung lainnya.

> `CATATAN:`
>  Penjelasan tipe mandatoris, deskripsi dan format pengisian dari setiap elemen data/_path_ di dalam _resource_ `Encounter` (data pendaftaran kunjungan pasien), dapat dilihat dalam _resource_ [`Encounter`](https://satusehat.kemkes.go.id/platform/docs/id/fhir/resources/encounter/#encounter).

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
        {{json:ANC-Encounter-Create-Pembuatan-Kunjungan-Baru-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-2-3" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Encounter",
    "identifier": [
        {
            "system": "http://sys-ids.kemkes.go.id/encounter/<strong style="color:#00a7ff">&lcub;&lcub;ORGANIZATION_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_LOCAL_CODE&rcub;&rcub;</strong>"
        },
        {
            "system": "http://terminology.kemkes.go.id/CodeSystem/episodeofcare/ANC",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;STATUS_KUNJUNGAN_ANC&rcub;&rcub;</strong>"
        }
    ],
    "status": "in-progress",
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
                "start": "<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_PERIOD1_START&rcub;&rcub;</strong>",
            }
        }
    ],
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
    "serviceProvider": {
        "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;ORGANIZATION_IHS_NUMBER&rcub;&rcub;</strong>"
    }
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-2-3" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__    | ID organisasi induk yang didapatkan dari master sarana indeks |
| __ENCOUNTER_LOCAL_CODE__   | Kode atau ID lokal/nomor kunjungan lokal yang disimpan di sistem internal masing-masing organisasi |
| __STATUS_KUNJUNGAN_ANC__   | __(*)__ Status kunjungan ANC yang menyatakan apakah kunjungan tersebut masuk kedalam kunjungan K1 akses, kunjungan K1 murni, kunjungan K2 dan lain sebagainya. Referensi ke value set "Status Kunjungan ANC"|
| __ENCOUNTER_PERIOD1_START__| Waktu mulai, sama dengan waktu kedatangan pasien |
| __ENCOUNTER_PERIOD1_END__  | Waktu selesai, sama dengan waktu berakhirnya suatu status kunjungan |
| __PATIENT_IHS_NUMBER__     | ID Patient yang didapatkan dari master pasien indeks |
| __PATIENT_NAME__           | Nama Pasien |
| __DOCTOR_IHS_NUMBER__      | ID Nakes organisasi induk yang didapatkan dari master Nakes indeks |
| __DOCTOR_NAME__            | Nama Nakes |
| __ENCOUNTER_LOCATION_ID__  | Berisi data lokasi dari pertemuan pasien. Dapat diisi oleh ruangan periksa pasien / poli pemeriksaannya dengan tipe data Reference, yang direferensikan ke ID Location yang didapatkan dari server |
| __ENCOUNTER_LOCATION_NAME__| Nama lokasi dari pertemuan pasien |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-2-3" style="border: 1px solid #e8edee; padding: 15px 10px;">

<div>Status kunjungan ANC</div>

| No | Kode | Display | System  |
|-|-|-|-|
| 1 | K1A | Kunjungan K1 akses | [http://terminology.kemkes.go.id/CodeSystem/episodeofcare/ANC](http://terminology.kemkes.go.id/CodeSystem/episodeofcare/ANC)  |
| 2 | K1M | Kunjungan K1 murni | http://terminology.kemkes.go.id/CodeSystem/episodeofcare/ANC  |
| 3 | K2 | Kunjungan K2 | http://terminology.kemkes.go.id/CodeSystem/episodeofcare/ANC  |
| 4 | K3 | Kunjungan K3 | http://terminology.kemkes.go.id/CodeSystem/episodeofcare/ANC  |
| 5 | K4 | Kunjungan K4 | http://terminology.kemkes.go.id/CodeSystem/episodeofcare/ANC  |
| 6 | K5 | Kunjungan K5 | http://terminology.kemkes.go.id/CodeSystem/episodeofcare/ANC  |
| 7 | K6 | Kunjungan K6 | http://terminology.kemkes.go.id/CodeSystem/episodeofcare/ANC  |

</div>
</div>
<br>
<!--END Part 2-3-->

<!--Part 2-2-->
<h4 style="font-weight: bold;">Memulai Episode Kehamilan saat Kunjungan pertama kali ANC</h4>

Saat pasien berkunjung untuk mendapatkan pelayanan ANC yang pertama kali, maka data _resource_ `EpisodeOfCare` harus dikirimkan. Pembuatan _resource_ `EpisodeOfCare` cukup dikirimkan satu kali saja saat pertama kali melakukan kunjungan ANC. Respons balikan dari SATUSEHAT berupa UUID kemudian digunakan untuk menandai data [`Encounter.episodeOfCare`](https://satusehat.kemkes.go.id/platform/docs/id/fhir/resources/encounter/#encounter-episodeofcare) selama pasien hamil.<br><br>

Pada saat pembuatan pembuatan baru `EpisodeOfCare`, maka `EpisodeOfCare.period.start` diisikan dengan nilai yang sama persis dengan tanggal HPHT (Hari Pertama Haid Terakhir) jika tersedia. Untuk pengisian `EpisodeOfCare.period.end` dilakukan saat menandai `EpisodeOfCare.status` sebagai _finished_ dan harus diisikan dengan tanggal persalinan ibu.

> `CATATAN:`
>  Penjelasan tipe mandatoris, deskripsi dan format pengisian dari setiap elemen data/_path_ di dalam _resource_ `EpisodeOfCare` (episode kehamilan), dapat dilihat dalam [_resource_ `EpisodeOfCare`](https://satusehat.kemkes.go.id/platform/docs/id/fhir/resources/episode-of-care).

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
        {{json:ANC-EpisodeOfCare-Create-Pembuatan-Kunjungan-Pertama-ANC-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-2-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "EpisodeOfCare",
    "identifier": [
        {
            "system": "http://sys-ids.kemkes.go.id/episode-of-care/<strong style="color:#00a7ff">&lcub;&lcub;ORGANIZATION_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;EPISODEOFCARE_LOCAL_CODE&rcub;&rcub;</strong>"
        }
    ],
    "status": "active",
    "statusHistory": [
        {
            "status": "active",
            "period": {
                "start": "<strong style="color:#00a7ff">&lcub;&lcub;EPISODEOFCARE_PERIOD1_START&rcub;&rcub;</strong>",
            }
        }
    ],
    "type": [
        {
            "coding": [
                {
                    "system": "http://terminology.kemkes.go.id/CodeSystem/episodeofcare-type",
                    "code": "ANC",
                    "display": "Antenatal Care"
                }
            ]
        }
    ],
    "patient": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>",
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "managingOrganization": {
        "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;ORGANIZATION_IHS_NUMBER&rcub;&rcub;</strong>"
    },
    "period": {
        "start": "<strong style="color:#00a7ff">&lcub;&lcub;EPISODEOFCARE_PERIOD1_START&rcub;&rcub;</strong>"
    }
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-2-2" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__    | ID organisasi induk yang didapatkan dari master sarana indeks |
| __EPISODEOFCARE_LOCAL_CODE__   | Berisi kode atau nomor internal sub organisasi |
| __EPISODEOFCARE_PERIOD1_START__| Waktu dimulainya suatu kategori status EpisodeOfCare |
| __PATIENT_IHS_NUMBER__     | ID Patient yang didapatkan dari master pasien indeks |
| __PATIENT_NAME__           | Nama Pasien |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"

</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-2-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
			<div>
				[none]
			</div>
		</div>
	</div>
<!--END Part 2-2-->
</div>
<!--END Part 2-->

<!--END Part 3-->
### <div id="CreateClinicalData" style="font-weight: bold"> Step 3. Pengiriman Data Status Obstetri</div>

<div style="margin-left: 30px;">
Berikut adalah variabel hasil pemeriksaan yang dapat dikirimkan menggunakan <i>resource</i> <a href="https://satusehat.kemkes.go.id/platform/docs/id/fhir/resources/observation/#observation">Observation</a>:<br>
<ol>
<li>Gravida</li>
<li>Paritas</li>
<li>Abortus</li>
<li>Tanggal HPHT</li>
<li>Hari Perkiraan Lahir (HPL)</li>
<li>Berat Badan Sebelum Hamil</li>
<li>Tinggi badan</li>
<li>IMT Sebelum Hamil</li>
<li>Target Kenaikan BB</li>
<li>Jarak kehamilan saat ini dengan kehamilan sebelumnya</li>
</ol>

Sedangkan variabel Status TT (Imunisasi Tetanus Toxoid) dapat dikirimkan melalui resource Immunization. 

> `CATATAN:`
>  Penjelasan tipe mandatoris, deskripsi dan format pengisian dari setiap elemen data/path di dalam resource Observation dan Immunization, dan contoh pengiriman data atau payload dari data tanda vital dapat dilihat dalam Postman Collection pada <a href="https://docs.google.com/document/d/1wGsuxUJcmWsGhTdAthe0pmcnsqtggLlQdFUG5fU4_T4/edit#heading=h.4fzggw2guay3" target="_blank">Petunjuk Teknis SATUSEHAT (Juknis SATSET)</a>.
</div>

<div style="margin-left: 60px;">
<!--Part 3-1 Variable Gravida-->
<h4 style="font-weight: bold;">Gravida</h4>
	
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
        {{json:ANC-Observation-Create-Gravida-2}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "survey",
                    "display": "Survey"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://loinc.org",
                "code": "11996-6",
                "display": "[#] Pregnancies"
            },
            {
                "system": "http://fhir.org/guides/who/anc-cds/CodeSystem/anc-custom-codes",
                "code": "ANC.B6.DE24",
                "display": "Number of pregnancies (gravida)"
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
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueInteger": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>"
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-1" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-3-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
			<div>
				[none]
			</div>
		</div>
	</div>
<br>
<!--END Part 3-1-->

<!--Part 3-2-->
<h4 style="font-weight: bold;">Paritas</h4>
	
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
        {{json:ANC-Observation-Create-Paritas-2}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-1-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "survey",
                    "display": "Survey"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://loinc.org",
                "code": "11977-6",
                "display": "[#] Parity"
            },
            {
                "system": "http://fhir.org/guides/who/anc-cds/CodeSystem/anc-custom-codes",
                "code": "ANC.B6.DE32",
                "display": "Parity"
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
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueInteger": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>"
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-1-2" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-3-1-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
			<div>
				[none]
			</div>
		</div>
	</div>
<br>
<!--END Part 3-2-->

<!--Part 3-3 Variable Abortus-->
<h4 style="font-weight: bold;">Abortus</h4>
	
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
        {{json:ANC-Observation-Create-Abortus-2}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-1-3" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "survey",
                    "display": "Survey"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://loinc.org",
                "code": "69043-8",
                "display": "Other pregnancy outcomes #"
            },
            {
                "system": "http://fhir.org/guides/who/anc-cds/CodeSystem/anc-custom-codes",
                "code": "ANC.B6.DE25",
                "display": "Number of miscarriages and/or abortions"
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
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueInteger": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>"
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-1-3" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-3-1-3" style="border: 1px solid #e8edee; padding: 15px 10px;">
			<div>
				[none]
			</div>
		</div>
	</div>
<br>
<!--END Part 3-3-->

<!--Part 3-4-->
<h4 style="font-weight: bold;">Tanggal HPHT (Hari Pertama Haid Terakhir)</h4>
	
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-1-4" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-1-4" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-1-4" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-1-4" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-1-4">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Observation-Create-Tanggal-HPHT-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-1-4" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "survey",
                    "display": "Survey"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://loinc.org",
                "code": "8665-2",
                "display": "Last menstrual period start date"
            },
            {
                "system": "http://fhir.org/guides/who/anc-cds/CodeSystem/anc-custom-codes",
                "code": "ANC.B6.DE14",
                "display": "Last menstrual period (LMP) date"
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
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>"
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-1-4" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-3-1-4" style="border: 1px solid #e8edee; padding: 15px 10px;">
			<div>
				[none]
			</div>
		</div>
	</div>
<br>
<!--END Part 3-4-->

<!--Part 3-5-->
<h4 style="font-weight: bold;">Hari Perkiraan Lahir (HPL)</h4>
	
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-1-5" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-1-5" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-1-5" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-1-5" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-1-5">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Observation-Create-Hari-Perkiraan-Lahir-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-1-5" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "survey",
                    "display": "Survey"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://loinc.org",
                "code": "11778-8",
                "display": "Delivery date Estimated"
            },
            {
                "system": "http://fhir.org/guides/who/anc-cds/CodeSystem/anc-custom-codes",
                "code": "ANC.B6.DE22",
                "display": "Expected date of delivery (EDD)"
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
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>"
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-1-5" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-3-1-5" style="border: 1px solid #e8edee; padding: 15px 10px;">
			<div>
				[none]
			</div>
		</div>
	</div>
<br>
<!--END Part 3-5-->

<!--Part 3-6-->
<h4 style="font-weight: bold;">Berat Badan Sebelum Hamil</h4>
	
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-1-6" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-1-6" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-1-6" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-1-6" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-1-6">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Observation-Create-BodyWeight-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-1-6" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "survey",
                    "display": "Survey"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://loinc.org",
                "code": "56077-1",
                "display": "Body weight --pre current pregnancy"
            },
            {
                "system": "http://fhir.org/guides/who/anc-cds/CodeSystem/anc-custom-codes",
                "code": "ANC.B8.DE2",
                "display": "Pre-gestational weight"
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
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueQuantity": {
        "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
        "unit": "kg",
        "system": "http://unitsofmeasure.org",
        "code": "kg"
    }
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-1-6" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-3-1-6" style="border: 1px solid #e8edee; padding: 15px 10px;">
			<div>
				[none]
			</div>
		</div>
	</div>
<br>
<!--END Part 3-6-->

<!--Part 3-7 Variable Tinggi Badan-->
<h4 style="font-weight: bold;">Tinggi Badan</h4>
	
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-1-7" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-1-7" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-1-7" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-1-7" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-1-7">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Observation-Create-BodyHeight-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-1-7" style="border: 1px solid #e8edee; padding: 15px 10px;">
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
                "code": "8302-2",
                "display": "Body height"
            },
            {
                "system": "http://fhir.org/guides/who/anc-cds/CodeSystem/anc-custom-codes",
                "code": "ANC.B8.DE1",
                "display": "Height"
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
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueQuantity": {
        "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
        "unit": "cm",
        "system": "http://unitsofmeasure.org",
        "code": "cm"
    }
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-1-7" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-3-1-7" style="border: 1px solid #e8edee; padding: 15px 10px;">
			<div>
				[none]
			</div>
		</div>
	</div>
<br>
<!--END Part 3-7-->

<!--Part 3-8-->
<h4 style="font-weight: bold;">Indeks massa tubuh (IMT) Sebelum Hamil</h4>
	
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-1-8" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-1-8" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-1-8" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-1-8" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-1-8">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Observation-Create-Indeks-Massa-Tubuh-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-1-8" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "survey",
                    "display": "Survey"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://terminology.kemkes.go.id/CodeSystem/clinical-term",
                "code": "OC000010",
                "display": "Indeks Massa Tubuh Sebelum Hamil"
            },
            {
                "system": "http://terminology.kemkes.go.id/CodeSystem/anc-custom-codes",
                "code": "ANC.SS.DE58",
                "display": "IMT Sebelum Hamil"
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
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueQuantity": {
        "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
        "unit": "kg/m2",
        "system": "http://unitsofmeasure.org",
        "code": "kg/m2"
    },
    "interpretation":  [
        {
            "coding":  [
                {
                    "system": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_INTERPRETATION&rcub;&rcub;</strong>",
                    "code": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_INTERPRETATION&rcub;&rcub;</strong>",
                    "display": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_INTERPRETATION&rcub;&rcub;</strong>"
                }
            ]
        }
    ],
    "referenceRange":  [
        {
            "high": {
                "value": 18.5,
                "unit": "kg/m2",
                "system": "http://unitsofmeasure.org",
                "code": "kg/m2"
            },
            "text": "Kurus"
        },
        {
            "low": {
                "value": 18.5,
                "unit": "kg/m2",
                "system": "http://unitsofmeasure.org",
                "code": "kg/m2"
            },
            "high": {
                "value": 25,
                "unit": "kg/m2",
                "system": "http://unitsofmeasure.org",
                "code": "kg/m2"
            },
            "text": "Normal"
        },
        {
            "low": {
                "value": 25,
                "unit": "kg/m2",
                "system": "http://unitsofmeasure.org",
                "code": "kg/m2"
            },
            "high": {
                "value": 30,
                "unit": "kg/m2",
                "system": "http://unitsofmeasure.org",
                "code": "kg/m2"
            },
            "text": "Gemuk"
        },
        {
            "low": {
                "value": 30,
                "unit": "kg/m2",
                "system": "http://unitsofmeasure.org",
                "code": "kg/m2"
            },
            "text": "Obesitas"
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-1-8" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi |
| __OBSERVATION_INTERPRETATION__          		| __(*)__ Berisi data hasil kesimpulan dari observasi yang dilakukan. Referensi ke value set "Interpretasi Indeks massa tubuh (IMT) Sebelum Hamil" |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-3-1-8" style="border: 1px solid #e8edee; padding: 15px 10px;">

<div>Interpretasi Indeks massa tubuh (IMT) Sebelum Hamil</div>
<table class="table-fhir-resources" style="table-layout: fixed; width: 100%">
    <tr>
        <th style="width: 5%">No.</th>
        <th style="width: 14%">Keterangan</th>
        <th>Observation.interpretation.coding.code</th>
        <th>Observation.interpretation.coding.display</th>
        <th>Observation.interpretation.coding.system</th>
    </tr>
    <tr>
        <td>1</td>
        <td>Kurus</td>
        <td>248342006</td>
        <td>Underweight</td>
        <td>http://snomed.info/sct</td>
    </tr>
    <tr>
        <td>2</td>
        <td>Normal</td>
        <td>BMI-Normal</td>
        <td>Normal weight</td>
        <td>http://terminology.kemkes.go.id/CodeSystem/ObservationInterpretation</td>
    </tr>
    <tr>
        <td>3</td>
        <td>Gemuk</td>
        <td>238131007</td>
        <td>Overweight</td>
        <td>http://snomed.info/sct</td>
    </tr>
    <tr>
        <td>4</td>
        <td>Obesitas</td>
        <td>414915002</td>
        <td>Obese</td>
        <td>http://snomed.info/sct</td>
    </tr>
</table>
</div>
</div>
<br>
<!--END Part 3-8-->

<!--Part 3-9-->
<h4 style="font-weight: bold;">Target Kenaikan Berat Badan (BB)</h4>
	
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-1-9" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-1-9" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-1-9" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-1-9" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-1-9">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Observation-Create-BodyWeight-Expected-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-1-9" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "survey",
                    "display": "Survey"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://terminology.kemkes.go.id/CodeSystem/clinical-term",
                "code": "OC000011",
                "display": "Target Kenaikan Berat Badan"
            },
            {
                "system": "http://fhir.org/guides/who/anc-cds/CodeSystem/anc-custom-codes",
                "code": "ANC.B8.DE10",
                "display": "Expected weight gain"
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
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueCodeableConcept": {
        "coding": [
            {
                "system": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>"
            }
        ]
    }
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-1-9" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		|__(*)__ Nilai observasi. Referensi ke value set "Target Kenaikan Berat Badan" |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"

</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-3-1-9" style="border: 1px solid #e8edee; padding: 15px 10px;">
			
<div>Target Kenaikan Berat Badan</div>

| No | Kode        | Display                | System|
|-|-|-|-|
| 1 | OV000008 | 5–9 kg | Untuk IMT ≥ 30 (Obese)  |
| 2 | OV000009 | 7–11.5 kg | Untuk IMT 25.0-29.9 (Overweight)  |
| 3 | OV000010 | 11.5–16 kg | Untuk IMT 18.5-24.99 (Normal weight)  |
| 4 | OV000011 | 12.5–18 kg | Untuk IMT  |

</div>
</div>
<br>
<!--END Part 3-9-->

<!--Part 3-10-->
<h4 style="font-weight: bold;">Jarak kehamilan saat ini dengan kehamilan sebelumnya</h4>
	
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-1-10" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-1-10" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-1-10" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-1-10" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-1-10">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Observation-Create-Jarak-Kehamilan-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-1-10" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "survey",
                    "display": "Survey"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://terminology.kemkes.go.id/CodeSystem/clinical-term",
                "code": "OC000001",
                "display": "Jarak kehamilan"
            },
            {
                "system": "http://terminology.kemkes.go.id/CodeSystem/anc-custom-codes",
                "code": "ANC.SS.DE53",
                "display": "Jarak kehamilan"
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
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueQuantity": {
        "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
        "unit": "mo",
        "system": "http://unitsofmeasure.org",
        "code": "mo"
    }
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-1-10" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-3-1-10" style="border: 1px solid #e8edee; padding: 15px 10px;">
			<div>
				[none]
			</div>
		</div>
	</div>
<br>
<!--END Part 3-10-->

<!--Part 3-11-->
<h4 style="font-weight: bold;">Status Imunisasi TT (Tetanus Toxoid)</h4>
Pengiriman data status imunisasi tetanus disini mencakup imunisasi T0 (belum pernah), T1, T2, T3, T4, dan T5.<br>

<div style="margin-left: 30px;">
<!--Part 3-11-1-->
<h4 style="font-weight: bold;">T0 (belum pernah)</h4>
<div>Variabel dan terminologi yang digunakan dalam pengiriman data status imunisasi tetanus untuk T0/belum pernah melalui resource Immunization adalah sebagai berikut:</div>

<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-1-11" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-1-11" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-1-11" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-1-11" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-1-11">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Immunization-Create-VG139}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-1-11" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Immunization",
    "status": "not-done",
    "primarySource": false,
    "vaccineCode": {
        "coding":  [
            {
                "system": "http://sys-ids.kemkes.go.id/kfa",
                "code": "VG139",
                "display": "Td"
            },
            {
                "system": "http://hl7.org/fhir/sid/cvx",
                "code": "28",
                "display": "DT (pediatric)"
            },
            {
                "system": "http://sys-ids.kemkes.go.id/kfa",
                "code": "VG107",
                "display": "DTAP"
            }
        ]
    },
    "patient": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>",
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "encounter": {
        "reference": "Encounter/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_ENCOUNTER&rcub;&rcub;</strong>"
    },
    "occurrenceDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;IMMUNIZATION_OCCURENCEDATETIME&rcub;&rcub;</strong>",
    "recorded": "<strong style="color:#00a7ff">&lcub;&lcub;IMMUNIZATION_RECORDED&rcub;&rcub;</strong>",
    "reportOrigin": {
        "coding":  [
            {
                "system": "http://terminology.hl7.org/CodeSystem/immunization-origin",
                "code": "recall",
                "display": "Parent/Guardian/Patient Recall"
            }
        ]
    },
    "performer":  [
        {
            "function": {
                "coding":  [
                    {
                        "system": "<strong style="color:#00a7ff">&lcub;&lcub;IMMUNIZATION_PERFORMER_ROLE&rcub;&rcub;</strong>",
                        "code": "<strong style="color:#00a7ff">&lcub;&lcub;IMMUNIZATION_PERFORMER_ROLE&rcub;&rcub;</strong>",
                        "display": "<strong style="color:#00a7ff">&lcub;&lcub;IMMUNIZATION_PERFORMER_ROLE&rcub;&rcub;</strong>"
                    }
                ]
            },
            "actor": {
                "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
            }
        }
    ],
"statusReason": {
        "coding":  [
            {
                "system": "<strong style="color:#00a7ff">&lcub;&lcub;VACCINE_STATUS_REASON&rcub;&rcub;</strong>",
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;VACCINE_STATUS_REASON&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;VACCINE_STATUS_REASON&rcub;&rcub;</strong>"
            }
        ]
    },
    "reasonCode":  [
        {
            "coding":  [
                {
                    "system": "http://terminology.kemkes.go.id/CodeSystem/immunization-reason",
                    "code": "IM-WUS",
                    "display": "Imunisasi Program Rutin Lanjutan Wanita Usia Subur"
                }
            ]
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-1-11" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __VACCINE_STATUS_REASON__    | __(*)__ Berisi data alasan yang menyebabkan tidak dilakukannya vaksinasi, sehingga kolom ini hanya diisi apabila Immunization.status= "not-done". Referensi ke value set "Alasan Tidak Dilakukan Imunisasi"|
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __PATIENT_NAME__           | Nama Pasien |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __IMMUNIZATION_OCCURENCEDATETIME__     |  Kapan vaksin diadministrasikan dengan tipe data dateTime, dengan format yang diperbolehkan YYYY-MM-DDThh:mm:ss+zz:zz |
| __IMMUNIZATION_RECORDED__     |  Kapan pencatatan vaksin dicatatkan (kemungkinan terjadi setelah vaksin diadministrasikan) dengan tipe data dateTime, dengan format yang diperbolehkan YYYY-MM-DDThh:mm:ss+zz:zz |
| __IMMUNIZATION_PERFORMER_ROLE__| __(*)__ Berisi data peran tenaga kesehatan dalam proses vaksin/imunisasi. Referensi ke value set "Peran Tenaga Kesehatan dalam Proses Imunisasi" |
| __PRACTITIONER_IHS_NUMBER__      | &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __VACCINE_STATUS_REASON__    | __(*)__ Berisi data alasan yang menyebabkan tidak dilakukannya vaksinasi, sehingga kolom ini hanya diisi apabila Immunization.status= "not-done". Referensi ke value set "Alasan Tidak Dilakukan Imunisasi"|

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"

</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-3-1-11" style="border: 1px solid #e8edee; padding: 15px 10px;">
			<div>
				[none]
			</div>
		</div>
	</div>
<br>
<!--END Part 3-1-11-->

<!--Part 3-11-1-->
<h4 style="font-weight: bold;">T1-T5</h4>
<p>Variabel dan terminologi yang digunakan dalam pengiriman data status imunisasi tetanus untuk T1, T2, T3, T4, dan T5 melalui resource Immunization adalah sebagai berikut: Nilai T1-T5 dilampirkan pada field Immunization.doseNumberPositiveInt[0]</p>

<p>
Cara pengisian Immunization.vaccineCode dibedakan berdasarkan kategori:
<ol>
<li>Pencatatan Riwayat Imunisasi: dimana informasi jenis vaksin yang digunakan tidak diketahui secara detail, sehingga hanya perlu melampirkan 1 kode CVX Group.</li>
<li>Pencatatan Tindakan Imunisasi: dimana informasi terkait jenis vaksin yang digunakan tercatat secara detail, sehingga perlu melampirkan 3 kode yaitu:  kode KFA + kode CVX Name + kode CVX Group</li>
</ol>

Detail cara pengisian Immunization.vaccineCode dapat diakses di <a href="https://satusehat.kemkes.go.id/platform/docs/id/terminology/lampiran-terminologi/imunisasi-new/">SATUSEHAT Portal</a>
</p>

<h4 style="font-weight: bold;">Pencatatan Riwayat Imunisasi</h4>
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-11-2" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-11-2" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-11-2" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-11-2" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-11-2">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC/Immunization-Create-VG139-T1.json}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-11-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Immunization",
    "status": "completed",
    "primarySource": false,
    "vaccineCode": {
        "coding":  [
            {
                "system": "http://sys-ids.kemkes.go.id/kfa",
                "code": "VG139",
                "display": "Td"
            },
            {
                "system": "http://hl7.org/fhir/sid/cvx",
                "code": "28",
                "display": "DT (pediatric)"
            },
            {
                "system": "http://sys-ids.kemkes.go.id/kfa",
                "code": "VG107",
                "display": "DTAP"
            }
        ]
    },
    "patient": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>",
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "encounter": {
        "reference": "Encounter/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_ENCOUNTER&rcub;&rcub;</strong>"
    },
    "occurrenceDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;IMMUNIZATION_OCCURENCEDATETIME&rcub;&rcub;</strong>",
    "recorded": "<strong style="color:#00a7ff">&lcub;&lcub;IMMUNIZATION_RECORDED&rcub;&rcub;</strong>",
    "reportOrigin": {
        "coding":  [
            {
                "system": "http://terminology.hl7.org/CodeSystem/immunization-origin",
                "code": "recall",
                "display": "Parent/Guardian/Patient Recall"
            }
        ]
    },
    "performer":  [
        {
            "function": {
                "coding":  [
                    {
                        "system": "<strong style="color:#00a7ff">&lcub;&lcub;IMMUNIZATION_PERFORMER_ROLE&rcub;&rcub;</strong>",
                        "code": "<strong style="color:#00a7ff">&lcub;&lcub;IMMUNIZATION_PERFORMER_ROLE&rcub;&rcub;</strong>",
                        "display": "<strong style="color:#00a7ff">&lcub;&lcub;IMMUNIZATION_PERFORMER_ROLE&rcub;&rcub;</strong>"
                    }
                ]
            },
            "actor": {
                "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
            }
        }
    ],
    "reasonCode":  [
        {
            "coding":  [
                {
                    "system": "http://terminology.kemkes.go.id/CodeSystem/immunization-reason",
                    "code": "IM-WUS",
                    "display": "Imunisasi Program Rutin Lanjutan Wanita Usia Subur"
                }
            ]
        }
    ],
    "protocolApplied":  [
        {
            "doseNumberPositiveInt": "<strong style="color:#00a7ff">&lcub;&lcub;IMMUNIZATION_DOSE_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "lotNumber": "<strong style="color:#00a7ff">&lcub;&lcub;IMMUNIZATION_BATCH_NO&rcub;&rcub;</strong>",
    "expirationDate": "<strong style="color:#00a7ff">&lcub;&lcub;IMMUNIZATION_EXPIRATIONDATE&rcub;&rcub;</strong>"
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-11-2" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __VACCINE_STATUS_REASON__    | __(*)__ Berisi data alasan yang menyebabkan tidak dilakukannya vaksinasi, sehingga kolom ini hanya diisi apabila Immunization.status= "not-done". Referensi ke value set "Alasan Tidak Dilakukan Imunisasi"|
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __PATIENT_NAME__           | Nama Pasien |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __IMMUNIZATION_OCCURENCEDATETIME__     |  Kapan vaksin diadministrasikan dengan tipe data dateTime, dengan format yang diperbolehkan YYYY-MM-DDThh:mm:ss+zz:zz |
| __IMMUNIZATION_RECORDED__     |  Kapan pencatatan vaksin dicatatkan (kemungkinan terjadi setelah vaksin diadministrasikan) dengan tipe data dateTime, dengan format yang diperbolehkan YYYY-MM-DDThh:mm:ss+zz:zz |
| __IMMUNIZATION_PERFORMER_ROLE__| __(*)__ Berisi data peran tenaga kesehatan dalam proses vaksin/imunisasi. Referensi ke value set "Peran Tenaga Kesehatan dalam Proses Imunisasi" |
| __PRACTITIONER_IHS_NUMBER__      | &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __IMMUNIZATION_DOSE_NUMBER__| Urutan dosis vaksin dalam seri pemberian vaksin yang direkomendasikan untuk diisi dengan tipe data positiveInt. |
| __IMMUNIZATION_BATCH_NO__| Nomor batch vaksin yang diberikan dengan tipe data string |
| __IMMUNIZATION_EXPIRATIONDATE__     | Tanggal kadaluarsa vaksin yang diberikan dengan tipe data date dalam format YYYY-MM-DD |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-3-11-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
			<div>
				[none]
			</div>
		</div>
	</div>
<br>
<!--END Part 3-11-2-->


<h4 style="font-weight: bold;">Pencatatan Tindakan Imunisasi</h4>
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-11-3" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-11-3" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-11-3" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-11-3" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-11-3">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC/Immunization-Create-VG139-T1-2.json}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-11-3" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Immunization",
    "status": "completed",
    "primarySource": false,
    "vaccineCode": {
        "coding":  [
            {
                "system": "http://sys-ids.kemkes.go.id/kfa",
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;IMMUNIZATION_KODE_KFA&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;IMMUNIZATION_KODE_KFA&rcub;&rcub;</strong>"
            },
            {
                "system": "http://hl7.org/fhir/sid/cvx",
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;IMMUNIZATION_KODE_CVX_NAME&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;IMMUNIZATION_KODE_CVX_NAME&rcub;&rcub;</strong>"
            },
            {
                "system": "http://sys-ids.kemkes.go.id/kfa",
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;IMMUNIZATION_KODE_CVX_GROUP&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;IMMUNIZATION_KODE_CVX_GROUP&rcub;&rcub;</strong>"
            }
        ]
    },
    "patient": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>",
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "encounter": {
        "reference": "Encounter/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_ENCOUNTER&rcub;&rcub;</strong>"
    },
    "occurrenceDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;IMMUNIZATION_OCCURENCEDATETIME&rcub;&rcub;</strong>",
    "recorded": "<strong style="color:#00a7ff">&lcub;&lcub;IMMUNIZATION_RECORDED&rcub;&rcub;</strong>",
    "reportOrigin": {
        "coding":  [
            {
                "system": "http://terminology.hl7.org/CodeSystem/immunization-origin",
                "code": "recall",
                "display": "Parent/Guardian/Patient Recall"
            }
        ]
    },
    "performer":  [
        {
            "function": {
                "coding":  [
                    {
                        "system": "<strong style="color:#00a7ff">&lcub;&lcub;IMMUNIZATION_PERFORMER_ROLE&rcub;&rcub;</strong>",
                        "code": "<strong style="color:#00a7ff">&lcub;&lcub;IMMUNIZATION_PERFORMER_ROLE&rcub;&rcub;</strong>",
                        "display": "<strong style="color:#00a7ff">&lcub;&lcub;IMMUNIZATION_PERFORMER_ROLE&rcub;&rcub;</strong>"
                    }
                ]
            },
            "actor": {
                "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
            }
        }
    ],
    "reasonCode":  [
        {
            "coding":  [
                {
                    "system": "http://terminology.kemkes.go.id/CodeSystem/immunization-reason",
                    "code": "IM-WUS",
                    "display": "Imunisasi Program Rutin Lanjutan Wanita Usia Subur"
                }
            ]
        }
    ],
    "protocolApplied":  [
        {
            "doseNumberPositiveInt": "<strong style="color:#00a7ff">&lcub;&lcub;IMMUNIZATION_DOSE_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "lotNumber": "<strong style="color:#00a7ff">&lcub;&lcub;IMMUNIZATION_BATCH_NO&rcub;&rcub;</strong>",
    "expirationDate": "<strong style="color:#00a7ff">&lcub;&lcub;IMMUNIZATION_EXPIRATIONDATE&rcub;&rcub;</strong>"
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-11-3" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __VACCINE_STATUS_REASON__    | __(*)__ Berisi data alasan yang menyebabkan tidak dilakukannya vaksinasi, sehingga kolom ini hanya diisi apabila Immunization.status= "not-done". Referensi ke value set "Alasan Tidak Dilakukan Imunisasi"|
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __PATIENT_NAME__           | Nama Pasien |
| __IMMUNIZATION_KODE_KFA__	 | Jenis vaksin yang digunakan. Referensi ke <a href="https://satusehat.kemkes.go.id/kfa-browser/">browser KFA (Kode Kamus Farmasi dan Alat Kesehatan)</a>|
| __IMMUNIZATION_KODE_CXV_NAME__	 | Kategori jenis vaksin yang digunakan. Kode CVX Name sudah 1 set dengan kode KFA vaksin. |
| __IMMUNIZATION_KODE_CXV_GROUP__	 | Kategori grup vaksin yang digunakan. Kode CVX Group sudah 1 set dengan kode KFA vaksin. |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __IMMUNIZATION_OCCURENCEDATETIME__     |  Kapan vaksin diadministrasikan dengan tipe data dateTime, dengan format yang diperbolehkan YYYY-MM-DDThh:mm:ss+zz:zz |
| __IMMUNIZATION_RECORDED__     |  Kapan pencatatan vaksin dicatatkan (kemungkinan terjadi setelah vaksin diadministrasikan) dengan tipe data dateTime, dengan format yang diperbolehkan YYYY-MM-DDThh:mm:ss+zz:zz |
| __IMMUNIZATION_PERFORMER_ROLE__| __(*)__ Berisi data peran tenaga kesehatan dalam proses vaksin/imunisasi. Referensi ke value set "Peran Tenaga Kesehatan dalam Proses Imunisasi" |
| __PRACTITIONER_IHS_NUMBER__      | &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __IMMUNIZATION_DOSE_NUMBER__| Urutan dosis vaksin dalam seri pemberian vaksin yang direkomendasikan untuk diisi dengan tipe data positiveInt. |
| __IMMUNIZATION_BATCH_NO__| Nomor batch vaksin yang diberikan dengan tipe data string |
| __IMMUNIZATION_EXPIRATIONDATE__     | Tanggal kadaluarsa vaksin yang diberikan dengan tipe data date dalam format YYYY-MM-DD |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-3-11-3" style="border: 1px solid #e8edee; padding: 15px 10px;">
			<div>
				[none]
			</div>
		</div>
	</div>
<br>
<!--END Part 3-11-3-->

</div>
<!--END Part 3-11-2-->
</div>
<!--END Part 3-->

<!--END Part 4-->
### <div id="CreateClinicalData" style="font-weight: bold">Step 4. Data Kunjungan Kehamilan</div>

<div style="margin-left: 30px;">
<!--Part 4-1 Usia Kehamilan-->
<h4 style="font-weight: bold;">Usia Kehamilan </h4>
    
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-2-1" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-2-1" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-2-1" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-2-1" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-2-1">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:example-MortalityRecord-Observation-Create-Gestational-Age-Week-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-2-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "identifier": [
        {
            "system": "http://sys-ids.kemkes.go.id/observation/<strong style="color:#00a7ff">&lcub;&lcub;ORGANIZATION_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_LOCAL_CODE&rcub;&rcub;</strong>"
        }
    ],
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "survey",
                    "display": "Survey"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://loinc.org",
                "code": "18185-9",
                "display": "Gestational age"
            },
            {
                "system": "http://fhir.org/guides/who/anc-cds/CodeSystem/anc-custom-codes",
                "code": "ANC.B6.DE17",
                "display": "Gestational age"
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
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueQuantity": {
        "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
        "unit": "week",
        "system": "http://unitsofmeasure.org",
        "code": "wk"
    }
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-2-1" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-2-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
            <div>
                [none]
            </div>
        </div>
    </div>
<br>
<!--END Part 4-1-->

<!--Part 4-2 Trimester ke--->
<h4 style="font-weight: bold;">Trimester ke-</h4>
    
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
        {{json:ANC-Observation-Create-Trimester-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-2-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "survey",
                    "display": "Survey"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://loinc.org",
                "code": "32418-6",
                "display": "Obstetric trimester Stated"
            },
            {
                "system": "http://terminology.kemkes.go.id/CodeSystem/anc-custom-codes",
                "code": "ANC.SS.DE13",
                "display": "Trimester ke"
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
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueInteger": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>"
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-2-2" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-2-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
            <div>
                [none]
            </div>
        </div>
    </div>
<br>
<!--END Part 4-2-->
</div>
<!--END Part 4-->

<!--Part 5-->

### <div id="CreateClinicalData" style="font-weight: bold">Step 5. Data Pelayanan Kehamilan</div>

<div style="margin-left: 30px;">
<!--Part 5-1-->
<h4>A. Pemeriksaan Ibu</h4>

<div style="margin-left: 30px;">
<!--Part 5-1-1 Berat Badan-->
<h4 style="font-weight: bold;"> Berat Badan Saat Kunjungan</h4>
    
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-2-4" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-2-4" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-2-4" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-2-4" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-2-4">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Observation-Create-BodyWeight-3}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-2-4" style="border: 1px solid #e8edee; padding: 15px 10px;">
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
                "code": "29463-7",
                "display": "Body weight"
            },
            {
                "system": "http://fhir.org/guides/who/anc-cds/CodeSystem/anc-custom-codes",
                "code": "ANC.B8.DE3",
                "display": "Current  weight"
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
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueQuantity": {
        "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
        "unit": "kg",
        "system": "http://unitsofmeasure.org",
        "code": "kg"
    }
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-2-4" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-2-4" style="border: 1px solid #e8edee; padding: 15px 10px;">
            <div>
                [none]
            </div>
        </div>
    </div>
<br>
<!--END Part 5-1-1-->


<!--Part 5-1-2 Lingkar Lengan Atas-->
<h4 style="font-weight: bold;">Lingkar lengan atas (LiLA) & Interpretasi LiLA</h4>
    
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-2-5" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-2-5" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-2-5" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-2-5" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-2-5">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Observation-Create-Lingkar-Lengan-Atas-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-2-5" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "exam",
                    "display": "Exam"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://loinc.org",
                "code": "56072-2",
                "display": "Circumference Mid upper arm - right"
            },
            {
                "system": "http://terminology.kemkes.go.id/CodeSystem/anc-custom-codes",
                "code": "ANC.SS.DE3",
                "display": "Lingkar Lengan Atas (LILA)"
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
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueQuantity": {
        "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
        "unit": "cm",
        "system": "http://unitsofmeasure.org",
        "code": "cm"
    },
    "interpretation":  [
        {
            "coding":  [
                {
                    "system": "http://terminology.kemkes.go.id/CodeSystem/clinical-term",
                    "code": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_INTERPRETATION&rcub;&rcub;</strong>",
                    "display": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_INTERPRETATION&rcub;&rcub;</strong>"
                }
            ]
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-2-5" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi |
| __OBSERVATION_INTERPRETATION__          		| __(*)__ Berisi data hasil kesimpulan dari observasi yang dilakukan. Referensi ke value set "Interpretasi LiLA (Lingkar Lengan Atas)" |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"

</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-2-5" style="border: 1px solid #e8edee; padding: 15px 10px;">
Interpretasi LiLA (Lingkar Lengan Atas)

<table class="table-fhir-resources" style="table-layout: fixed; width: 100%">
    <tr>
        <th style="width: 5%">No.</th>
        <th>Observation.interpretation.coding.code</th>
        <th>Observation.interpretation.coding.display</th>
        <th>Observation.interpretation.coding.system</th>
    </tr>
    <tr>
        <td>1</td>
        <td>OI000018</td>
        <td>Kurang Energi Kronis (KEK)</td>
        <td>http://terminology.kemkes.go.id/CodeSystem/clinical-term</td>
    </tr>
    <tr>
        <td>2</td>
        <td>OI000013</td>
        <td>Normal</td>
        <td>http://terminology.kemkes.go.id/CodeSystem/clinical-term</td>
    </tr>
</table>

</div>
</div>
<br>
<!--END Part 5-1-2-->

<!--END Part 5-1-3-->
<h4 style="font-weight: bold;">Indeks Massa Tubuh</h4>

<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-2-6" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-2-6" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-2-6" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-2-6" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-2-6">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Observation-Create-Indeks-Massa-Tubuh-BMI-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-2-6" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "survey",
                    "display": "Survey"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://loinc.org",
                "code": "39156-5",
                "display": "Body mass index (BMI) [Ratio]"
            },
            {
                "system": "http://fhir.org/guides/who/anc-cds/CodeSystem/anc-custom-codes",
                "code": "ANC.B8.DE4",
                "display": "BMI"
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
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueQuantity": {
        "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
        "unit": "kg/m2",
        "system": "http://unitsofmeasure.org",
        "code": "kg/m2"
    },
    "interpretation":  [
        {
            "coding":  [
                {
                    "system": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_INTERPRETATION&rcub;&rcub;</strong>",
                    "code": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_INTERPRETATION&rcub;&rcub;</strong>",
                    "display": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_INTERPRETATION&rcub;&rcub;</strong>"
                }
            ]
        }
    ],
"referenceRange":  [
        {
            "high": {
                "value": 17,
                "unit": "kg/m2",
                "system": "http://unitsofmeasure.org",
                "code": "kg/m2"
            },
            "text": "Sangat kurus"
        },
        {
            "low": {
                "value": 17,
                "unit": "kg/m2",
                "system": "http://unitsofmeasure.org",
                "code": "kg/m2"
            },
            "high": {
                "value": 18.5,
                "unit": "kg/m2",
                "system": "http://unitsofmeasure.org",
                "code": "kg/m2"
            },
            "text": "Kurus"
        },
        {
            "low": {
                "value": 18.5,
                "unit": "kg/m2",
                "system": "http://unitsofmeasure.org",
                "code": "kg/m2"
            },
            "high": {
                "value": 25,
                "unit": "kg/m2",
                "system": "http://unitsofmeasure.org",
                "code": "kg/m2"
            },
            "text": "Normal"
        },
        {
            "low": {
                "value": 25,
                "unit": "kg/m2",
                "system": "http://unitsofmeasure.org",
                "code": "kg/m2"
            },
            "high": {
                "value": 27,
                "unit": "kg/m2",
                "system": "http://unitsofmeasure.org",
                "code": "kg/m2"
            },
            "text": "Gemuk"
        },
        {
            "low": {
                "value": 27,
                "unit": "kg/m2",
                "system": "http://unitsofmeasure.org",
                "code": "kg/m2"
            },
            "text": "Obesitas"
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-2-6" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi |
| __OBSERVATION_INTERPRETATION__          		| __(*)__ Berisi data hasil kesimpulan dari observasi yang dilakukan. Referensi ke value set "Indeks Massa Tubuh" |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"

</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-2-6" style="border: 1px solid #e8edee; padding: 15px 10px;">

<div>Indeks Massa Tubuh</div>
<table class="table-fhir-resources" style="table-layout: fixed; width: 100%">
    <tr>
        <th style="width: 5%">No.</th>
        <th  style="width: 14%">Keterangan</th>
        <th>Observation.interpretation.coding.code</th>
        <th>Observation.interpretation.coding.display</th>
        <th>Observation.interpretation.coding.system</th>
    </tr>
    <tr>
        <td>1</td>
        <td>Kurus</td>
        <td>248342006</td>
        <td>Underweight</td>
        <td>http://snomed.info/sct</td>
    </tr>
    <tr>
        <td>2</td>
        <td>Normal</td>
        <td>BMI-Normal</td>
        <td>Normal weight</td>
        <td>http://terminology.kemkes.go.id/CodeSystem/ObservationInterpretation</td>
    </tr>
    <tr>
        <td>3</td>
        <td>Gemuk</td>
        <td>238131007</td>
        <td>Overweight</td>
        <td>http://snomed.info/sct</td>
    </tr>
    <tr>
        <td>4</td>
        <td>Obesitas</td>
        <td>414915002</td>
        <td>Obese</td>
        <td>http://snomed.info/sct</td>
    </tr>
    <tr>
        <td>5</td>
        <td>Underweight</td>
        <td>BMI-SevereUnder</td>
        <td>Severely Underweight</td>
        <td>http://terminology.kemkes.go.id/CodeSystem/ObservationInterpretation</td>
    </tr>
</table>
</div>
</div>
<br>
<!--END Part 5-1-3-->

<!--Part 5-1-4 Tinggi Fundus-->
<h4 style="font-weight: bold;">Tinggi Fundus</h4>
    
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-2-7" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-2-7" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-2-7" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-2-7" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-2-7">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Observation-Create-Tinggi-Fundus-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-2-7" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "exam",
                    "display": "Exam"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://loinc.org",
                "code": "11881-0",
                "display": "Uterus Fundal height Tape measure"
            },
            {
                "system": "http://fhir.org/guides/who/anc-cds/CodeSystem/anc-custom-codes",
                "code": "ANC.B8.DE105",
                "display": "Symphysis-fundal height (SFH)"
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
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueQuantity": {
        "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
        "unit": "cm",
        "system": "http://unitsofmeasure.org",
        "code": "cm"
    }
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-2-7" style="border: 1px solid #e8edee; padding: 15px 10px;">


| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"

</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-2-7" style="border: 1px solid #e8edee; padding: 15px 10px;">
            <div>
                [none]
            </div>
        </div>
    </div>
<br>
<!--END Part 5-1-4-->

<!--Part 5-1-5-->
<h4 style="font-weight: bold;">Tekanan Darah Sistolik</h4>
    
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-2-8" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-2-8" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-2-8" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-2-8" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-2-8">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Observation-Create-BP-Systolic-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-2-8" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
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
                "code": "8480-6",
                "display": "Systolic blood pressure"
            },
            {
                "system": "http://fhir.org/guides/who/anc-cds/CodeSystem/anc-custom-codes",
                "code": "ANC.B8.DE17",
                "display": "Systolic blood pressure"
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
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueQuantity": {
        "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
        "unit": "mm[Hg]",
        "system": "http://unitsofmeasure.org",
        "code": "mm[Hg]"
    }
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-2-8" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-2-8" style="border: 1px solid #e8edee; padding: 15px 10px;">
            <div>
                [none]
            </div>
        </div>
    </div>
<br>
<!--END Part 5-1-5-->


<!--Part 5-1-6-->
<h4 style="font-weight: bold;">Tekanan Darah Diastolik</h4>
    
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-2-9" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-2-9" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-2-9" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-2-9" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-2-9">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Observation-Create-BP-Diastolic-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-2-9" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
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
                "code": "8462-4",
                "display": "Diastolic blood pressure"
            },
            {
                "system": "http://fhir.org/guides/who/anc-cds/CodeSystem/anc-custom-codes",
                "code": "ANC.B8.DE19",
                "display": "Diastolic blood pressure"
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
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueQuantity": {
        "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
        "unit": "mm[Hg]",
        "system": "http://unitsofmeasure.org",
        "code": "mm[Hg]"
    }
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-2-9" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-2-9" style="border: 1px solid #e8edee; padding: 15px 10px;">
            <div>
                [none]
            </div>
        </div>
    </div>
<br>
<!--END Part 5-1-6-->

<!--Part 5-1-7-->
<h4 style="font-weight: bold;">Nadi</h4>
    
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-2-10" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-2-10" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-2-10" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-2-10" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-2-10">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Observation-Create-Tekanan-Nadi-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-2-10" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
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
                "code": "8867-4",
                "display": "Heart rate"
            },
            {
                "system": "http://fhir.org/guides/who/anc-cds/CodeSystem/anc-custom-codes",
                "code": "ANC.B8.DE36",
                "display": "Pulse rate"
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
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueQuantity": {
        "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
        "unit": "beats/minute",
        "system": "http://unitsofmeasure.org",
        "code": "/min"
    }
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-2-10" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-2-10" style="border: 1px solid #e8edee; padding: 15px 10px;">
            <div>
                [none]
            </div>
        </div>
    </div>
<br>
<!--END Part 5-1-7-->

<!--Part 5-1-8-->
<h4 style="font-weight: bold;">Suhu</h4>
    
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-2-11" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-2-11" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-2-11" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-2-11" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-2-11">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Observation-Create-Suhu-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-2-11" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
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
            },
            {
                "system": "http://fhir.org/guides/who/anc-cds/CodeSystem/anc-custom-codes",
                "code": "ANC.B8.DE34",
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
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
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

<div role="tabpanel" class="tab-pane" id="variabel-3-2-11" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-2-11" style="border: 1px solid #e8edee; padding: 15px 10px;">
            <div>
                [none]
            </div>
        </div>
    </div>
<br>
<!--END Part 5-1-8-->

<!--Part 5-1-9-->
<h4 style="font-weight: bold;">Pernapasan</h4>
    
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-2-12" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-2-12" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-2-12" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-2-12" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-2-12">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Observation-Create-Pernapasan-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-2-12" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
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
            },
            {
                "system": "http://terminology.kemkes.go.id/CodeSystem/anc-custom-codes",
                "code": "ANC.SS.DE2",
                "display": "Pernapasan"
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
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueQuantity": {
        "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
        "unit": "breaths/minute",
        "system": "http://unitsofmeasure.org",
        "code": "/min"
    }
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-2-12" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-2-12" style="border: 1px solid #e8edee; padding: 15px 10px;">
            <div>
                [none]
            </div>
        </div>
    </div>
<br>
<!--END Part 5-1-9-->

<!--Part 5-1-10-->
<h4 style="font-weight: bold;">Golongan Darah</h4>
    
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-2-13" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-2-13" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-2-13" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-2-13" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-2-13">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Observation-Create-Golongan-Darah-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-2-13" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "identifier": [
        {
            "system": "http://sys-ids.kemkes.go.id/observation/<strong style="color:#00a7ff">&lcub;&lcub;ORGANIZATION_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_LOCAL_CODE&rcub;&rcub;</strong>"
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
                "code": "883-9",
                "display": "ABO group [Type] in Blood"
            },
            {
                "system": "http://fhir.org/guides/who/anc-cds/CodeSystem/anc-custom-codes",
                "code": "ANC.B9.DE24",
                "display": "Blood type"
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
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueCodeableConcept": {
        "coding": [
            {
                "system": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>"
            }
        ]
    }
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-2-13" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi. Referensi ke value set "Golongan Darah" |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-2-13" style="border: 1px solid #e8edee; padding: 15px 10px;">

Golongan Darah
<table class="table-fhir-resources" style="table-layout: fixed; width: 100%">
    <tr>
        <th style="width: 5%">No.</th>
        <th>Observation.valueCodeableConcept[0].coding[0].code[0]</th>
        <th>Observation.valueCodeableConcept[0].coding[0].display[0]</th>
        <th>Observation.valueCodeableConcept[0].coding[0].system[0]</th>
    </tr>
    <tr>
        <td>1</td>
        <td>LA19710-5</td>
        <td>Group A</td>
        <td>http://loinc.org</td>
    </tr>
    <tr>
        <td>2</td>
        <td>LA19709-7</td>
        <td>Group B</td>
        <td>http://loinc.org</td>
    </tr>
    <tr>
        <td>3</td>
        <td>LA19708-9 </td>
        <td>Group O</td>
        <td>http://loinc.org</td>
    </tr>
    <tr>
        <td>4</td>
        <td>LA28449-9</td>
        <td>Group AB</td>
        <td>http://loinc.org</td>
    </tr>
</table>
</div>
</div>
<br>
<!--END Part 5-1-10-->

<!--Part 5-1-11-->
<h4 style="font-weight: bold;">Rhesus</h4>
    
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-2-14" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-2-14" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-2-14" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-2-14" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-2-14">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Observation-Create-Rhesus-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-2-14" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "identifier": [
        {
            "system": "http://sys-ids.kemkes.go.id/observation/<strong style="color:#00a7ff">&lcub;&lcub;ORGANIZATION_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_LOCAL_CODE&rcub;&rcub;</strong>"
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
                "code": "10331-7",
                "display": "Rh [Type] in Blood"
            },
            {
                "system": "http://fhir.org/guides/who/anc-cds/CodeSystem/anc-custom-codes",
                "code": "ANC.B9.DE29",
                "display": "Rh factor"
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
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueCodeableConcept": {
        "coding": [
            {
                "system": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>"
            }
        ]
    }
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-2-14" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi. Referensi ke value set "Rhesus" |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-2-14" style="border: 1px solid #e8edee; padding: 15px 10px;">
Rhesus
<table class="table-fhir-resources" style="table-layout: fixed; width: 100%">
    <tr>
        <th style="width: 5%">No.</th>
        <th>Observation.valueCodeableConcept[0].coding[0].code[0]</th>
        <th>Observation.valueCodeableConcept[0].coding[0].display[0]</th>
        <th>Observation.valueCodeableConcept[0].coding[0].system[0]</th>
    </tr>
    <tr>
        <td>1</td>
        <td>LA6576-8</td>
        <td>Positive</td>
        <td>http://loinc.org</td>
    </tr>
    <tr>
        <td>2</td>
        <td>LA6577-6</td>
        <td>Negative</td>
        <td>http://loinc.org</td>
    </tr>
</table>
        </div>
    </div>
<br>
<!--END Part 5-1-11-->

<!--Part 5-1-12-->
<h4 style="font-weight: bold;"> Makanan Tambahan Ibu Hamil </h4>
    
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-2-15" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-2-15" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-2-15" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-2-15" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-2-15">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-QuestionnaireResponse-Create-Pemberian-Makanan-Tambahan-Ibu-Hamil}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-2-15" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "QuestionnaireResponse",
    "questionnaire": "https://fhir.kemkes.go.id/Questionnaire/Q0001",
    "status": "completed",
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>",
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "encounter": {
        "reference": "Encounter/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_ENCOUNTER&rcub;&rcub;</strong>"
    },
    "authored": "<strong style="color:#00a7ff">&lcub;&lcub;QUESTRESPONSE_AUTHORED&rcub;&rcub;</strong>",
    "author": {
        "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
    },
    "source": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>"
    },
    "item":  [
        {
            "linkId": "1",
            "text": "Mendapatkan MT",
            "item":  [
                {
                    "linkId": "1.1",
                    "text": "Jika LILA <23,5, Apakah mendapatkan MT",
                    "answer":  [
                        {
                            "valueBoolean": <strong style="color:#00a7ff">&lcub;&lcub;QUESTRESPONSE_ITEM1&rcub;&rcub;</strong>
                        }
                    ]
                },
                {
                    "linkId": "1.2",
                    "text": "Jenis MT",
                    "answer":  [
                        {
                            "valueCoding": {
                                "system": "http://terminology.kemkes.go.id/CodeSystem/clinical-term",
                                "code": "<strong style="color:#00a7ff">&lcub;&lcub;QUESTRESPONSE_ITEM2&rcub;&rcub;</strong>",
                                "display": "<strong style="color:#00a7ff">&lcub;&lcub;QUESTRESPONSE_ITEM2&rcub;&rcub;</strong>"
                            }
                        }
                    ]
                }
            ]
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-2-15" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __PATIENT_NAME__      			| Nama pasien |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __QUESTRESPONSE_AUTHORED__      		| Berisi data waktu di mana jawaban kuesioner didapatkan dengan tipe data dateTime, dengan format yang diperbolehkan YYYY-MM-DDThh:mm:ss+zz:zz. |
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __QUESTRESPONSE_ITEM1__   			| Berisi data jawaban dari kuesioner dengan tipe data Boolean (true atau false) |
| __QUESTRESPONSE_ITEM2__    		| Berisi data jawaban dari kuesioner dengan tipe data CodeableConcept. Referensi ke value set "Jenis MT" |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-2-15" style="border: 1px solid #e8edee; padding: 15px 10px;">
Jenis MT

<table class="table-fhir-resources" style="table-layout: fixed; width: 100%">
    <tr>
        <th style="width: 5%">No.</th>
        <th>QuestionnaireResponse.item.item.answer.valueCoding.code[0]</th>
        <th>QuestionnaireResponse.item.item.answer.valueCoding.display</th>
        <th>QuestionnaireResponse.item.item.answer.valueCoding.system</th>
    </tr>
    <tr>
        <td>1</td>
        <td>FO000001</td>
        <td>MT Lokal</td>
        <td>http://terminology.kemkes.go.id/CodeSystem/clinical-term</td>
    </tr>
    <tr>
        <td>2</td>
        <td>FO000002</td>
        <td>MT Pabrikan</td>
        <td>http://terminology.kemkes.go.id/CodeSystem/clinical-term</td>
    </tr>
</table>
</div>
</div>
<br>
<!--END Part 5-1-12-->
</div>
<!--END Part 5-1-->

<!--Part 5-2-->
<h4>B. Pemeriksaan Fisik</h4>

<div style="margin-left: 30px;">
<!--Part 5-2-1-->
<h4 style="font-weight: bold;"> Konjungtiva </h4>
    
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-2-16" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-2-16" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-2-16" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-2-16" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-2-16">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Observation-Create-Konjungtiva-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-2-16" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "exam",
                    "display": "Exam"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://loinc.org",
                "code": "10197-2",
                "display": "Physical findings of Eye Narrative"
            },
            {
                "system": "http://terminology.kemkes.go.id/CodeSystem/anc-custom-codes",
                "code": "ANC.SS.DE26",
                "display": "Pemeriksaan Fisik Konjungtiva"
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
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueString": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
    "interpretation":  [
        {
            "coding":  [
                {
                    "system": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_INTERPRETATION&rcub;&rcub;</strong>",
                    "code": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_INTERPRETATION&rcub;&rcub;</strong>",
                    "display": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_INTERPRETATION&rcub;&rcub;</strong>"
                }
            ]
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-2-16" style="border: 1px solid #e8edee; padding: 15px 10px;">


| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi |
| __OBSERVATION_INTERPRETATION__          		| __(*)__ Berisi data hasil kesimpulan dari observasi yang dilakukan. Referensi ke value set "Konjungtiva" |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-2-16" style="border: 1px solid #e8edee; padding: 15px 10px;">
Konjungtiva
<table class="table-fhir-resources" style="table-layout: fixed; width: 100%">
    <tr>
        <th style="width: 5%">No.</th>
        <th style="width: 14%">Keterangan</th>
        <th>Observation.interpretation.coding.code</th>
        <th>Observation.interpretation.coding.display</th>
        <th>Observation.interpretation.coding.system</th>
    </tr>
    <tr>
        <td>1</td>
        <td>Normal</td>
        <td>N</td>
        <td>Normal</td>
        <td>http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation</td>
    </tr>
    <tr>
        <td>2</td>
        <td>Tidak Normal</td>
        <td>A</td>
        <td>Abnormal</td>
        <td>http://terminology.kemkes.go.id/CodeSystem/ObservationInterpretation</td>
    </tr>
</table>
</div>
</div>
<br>
<!--END Part 5-2-1-->

<!--Part 5-2-2-->
<h4 style="font-weight: bold;">Sklera</h4>
    
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-2-17" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-2-17" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-2-17" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-2-17" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-2-17">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Observation-Create-Sklera-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-2-17" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "exam",
                    "display": "Exam"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://loinc.org",
                "code": "10197-2",
                "display": "Physical findings of Eye Narrative"
            },
            {
                "system": "http://terminology.kemkes.go.id/CodeSystem/anc-custom-codes",
                "code": "ANC.SS.DE27",
                "display": "Pemeriksaan Fisik Sklera"
            }
        ]
    },
   "bodySite": {
        "coding":  [
            {
                "system": "http://snomed.info/sct",
                "code": "18619003",
                "display": "Scleral structure"
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
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueString": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
    "interpretation":  [
        {
            "coding":  [
                {
                    "system": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_INTERPRETATION&rcub;&rcub;</strong>",
                    "code": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_INTERPRETATION&rcub;&rcub;</strong>",
                    "display": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_INTERPRETATION&rcub;&rcub;</strong>"
                }
            ]
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-2-17" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi |
| __OBSERVATION_INTERPRETATION__          		| __(*)__ Berisi data hasil kesimpulan dari observasi yang dilakukan. Referensi ke value set "Sklera" |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-2-17" style="border: 1px solid #e8edee; padding: 15px 10px;">

Sklera
<table class="table-fhir-resources" style="table-layout: fixed; width: 100%">
    <tr>
        <th style="width: 5%">No.</th>
        <th style="width: 14%">Keterangan</th>
        <th>Observation.interpretation.coding.code</th>
        <th>Observation.interpretation.coding.display</th>
        <th>Observation.interpretation.coding.system</th>
    </tr>
    <tr>
        <td>1</td>
        <td>Normal</td>
        <td>N</td>
        <td>Normal</td>
        <td>http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation</td>
    </tr>
    <tr>
        <td>2</td>
        <td>Tidak Normal</td>
        <td>A</td>
        <td>Abnormal</td>
        <td>http://terminology.kemkes.go.id/CodeSystem/ObservationInterpretation</td>
    </tr>
</table>
        </div>
    </div>
<br>
<!--END Part 5-2-2-->

<!--Part 5-2-3-->
<h4 style="font-weight: bold;">Leher</h4>
    
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-2-18" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-2-18" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-2-18" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-2-18" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-2-18">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Observation-Create-Leher-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-2-18" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "exam",
                    "display": "Exam"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://loinc.org",
                "code": "11411-6",
                "display": "Physical findings of Neck Narrative"
            },
            {
                "system": "http://terminology.kemkes.go.id/CodeSystem/anc-custom-codes",
                "code": "ANC.SS.DE28",
                "display": "Pemeriksaan Fisik Leher"
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
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueString": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
    "interpretation":  [
        {
            "coding":  [
                {
                    "system": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_INTERPRETATION&rcub;&rcub;</strong>",
                    "code": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_INTERPRETATION&rcub;&rcub;</strong>",
                    "display": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_INTERPRETATION&rcub;&rcub;</strong>"
                }
            ]
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-2-18" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi |
| __OBSERVATION_INTERPRETATION__          		| __(*)__ Berisi data hasil kesimpulan dari observasi yang dilakukan. Referensi ke value set "Interpretasi Leher" |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-2-18" style="border: 1px solid #e8edee; padding: 15px 10px;">
Interpretasi Leher
<table class="table-fhir-resources" style="table-layout: fixed; width: 100%">
    <tr>
        <th style="width: 5%">No.</th>
        <th style="width: 14%">Keterangan</th>
        <th>Observation.interpretation.coding.code</th>
        <th>Observation.interpretation.coding.display</th>
        <th>Observation.interpretation.coding.system</th>
    </tr>
    <tr>
        <td>1</td>
        <td>Normal</td>
        <td>N</td>
        <td>Normal</td>
        <td>http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation</td>
    </tr>
    <tr>
        <td>2</td>
        <td>Tidak Normal</td>
        <td>A</td>
        <td>Abnormal</td>
        <td>http://terminology.kemkes.go.id/CodeSystem/ObservationInterpretation</td>
    </tr>
</table>
</div>
</div>
<br>
<!--END Part 5-2-3-->

<!--Part 5-2-4-->
<h4 style="font-weight: bold;"> Gigi dan Mulut </h4>
    
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-2-19" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-2-19" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-2-19" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-2-19" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-2-19">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Observation-Create-Gigi-Mulut-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-2-19" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "exam",
                    "display": "Exam"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://snomed.info/sct",
                "code": "423066003",
                "display": "Finding of mouth region"
            },
            {
                "system": "http://terminology.kemkes.go.id/CodeSystem/anc-custom-codes",
                "code": "ANC.SS.DE29",
                "display": "Pemeriksaan Fisik Area Mulut"
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
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueString": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
    "interpretation":  [
        {
            "coding":  [
                {
                    "system": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_INTERPRETATION&rcub;&rcub;</strong>",
                    "code": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_INTERPRETATION&rcub;&rcub;</strong>",
                    "display": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_INTERPRETATION&rcub;&rcub;</strong>"
                }
            ]
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-2-19" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi |
| __OBSERVATION_INTERPRETATION__          		| __(*)__ Berisi data hasil kesimpulan dari observasi yang dilakukan. Referensi ke value set "Interpretasi Leher" |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-2-19" style="border: 1px solid #e8edee; padding: 15px 10px;">
Interpretasi Gigi dan Mulut
<table class="table-fhir-resources" style="table-layout: fixed; width: 100%">
    <tr>
        <th style="width: 5%">No.</th>
        <th style="width: 14%">Keterangan</th>
        <th>Observation.interpretation.coding.code</th>
        <th>Observation.interpretation.coding.display</th>
        <th>Observation.interpretation.coding.system</th>
    </tr>
    <tr>
        <td>1</td>
        <td>Normal</td>
        <td>N</td>
        <td>Normal</td>
        <td>http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation</td>
    </tr>
    <tr>
        <td>2</td>
        <td>Tidak Normal</td>
        <td>A</td>
        <td>Abnormal</td>
        <td>http://terminology.kemkes.go.id/CodeSystem/ObservationInterpretation</td>
    </tr>
</table>
</div>
</div>
<br>
<!--END Part 5-2-4-->

<!--Part 5-2-5-->
<h4 style="font-weight: bold;"> Pemeriksaan THT </h4>
    
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-2-20" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-2-20" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-2-20" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-2-20" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-2-20">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Observation-Create-THT-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-2-20" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "exam",
                    "display": "Exam"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://snomed.info/sct",
                "code": "297268004",
                "display": "Ear, nose and throat finding"
            },
            {
                "system": "http://terminology.kemkes.go.id/CodeSystem/anc-custom-codes",
                "code": "ANC.SS.DE30",
                "display": "Pemeriksaan Fisik Telinga Hidung dan Tenggorokan (THT)"
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
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueString": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
    "interpretation":  [
        {
            "coding":  [
                {
                    "system": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_INTERPRETATION&rcub;&rcub;</strong>",
                    "code": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_INTERPRETATION&rcub;&rcub;</strong>",
                    "display": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_INTERPRETATION&rcub;&rcub;</strong>"
                }
            ]
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-2-20" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi |
| __OBSERVATION_INTERPRETATION__          		| __(*)__ Berisi data hasil kesimpulan dari observasi yang dilakukan. Referensi ke value set "Interpretasi Pemeriksaan THT" |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-2-20" style="border: 1px solid #e8edee; padding: 15px 10px;">
Interpretasi Pemeriksaan THT
<table class="table-fhir-resources" style="table-layout: fixed; width: 100%">
    <tr>
        <th style="width: 5%">No.</th>
        <th style="width: 14%">Keterangan</th>
        <th>Observation.interpretation.coding.code</th>
        <th>Observation.interpretation.coding.display</th>
        <th>Observation.interpretation.coding.system</th>
    </tr>
    <tr>
        <td>1</td>
        <td>Normal</td>
        <td>N</td>
        <td>Normal</td>
        <td>http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation</td>
    </tr>
    <tr>
        <td>2</td>
        <td>Tidak Normal</td>
        <td>A</td>
        <td>Abnormal</td>
        <td>http://terminology.kemkes.go.id/CodeSystem/ObservationInterpretation</td>
    </tr>
</table>
</div>
</div>
<br>
<!--END Part 5-2-5-->

<!--Part 5-2-6-->
<h4 style="font-weight: bold;"> Pemeriksaan Dada (Jantung) </h4>
    
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-2-21" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-2-21" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-2-21" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-2-21" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-2-21">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Observation-Create-Dada-Jantung-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-2-21" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "exam",
                    "display": "Exam"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://loinc.org",
                "code": "10200-4",
                "display": "Physical findings of Heart Narrative"
            },
            {
                "system": "http://terminology.kemkes.go.id/CodeSystem/anc-custom-codes",
                "code": "ANC.SS.DE31",
                "display": "Pemeriksaan Fisik Dada (Auskultasi Jantung)"
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
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueString": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
    "interpretation":  [
        {
            "coding":  [
                {
                    "system": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_INTERPRETATION&rcub;&rcub;</strong>",
                    "code": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_INTERPRETATION&rcub;&rcub;</strong>",
                    "display": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_INTERPRETATION&rcub;&rcub;</strong>"
                }
            ]
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-2-21" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi |
| __OBSERVATION_INTERPRETATION__          		| __(*)__ Berisi data hasil kesimpulan dari observasi yang dilakukan. Referensi ke value set "Interpretasi Pemeriksaan Dada (Jantung)" |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-2-21" style="border: 1px solid #e8edee; padding: 15px 10px;">
Interpretasi Pemeriksaan Dada (Jantung)
<table class="table-fhir-resources" style="table-layout: fixed; width: 100%">
    <tr>
        <th style="width: 5%">No.</th>
        <th style="width: 14%">Keterangan</th>
        <th>Observation.interpretation.coding.code</th>
        <th>Observation.interpretation.coding.display</th>
        <th>Observation.interpretation.coding.system</th>
    </tr>
    <tr>
        <td>1</td>
        <td>Normal</td>
        <td>N</td>
        <td>Normal</td>
        <td>http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation</td>
    </tr>
    <tr>
        <td>2</td>
        <td>Tidak Normal</td>
        <td>A</td>
        <td>Abnormal</td>
        <td>http://terminology.kemkes.go.id/CodeSystem/ObservationInterpretation</td>
    </tr>
</table>
</div>
</div>
<br>
<!--END Part 5-2-6-->

<!--Part 5-2-7-->
<h4 style="font-weight: bold;"> Pemeriksaan Dada (Paru) </h4>
    
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-2-22" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-2-22" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-2-22" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-2-22" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-2-22">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Observation-Create-Dada-Paru-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-2-22" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "exam",
                    "display": "Exam"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://snomed.info/sct",
                "code": "301230006",
                "display": "Lung finding"
            },
            {
                "system": "http://terminology.kemkes.go.id/CodeSystem/anc-custom-codes",
                "code": "ANC.SS.DE32",
                "display": "Pemeriksaan Fisik Dada (Auskultasi Paru)"
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
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueString": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
    "interpretation":  [
        {
            "coding":  [
                {
                    "system": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_INTERPRETATION&rcub;&rcub;</strong>",
                    "code": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_INTERPRETATION&rcub;&rcub;</strong>",
                    "display": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_INTERPRETATION&rcub;&rcub;</strong>"
                }
            ]
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-2-22" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi |
| __OBSERVATION_INTERPRETATION__          		| __(*)__ Berisi data hasil kesimpulan dari observasi yang dilakukan. Referensi ke value set "Interpretasi Pemeriksaan Dada (Paru)" |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-2-22" style="border: 1px solid #e8edee; padding: 15px 10px;">
Interpretasi Pemeriksaan Dada (Paru)
<table class="table-fhir-resources" style="table-layout: fixed; width: 100%">
    <tr>
        <th style="width: 5%">No.</th>
        <th style="width: 14%">Keterangan</th>
        <th>Observation.interpretation.coding.code</th>
        <th>Observation.interpretation.coding.display</th>
        <th>Observation.interpretation.coding.system</th>
    </tr>
    <tr>
        <td>1</td>
        <td>Normal</td>
        <td>N</td>
        <td>Normal</td>
        <td>http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation</td>
    </tr>
    <tr>
        <td>2</td>
        <td>Tidak Normal</td>
        <td>A</td>
        <td>Abnormal</td>
        <td>http://terminology.kemkes.go.id/CodeSystem/ObservationInterpretation</td>
    </tr>
</table>
        </div>
    </div>
<br>
<!--END Part 5-2-7-->

<!--Part 5-2-8-->
<h4 style="font-weight: bold;"> Perut </h4>
    
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-2-23" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-2-23" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-2-23" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-2-23" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-2-23">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Observation-Create-Perut-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-2-23" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "exam",
                    "display": "Exam"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://loinc.org",
                "code": "10191-5",
                "display": "Physical findings of Abdomen Narrative"
            },
            {
                "system": "http://terminology.kemkes.go.id/CodeSystem/anc-custom-codes",
                "code": "ANC.SS.DE33",
                "display": "Pemeriksaan Fisik Perut"
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
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueString": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
    "interpretation":  [
        {
            "coding":  [
                {
                    "system": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_INTERPRETATION&rcub;&rcub;</strong>",
                    "code": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_INTERPRETATION&rcub;&rcub;</strong>",
                    "display": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_INTERPRETATION&rcub;&rcub;</strong>"
                }
            ]
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-2-23" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi |
| __OBSERVATION_INTERPRETATION__          		| __(*)__ Berisi data hasil kesimpulan dari observasi yang dilakukan. Referensi ke value set "Interpretasi Perut" |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-2-23" style="border: 1px solid #e8edee; padding: 15px 10px;">
Interpretasi Perut
<table class="table-fhir-resources" style="table-layout: fixed; width: 100%">
    <tr>
        <th style="width: 5%">No.</th>
        <th style="width: 14%">Keterangan</th>
        <th>Observation.interpretation.coding.code</th>
        <th>Observation.interpretation.coding.display</th>
        <th>Observation.interpretation.coding.system</th>
    </tr>
    <tr>
        <td>1</td>
        <td>Normal</td>
        <td>N</td>
        <td>Normal</td>
        <td>http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation</td>
    </tr>
    <tr>
        <td>2</td>
        <td>Tidak Normal</td>
        <td>A</td>
        <td>Abnormal</td>
        <td>http://terminology.kemkes.go.id/CodeSystem/ObservationInterpretation</td>
    </tr>
</table>
        </div>
    </div>
<br>
<!--END Part 5-2-8-->

<!--Part 5-2-9 -->
<h4 style="font-weight: bold;"> Tungkai </h4>
    
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-2-24" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-2-24" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-2-24" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-2-24" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-2-24">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Observation-Create-Tungkai-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-2-24" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "exam",
                    "display": "Exam"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://snomed.info/sct",
                "code": "116312005",
                "display": "Finding of limb structure"
            },
            {
                "system": "http://terminology.kemkes.go.id/CodeSystem/anc-custom-codes",
                "code": "ANC.SS.DE34",
                "display": "Pemeriksaan Fisik Tungkai"
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
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueString": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
    "interpretation":  [
        {
            "coding":  [
                {
                    "system": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_INTERPRETATION&rcub;&rcub;</strong>",
                    "code": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_INTERPRETATION&rcub;&rcub;</strong>",
                    "display": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_INTERPRETATION&rcub;&rcub;</strong>"
                }
            ]
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-2-24" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi |
| __OBSERVATION_INTERPRETATION__          		| __(*)__ Berisi data hasil kesimpulan dari observasi yang dilakukan. Referensi ke value set "Interpretasi Tungkai" |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-2-24" style="border: 1px solid #e8edee; padding: 15px 10px;">
Interpretasi Tungkai
<table class="table-fhir-resources" style="table-layout: fixed; width: 100%">
    <tr>
        <th style="width: 5%">No.</th>
        <th style="width: 14%">Keterangan</th>
        <th>Observation.interpretation.coding.code</th>
        <th>Observation.interpretation.coding.display</th>
        <th>Observation.interpretation.coding.system</th>
    </tr>
    <tr>
        <td>1</td>
        <td>Normal</td>
        <td>N</td>
        <td>Normal</td>
        <td>http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation</td>
    </tr>
    <tr>
        <td>2</td>
        <td>Tidak Normal</td>
        <td>A</td>
        <td>Abnormal</td>
        <td>http://terminology.kemkes.go.id/CodeSystem/ObservationInterpretation</td>
    </tr>
</table>
        </div>
    </div>
<br>
<!--END Part 5-2-8-->
</div>
<!--END Part 5-2-->

<!--Part 5-3-->
<h4>C. Pemeriksaan Janin</h4>

<div style="margin-left: 30px;">
<!--Part 5-3-1-->
<h4 style="font-weight: bold;"> Denyut Jantung Janin </h4>
    
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-2-25" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-2-25" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-2-25" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-2-25" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-2-25">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Observation-Create-Fetal-Heart-Rate-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-2-25" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "exam",
                    "display": "Exam"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://loinc.org",
                "code": "55283-6",
                "display": "Fetal Heart rate"
            },
            {
                "system": "http://fhir.org/guides/who/anc-cds/CodeSystem/anc-custom-codes",
                "code": "ANC.B8.DE107",
                "display": "Fetal heart rate"
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
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueQuantity": {
        "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
        "unit": "beats/minute",
        "system": "http://unitsofmeasure.org",
        "code": "/min"
    }
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-2-25" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-2-25" style="border: 1px solid #e8edee; padding: 15px 10px;">
            <div>
                [none]
            </div>
        </div>
    </div>
<br>
<!--END Part 5-3-1-->

<!--Part 5-3-2-->
<h4 style="font-weight: bold;"> Kepala Terhadap PAP </h4>
    
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-2-26" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-2-26" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-2-26" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-2-26" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-2-26">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Observation-Create-Kepala-Terhadap-PAP-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-2-26" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "exam",
                    "display": "Exam"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://terminology.kemkes.go.id/CodeSystem/clinical-term",
                "code": "OC000002",
                "display": "Kepala Terhadap PAP"
            },
            {
                "system": "http://terminology.kemkes.go.id/CodeSystem/anc-custom-codes",
                "code": "ANC.SS.DE46",
                "display": "Kepala terhadap PAP"
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
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueCodeableConcept": {
        "coding": [
            {
                "system": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>"
            }
        ]
    }
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-2-26" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| __(*)__ Nilai observasi. Referensi ke value set "Kepala terhadap PAP" |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-2-26" style="border: 1px solid #e8edee; padding: 15px 10px;">
Kepala terhadap PAP
<table class="table-fhir-resources" style="table-layout: fixed; width: 100%">
    <tr>
        <th style="width: 5%">No.</th>
        <th>Observation.valueCodeableConcept[0].coding[0].code[0]</th>
        <th>Observation.valueCodeableConcept[0].coding[0].display[0]</th>
        <th>Observation.valueCodeableConcept[0].coding[0].system[0]</th>
    </tr>
    <tr>
        <td>1</td>
        <td>OV000001</td>
        <td>Masuk panggul</td>
        <td>http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation</td>
    </tr>
    <tr>
        <td>2</td>
        <td>OV000002</td>
        <td>Belum masuk panggul</td>
        <td>http://terminology.kemkes.go.id/CodeSystem/ObservationInterpretation</td>
    </tr>
</table>
        </div>
    </div>
<br>
<!--END Part 3-2-26-->

<!--Part 3-2-27 Taksiran Berat Janin-->
<h4 style="font-weight: bold;"> Taksiran Berat Janin </h4>
    
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-2-27" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-2-27" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-2-27" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-2-27" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-2-27">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC/Observation-Create-BodyWeight-Janin-3.json}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-2-27" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "exam",
                    "display": "Exam"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://loinc.org",
                "code": "89087-1",
                "display": "Fetal Body weight Estimated"
            },
            {
                "system": "http://terminology.kemkes.go.id/CodeSystem/anc-custom-codes",
                "code": "ANC.SS.DE1",
                "display": "Taksiran Berat Janin (TBJ)"
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
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueQuantity": {
        "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
        "unit": "g",
        "system": "http://unitsofmeasure.org",
        "code": "g"
    }
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-2-27" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-2-27" style="border: 1px solid #e8edee; padding: 15px 10px;">
            <div>
                [none]
            </div>
        </div>
    </div>
<br>
<!--END Part 3-2-27-->

<!--Part 3-2-28 Presentasi-->
<h4 style="font-weight: bold;"> Presentasi Janin</h4>
    
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-2-28" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-2-28" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-2-28" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-2-28" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-2-28">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Observation-Create-Fetal-Presentation-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-2-28" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "exam",
                    "display": "Exam"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://loinc.org",
                "code": "72155-5",
                "display": "Position in womb Fetus [RHEA]"
            },
            {
                "system": "http://fhir.org/guides/who/anc-cds/CodeSystem/anc-custom-codes",
                "code": "ANC.B8.DE111",
                "display": "Fetal presentation"
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
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueCodeableConcept": {
        "coding": [
            {
                "system": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>"
            }
        ]
    }
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-2-28" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| __(*)__ Nilai observasi. Referensi ke value set "Jenis Presentasi Janin"|

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-2-28" style="border: 1px solid #e8edee; padding: 15px 10px;">
Jenis Presentasi Janin

<table class="table-fhir-resources" style="table-layout: fixed; width: 100%">
    <tr>
        <th style="width: 5%">No.</th>
        <th style="width: 14%">Keterangan</th>
        <th>Observation.interpretation.coding.code</th>
        <th>Observation.interpretation.coding.display</th>
        <th>Observation.interpretation.coding.system</th>
    </tr>
    <tr>
        <td>1</td>
        <td>Presentasi Kepala</td>
        <td>1209182005</td>
        <td>Cephalic fetal presentation</td>
        <td>http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation</td>
    </tr>
    <tr>
        <td>2</td>
        <td> Presentasi Bokong</td>
        <td>6096002</td>
        <td>Breech presentation</td>
        <td>http://snomed.info/sct</td>
    </tr>
    <tr>
        <td>3</td>
        <td>Letak Lintang</td>
        <td>288203005</td>
        <td>Transverse/oblique lie</td>
        <td>http://snomed.info/sct</td>
    </tr>
</table>

</div>
</div>
<br>
<!--END Part 3-2-28-->


<!--Part 3-2-29 Jumlah Janin-->
<h4 style="font-weight: bold;"> Jumlah Janin </h4>
    
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-2-29" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-2-29" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-2-29" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-2-29" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-2-29">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Observation-Create-Jumlah-Janin-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-2-29" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "exam",
                    "display": "Exam"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://terminology.kemkes.go.id/CodeSystem/clinical-term",
                "code": "OC000003",
                "display": "Jumlah Janin"
            },
            {
                "system": "http://fhir.org/guides/who/anc-cds/CodeSystem/anc-custom-codes",
                "code": "ANC.B8.DE109",
                "display": "Number of fetuses"
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
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueInteger": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>"
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-2-29" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-2-29" style="border: 1px solid #e8edee; padding: 15px 10px;">
            <div>
                [none]
            </div>
        </div>
    </div>
<br>
<!--END Part 3-2-29-->
</div>
<!--END Part 5-3-->

<!--Part 5-4-->
<h4>D. Pemantauan & Pendampingan</h4>

<div style="margin-left: 30px;">

> `CATATAN:`
>  Penjelasan tipe mandatoris, deskripsi dan format pengisian dari setiap elemen data/_path_ di dalam _resource_ `QuestionnaireResponse`, dapat dilihat dalam _resource_ [`QuestionnaireResponse`](https://satusehat.kemkes.go.id/platform/docs/id/fhir/resources/QuestionnaireResponse).

<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-5-4-1" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-5-4-1" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-5-4-1" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-5-4-1" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-5-4-1">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-QuestionnaireResponse-Pemantauan-ANC}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-5-4-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "QuestionnaireResponse",
    "questionnaire": "https://fhir.kemkes.go.id/Questionnaire/Q0002",
    "status": "completed",
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>",
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "encounter": {
        "reference": "Encounter/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_ENCOUNTER&rcub;&rcub;</strong>"
    },
    "authored": "<strong style="color:#00a7ff">&lcub;&lcub;QUESTRESPONSE_AUTHORED&rcub;&rcub;</strong>",
    "author": {
        "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
    },
    "source": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>"
    },
    "item":  [
        {
             "linkId": "2",
            "text": "Pemantauan & Pendampingan",
            "item":  [
                {
                    "linkId": "2.1",
                    "text": "Terlalu muda usia melahirkan dibawah 21 tahun",
                    "answer":  [
                        {
                            "valueBoolean": "<strong style="color:#00a7ff">&lcub;&lcub;QUESTRESPONSE_ITEM1&rcub;&rcub;</strong>"
                        }
                    ]
                },
{
                    "linkId": "2.2",
                    "text": "Terlalu rapat jarak kelahiran (<2 tahun)",
                    "answer":  [
                        {
                            "valueBoolean": "<strong style="color:#00a7ff">&lcub;&lcub;QUESTRESPONSE_ITEM1&rcub;&rcub;</strong>"
                        }
                    ]
                },
                {
                    "linkId": "2.3",
                    "text": "Terlalu tua (kehamilan diatas 35 tahun)",
                    "answer":  [
                        {
                            "valueBoolean": "<strong style="color:#00a7ff">&lcub;&lcub;QUESTRESPONSE_ITEM1&rcub;&rcub;</strong>"
                        }
                    ]
                },
                {
                    "linkId": "2.4",
                    "text": "Terlalu sering melahirkan (anak>3)",
                    "answer":  [
                        {
                            "valueBoolean": "<strong style="color:#00a7ff">&lcub;&lcub;QUESTRESPONSE_ITEM1&rcub;&rcub;</strong>"
                        }
                    ]
                }
            ]
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-5-4-1" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __PATIENT_NAME__      			| Nama pasien |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __QUESTRESPONSE_AUTHORED__      		| Berisi data waktu di mana jawaban kuesioner didapatkan dengan tipe data dateTime, dengan format yang diperbolehkan YYYY-MM-DDThh:mm:ss+zz:zz. |
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __QUESTRESPONSE_ITEM1__   			| Berisi data jawaban dari kuesioner dengan tipe data Boolean (true atau false) |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-5-4-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
[none]
		</div>
	</div>
<br>
<!--END Part 5-4-1-->
</div>
</div>
<!--END Part 5-4-->

<!--Part 5-5-->
<h4>E. Riwayat Penyakit & Risiko</h4>

<div style="margin-left: 30px;">
<!--Part 3-2-42 Komplikasi/Penyulit Kehamilan-->
<h4 style="font-weight: bold;"> Komplikasi/Penyulit Kehamilan</h4>
    
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-2-42" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-2-42" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-2-42" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-2-42" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-2-42">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Condition-Create-Komplikasi-Kehamilan-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-2-42" style="border: 1px solid #e8edee; padding: 15px 10px;">
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
                "system": "http://hl7.org/fhir/sid/icd-10",
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;CONDITION_VALUE&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;CONDITION_VALUE&rcub;&rcub;</strong>"
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

<div role="tabpanel" class="tab-pane" id="variabel-3-2-42" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __PATIENT_IHS_NUMBER__      | &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __PATIENT_NAME__           | Nama Pasien |
| __CONDITION_VALUE__           | Berisi data diagnosis menggunakan ICD-10 tahun 2010 |
| __CONDITION_ONSET_DATETIME__ | Tanggal perkiraan atau tanggal aktual atau tanggal-waktu kondisi mulai, menurut pendapat dokter.|
| __CONDITION_RECORDED_DATETIME__ | 	Tanggal kapan kondisi/keluhan ini tercatat dalam sistem (tanggal yang dibuat oleh sistem)|

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-2-42" style="border: 1px solid #e8edee; padding: 15px 10px;">
            <div>
                [none]
            </div>
        </div>
    </div>
<br>
<!--END Part 3-2-42-->

<!--Part 3-2-43 Riwayat Penyakit Menular (dan Tidak Menular)-->
<h4 style="font-weight: bold;"> Riwayat Penyakit Menular (dan Tidak Menular)</h4>
    
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-2-43" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-2-43" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-2-43" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-2-43" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-2-43">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Condition-Create-Riwayat-Penyakit-Menular-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-2-43" style="border: 1px solid #e8edee; padding: 15px 10px;">
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
                "system": "http://hl7.org/fhir/sid/icd-10",
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;CONDITION_VALUE&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;CONDITION_VALUE&rcub;&rcub;</strong>"
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

<div role="tabpanel" class="tab-pane" id="variabel-3-2-43" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __PATIENT_IHS_NUMBER__      | &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __PATIENT_NAME__           | Nama Pasien |
| __CONDITION_VALUE__           | Berisi data diagnosis menggunakan ICD-10 tahun 2010 |
| __CONDITION_ONSET_DATETIME__ | Tanggal perkiraan atau tanggal aktual atau tanggal-waktu kondisi mulai, menurut pendapat dokter.|
| __CONDITION_RECORDED_DATETIME__ | 	Tanggal kapan kondisi/keluhan ini tercatat dalam sistem (tanggal yang dibuat oleh sistem)|

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-2-43" style="border: 1px solid #e8edee; padding: 15px 10px;">
            <div>
                [none]
            </div>
        </div>
    </div>
<br>
<!--END Part 3-2-43-->

<!--Part 3-2-44 Riwayat Penyakit Keluarga-->
<h4 style="font-weight: bold;"> Riwayat Penyakit Keluarga</h4>
    
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-2-44" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-2-44" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-2-44" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-2-44" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-2-44">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-FamilyMemberHistory-Riwayat-Penyakit-Keluarga-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-2-44" style="border: 1px solid #e8edee; padding: 15px 10px;">
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
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;CONDITION_VALUE&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;CONDITION_VALUE&rcub;&rcub;</strong>"
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

<div role="tabpanel" class="tab-pane" id="variabel-3-2-44" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __PATIENT_IHS_NUMBER__      | &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __PATIENT_NAME__           | Nama Pasien |
| __CONDITION_VALUE__           | Berisi data jenis riwayat penyakit. Referensi ke value set "Lampiran Terminologi Condition.code untuk Riwayat Penyakit"|
| __CONDITION_ONSET_DATETIME__ | Tanggal perkiraan atau tanggal aktual atau tanggal-waktu kondisi mulai, menurut pendapat dokter.|
| __CONDITION_RECORDED_DATETIME__ | 	Tanggal kapan kondisi/keluhan ini tercatat dalam sistem (tanggal yang dibuat oleh sistem)|

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-2-44" style="border: 1px solid #e8edee; padding: 15px 10px;">

Lampiran Terminologi Condition.code untuk Riwayat Penyakit dapat diakses <a href="https://docs.google.com/spreadsheets/d/1K91P8K-e_iB4kk6nFIMphYv64bme4gxma7a_J_EzUDk/edit#gid=1972679880&range=A1">disini</a>.
        </div>
    </div>
<br>
<!--END Part 3-2-44-->

<!--Part 3-2-45 Merokok-->
<h4 style="font-weight: bold;"> Merokok</h4>
    
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-2-45" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-2-45" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-2-45" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-2-45" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-2-45">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Observation-Create-Merokok-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-2-45" style="border: 1px solid #e8edee; padding: 15px 10px;">
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
                "system": "http://loinc.org",
                "code": "72166-2",
                "display": "Tobacco smoking status"
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
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueCodeableConcept": {
        "coding": [
            {
                "system": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>"
            }
        ]
    }
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-2-45" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		|__(*)__ Nilai observasi. Referensi ke value set "Merokok" |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-2-45" style="border: 1px solid #e8edee; padding: 15px 10px;">
Merokok
<table class="table-fhir-resources" style="table-layout: fixed; width: 100%">
    <tr>
        <th style="width: 5%">No.</th>
        <th>Keterangan</th>
        <th>Observation.valueCodeableConcept[0].coding[0].code[0]</th>
        <th>Observation.valueCodeableConcept[0].coding[0].display[0]</th>
        <th>Observation.valueCodeableConcept[0].coding[0].system[0]</th>
    </tr>
    <tr>
        <td>1</td>
        <td>Ya</td>
        <td>77176002</td>
        <td>Smoker</td>
        <td>http://snomed.info/sct</td>
    </tr>
    <tr>
        <td>2</td>
        <td>Pasif</td>
        <td>43381005</td>
        <td>Passive smoker</td>
        <td>http://snomed.info/sct</td>
    </tr>
    <tr>
        <td>3</td>
        <td>Tidak</td>
        <td>8392000</td>
        <td>Non-smoker</td>
        <td>http://snomed.info/sct</td>
    </tr>
</table>
        </div>
    </div>
<br>
<!--END Part 3-2-45-->

<!--Part 3-2-46 Konsumsi Alkohol-->
<h4 style="font-weight: bold;"> Konsumsi Alkohol</h4>
    
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-2-46" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-2-46" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-2-46" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-2-46" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-2-46">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Observation-Create-Konsumsi-Alkohol-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-2-46" style="border: 1px solid #e8edee; padding: 15px 10px;">
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
                "system": "http://loinc.org",
                "code": "11331-6",
                "display": "History of Alcohol use"
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
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueCodeableConcept": {
        "coding": [
            {
                "system": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>"
            }
        ]
    }
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-2-46" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		|__(*)__ Nilai observasi. Referensi ke value set "Konsumsi Alkohol" |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-2-46" style="border: 1px solid #e8edee; padding: 15px 10px;">
Konsumsi Alkohol
<table class="table-fhir-resources" style="table-layout: fixed; width: 100%">
    <tr>
        <th style="width: 5%">No.</th>
        <th>Keterangan</th>
        <th>Observation.valueCodeableConcept[0].coding[0].code[0]</th>
        <th>Observation.valueCodeableConcept[0].coding[0].display[0]</th>
        <th>Observation.valueCodeableConcept[0].coding[0].system[0]</th>
    </tr>
    <tr>
        <td>1</td>
        <td>Ya</td>
        <td>219006</td>
        <td>Current drinker</td>
        <td>http://snomed.info/sct</td>
    </tr>
    <tr>
        <td>2</td>
        <td>Tidak</td>
        <td>105542008</td>
        <td>Non - drinker</td>
        <td>http://snomed.info/sct</td>
    </tr>
</table>
        </div>
    </div>
<br>
</div>
<!--END Part 3-2-46-->

<!--Part 5-6-->
<h4>F. Lainnya</h4>

<div style="margin-left: 30px;">
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-2-47" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-2-47" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-2-47" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-2-47" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-2-47">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-QuestionnaireResponse-Pelayanan-Kehamilan-Lainnya}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-2-47" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "QuestionnaireResponse",
    "questionnaire": "https://fhir.kemkes.go.id/Questionnaire/Q0002",
    "status": "completed",
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>",
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "encounter": {
        "reference": "Encounter/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_ENCOUNTER&rcub;&rcub;</strong>"
    },
    "authored": "<strong style="color:#00a7ff">&lcub;&lcub;QUESTRESPONSE_AUTHORED&rcub;&rcub;</strong>",
    "author": {
        "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
    },
    "source": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>"
    },
    "item":  [
        {
            "linkId": "3",
            "text": "Lainnya",
            "item":  [
                {
                    "linkId": "3.1",
                    "text": "Apakah disabilitas",
                    "answer":  [
                        {
                            "valueBoolean": "valueBoolean": "<strong style="color:#00a7ff">&lcub;&lcub;QUESTRESPONSE_ITEM1&rcub;&rcub;</strong>"
                        }
                    ]
                },
                {
                    "linkId": "3.2",
                    "text": "Apakah mengikuti kelas ibu hamil?",
                    "answer":  [
                        {
                            "valueBoolean": "valueBoolean": "<strong style="color:#00a7ff">&lcub;&lcub;QUESTRESPONSE_ITEM1&rcub;&rcub;</strong>"
                        }
                    ]
                }
            ]
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-2-47" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __PATIENT_NAME__      			| Nama pasien |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __QUESTRESPONSE_AUTHORED__      		| Berisi data waktu di mana jawaban kuesioner didapatkan dengan tipe data dateTime, dengan format yang diperbolehkan YYYY-MM-DDThh:mm:ss+zz:zz. |
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __QUESTRESPONSE_ITEM1__   			| Berisi data jawaban dari kuesioner dengan tipe data Boolean (true atau false) |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-2-47" style="border: 1px solid #e8edee; padding: 15px 10px;">
            <div>
                [none]
            </div>
        </div>
    </div>
<br>
</div>
<!--END Part 5-6-->
</div>
<!--END Part 5-->

<!--Part 6-->
### <div id="step6" style="font-weight: bold">Step 6. Data Tindakan/Prosedur Medis</div>

<div style="margin-left: 30px;">
<h4 style="font-weight: bold;">USG Kehamilan/ Apakah Dilakukan USG</h4>
<div>Fokus utama opsi jawaban ya atau tidak pada variabel ini terletak pada kolom Procedure.status. Apabila USG dilakukan, maka Procedure.status= completed. Sebaliknya apabila tidak dilakukan maka Procedure.status= not-done</div><br>

<div>Pengiriman data terkait apakah dilakukan USG dapat dikirimkan menggunakan resource`Procedure`. Tindakan yang dilaporkan dapat berupa tindakan non-invasif (konsultasi, edukasi) maupun invasif (contoh operasi). Standar kode tindakan/prosedur medis yang dikirimkan ke SATUSEHAT menggunakan kode ICD-9 CM.</div>

> `CATATAN:`
>  Penjelasan tipe mandatoris, deskripsi dan format pengisian dari setiap elemen data/_path_ di dalam _resource_ `Procedure` (data tindakan/prosedur medis), dapat dilihat dalam [_resource_ `Procedure`](https://satusehat.kemkes.go.id/platform/docs/id/fhir/resources/procedure).

<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-4-1" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-4-1" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-4-1" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-4-1" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-4-1">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Procedure-Tindakan-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-4-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Procedure",
    "status": "completed",
    "category": {
        "coding":  [
            {
                "system": "http://snomed.info/sct",
                "code": "103693007",
                "display": "Diagnostic procedure"
            }
        ],
        "text": "Diagnostic procedure"
    },
    "code": {
        "coding":  [
            {
                "system": "http://hl7.org/fhir/sid/icd-9-cm",
                "code": "88.78",
                "display": "Diagnostic ultrasound of gravid uterus"
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
    "performedPeriod": {
        "start": "<strong style="color:#00a7ff">&lcub;&lcub;PROCEDURE_PERFORM_START&rcub;&rcub;</strong>",
        "end": "<strong style="color:#00a7ff">&lcub;&lcub;PROCEDURE_PERFORM_END&rcub;&rcub;</strong>"
    },
    "performer":  [
        {
            "actor": {
                "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>",
                "display": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_NAME&rcub;&rcub;</strong>"
            }
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-4-1" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __PATIENT_NAME__      			| Nama pasien |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __PROCEDURE_PERFORM_START__      		| Diisi dengan waktu mulai, sama dengan waktu mulai prosedur pasien dengan tipe data dateTime, dengan format yang diperbolehkan YYYY-MM-DD atau YYYY-MM-DDThh:mm:ss+zz:zz. |
| __PROCEDURE_PERFORM_END__      		|Diisi dengan waktu selesai, sama dengan waktu selesai prosedur pasien dengan tipe data dateTime, dengan format yang diperbolehkan YYYY-MM-DDThh:mm:ss+zz:zz. |
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __PRACTITIONER_NAME__   			| Nama dokter |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-4-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
            <div>
                [none]
            </div>
        </div>
    </div>
</div>
<br>
<!--END Part 6-->

<!--Part 7-->
### <div id="step6" style="font-weight: bold">Step 7. Data Tema Konseling/Temu Wicara/Edukasi</div>

<div style="margin-left: 30px;">
<!--Part 7-1-->
<h4 style="font-weight: bold;">Konseling</h4>
    
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
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Procedure-Konseling-1}}
        </div>
    </div>

<div role="tabpanel" class="tab-pane" id="data-7-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Procedure",
    "status": "completed",
    "category": {
        "coding":  [
            {
                "system": "http://snomed.info/sct",
                "code": "409073007",
                "display": "Education"
            }
        ]
    },
    "code": {
        "coding":  [
            {
                "system": "<strong style="color:#00a7ff">&lcub;&lcub;PROCEDURE_TYPE&rcub;&rcub;</strong>",
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;PROCEDURE_TYPE&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;PROCEDURE_TYPE&rcub;&rcub;</strong>"
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
    "performedPeriod": {
        "start": "<strong style="color:#00a7ff">&lcub;&lcub;PROCEDURE_PERFORM_START&rcub;&rcub;</strong>",
        "end": "<strong style="color:#00a7ff">&lcub;&lcub;PROCEDURE_PERFORM_END&rcub;&rcub;</strong>"
    },
    "performer":  [
        {
            "actor": {
                "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>",
                "display": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_NAME&rcub;&rcub;</strong>"
            }
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-7-1" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __PATIENT_NAME__      			| Nama pasien |
| __PROCEDURE_TYPE__      			| __(*)__ Berisi data berkaitan dengan kode tindakan kepada pasien dengan tipe data CodeableConcept. Referensi ke value set "Tema Konseling/Temu Wicara/Edukasi"|
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __PROCEDURE_PERFORM_START__      		| Diisi dengan waktu mulai, sama dengan waktu mulai prosedur pasien dengan tipe data dateTime, dengan format yang diperbolehkan YYYY-MM-DD atau YYYY-MM-DDThh:mm:ss+zz:zz. |
| __PROCEDURE_PERFORM_END__      		|Diisi dengan waktu selesai, sama dengan waktu selesai prosedur pasien dengan tipe data dateTime, dengan format yang diperbolehkan YYYY-MM-DDThh:mm:ss+zz:zz. |
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __PRACTITIONER_NAME__   			| Nama dokter |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
			
<div role="tabpanel" class="tab-pane" id="valueset-7-1" style="border: 1px solid #e8edee; padding: 15px 10px;">

Tema Konseling/Temu Wicara/Edukasi
<table class="table-fhir-resources" style="table-layout: fixed; width: 100%">
    <tr>
        <th style="width: 5%">No.</th>
        <th>Keterangan</th>
        <th>Procedure.code.coding.code</th>
        <th>Procedure.code.coding.display</th>
        <th>Procedure.code.coding.system</th>
    </tr>
    <tr>
        <td>1</td>
        <td>Asupan gizi seimbang</td>
        <td>61310001</td>
        <td>Nutrition education</td>
        <td>http://snomed.info/sct</td>
    </tr>
    <tr>
        <td>2</td>
        <td>Tanda bahaya kehamilan, bersalin dan nifas</td>
        <td>ED000008</td>
        <td>Edukasi Tanda Bahaya Kehamilan, Bersalin dan Nifas</td>
        <td>http://terminology.kemkes.go.id/CodeSystem/clinical-term</td>
    </tr>
    <tr>
        <td>3</td>
        <td>IMD dan ASI eksklusif</td>
        <td>ED000009</td>
        <td>Edukasi IMD dan ASI Eksklusif</td>
        <td>http://terminology.kemkes.go.id/CodeSystem/clinical-term</td>
    </tr>
    <tr>
        <td>4</td>
        <td>PHBS</td>
        <td>ED000010</td>
        <td>Edukasi PHBS</td>
        <td>http://terminology.kemkes.go.id/CodeSystem/clinical-term</td>
    </tr>
    <tr>
        <td>5</td>
        <td>KB pasca salin</td>
        <td>ED000011</td>
        <td>Edukasi KB pasca salin</td>
        <td>http://terminology.kemkes.go.id/CodeSystem/clinical-term</td>
    </tr>
    <tr>
        <td>6</td>
        <td>lainnya</td>
        <td>ED000012</td>
        <td>Edukasi lainnya</td>
        <td>http://terminology.kemkes.go.id/CodeSystem/clinical-term</td>
    </tr>
</table>
		</div>
	</div>
<!--END Part 7-1-->


<!--Part 7-2-->
<h4 style="font-weight: bold;">Tidak Diberikan Konseling</h4>

<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-7-2" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-7-2" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-7-2" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-7-2" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-7-2">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Procedure-Konseling-2}}
        </div>
    </div>

<div role="tabpanel" class="tab-pane" id="data-7-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Procedure",
    "status": "not-done",
    "category": {
        "coding":  [
            {
                "system": "http://snomed.info/sct",
                "code": "409073007",
                "display": "Education"
            }
        ]
    },
    "code": {
        "coding":  [
            {
                "system": "http://snomed.info/sct",
                "code": "409073007",
                "display": "Education"
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
    "performedPeriod": {
        "start": "<strong style="color:#00a7ff">&lcub;&lcub;PROCEDURE_PERFORM_START&rcub;&rcub;</strong>",
        "end": "<strong style="color:#00a7ff">&lcub;&lcub;PROCEDURE_PERFORM_END&rcub;&rcub;</strong>"
    },
    "performer":  [
        {
            "actor": {
                "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>",
                "display": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_NAME&rcub;&rcub;</strong>"
            }
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-7-2" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __PATIENT_NAME__      			| Nama pasien |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __PROCEDURE_PERFORM_START__      		| Diisi dengan waktu mulai, sama dengan waktu mulai prosedur pasien dengan tipe data dateTime, dengan format yang diperbolehkan YYYY-MM-DD atau YYYY-MM-DDThh:mm:ss+zz:zz. |
| __PROCEDURE_PERFORM_END__      		|Diisi dengan waktu selesai, sama dengan waktu selesai prosedur pasien dengan tipe data dateTime, dengan format yang diperbolehkan YYYY-MM-DDThh:mm:ss+zz:zz. |
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __PRACTITIONER_NAME__   			| Nama dokter |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
			
<div role="tabpanel" class="tab-pane" id="valueset-7-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
[none]
    </div>
</div>
<!--END Part 7-2-->
</div>
<!--END Part 7-->
<br>

<!--Part 8-->
### <div id="step8" style="font-weight: bold">Step 8. Pemeriksaan Penunjang</div>

<div style="margin-left: 30px;">
<!--Part 8-1-->
<h4>8.1. Laboratorium</h4>
<div style="margin-left: 30px;">
Pengiriman data terkait pemeriksaan penunjang memiliki 2 skema, yaitu: <br>
<ol type="1">
<li>Pemeriksaan Penunjang Tunggal</li>
Data yang perlu dikirimkan, yaitu: <br>
    <ol type="a">
    <li>1 data permintaan (ServiceRequest)</li>
    <li>1 data spesimen (Specimen)</li>
    <li>1 data hasil pemeriksaan (Observation)</li>
    <li>1 data laporan pemeriksaan (DiagnosticReport). Data permintaan (ServiceRequest), data spesimen (Specimen), dan data hasil pemeriksaan (Observation) akan di referensi dalam data laporan pemeriksaan (DiagnosticReport).</li>
    </ol>

<center>
{{render:skema-lab-penunjang-tunggal.png}}
<i>Gambar 2. Skema Pemeriksaan Penunjang Tunggal</i>
</center>

<li>Pemeriksaan Penunjang Panel/Paket</li>
Contoh kasus: Seorang dokter melakukan permintaan pemeriksaan panel elektrolit darah yang terdiri dari 3 parameter yaitu natrium, kalium, dan klorida darah. Maka, data yang perlu dikirimkan yaitu:<br>
<ol type="a">
<li>1 data permintaan (ServiceRequest) dengan kode LOINC untuk panel elektrolit darah</li>
<li>1 data spesimen (Specimen)</li>
<li>3 data hasil pemeriksaan (Observation) terdiri dari kode LOINC untuk natrium darah, kalium darah, klorida darah</li>
<li>1 data laporan pemeriksaan (DiagnosticReport) dengan kode LOINC untuk panel elektrolit darah. Data permintaan (ServiceRequest), data spesimen (Specimen), dan data hasil pemeriksaan (Observation) akan di referensi dalam data laporan pemeriksaan (DiagnosticReport).</li>
</div>

<center>
{{render:skema-lab-penunjang-panel.png}}<i>Gambar 3. Skema Pemeriksaan Penunjang Panel</i>
</center>

<!--Part 8-1-1 Variable Permintaan Pemeriksaan Penunjang Laboratorium-->

<div style="margin-left: 30px;">
<h4 style="font-weight: bold;">Permintaan Pemeriksaan Laboratorium</h4>
<div>
Sebelum melakukan pemeriksaan penunjang seperti laboratorium, diperlukan langkah permintaan pemeriksaan penunjang. Pengiriman data terkait permintaan pemeriksaan penunjang dapat dilakukan menggunakan resource ServiceRequest. Data permintaan pemeriksaan penunjang laboratorium yang dapat dikirimkan antara lain nama pemeriksaan, pasien terkait, kunjungan terkait, tanggal permintaan akan dilakukan, tanggal permintaan dibuat, dan tenaga kesehatan yang melakukan permintaan.<br>

Kode LOINC atau kode Pemeriksaan Penunjang Nasional digunakan pada elemen ServiceRequest.code untuk merepresentasikan nama pemeriksaan yang diminta. Referensi pemetaan pemeriksaan laboratorium dengan kode LOINC dapat dilihat melalui kode LOINC. Gunakan parameter pemeriksaan dengan kategori “Permintaan” atau “Permintaan & Hasil” pada file Terminologi Laboratorium ketika mengirimkan data melalui resource ServiceRequest.<br>

Satu payload atau satu record dari resource ServiceRequest hanya dapat digunakan untuk 1 kode/permintaan parameter laboratorium. Sehingga, apabila dilakukan permintaan 2 parameter laboratorium, sebagai contoh panel elektrolit dan hemoglobin, maka perlu mengirimkan 2 payload di mana 1 payload berisi 1 kode panel elektrolit dan 1 payload berisi kode parameter hemoglobin.
</div>

<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-6-1" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-6-1" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-6-1" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-6-1" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-6-1">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-ServiceRequest-Create-PermintaanPenunjang-Lab-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-6-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "ServiceRequest",
    "identifier":  [
        {
            "system": "http://sys-ids.kemkes.go.id/servicerequest/<strong style="color:#00a7ff">&lcub;&lcub;ORGANIZATION_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;SERVICEREQUEST_LOCAL_CODE&rcub;&rcub;</strong>"
        }
    ],
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
    "status": "active",
    "intent": "original-order",
    "priority": "routine",
    "code": {
        "coding":  [
            {
                "system": "<strong style="color:#00a7ff">&lcub;&lcub;SERVICEREQUEST_VALUE&rcub;&rcub;</strong>",
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;SERVICEREQUEST_VALUE&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;SERVICEREQUEST_VALUE&rcub;&rcub;</strong>"
            }
        ]
    },
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>"
    },
    "encounter": {
        "reference": "Encounter/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_ENCOUNTER&rcub;&rcub;</strong>"
    },
    "occurrenceDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;PROCEDURE_OCCUR&rcub;&rcub;</strong>",
    "requester": {
        "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER1&rcub;&rcub;</strong>",
                "display": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_NAME1&rcub;&rcub;</strong>"
    },
    "performer":  [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER2&rcub;&rcub;</strong>",
                "display": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_NAME2&rcub;&rcub;</strong>"
        }
    ],
    "reasonCode":  [
        {
            "text": "<strong style="color:#00a7ff">&lcub;&lcub;SERVICEREQUEST_REASON&rcub;&rcub;</strong>"
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-6-1" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__    | ID organisasi induk yang didapatkan dari master sarana indeks |
| __SERVICEREQUEST_LOCAL_CODE__   | Berisi data id lokal dari masing-masing institusi terkait tindak lanjut |
| __SERVICEREQUEST_VALUE__      			| Berisi data format pengisian rencana tindak lanjut dengan tipe data CodeableConcept. Referensi ke value set "Permintaan Lab" |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __PRACTITIONER_IHS_NUMBER1__    				| Berisi data siapa yang melakukan permintaan, merujuk ke &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __PRACTITIONER_NAME1__   			| Nama dokter yang melakukan permintaan|
| __PRACTITIONER_IHS_NUMBER2__    				| Berisi satu atau lebih data siapa yang diharapkan melakukan permintaan, merujuk ke &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __PRACTITIONER_NAME2__   			| Nama dokter yang diharapkan melakukan permintaan |
| __SERVICEREQUEST_REASON__      		| Berisi data yang berkaitan dengan penjelasan atau justifikasi mengenai mengapa pelayanan ini diminta dalam bentuk teks (free-text)|

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-6-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
Lampiran terminologi "Permintaan Lab" dapat diakses di <a href="https://satusehat.kemkes.go.id/platform/docs/id/terminology/loinc/laboratory/lampiran/">portal SATUSEHAT</a>
        </div>
    </div>
<br>
<!--END Part 8-1-1-->

<!--Part 8-1-2 Variable Data Spesimen-->
<h4 style="font-weight: bold;">Data Spesimen</h4>
<div>
Pengiriman data spesimen yang digunakan pada pemeriksaan laboratorium dapat dikirimkan menggunakan resource Specimen. Data spesimen yang dapat dikirimkan antara lain jenis spesimen, waktu pengambilan spesimen, metode pengambilan spesimen, pasien terkait, kunjungan terkait, waktu spesimen diterima, tenaga kesehatan yang melakukan pengambilan sampel, permintaan terkait.

Satu payload atau satu record dari resource Specimen hanya dapat digunakan untuk 1 kode jenis spesimen. Sehingga, apabila diambil 2 jenis spesimen, sebagai contoh spesimen darah dan urin, maka perlu mengirimkan 2 payload di mana 1 payload berisi 1 kode spesimen darah dan 1 payload berisi kode spesimen urin.
</div>

> `CATATAN:`
>  Penjelasan tipe mandatoris, deskripsi dan format pengisian dari setiap elemen data/_path_ di dalam _resource_ `Specimen` (data permintaan spesimen), dapat dilihat dalam [_resource_ `Specimen`](https://satusehat.kemkes.go.id/platform/docs/id/fhir/resources/specimen).

<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-6-2" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-6-2" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-6-2" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-6-2" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-6-2">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Specimen-Create-Sputum-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-6-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Specimen",
    "identifier":  [
        {
            "system": "http://sys-ids.kemkes.go.id/specimen/<strong style="color:#00a7ff">&lcub;&lcub;ORGANIZATION_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;SPECIMEN_LOCAL_CODE&rcub;&rcub;</strong>"
            "assigner": {
                "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;ORGANIZATION_IHS_NUMBER&rcub;&rcub;</strong>"
            }
        }
    ],
    "status": "available",
    "type": {
        "coding":  [
            {
                "system": "<strong style="color:#00a7ff">&lcub;&lcub;SPECIMEN_TYPE&rcub;&rcub;</strong>",
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;SPECIMEN_TYPE&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;SPECIMEN_TYPE&rcub;&rcub;</strong>"
            }
        ]
    },
    "collection": {
        "method": {
            "coding":  [
                {
                "system": "<strong style="color:#00a7ff">&lcub;&lcub;SPECIMEN_METHOD&rcub;&rcub;</strong>",
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;SPECIMEN_METHOD&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;SPECIMEN_METHOD&rcub;&rcub;</strong>"
            }
            ]
        },
        "collectedDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;SPECIMEN_COLLECTION_DATE&rcub;&rcub;</strong>"
    },
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>"
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "request":  [
        {
            "reference": "ServiceRequest/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_SERVICEREQUEST&rcub;&rcub;</strong>"
        }
    ],
    "receivedTime": "<strong style="color:#00a7ff">&lcub;&lcub;SPECIMEN_RECEIVED_DATE&rcub;&rcub;</strong>"
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-6-2" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__    | ID organisasi induk yang didapatkan dari master sarana indeks |
| __SPECIMEN_LOCAL_CODE__   | Berisi data id lokal dari masing-masing institusi terkait spesimen |
| __SPECIMEN_TYPE__      			| Berisi data jenis spesimen dengan tipe data CodeableConcept, yang nilainya mengacu pada kode SNOMED-CT yang tersedia dalam Global Patient Set. Referensi ke value set "Jenis Spesimen" |
| __SPECIMEN_METHOD__   | Berisi data kode yang menspesifikan teknik pengambilan spesimen. Referensi ke value set "Metode Pengambilan Spesimen" |
| __SPECIMEN_COLLECTION_DATE__   | Berisi data waktu diambilnya spesimen. |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __PATIENT_NAME__      			| Nama pasien |
| __ID_RESOURCE_SERVICEREQUEST__      		| &lcub;id-resource-ServiceRequest&rcub; pada SATUSEHAT untuk data ServiceRequest |
| __SPECIMEN_COLLECTION_DATE__   | Berisi data kapan spesimen diterima oleh laboratorium dengan tipe data dateTime, dengan format yang diperbolehkan YYYY-MM-DDThh:mm:ss+zz:zz. |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-6-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>a. Lampiran terminologi "Permintaan Lab" dapat diakses di <a href="https://docs.google.com/spreadsheets/d/1pitXlFTGFnvWapll8_IHfyJpPb-Vl495/edit?usp=sharing&ouid=102706494438870645457&rtpof=true&sd=true">portal SATUSEHAT</a></div>

<div>b. Metode Pengambilan Spesimen
<table class="table-fhir-resources" style="table-layout: fixed; width: 100%">
    <tr>
        <th style="width: 5%">No.</th>
        <th>Specimen.collection.method.coding.code</th>
        <th>Specimen.collection.method.coding.display</th>
        <th>Specimen.collection.method.coding.system</th>
    </tr>
    <tr>
        <td>1</td>
        <td>129304002</td>
        <td>Excision - action</td>
        <td>http://snomed.info/sct</td>
    </tr>
    <tr>
        <td>2</td>
        <td>129323009</td>
        <td>Scraping - action</td>
        <td>http://snomed.info/sct</td>
    </tr>
    <tr>
        <td>3</td>
        <td>129316008</td>
        <td>Aspiration - action</td>
        <td>http://snomed.info/sct</td>
    </tr>
    <tr>
        <td>4</td>
        <td>129314006</td>
        <td>Biopsy - action</td>
        <td>http://snomed.info/sct</td>
    </tr>
    <tr>
        <td>5</td>
        <td>129300006</td>
        <td>Puncture - action</td>
        <td>http://snomed.info/sct</td>
    </tr>
    <tr>
        <td>6</td>
        <td>82078001</td>
        <td>Collection of blood specimen for laboratory</td>
        <td>http://snomed.info/sct</td>
    </tr>
    <tr>
        <td>7</td>
        <td>225113003</td>
        <td>Timed urine collection</td>
        <td>http://snomed.info/sct</td>
    </tr>
    <tr>
        <td>8</td>
        <td>386089008</td>
        <td>Collection of coughed sputum</td>
        <td>http://snomed.info/sct</td>
    </tr>
    <tr>
        <td>9</td>
        <td>713143008</td>
        <td>Collection of arterial blood specimen</td>
        <td>http://snomed.info/sct</td>
    </tr>
    <tr>
        <td>10</td>
        <td>1048003</td>
        <td>Capillary specimen collection</td>
        <td>http://snomed.info/sct</td>
    </tr>
    <tr>
        <td>11</td>
        <td>70777001</td>
        <td>Urine specimen collection, catheterized</td>
        <td>http://snomed.info/sct</td>
    </tr>
    <tr>
        <td>12</td>
        <td>73416001</td>
        <td>Urine specimen collection, clean catch</td>
        <td>http://snomed.info/sct</td>
    </tr>
    <tr>
        <td>13</td>
        <td>243776001</td>
        <td>Blood sampling from extracorporeal blood circuit</td>
        <td>http://snomed.info/sct</td>
    </tr>
    <tr>
        <td>14</td>
        <td>278450005</td>
        <td>Finger-prick sampling</td>
        <td>http://snomed.info/sct</td>
    </tr>
    <tr>
        <td>15</td>
        <td>285570007</td>
        <td>Taking of swab</td>
        <td>http://snomed.info/sct</td>
    </tr>
</table></div>
        </div>
    </div>
<br>
<!--END Part 8-1-2-->

<!--Part 8-1-3 Variable Data Hasil Pemeriksaan Penunjang Laboratorium-->
<h4 style="font-weight: bold;"> Data Hasil Pemeriksaan Penunjang Laboratorium</h4>
<div>
Hasil pemeriksaan penunjang dapat dikirimkan menggunakan resource Observation. Berikut adalah ketentuan pengisian data hasil pemeriksaan laboratorium melalui resource Observation:<br>
<ol type="a">
<li>Kode LOINC atau kode Pemeriksaan Penunjang Nasional digunakan pada elemen Observation.code untuk merepresentasikan nama pemeriksaan yang dihasilkan. Referensi pemetaan pemeriksaan laboratorium dengan kode LOINC dapat dilihat melalui kode LOINC. Gunakan parameter pemeriksaan dengan kategori “Hasil” atau “Permintaan & Hasil” pada file Terminologi Laboratorium ketika mengirimkan data melalui resource Observation.</li>

<li>Elemen Observation.category.coding diisi dengan kode laboratory.</li>

<li>Pemilihan elemen `Observation.value[x]` disesuaikan dengan Tipe hasil pemeriksaan laboratorium.
<ol type="i">
<li>Observation.valueCodeableConcept untuk tipe hasil Nominal</li>
<li>Observation.valueCodeableConcept untuk tipe hasil Ordinal</li>
<li>Observation.valueQuantity untuk tipe hasil Kuantitatif/Quantitative</li>
<li>Observation.valueString untuk tipe hasil Naratif/Narrative</li>
</ol>
</li>

<li>Elemen Observation.referenceRange direkomendasikan untuk selalu diisikan guna mempermudah interpretasi hasil laboratorium oleh tenaga kesehatan lainnya. Nilai normal yang dicantumkan disesuaikan dengan nilai normal yang ada dimasing-masing laboratorium berdasarkan alat maupun reagen yang tersedia.</li>
</ol>

Satu payload atau satu record dari resource Observation hanya dapat digunakan untuk 1 kode hasil parameter laboratorium. Sehingga, apabila terdapat 2 hasil laboratorium, sebagai contoh hasil pemeriksaan hemoglobin dan hematokrit, maka perlu mengirimkan 2 payload di mana 1 payload berisi 1 kode pemeriksaan hemoglobin dan 1 payload berisi kode pemeriksaan hematokrit.
</div>

<div>Pemeriksaan BTA</div>
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-6-3" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-6-3" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-6-3" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-6-3" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-6-3">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Observation-Create-Hasil-Lab-Sputum-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-6-3" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "identifier":  [
        {
            "system": "http://sys-ids.kemkes.go.id/servicerequest/<strong style="color:#00a7ff">&lcub;&lcub;ORGANIZATION_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_LOCAL_CODE&rcub;&rcub;</strong>"
    }
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
                "system": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_CODE&rcub;&rcub;</strong>",
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_CODE&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_CODE&rcub;&rcub;</strong>"
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
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        },
        {
            "reference": "<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_NAME&rcub;&rcub;</strong>"
        }
    ],
    "specimen": {
        "reference": "Specimen/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_SPECIMEN&rcub;&rcub;</strong>"
    },
    "basedOn":  [
        {
            "reference": "ServiceRequest/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_SERVICEREQUEST&rcub;&rcub;</strong>"
        }
    ],
    "valueCodeableConcept": {
        "coding": [
            {
                "system": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>"
            }
        ]
    }
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-6-3" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __OBSERVATION_CODE__          		|__(*)__ Jenis Pemeriksaan Lab. Referensi ke value set "Lampiran Terminologi Laboratorium" |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __PRACTITIONER_Name__    				| Nama dokter |
| __ID_RESOURCE_SPECIMEN__    				|  &lcub;id-resource-Specimen&rcub; pada SATUSEHAT |
| __ID_RESOURCE_SERVICEREQUEST__    				|  &lcub;id-resource-ServiceRequest&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		|__(*)__ Nilai observasi. Referensi ke value set "Lampiran Terminologi Laboratorium" |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-6-3" style="border: 1px solid #e8edee; padding: 15px 10px;">
Lampiran Terminologi Laboratorium dapat diakses di <a href="https://satusehat.kemkes.go.id/platform/docs/id/terminology/loinc/laboratory/lampiran/">portal SATUSEHAT</a>
        </div>
    </div>
<br>
<!--END Part 8-1-3-->

<!--Part 8-1-4 Variable Data Laporan Pemeriksaan Penunjang Laboratorium-->
<h4 style="font-weight: bold;">Laporan Pemeriksaan Penunjang Laboratorium</h4>
<div>

Laporan hasil pemeriksaan akan dikirimkan melalui resource DiagnosticReport. Berikut adalah ketentuan pengisian laporan pemeriksaan penunjang laboratorium melalui _resource_ `DiagnosticReport`:

a. Data di resource DiagnosticReport akan mereferensi ke hasil pemeriksaan laboratorium terkait pada resource Observation melalui DiagnosticReport.result, spesimen terkait pada resource Specimen melalui DiagnosticReport.specimen, dan permintaan pemeriksaan penunjang terkait pada resource ServiceRequest melalui DiagnosticReport.basedOn.
b. Kode LOINC atau kode Pemeriksaan Penunjang Nasional digunakan pada elemen DiagnosticReport.code untuk merepresentasikan nama pemeriksaan yang dilaporkan. Referensi pemetaan parameter laboratorium ke kode LOINC dapat dilihat melalui kode LOINC. Gunakan parameter pemeriksaan dengan kategori “Permintaan” atau “Permintaan & Hasil” pada file Terminologi Laboratorium melalui resource DiagnosticReport.
c. Kode yang dicantumkan dalam DiagnosticReport.code akan sama dengan kode yang dicantumkan pada ServiceRequest.code terkait.

Satu payload atau satu record dari resource DiagnosticReport hanya dapat digunakan untuk 1 kode/laporan parameter laboratorium. Sehingga, apabila dilakukan permintaan 2 parameter laboratorium, sebagai contoh panel elektrolit dan hemoglobin, maka perlu mengirimkan 2 payload laporan melalui resource DiagnosticReport di mana 1 payload berisi 1 kode panel elektrolit dan 1 payload berisi kode parameter hemoglobin.
</div>

<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-6-4" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-6-4" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-6-4" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-6-4" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-6-4">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-DiagnosticReport-Report-Lab-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-6-4" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "DiagnosticReport",
    "identifier":  [
        {
            "system": "http://sys-ids.kemkes.go.id/diagnostic/<strong style="color:#00a7ff">&lcub;&lcub;ORGANIZATION_IHS_NUMBER&rcub;&rcub;</strong>/lab",
            "use": "official",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;DIAGNOSTIC_LOCAL_CODE&rcub;&rcub;</strong>"
        }
    ],
    "status": "final",
    "category":  [
        {
            "coding":  [
                {
                "system": "<strong style="color:#00a7ff">&lcub;&lcub;DIAGNOSTIC_CATEGORY&rcub;&rcub;</strong>",
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;DIAGNOSTIC_CATEGORY&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;DIAGNOSTIC_CATEGORY&rcub;&rcub;</strong>"
                },
                {
                    "system": "http://terminology.hl7.org/CodeSystem/v2-0074",
                    "code": "LAB",
                    "display": "Laboratory"
                }
            ]
        }
    ],
    "code": {
        "coding":  [
            {
                "system": "<strong style="color:#00a7ff">&lcub;&lcub;DIAGNOSTIC_TYPE&rcub;&rcub;</strong>",
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;DIAGNOSTIC_TYPE&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;DIAGNOSTIC_TYPE&rcub;&rcub;</strong>"
                }
        ]
    },
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>"
    },
    "encounter": {
        "reference": "Encounter/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_ENCOUNTER&rcub;&rcub;</strong>"
    },
    "effectiveDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;DIAGNOSTIC_EFFECTIVE_DATETIME&rcub;&rcub;</strong>",
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;DIAGNOSTIC_ISSUED&rcub;&rcub;</strong>",
    "performer":  [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
        {
            "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;ORGANIZATION_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "result":  [
        {
            "reference": "Observation/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_OBSERVATION&rcub;&rcub;</strong>"
        }
    ],
    "specimen":  [
        {
            "reference": "Specimen/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_SPECIMEN&rcub;&rcub;</strong>"
        }
    ],
    "basedOn":  [
        {
            "reference": "ServiceRequest/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_SERVICEREQUEST&rcub;&rcub;</strong>"
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-6-4" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __DIAGNOSTIC_LOCAL_CODE__    		| ID Lokal untuk Report Lab  |
| __DIAGNOSTIC_CATEGORY__          		|__(*)__ Kategori Pemeriksaan Lab. Referensi ke value set "Kategori DiagnosticReport" |
| __DIAGNOSTIC_TYPE__          		|__(*)__  Jenis Laporan Pemeriksaan Lab. Referensi ke value set "Lampiran Terminologi Laboratorium" |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __DIAGNOSTIC_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __DIAGNOSTIC_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __ID_RESOURCE_OBSERVATION__      		| &lcub;id-resource-Observation&rcub; pada SATUSEHAT untuk data hasil pemeriksaan lab |
| __ID_RESOURCE_SPECIMEN__    				|  &lcub;id-resource-Specimen&rcub; pada SATUSEHAT |
| __ID_RESOURCE_SERVICEREQUEST__    				|  &lcub;id-resource-ServiceRequest&rcub; pada SATUSEHAT |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-6-4" style="border: 1px solid #e8edee; padding: 15px 10px;">
Lampiran Terminologi Laboratorium dapat diakses di <a href="https://satusehat.kemkes.go.id/platform/docs/id/terminology/loinc/laboratory/lampiran/">portal SATUSEHAT</a><br>

Kategori DiagnosticReport
<table class="table-fhir-resources" style="table-layout: fixed; width: 100%">
    <tr>
        <th style="width: 5%">No.</th>
        <td>DiagnosticReport.category.coding.system</td>
        <td>DiagnosticReport.category.coding.code</td>
        <td>DiagnosticReport.category.coding.display</td>
    </tr>
    <tr>
        <td>1</td>
        <td>AU</td>
        <td>Audiology</td>
        <td>http://terminology.hl7.org/CodeSystem/v2-0074</td>
    </tr>
    <tr>
        <td>2</td>
        <td>BG</td>
        <td>Blood Gases</td>
        <td>http://terminology.hl7.org/CodeSystem/v2-0074</td>
    </tr>
    <tr>
        <td>3</td>
        <td>BLB</td>
        <td>Blood Bank</td>
        <td>http://terminology.hl7.org/CodeSystem/v2-0074</td>
    </tr>
    <tr>
        <td>4</td>
        <td>CG</td>
        <td>Cytogenetics</td>
        <td>http://terminology.hl7.org/CodeSystem/v2-0074</td>
    </tr>
    <tr>
        <td>5</td>
        <td>CH</td>
        <td>Chemistry</td>
        <td>http://terminology.hl7.org/CodeSystem/v2-0074</td>
    </tr>
    <tr>
        <td>6</td>
        <td>CP</td>
        <td>Cytopathology</td>
        <td>http://terminology.hl7.org/CodeSystem/v2-0074</td>
    </tr>
    <tr>
        <td>7</td>
        <td>CT</td>
        <td>CAT Scan</td>
        <td>http://terminology.hl7.org/CodeSystem/v2-0074</td>
    </tr>
    <tr>
        <td>8</td>
        <td>CTH</td>
        <td>Cardiac Catheterization</td>
        <td>http://terminology.hl7.org/CodeSystem/v2-0074</td>
    </tr>
    <tr>
        <td>9</td>
        <td>CUS</td>
        <td>Cardiac Ultrasound</td>
        <td>http://terminology.hl7.org/CodeSystem/v2-0074</td>
    </tr>
    <tr>
        <td>10</td>
        <td>EC</td>
        <td>Electrocardiac (e.g., EKG, EEC, Holter)</td>
        <td>http://terminology.hl7.org/CodeSystem/v2-0074</td>
    </tr>
    <tr>
        <td>11</td>
        <td>EN</td>
        <td>Electroneuro (EEG, EMG,EP,PSG)</td>
        <td>http://terminology.hl7.org/CodeSystem/v2-0074</td>
    </tr>
    <tr>
        <td>12</td>
        <td>GE</td>
        <td>Genetics</td>
        <td>http://terminology.hl7.org/CodeSystem/v2-0074</td>
    </tr>
    <tr>
        <td>13</td>
        <td>HM</td>
        <td>Hematology</td>
        <td>http://terminology.hl7.org/CodeSystem/v2-0074</td>
    </tr>
    <tr>
        <td>14</td>
        <td>ICU</td>
        <td>Bedside ICU Monitoring</td>
        <td>http://terminology.hl7.org/CodeSystem/v2-0074</td>
    </tr>
    <tr>
        <td>15</td>
        <td>IMM</td>
        <td>Immunology</td>
        <td>http://terminology.hl7.org/CodeSystem/v2-0074</td>
    </tr>
    <tr>
        <td>16</td>
        <td>LAB</td>
        <td>Laboratory</td>
        <td>http://terminology.hl7.org/CodeSystem/v2-0074</td>
    </tr>
    <tr>
        <td>17</td>
        <td>MB</td>
        <td>Microbiology</td>
        <td>http://terminology.hl7.org/CodeSystem/v2-0074</td>
    </tr>
    <tr>
        <td>18</td>
        <td>MCB</td>
        <td>Mycobacteriology</td>
        <td>http://terminology.hl7.org/CodeSystem/v2-0074</td>
    </tr>
    <tr>
        <td>19</td>
        <td>MYC</td>
        <td>Mycology</td>
        <td>http://terminology.hl7.org/CodeSystem/v2-0074</td>
    </tr>
    <tr>
        <td>20</td>
        <td>NMR</td>
        <td>Nuclear Magnetic Resonance</td>
        <td>http://terminology.hl7.org/CodeSystem/v2-0074</td>
    </tr>
    <tr>
        <td>21</td>
        <td>NMS</td>
        <td>Nuclear Medicine Scan</td>
        <td>http://terminology.hl7.org/CodeSystem/v2-0074</td>
    </tr>
    <tr>
        <td>22</td>
        <td>NRS</td>
        <td>Nursing Service Measures</td>
        <td>http://terminology.hl7.org/CodeSystem/v2-0074</td>
    </tr>
    <tr>
        <td>23</td>
        <td>OSL</td>
        <td>Outside Lab</td>
        <td>http://terminology.hl7.org/CodeSystem/v2-0074</td>
    </tr>
    <tr>
        <td>24</td>
        <td>OT</td>
        <td>Occupational Therapy</td>
        <td>http://terminology.hl7.org/CodeSystem/v2-0074</td>
    </tr>
    <tr>
        <td>25</td>
        <td>OTH</td>
        <td>Other</td>
        <td>http://terminology.hl7.org/CodeSystem/v2-0074</td>
    </tr>
    <tr>
        <td>26</td>
        <td>OUS</td>
        <td>OB Ultrasound</td>
        <td>http://terminology.hl7.org/CodeSystem/v2-0074</td>
    </tr>
    <tr>
        <td>27</td>
        <td>PF</td>
        <td>Pulmonary Function</td>
        <td>http://terminology.hl7.org/CodeSystem/v2-0074</td>
    </tr>
    <tr>
        <td>28</td>
        <td>PHR</td>
        <td>Pharmacy</td>
        <td>http://terminology.hl7.org/CodeSystem/v2-0074</td>
    </tr>
    <tr>
        <td>29</td>
        <td>PHY</td>
        <td>Physician (Hx. Dx, admission note, etc.)</td>
        <td>http://terminology.hl7.org/CodeSystem/v2-0074</td>
    </tr>
    <tr>
        <td>30</td>
        <td>PT</td>
        <td>Physical Therapy</td>
        <td>http://terminology.hl7.org/CodeSystem/v2-0074</td>
    </tr>
    <tr>
        <td>31</td>
        <td>RAD</td>
        <td>Radiology</td>
        <td>http://terminology.hl7.org/CodeSystem/v2-0074</td>
    </tr>
    <tr>
        <td>32</td>
        <td>RC</td>
        <td>Respiratory Care (therapy)</td>
        <td>http://terminology.hl7.org/CodeSystem/v2-0074</td>
    </tr>
    <tr>
        <td>33</td>
        <td>RT</td>
        <td>Radiation Therapy</td>
        <td>http://terminology.hl7.org/CodeSystem/v2-0074</td>
    </tr>
    <tr>
        <td>34</td>
        <td>RUS</td>
        <td>Radiology Ultrasound</td>
        <td>http://terminology.hl7.org/CodeSystem/v2-0074</td>
    </tr>
    <tr>
        <td>35</td>
        <td>RX</td>
        <td>Radiograph</td>
        <td>http://terminology.hl7.org/CodeSystem/v2-0074</td>
    </tr>
    <tr>
        <td>36</td>
        <td>SP</td>
        <td>Surgical Pathology</td>
        <td>http://terminology.hl7.org/CodeSystem/v2-0074</td>
    </tr>
    <tr>
        <td>37</td>
        <td>SR</td>
        <td>Serology</td>
        <td>http://terminology.hl7.org/CodeSystem/v2-0074</td>
    </tr>
    <tr>
        <td>38</td>
        <td>TX</td>
        <td>Toxicology</td>
        <td>http://terminology.hl7.org/CodeSystem/v2-0074</td>
    </tr>
    <tr>
        <td>39</td>
        <td>VR</td>
        <td>Virology</td>
        <td>http://terminology.hl7.org/CodeSystem/v2-0074</td>
    </tr>
    <tr>
        <td>40</td>
        <td>VUS</td>
        <td>Vascular Ultrasound</td>
        <td>http://terminology.hl7.org/CodeSystem/v2-0074</td>
    </tr>
    <tr>
        <td>41</td>
        <td>XRC</td>
        <td>Cineradiograph</td>
        <td>http://terminology.hl7.org/CodeSystem/v2-0074</td>
    </tr>
</table>
</div>
</div>
<br>
<!--END Part 8-1-4-->
</div>
<!--END Part 8-1-->

<!--Part 8-2-->
<h4>8.2. Radiologi</h4>
<div style="margin-left: 30px;">

<!--Part 8-2-1-->
<h4 style="font-weight: bold;">Permintaan Pemeriksaan Radiologi - USG</h4>
    
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-8-2-1" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-8-2-1" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-8-2-1" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-8-2-1" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-8-2-1">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-ServiceRequest-Create-PermintaanPenunjang-Rad-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-8-2-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "ServiceRequest",
    "identifier":  [
        {
            "system": "urn:dicom:uid",
            "value": "urn:oid:<strong style="color:#00a7ff">&lcub;&lcub;DICOM_UID&rcub;&rcub;</strong>"
        },
        {
            "system": "http://sys-ids.kemkes.go.id/servicerequest/<strong style="color:#00a7ff">&lcub;&lcub;ORGANIZATION_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;SERVICEREQUEST_LOCAL_CODE&rcub;&rcub;</strong>"
        },
        {
            "use": "usual",
            "type": {
                "coding":  [
                    {
                        "system": "http://terminology.hl7.org/CodeSystem/v2-0203",
                        "code": "ACSN"
                    }
                ]
            },
            "system": "http://sys-ids.kemkes.go.id/acsn/<strong style="color:#00a7ff">&lcub;&lcub;ORGANIZATION_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;SERVICEREQUEST_ACCESSION_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "contained":  [
        {
            "resourceType": "Patient",
            "id": "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>",
            "identifier":  [
                {
                    "system": "http://sys-ids.kemkes.go.id/mrn/<strong style="color:#00a7ff">&lcub;&lcub;ORGANIZATION_IHS_NUMBER&rcub;&rcub;</strong>",
                    "value": ""reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_MRN_LOCAL&rcub;&rcub;</strong>""
                }
            ],
            "active": true,
            "name":  [
                {
                    "use": "official",
                    "text": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
                }
            ],
            "gender": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_GENDER&rcub;&rcub;</strong>",
            "birthDate": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_DOB&rcub;&rcub;</strong>"
        }
    ],
    "status": "active",
    "intent": "original-order",
    "priority": "routine",
    "code": {
        "coding":  [
            {
                "system": "http://loinc.org",
                "code": "11525-3",
                "display": "US for pregnancy"
            }
        ],
        "text": "Pemeriksaan USG"
    },"orderDetail":  [
        {
            "coding":  [
                {
                    "system": "http://dicom.nema.org/resources/ontology/DCM",
                    "code": "US"
                }
            ],
            "text": "Modality Code: US"
        },
        {
            "coding":  [
                {
                    "system": "http://sys-ids.kemkes.go.id/ae-title",
                    "display": "<strong style="color:#00a7ff">&lcub;&lcub;DICOM_AE_TITLE&rcub;&rcub;</strong>"
                }
            ]
        }
    ],
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>"
    },
    "encounter": {
        "reference": "Encounter/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_ENCOUNTER&rcub;&rcub;</strong>"
    },
    "occurrenceDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;SERVICEREQUEST_OCCUR&rcub;&rcub;</strong>",
    "requester": {
        "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER1&rcub;&rcub;</strong>",
                "display": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_NAME1&rcub;&rcub;</strong>"
    },
    "performer":  [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER2&rcub;&rcub;</strong>",
                "display": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_NAME2&rcub;&rcub;</strong>"
        }
    ],
    "reasonCode":  [
        {
            "text": "<strong style="color:#00a7ff">&lcub;&lcub;SERVICEREQUEST_REASON&rcub;&rcub;</strong>"
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-8-2-1" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __DICOM_UID__    | Kode Study Unique Identifiers (UIDs) dari gambar DICOM |
| __ORGANIZATION_IHS_NUMBER__    | ID organisasi induk yang didapatkan dari master sarana indeks |
| __SERVICEREQUEST_LOCAL_CODE__   | Berisi data id lokal dari masing-masing institusi terkait tindak lanjut |
| __SERVICEREQUEST_ACCESSION_NUMBER__   | merupakan nomor untuk mengidentifikasi urutan permintaan/order dari study. Nomor ini selalu unik untuk setiap permintaan yang di fasyankes tersebut.  |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __PATIENT_MRN_LOCAL__      			| Nomor rekam medis pasien di internal fasker |
| __PATIENT_NAME__      			| Nama pasien |
| __PATIENT_GENDER__      			| Jenis kelamin pasien |
| __PATIENT_DOB__      			| Tanggal lahir pasien |
| __DICOM_AE_TITLE__      			| Kode "Application Entity Title" pada modality/ alat radiologi yang secara unik mengidentifikasi sebuah layanan atau aplikasi pada sistem tertentu dalam jaringan. Judul Entitas Aplikasi tidak bergantung pada topologi jaringan sehingga perangkat dapat dipindahkan secara fisik saat Appli terkait |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __SERVICEREQUEST_OCCUR__      		| Berisi data informasi kapan kontrol harus terlaksana dengan tipe data dateTime, dengan format yang diperbolehkan YYYY-MM-DDThh:mm:ss+zz:zz.|
| __PRACTITIONER_IHS_NUMBER1__    				| Berisi data siapa yang melakukan permintaan, merujuk ke &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __PRACTITIONER_NAME1__   			| Nama dokter yang melakukan permintaan|
| __PRACTITIONER_IHS_NUMBER2__    				| Berisi satu atau lebih data siapa yang diharapkan melakukan permintaan, merujuk ke &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __PRACTITIONER_NAME2__   			| Nama dokter yang diharapkan melakukan permintaan |
| __SERVICEREQUEST_REASON__      		| Berisi data yang berkaitan dengan penjelasan atau justifikasi mengenai mengapa pelayanan ini diminta dalam bentuk teks (free-text)|

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-8-2-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
            <div>
                [none]
            </div>
        </div>
    </div>
<br>
<!--END Part 8-2-1-->

<!--Part 8-2-2-->
<h4 style="font-weight: bold;">Hasil Gambar Radiologi</h4>
<p>Pada tahap ini, akan terjadi proses GET data hasil gambar radiologi yang disimpan dalam resource ImagingStudy. Resource ImagingStudy akan terbentuk pada saat pengiriman gambar hasil radiologi dalam format DICOM yang dikirimkan oleh DICOM router. Setelah mendapatkan file DICOM dari PACS, DICOM router akan mengirimkan file tersebut ke National Imaging Data Repository (NIDR). NIDR akan mengembalikan WADO URL yang nantinya dapat digunakan untuk melihat hasil gambar radiologi yang telah tersimpan di NIDR. DICOM router kemudian akan melakukan POST informasi terkait DICOM melalui resource ImagingStudy ke SATUSEHAT. SATUSEHAT akan merespon dengan mengembalikan ImagingStudy.id ke DICOM Router. ImagingStudy.id ini yang perlu disimpan dan akan direferensikan ketika pada saat pengiriman data bacaan atau ekspertise dari hasil pemeriksaan radiologi.</p>

> `CATATAN:`
>  Untuk penjelasan detail terkait pengiriman hasil gambar radiologi menggunakan DICOM Router ke SATUSEHAT dapat dilihat dalam <a href="https://satusehat.kemkes.go.id/platform/docs/id/dicom-system/" target="_blank"> SATUSEHAT Portal - Sistem DICOM</a>.
<br>
<br>
<!--END Part 8-2-2-->

<!--Part 8-2-3-->
<h4 style="font-weight: bold;">Hasil Temuan Radiologi</h4>
<p>Hasil-hasil temuan radiologis yang diidentifikasi dari pemeriksaan radiologis dapat dikirimkan dengan resource Observation, sedangkan hasil pemeriksaan lengkap dari ,pemeriksaan radiologis tersebut dapat dikirimkan dengan resource DiagnosticReport. Sebagai contoh, pemeriksaan radiologi memperlihatkan adanya konsolidasi paru dan tanda fibrosis pada paru seorang pasien yang dicurigai dengan tuberkulosis. Setelah itu, dokter ahli radiologi menuliskan ekspertise radiologis. Dalam kasus ini, hasil temuan konsolidasi dan tanda fibrosis dikirimkan dengan resource Observation, sedangkan ekspertise radiologis tersebut dapat dikirimkan dengan resource DiagnosticReport.</p>


<div style="margin-left: 30px;">
<div>Gestational Sac (GS) Diameter</div>
<!--Part 8-2-3-0-->
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-8-2-3-0" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-8-2-3-0" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-8-2-3-0" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-8-2-3-0" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-8-2-3-0">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Observation-Create-USG-Gestational-sac-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-8-2-3-0" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "imaging",
                    "display": "Imaging"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://loinc.org",
                "code": "11850-5",
                "display": "Gestational sac Mean diameter US"
            },
            {
                "system": "http://terminology.kemkes.go.id/CodeSystem/anc-custom-codes",
                "code": "ANC.SS.DE36",
                "display": "Gestational sac (GS) USG"
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
    "effectiveDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_EFFECTIVE_DATETIME&rcub;&rcub;</strong>",
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueQuantity": {
        "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
        "unit": "cm",
        "system": "http://unitsofmeasure.org",
        "code": "cm"
    },
    "basedOn":  [
        {
            "reference": "ServiceRequest/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_SERVICEREQUEST&rcub;&rcub;</strong>"
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-8-2-3-0" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __PATIENT_NAME__      			| Nama pasien |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi |
| __ID_RESOURCE_SERVICEREQUEST__ | &lcub;id-resource-ServiceRequest&rcub; pada SATUSEHAT |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-8-2-3-0" style="border: 1px solid #e8edee; padding: 15px 10px;">
            <div>
                [none]
            </div>
        </div>
    </div>
<br>
<!--END Part 8-2-3-0-->

<div>Crown Rump Length (CRL)</div>
<!--Part 8-2-3-1-->
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-8-2-3-1" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-8-2-3-1" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-8-2-3-1" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-8-2-3-1" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-8-2-3-1">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Observation-Create-USG-Fetal-Crown-Rump-Length-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-8-2-3-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "imaging",
                    "display": "Imaging"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://loinc.org",
                "code": "11957-8",
                "display": "Fetal Crown Rump length US"
            },
            {
                "system": "http://terminology.kemkes.go.id/CodeSystem/anc-custom-codes",
                "code": "ANC.SS.DE37",
                "display": "Fetal Crown Rump Length (CRL) USG"
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
    "effectiveDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_EFFECTIVE_DATETIME&rcub;&rcub;</strong>",
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueQuantity": {
        "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
        "unit": "cm",
        "system": "http://unitsofmeasure.org",
        "code": "cm"
    },
    "basedOn":  [
        {
            "reference": "ServiceRequest/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_SERVICEREQUEST&rcub;&rcub;</strong>"
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-8-2-3-1" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __PATIENT_NAME__      			| Nama pasien |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi |
| __ID_RESOURCE_SERVICEREQUEST__ | &lcub;id-resource-ServiceRequest&rcub; pada SATUSEHAT |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-8-2-3-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
            <div>
                [none]
            </div>
        </div>
    </div>
<br>
<!--END Part 8-2-3-1-->

<div>Denyut Jantung Janin (DJJ)</div>
<!--Part 8-2-3-2-->
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-8-2-3-2" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-8-2-3-2" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-8-2-3-2" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-8-2-3-2" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-8-2-3-2">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Observation-Create-Denyut-Jantung-Janin-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-8-2-3-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "imaging",
                    "display": "Imaging"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://loinc.org",
                "code": "11948-7",
                "display": "Fetal Heart rate US"
            },
            {
                "system": "http://terminology.kemkes.go.id/CodeSystem/anc-custom-codes",
                "code": "ANC.SS.DE38",
                "display": "Denyut Jantung Janin (DJJ) USG"
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
    "effectiveDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_EFFECTIVE_DATETIME&rcub;&rcub;</strong>",
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueQuantity": {
        "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
        "unit": "beats/minute",
        "system": "http://unitsofmeasure.org",
        "code": "/min"
    },
    "basedOn":  [
        {
            "reference": "ServiceRequest/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_SERVICEREQUEST&rcub;&rcub;</strong>"
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-8-2-3-2" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __PATIENT_NAME__      			| Nama pasien |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi |
| __ID_RESOURCE_SERVICEREQUEST__ | &lcub;id-resource-ServiceRequest&rcub; pada SATUSEHAT |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-8-2-3-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
            <div>
                [none]
            </div>
        </div>
    </div>
<br>
<!--END Part 8-2-3-2-->

<div>Usia Kehamilan - USG</div>
<!--Part 8-2-3-3-->
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-8-2-3-3" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-8-2-3-3" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-8-2-3-3" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-8-2-3-3" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-8-2-3-3">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Observation-Create-Gestational-Age-Week-2}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-8-2-3-3" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "imaging",
                    "display": "Imaging"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://loinc.org",
                "code": "11888-5",
                "display": "Gestational age US composite estimate"
            },
            {
                "system": "http://fhir.org/guides/who/anc-cds/CodeSystem/anc-custom-codes",
                "code": "ANC.B6.DE20",
                "display": "Ultrasound"
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
    "effectiveDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_EFFECTIVE_DATETIME&rcub;&rcub;</strong>",
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueQuantity": {
        "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
        "unit": "wk",
        "system": "http://unitsofmeasure.org",
        "code": "wk"
    },
    "basedOn":  [
        {
            "reference": "ServiceRequest/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_SERVICEREQUEST&rcub;&rcub;</strong>"
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-8-2-3-3" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __PATIENT_NAME__      			| Nama pasien |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi |
| __ID_RESOURCE_SERVICEREQUEST__ | &lcub;id-resource-ServiceRequest&rcub; pada SATUSEHAT |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-8-2-3-3" style="border: 1px solid #e8edee; padding: 15px 10px;">
            <div>
                [none]
            </div>
        </div>
    </div>
<br>
<!--END Part 8-2-3-3-->

<div>Hari Perkiraan Lahir - USG</div>
<!--Part 8-2-3-4-->
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-8-2-3-4" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-8-2-3-4" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-8-2-3-4" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-8-2-3-4" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-8-2-3-4">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Observation-Create-Hari-Perkiraan-Lahir-USG-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-8-2-3-4" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "imaging",
                    "display": "Imaging"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://loinc.org",
                "code": "11781-2",
                "display": "Delivery date US composite estimate"
            },
            {
                "system": "http://terminology.kemkes.go.id/CodeSystem/anc-custom-codes",
                "code": "ANC.SS.DE40",
                "display": "Hari Perkiraan Lahir (HPL) USG"
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
    "effectiveDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_EFFECTIVE_DATETIME&rcub;&rcub;</strong>",
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
    "basedOn":  [
        {
            "reference": "ServiceRequest/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_SERVICEREQUEST&rcub;&rcub;</strong>"
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-8-2-3-4" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __PATIENT_NAME__      			| Nama pasien |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi |
| __ID_RESOURCE_SERVICEREQUEST__ | &lcub;id-resource-ServiceRequest&rcub; pada SATUSEHAT |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-8-2-3-4" style="border: 1px solid #e8edee; padding: 15px 10px;">
            <div>
                [none]
            </div>
        </div>
    </div>
<br>
<!--END Part 8-2-3-4-->

<div>Letak Janin</div>
<!--Part 8-2-3-5-->
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-8-2-3-5" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-8-2-3-5" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-8-2-3-5" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-8-2-3-5" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-8-2-3-5">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Observation-Create-Letak-Janin-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-8-2-3-5" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "imaging",
                    "display": "Imaging"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://terminology.kemkes.go.id/CodeSystem/clinical-term",
                "code": "OC000004",
                "display": "Letak Janin (USG)"
            },
            {
                "system": "http://terminology.kemkes.go.id/CodeSystem/anc-custom-codes",
                "code": "ANC.SS.DE41",
                "display": "Letak Janin USG"
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
    "effectiveDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_EFFECTIVE_DATETIME&rcub;&rcub;</strong>",
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    
    "valueCodeableConcept": {
        "coding": [
            {
                "system": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>"
            }
        ]
    },
    "basedOn":  [
        {
            "reference": "ServiceRequest/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_SERVICEREQUEST&rcub;&rcub;</strong>"
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-8-2-3-5" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __PATIENT_NAME__      			| Nama pasien |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| __(*)__ Nilai observasi. Referensi ke value set "Letak janin" |
| __ID_RESOURCE_SERVICEREQUEST__ | &lcub;id-resource-ServiceRequest&rcub; pada SATUSEHAT |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-8-2-3-5" style="border: 1px solid #e8edee; padding: 15px 10px;">
Letak janin
<table class="table-fhir-resources" style="table-layout: fixed; width: 100%">
    <tr>
        <th style="width: 5%">No.</th>
        <th>Observation.valueCodeableConcept[0].coding[0].code[0]</th>
        <th>Observation.valueCodeableConcept[0].coding[0].display[0]</th>
        <th>Observation.valueCodeableConcept[0].coding[0].system[0]</th>
    </tr>
    <tr>
        <td>1</td>
        <td>OV000006</td>
        <td>Intrauteri</td>
        <td>http://terminology.kemkes.go.id/CodeSystem/clinical-term</td>
    </tr>
    <tr>
        <td>2</td>
        <td>OV000007</td>
        <td>Ekstrauteri</td>
        <td>http://terminology.kemkes.go.id/CodeSystem/clinical-term</td>
    </tr>
</table>
</div>
</div>
<br>
<!--END Part 8-2-3-5-->

<div>Biparietal Diameter (BPD)</div>
<!--Part 8-2-3-6-->
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-8-2-3-6" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-8-2-3-6" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-8-2-3-6" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-8-2-3-6" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-8-2-3-6">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Observation-Create-USG-Finding-BPD}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-8-2-3-6" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "imaging",
                    "display": "Imaging"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://loinc.org",
                "code": "11820-8",
                "display": "Fetal Head Diameter.biparietal US"
            },
            {
                "system": "http://terminology.kemkes.go.id/CodeSystem/anc-custom-codes",
                "code": "ANC.SS.DE59",
                "display": "Biparietal Diameter (BPD) USG"
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
    "effectiveDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_EFFECTIVE_DATETIME&rcub;&rcub;</strong>",
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueQuantity": {
        "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
        "unit": "cm",
        "system": "http://unitsofmeasure.org",
        "code": "cm"
    },
    "basedOn":  [
        {
            "reference": "ServiceRequest/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_SERVICEREQUEST&rcub;&rcub;</strong>"
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-8-2-3-6" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __PATIENT_NAME__      			| Nama pasien |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi |
| __ID_RESOURCE_SERVICEREQUEST__ | &lcub;id-resource-ServiceRequest&rcub; pada SATUSEHAT |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-8-2-3-6" style="border: 1px solid #e8edee; padding: 15px 10px;">
            <div>
                [none]
            </div>
        </div>
    </div>
<br>
<!--END Part 8-2-3-6-->

<div>Head Circumference (HC)</div>
<!--Part 8-2-3-7-->
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-8-2-3-7" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-8-2-3-7" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-8-2-3-7" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-8-2-3-7" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-8-2-3-7">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Observation-Create-USG-Finding-HC}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-8-2-3-7" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "imaging",
                    "display": "Imaging"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://loinc.org",
                "code": "11984-2",
                "display": "Fetal Head Circumference US"
            },
            {
                "system": "http://terminology.kemkes.go.id/CodeSystem/anc-custom-codes",
                "code": "ANC.SS.DE42",
                "display": "Head Circumference (HC) USG"
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
    "effectiveDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_EFFECTIVE_DATETIME&rcub;&rcub;</strong>",
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueQuantity": {
        "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
        "unit": "cm",
        "system": "http://unitsofmeasure.org",
        "code": "cm"
    },
    "basedOn":  [
        {
            "reference": "ServiceRequest/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_SERVICEREQUEST&rcub;&rcub;</strong>"
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-8-2-3-7" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __PATIENT_NAME__      			| Nama pasien |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi |
| __ID_RESOURCE_SERVICEREQUEST__ | &lcub;id-resource-ServiceRequest&rcub; pada SATUSEHAT |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-8-2-3-7" style="border: 1px solid #e8edee; padding: 15px 10px;">
            <div>
                [none]
            </div>
        </div>
    </div>
<br>
<!--END Part 8-2-3-7-->

<div>Abdominal Circumference (AC)</div>
<!--Part 8-2-3-8-->
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-8-2-3-8" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-8-2-3-8" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-8-2-3-8" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-8-2-3-8" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-8-2-3-8">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Observation-Create-USG-Finding-AC}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-8-2-3-8" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "imaging",
                    "display": "Imaging"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://loinc.org",
                "code": "11979-2",
                "display": "Fetal Abdomen Circumference US"
            },
            {
                "system": "http://terminology.kemkes.go.id/CodeSystem/anc-custom-codes",
                "code": "ANC.SS.DE43",
                "display": "Abdominal Circumference (AC) USG"
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
    "effectiveDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_EFFECTIVE_DATETIME&rcub;&rcub;</strong>",
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueQuantity": {
        "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
        "unit": "cm",
        "system": "http://unitsofmeasure.org",
        "code": "cm"
    },
    "basedOn":  [
        {
            "reference": "ServiceRequest/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_SERVICEREQUEST&rcub;&rcub;</strong>"
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-8-2-3-8" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __PATIENT_NAME__      			| Nama pasien |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi |
| __ID_RESOURCE_SERVICEREQUEST__ | &lcub;id-resource-ServiceRequest&rcub; pada SATUSEHAT |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-8-2-3-8" style="border: 1px solid #e8edee; padding: 15px 10px;">
            <div>
                [none]
            </div>
        </div>
    </div>
<br>
<!--END Part 8-2-3-8-->

<div>Femur Length (FL)</div>
<!--Part 8-2-3-9-->
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-8-2-3-9" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-8-2-3-9" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-8-2-3-9" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-8-2-3-9" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-8-2-3-9">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Observation-Create-Femur-Length-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-8-2-3-9" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">

{
    "resourceType": "Observation",
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "imaging",
                    "display": "Imaging"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://loinc.org",
                "code": "11963-6",
                "display": "Fetal Femur diaphysis [Length] US"
            },
            {
                "system": "http://terminology.kemkes.go.id/CodeSystem/anc-custom-codes",
                "code": "ANC.SS.DE44",
                "display": "Femur Length (FL) USG"
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
    "effectiveDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_EFFECTIVE_DATETIME&rcub;&rcub;</strong>",
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueQuantity": {
        "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
        "unit": "cm",
        "system": "http://unitsofmeasure.org",
        "code": "cm"
    },
    "basedOn":  [
        {
            "reference": "ServiceRequest/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_SERVICEREQUEST&rcub;&rcub;</strong>"
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-8-2-3-9" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __PATIENT_NAME__      			| Nama pasien |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi |
| __ID_RESOURCE_SERVICEREQUEST__ | &lcub;id-resource-ServiceRequest&rcub; pada SATUSEHAT |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-8-2-3-9" style="border: 1px solid #e8edee; padding: 15px 10px;">
            <div>
                [none]
            </div>
        </div>
    </div>
<br>
<!--END Part 8-2-3-9-->

<div>Berat Janin (USG)</div>
<!--Part 8-2-3-10-->
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-8-2-3-10" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-8-2-3-10" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-8-2-3-10" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-8-2-3-10" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-8-2-3-10">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC/Observation-Create-BodyWeight-2.json}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-8-2-3-10" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "imaging",
                    "display": "Imaging"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://loinc.org",
                "code": "11727-5",
                "display": "Fetal Body weight estimated by US"
            },
            {
                "system": "http://terminology.kemkes.go.id/CodeSystem/anc-custom-codes",
                "code": "ANC.SS.DE45",
                "display": "Berat janin USG"
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
    "effectiveDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_EFFECTIVE_DATETIME&rcub;&rcub;</strong>",
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueQuantity": {
        "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>",
        "unit": "g",
        "system": "http://unitsofmeasure.org",
        "code": "g"
    },
    "basedOn":  [
        {
            "reference": "ServiceRequest/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_SERVICEREQUEST&rcub;&rcub;</strong>"
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-8-2-3-10" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __PATIENT_NAME__      			| Nama pasien |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi |
| __ID_RESOURCE_SERVICEREQUEST__ | &lcub;id-resource-ServiceRequest&rcub; pada SATUSEHAT |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-8-2-3-10" style="border: 1px solid #e8edee; padding: 15px 10px;">
            <div>
                [none]
            </div>
        </div>
    </div>
<br>
<!--END Part 8-2-3-10-->
</div>

<!--Part 8-2-4-->
<h4 style="font-weight: bold;">Laporan Hasil Pemeriksaan - USG</h4>
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-8-2-4" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-8-2-4" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-8-2-4" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-8-2-4" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-8-2-4">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-DiagnosticReport-Report-Rad-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-8-2-4" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "DiagnosticReport",
    "identifier":  [
        {
            "system": "http://sys-ids.kemkes.go.id/diagnostic/<strong style="color:#00a7ff">&lcub;&lcub;ORGANIZATION_IHS_NUMBER&rcub;&rcub;</strong>/rad",
            "use": "official",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;DIAGNOSTIC_LOCAL_CODE&rcub;&rcub;</strong>"
        }
    ],
    "status": "final",
    "category":  [
        {
            "coding":  [
                "system": "http://terminology.hl7.org/CodeSystem/v2-0074",
                "code": "RAD",
                "display": "Radiology"
            ]
        }
    ],
    "code": {
        "coding":  [
            {
                "system": "http://loinc.org",
                "code": "11525-3",
                "display": "US for pregnancy"
            }
        ]
    },
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>"
    },
    "encounter": {
        "reference": "Encounter/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_ENCOUNTER&rcub;&rcub;</strong>"
    },
    "effectiveDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;DIAGNOSTIC_EFFECTIVE_DATETIME&rcub;&rcub;</strong>",
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;DIAGNOSTIC_ISSUED&rcub;&rcub;</strong>",
    "performer":  [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
        {
            "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;ORGANIZATION_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "imagingStudy":  [
        {
            "reference": "ImagingStudy/1d3294e1-2bc9-439d-8915-272913f23bb8"
        }
    ],
    "result":  [
        {
            "reference": "Observation/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_OBSERVATION&rcub;&rcub;</strong>"
        }
    ],
    "basedOn":  [
        {
            "reference": "ServiceRequest/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_SERVICEREQUEST&rcub;&rcub;</strong>"
        }
    ],
    "conclusion": "<strong style="color:#00a7ff">&lcub;&lcub;REPORT_CONCLUSION&rcub;&rcub;</strong>"
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-8-2-4" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __DIAGNOSTIC_LOCAL_CODE__    		| ID Lokal untuk Report Lab  |
| __DIAGNOSTIC_CATEGORY__          		|__(*)__ Kategori Pemeriksaan Lab. Referensi ke value set "Kategori DiagnosticReport" |
| __DIAGNOSTIC_TYPE__          		|__(*)__  Jenis Laporan Pemeriksaan Lab. Referensi ke value set "Lampiran Terminologi Laboratorium" |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __DIAGNOSTIC_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __DIAGNOSTIC_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __ID_RESOURCE_OBSERVATION__      		| &lcub;id-resource-Observation&rcub; pada SATUSEHAT untuk data hasil pemeriksaan lab |
| __ID_RESOURCE_SPECIMEN__    				|  &lcub;id-resource-Specimen&rcub; pada SATUSEHAT |
| __ID_RESOURCE_SERVICEREQUEST__    				|  &lcub;id-resource-ServiceRequest&rcub; pada SATUSEHAT |
| __REPORT_CONCLUSION__    				|  Hasil pemeriksaan laporan radiologi dalam format free-text |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-8-2-4" style="border: 1px solid #e8edee; padding: 15px 10px;">
            <div>
                [none]
            </div>
        </div>
    </div>
<br>
</div>
<!--END Part 8-2-4-->
</div>
<!--END Part 8-->
<br>



<!--Part 9-->
### <div id="step8" style="font-weight: bold">Step 9. Peresepan Obat</div>
<div style="margin-left: 30px;">

Data terkait Farmasi meliputi data alergi obat, pengiriman data peresepan obat, dan pengeluaran obat. Data terkait Farmasi dikirimkan menggunakan resource AllergyIntolerance, Medication, MedicationRequest, dan Medication Dispense.

> `CATATAN:`
>  Detail skema peresepan obat, dapat dilihat dalam [Portal SATUSEHAT](https://satusehat.kemkes.go.id/platform/docs/id/interoperability/anc-prio/#_13_pengiriman_data_peresepan_obat_tablet_tambah_darah).

</div>
<!--Part 9-1 Variable Daftar Nama Obat-->
<div style="margin-left: 30px;">
<h4 style="font-weight: bold;">Daftar Nama Obat</h4>
    
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-7-1" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-7-1" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-7-1" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-7-1" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-7-1">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Medication-Create-Obat-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-7-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Medication",
    "meta": {
        "profile":  [
            "https://fhir.kemkes.go.id/r4/StructureDefinition/Medication"
        ]
    },
    "identifier":  [
        {
            "system": "http://sys-ids.kemkes.go.id/medication/<strong style="color:#00a7ff">&lcub;&lcub;ORGANIZATION_IHS_NUMBER1&rcub;&rcub;</strong>",
            "use": "official",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION_LOCAL_CODE&rcub;&rcub;</strong>"
        }
    ],
    "code": {
        "coding":  [
            {
                "system": "http://sys-ids.kemkes.go.id/kfa",
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION_VALUE&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION_VALUE&rcub;&rcub;</strong>"
            }
        ]
    },
    "status": "active",
    "manufacturer": {
        "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;ORGANIZATION_IHS_NUMBER2&rcub;&rcub;</strong>"
    },
    "form": {
        "coding":  [
            {
                "system": "http://terminology.kemkes.go.id/CodeSystem/medication-form",
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION_FORM&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION_FORM&rcub;&rcub;</strong>"
            }
        ]
    },
    "ingredient":  [
        {
            "itemCodeableConcept": {
                "coding":  [
                    {
                        "system": "http://sys-ids.kemkes.go.id/kfa",
                        "code": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION_INGREDIENT&rcub;&rcub;</strong>",
                        "display": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION_INGREDIENT&rcub;&rcub;</strong>"
                    }
                ]
            },
            "isActive": true,
            "strength": {
                "numerator": {
                    "value": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION_INGREDIENT_NUM&rcub;&rcub;</strong>",
                    "system": "http://unitsofmeasure.org",
                    "code": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION_INGREDIENT_UOM&rcub;&rcub;</strong>"
                },
                "denominator": {
                    "value": <strong style="color:#00a7ff">&lcub;&lcub;MEDICATION_INGREDIENT_DENUM&rcub;&rcub;</strong>,
                    "unit": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION_INGREDIENT_UOM&rcub;&rcub;</strong>",
                    "system": "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm",
                    "code": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION_INGREDIENT_UOM&rcub;&rcub;</strong>"
                }
            }
        }
    ],
    "extension":  [
        {
            "url": "https://fhir.kemkes.go.id/r4/StructureDefinition/MedicationType",
            "valueCodeableConcept": {
                "coding":  [
                    {
                        "system": "http://terminology.kemkes.go.id/CodeSystem/medication-type",
                        "code": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION_TYPE&rcub;&rcub;</strong>",
                        "display": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION_TYPE&rcub;&rcub;</strong>"
                    }
                ]
            }
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-7-1" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __MEDICATION_LOCAL_CODE__    		| Berisi data kode lokal obat di masing-masing institusi. Apabila data obat yang dikirimkan merupakan data obat racikan, Medication.identifier dapat dikosongkan.  |
| __MEDICATION_VALUE__          		|__(*)__ Berisi data kode obat yang digunakan akan menggunakan kode obat yang tersedia pada KFA (kamus farmasi dan alat kesehatan) dengan tipe data CodeableConcept. Medication.code wajib diisi apabila mengirimkan data obat non-racikan. Untuk pengiriman data racikan, Medication.code dapat dikosongkan. Referensi ke value set "Lampiran Terminologi Peresepan dan Pengeluaran Obat "|
| __MEDICATION_FORM__          		|__(*)__  Berisi data yang menjelaskan bentuk dari sediaan obat yang merujuk pada Peraturan Kepala Badan Pengawas Obat dan Makanan Republik Indonesia Nomor 24 Tahun 2017, dengan tipe data CodeableConcept. Referensi ke value set "Lampiran Terminologi Peresepan dan Pengeluaran Obat " |
| __MEDICATION_INGREDIENT__      			| Terdapat 2 cara pengisian Medication.ingredient yaitu: * Peresepan/pengeluaran obat non-racikan dan obat racikan dengan instruksi berikan dalam dosis demikian/ d.t.d * Peresepan/pengeluaran obat racikan non-d.t.d (bagi dalam bagian-bagian yang sama) dengan tipe data BackboneElement. Elemen ini WAJIB diisi apabila data yang dikirimkan adalah obat racikan. |
| __MEDICATION_INGREDIENT_NUM__; __MEDICATION_INGREDIENT_DENUM__        		| Berisi data informasi jumlah komposisi zat dalam obat (untuk zat aktif, maka diisi dengan kekuatan zat aktif obat) atau jumlah tablet yang dibutuhkan per jumlah pulveres/kapsul yang akan diresepkan dengan tipe data Ratio, yang umumnya nilai satuan kekuatan zat aktif mengacu pada tiga data terminologi, yaitu: UCUM, orderableDrugForm, dan SNOMED CT. |
| __MEDICATION_INGREDIENT_UOM__      			| Satuan pengukuran untuk numerator dan denumerator komposisi zat dalam obat. Referensi ke value set "UCUM"|
| __MEDICATION_TYPE__      			| Berisi satu atau lebih data bertipe Extension yang digunakan menyimpan informasi apakah obat yang diresepkan atau dikeluarkan merupakan obat non-racikan, obat racikan dengan instruksi berikan dalam dosis demikian/ d.t.d, atau obat racikan non-d.t.d, yang nilai dan strukturnya mengacu pada extension tambahan dengan nama <a href="https://simplifier.net/guide/SATUSEHAT-FHIR-R4-Implementation-Guide/Home/Extensions/MedicationType.page.md?version=current">MedicationType.</a> |
> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-7-1" style="border: 1px solid #e8edee; padding: 15px 10px;">

Lampiran Terminologi Peresepan dan Pengeluaran Obat dapat diakses di <a href="https://satusehat.kemkes.go.id/platform/docs/id/terminology/lampiran-terminologi/anc-prioritas/#lampiran-4-anc">SATUSEHAT Portal - Lampiran Terminologi ANC Prioritas</a><br>

Lampiran UCUM dapat diakses di <a href="https://docs.google.com/spreadsheets/d/1OHM4ICgQ3hseGLrqi9GQzcREddU5SDKto50dhkhOjnc/edit?usp=sharing">Spreadsheet Observation.valueQuantity (UCUM)</a> 
</div>
	</div>
<br>
<!--END Part 9-1-->

<!--Part 9-2 Variable Permintaan Obat-->
<h4 style="font-weight: bold;">Permintaan Obat</h4>

<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-7-2" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-7-2" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-7-2" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-7-2" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-7-2">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-MedicationRequest-Create-Permintaan-Peresepan-Obat-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-7-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "MedicationRequest",
    "identifier":  [
        {
            "system": "http://sys-ids.kemkes.go.id/prescription/<strong style="color:#00a7ff">&lcub;&lcub;ORGANIZATION_IHS_NUMBER&rcub;&rcub;</strong>",
            "use": "official",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATIONREQUEST_LOCAL_CODE&rcub;&rcub;</strong>"
        },
        {
            "system": "http://sys-ids.kemkes.go.id/prescription-item/<strong style="color:#00a7ff">&lcub;&lcub;ORGANIZATION_IHS_NUMBER&rcub;&rcub;</strong>",
            "use": "official",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION_LOCAL_CODE&rcub;&rcub;</strong>"
        }
    ],
    "status": "completed",
    "intent": "order",
    "category":  [
        {
            "coding":  [
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
        "reference": "Medication/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_MEDICATION&rcub;&rcub;</strong>"
    },
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>",
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "encounter": {
        "reference": "Encounter/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_ENCOUNTER&rcub;&rcub;</strong>"
    },
    "authoredOn": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATIONREQUEST_AUTHORED_DATE&rcub;&rcub;</strong>",
    "requester": {
        "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>",
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_NAME&rcub;&rcub;</strong>"
    },
    "courseOfTherapyType": {
        "coding":  [
            {
                "system": "http://terminology.hl7.org/CodeSystem/medicationrequest-course-of-therapy",
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION_THERAPY_TYPE&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION_THERAPY_TYPE&rcub;&rcub;</strong>"
            }
        ]
    },
    "dosageInstruction":  [
        {
            "sequence": "<strong style="color:#00a7ff">&lcub;&lcub;DOSAGE_SEQUENCE_NO&rcub;&rcub;</strong>",
            "text": "<strong style="color:#00a7ff">&lcub;&lcub;DOSAGE_INSTRUCTION&rcub;&rcub;</strong>",
            "additionalInstruction":  [
                {
                    "text": "<strong style="color:#00a7ff">&lcub;&lcub;DOSAGE_ADDITIONAL_INSTRUCTION&rcub;&rcub;</strong>"
                }
            ],
            "patientInstruction": "<strong style="color:#00a7ff">&lcub;&lcub;DOSAGE_PATIENT_INSTRUCTION&rcub;&rcub;</strong>",
            "timing": {
                "repeat": {
                    "frequency": "<strong style="color:#00a7ff">&lcub;&lcub;DOSAGE_TIMING_REPEAT&rcub;&rcub;</strong>",
                    "period": "<strong style="color:#00a7ff">&lcub;&lcub;DOSAGE_TIMING_REPEAT&rcub;&rcub;</strong>",
                    "periodUnit": "<strong style="color:#00a7ff">&lcub;&lcub;DOSAGE_TIMING_REPEAT&rcub;&rcub;</strong>"
                }
            },
            "route": {
                "coding":  [
                    {
                        "system": "http://www.whocc.no/atc",
                        "code": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICINE_CONSUME_ROUTE&rcub;&rcub;</strong>",
                        "display": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICINE_CONSUME_ROUTE&rcub;&rcub;</strong>"
                    }
                ]
            },
            "doseAndRate":  [
                {
                    "type": {
                        "coding":  [
                            {
                                "system": "http://terminology.hl7.org/CodeSystem/dose-rate-type",
                                "code": "ordered",
                                "display": "Ordered"
                            }
                        ]
                    },
                    "doseQuantity": {
                        "value": "<strong style="color:#00a7ff">&lcub;&lcub;DOSE_QTY&rcub;&rcub;</strong>",
                        "unit": "<strong style="color:#00a7ff">&lcub;&lcub;DOSE_QTY&rcub;&rcub;</strong>",
                        "system": "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm",
                        "code": "<strong style="color:#00a7ff">&lcub;&lcub;DOSE_QTY&rcub;&rcub;</strong>"
                    }
                }
            ]
        }
    ],
    "dispenseRequest": {
        "dispenseInterval": {
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;DISPENSE_INTERVAL_VALUE&rcub;&rcub;</strong>",
            "unit": "<strong style="color:#00a7ff">&lcub;&lcub;DISPENSE_INTERVAL_UNIT&rcub;&rcub;</strong>",
            "system": "http://unitsofmeasure.org",
            "code": ""<strong style="color:#00a7ff">&lcub;&lcub;DISPENSE_INTERVAL_UNIT&rcub;&rcub;</strong>""
        },
        "validityPeriod": {
            "start": "<strong style="color:#00a7ff">&lcub;&lcub;DISPENSE_INTERVAL_START&rcub;&rcub;</strong>",
            "end": "<strong style="color:#00a7ff">&lcub;&lcub;DISPENSE_INTERVAL_END&rcub;&rcub;</strong>"
        },
        "numberOfRepeatsAllowed": "<strong style="color:#00a7ff">&lcub;&lcub;PRESCRIPTION_NUMBER_OF_REPEAT&rcub;&rcub;</strong>",
        "quantity": {
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;DISPENSE_QTY&rcub;&rcub;</strong>",
            "unit": "<strong style="color:#00a7ff">&lcub;&lcub;DISPENSE_UNIT&rcub;&rcub;</strong>",
            "system": "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm",
            "code": "<strong style="color:#00a7ff">&lcub;&lcub;DISPENSE_UNIT&rcub;&rcub;</strong>"
        },
        "expectedSupplyDuration": {
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;EXPECTED_SUPPLY_DURATION&rcub;&rcub;</strong>",
            "unit": "<strong style="color:#00a7ff">&lcub;&lcub;EXPECTED_SUPPLY_DURATION_UNIT&rcub;&rcub;</strong>",
            "system": "http://unitsofmeasure.org",
            "code": "<strong style="color:#00a7ff">&lcub;&lcub;EXPECTED_SUPPLY_DURATION_UNIT&rcub;&rcub;</strong>"
        },
        "performer": {
            "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;ORGANIZATION_IHS_NUMBER2&rcub;&rcub;</strong>"
        }
    }
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-7-2" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __MEDICATIONREQUEST_LOCAL_CODE__    		| ID Lokal Peresepan Merupakan ID lokal di masing-masing institusi yang merepresentasikan satu resep yang dibuat oleh dokter (dapat terdiri dari lebih dari 1 obat dalam 1 resep).  |
| __MEDICATION_LOCAL_CODE__    		| ID Lokal Peresepan per-item obat Merupakan ID lokal di masing-masing institusi untuk setiap obat yang diresepkan dalam suatu resep.  |
| __ID_RESOURCE_MEDICATION__    		| Berisi data informasi obat yang diresepkan dengan tipe data Reference, yang direferensikan ke data yang tersimpan di resource Medication, yang nilainya merujuk ke &lcub;id-resource-MedicationReference&rcub; pada SATUSEHAT |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __PATIENT_NAME__      			| Nama pasien |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __MEDICATIONREQUEST_AUTHORED_DATE__      		| Berisi data waktu peresepan dengan tipe data dateTime, dengan format yang diperbolehkan YYYY-MM-DDThh:mm:ss+zz:zz. |
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __PRACTITIONER_NAME__    				| Nama dokter|
| __MEDICATION_THERAPY_TYPE__    				| Berisi satu atau lebih data yang mendeskripsikan keseluruhan pola pemberian obat pada pasien dengan tipe data CodeableConcept. |
| __DOSAGE_SEQUENCE_NO__    				| Berisi data paket aturan pakai dengan nilai sequence dengan tipe data integer.|
| __DOSAGE_INSTRUCTION__    				| Berisi satu atau lebih data aturan pakai obat dalam bentuk naratif dengan tipe data string.|
| __DOSAGE_ADDITIONAL_INSTRUCTION__    				| Nama dokter|
| __DOSAGE_PATIENT_INSTRUCTION__    				| Berisi data instruksi aturan pakai dengan orientasi pasien dengan tipe data string.|
| __DOSAGE_TIMING_REPEAT__    				| __(*)__ berisi aturan kapan suatu obat harus dikonsumsi. Cara Pengisian referensi ke value set "Lampiran Aturan Konsumsi Obat"|
| __MEDICINE_CONSUME_ROUTE__    				| __(*)__ Berisi data yang berkaitan dengan cara/rute yang digunakan untuk memasukkan obat ke dalam tubuh pasien dengan tipe data CodeableConcept, yang nilainya mengacu pada data terminologi WHO ATC/DDD. Referensi ke value set "Cara/ rute pemberian obat"|
| __DOSE_QTY__    				| __(*)__ Berisi data jumlah obat yang diberikan perdosis. Cara Pengisian referensi ke value set "Lampiran Aturan Konsumsi Obat"|
| __DISPENSE_INTERVAL_VALUE__    				| Berisi data yang Berkaitan dengan periode waktu minimal yang harus dilakukan antara pengeluaran obat |
| __DISPENSE_INTERVAL_UNIT__    				| __(*)__ nilai satuan kekuatan zat aktifnya merujuk pada referensi ke value set ""|
| __PRACTITIONER_NAME__    				| Nama dokter|

| __MEDICATION_VALUE__          		|__(*)__ Berisi data kode obat yang digunakan akan menggunakan kode obat yang tersedia pada KFA (kamus farmasi dan alat kesehatan) dengan tipe data CodeableConcept. Medication.code wajib diisi apabila mengirimkan data obat non-racikan. Untuk pengiriman data racikan, Medication.code dapat dikosongkan. Referensi ke value set "Lampiran Terminologi Peresepan dan Pengeluaran Obat "|
| __MEDICATION_FORM__          		|__(*)__  Berisi data yang menjelaskan bentuk dari sediaan obat yang merujuk pada Peraturan Kepala Badan Pengawas Obat dan Makanan Republik Indonesia Nomor 24 Tahun 2017, dengan tipe data CodeableConcept. Referensi ke value set "Lampiran Terminologi Peresepan dan Pengeluaran Obat " |
| __MEDICATION_INGREDIENT__      			| Terdapat 2 cara pengisian Medication.ingredient yaitu: * Peresepan/pengeluaran obat non-racikan dan obat racikan dengan instruksi berikan dalam dosis demikian/ d.t.d * Peresepan/pengeluaran obat racikan non-d.t.d (bagi dalam bagian-bagian yang sama) dengan tipe data BackboneElement. Elemen ini WAJIB diisi apabila data yang dikirimkan adalah obat racikan. |
| __MEDICATION_INGREDIENT_NUM__; __MEDICATION_INGREDIENT_DENUM__        		| Berisi data informasi jumlah komposisi zat dalam obat (untuk zat aktif, maka diisi dengan kekuatan zat aktif obat) atau jumlah tablet yang dibutuhkan per jumlah pulveres/kapsul yang akan diresepkan dengan tipe data Ratio, yang umumnya nilai satuan kekuatan zat aktif mengacu pada tiga data terminologi, yaitu: UCUM, orderableDrugForm, dan SNOMED CT. |
| __MEDICATION_INGREDIENT_UOM__      			| Satuan pengukuran untuk numerator dan denumerator komposisi zat dalam obat|
| __MEDICATION_TYPE__      			| Berisi satu atau lebih data bertipe Extension yang digunakan menyimpan informasi apakah obat yang diresepkan atau dikeluarkan merupakan obat non-racikan, obat racikan dengan instruksi berikan dalam dosis demikian/ d.t.d, atau obat racikan non-d.t.d, yang nilai dan strukturnya mengacu pada extension tambahan dengan nama <a href="https://simplifier.net/guide/SATUSEHAT-FHIR-R4-Implementation-Guide/Home/Extensions/MedicationType.page.md?version=current">MedicationType.</a> |
> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-7-2" style="border: 1px solid #e8edee; padding: 15px 10px;">

Lampiran Aturan Konsumsi Obat dapat diakses pada <a href="https://satusehat.kemkes.go.id/platform/docs/id/interoperability/anc-prio/#_13_pengiriman_data_peresepan_obat_tablet_tambah_darah:~:text=dalam%20Tabel%2015.-,Tabel%2016.,-Tatacara%20pengisian%20MedicationDispense">SATUSEHAT Portal - Tabel 16. Tatacara pengisian MedicationDispense.dosageInstruction[i].timing.repeat</a><br>

Cara/ rute pemberian obat
<table class="table-fhir-resources" style="table-layout: fixed; width: 100%">
    <tr>
        <th style="width: 5%">No.</th>
        <th>MedicationRequest.dosageInstruction.route.coding.system </th>
        <th>MedicationRequest.dosageInstruction.route.coding.code</th>
        <th>MedicationRequest.dosageInstruction.route.coding.display</th>
        <th>Keterangan </th>
    </tr>
    <tr>
        <td>1</td>
        <td>http://www.whocc.no/atc</td>
        <td>implant</td>
        <td>Implant</td>
        <td>Implant</td>
    </tr>
    <tr>
        <td>2</td>
        <td>http://www.whocc.no/atc</td>
        <td>Inhal</td>
        <td>Inhalation</td>
        <td>Inhalasi (dihirup)</td>
    </tr>
    <tr>
        <td>3</td>
        <td>http://www.whocc.no/atc</td>
        <td>Instill</td>
        <td>Instillation</td>
        <td>Instillation</td>
    </tr>
    <tr>
        <td>4</td>
        <td>http://www.whocc.no/atc</td>
        <td>N</td>
        <td>Nasal</td>
        <td>Nasal</td>
    </tr>
    <tr>
        <td>5</td>
        <td>http://www.whocc.no/atc</td>
        <td>O</td>
        <td>Oral</td>
        <td>Oral</td>
    </tr>
    <tr>
        <td>6</td>
        <td>http://www.whocc.no/atc</td>
        <td>P</td>
        <td>Parenteral</td>
        <td>Parenteral</td>
    </tr>
    <tr>
        <td>7</td>
        <td>http://www.whocc.no/atc</td>
        <td>R</td>
        <td>Rectal</td>
        <td>Rektum</td>
    </tr>
    <tr>
        <td>8</td>
        <td>http://www.whocc.no/atc</td>
        <td>SL</td>
        <td>Sublingual/Buccal/Oromucosal</td>
        <td>Sublingual (dibawah lidah) / bukal (diantara gusi &amp; pipi)</td>
    </tr>
    <tr>
        <td>9</td>
        <td>http://www.whocc.no/atc</td>
        <td>TD</td>
        <td>Transdermal</td>
        <td>Transdermal</td>
    </tr>
    <tr>
        <td>10</td>
        <td>http://www.whocc.no/atc</td>
        <td>V</td>
        <td>Vaginal</td>
        <td>Vagina</td>
    </tr>
    <tr>
        <td>11</td>
        <td>http://www.whocc.no/atc</td>
        <td>Inhal.powder</td>
        <td>Inhalation Powder</td>
        <td>Bubuk inhalasi</td>
    </tr>
    <tr>
        <td>12</td>
        <td>http://www.whocc.no/atc</td>
        <td>Inhal.aerosol</td>
        <td>Inhalation Aerosol</td>
        <td>Aerosol inhalasi</td>
    </tr>
    <tr>
        <td>13</td>
        <td>http://www.whocc.no/atc</td>
        <td>Inhal.solution</td>
        <td>Inhalation Solution</td>
        <td>Larutan inhalasi</td>
    </tr>
    <tr>
        <td>14</td>
        <td>http://www.whocc.no/atc</td>
        <td>urethral</td>
        <td>Urethral</td>
        <td>Uretra</td>
    </tr>
    <tr>
        <td>15</td>
        <td>http://www.whocc.no/atc</td>
        <td>TD patch</td>
        <td>Transdermal Patch</td>
        <td>Transdermal patch</td>
    </tr>
    <tr>
        <td>16</td>
        <td>http://www.whocc.no/atc</td>
        <td>intravesical</td>
        <td>Intravesical</td>
        <td>Intravesical</td>
    </tr>
    <tr>
        <td>17</td>
        <td>http://www.whocc.no/atc</td>
        <td>Instill.solution</td>
        <td>Instillation Solution</td>
        <td>Instillation solution</td>
    </tr>
    <tr>
        <td>18</td>
        <td>http://www.whocc.no/atc</td>
        <td>lamella</td>
        <td>Lamella</td>
        <td>Ophtalmic</td>
    </tr>
    <tr>
        <td>19</td>
        <td>http://www.whocc.no/atc</td>
        <td>oral aerosol</td>
        <td>Oral Aerosol</td>
        <td>Aerosol oral</td>
    </tr>
    <tr>
        <td>20</td>
        <td>http://www.whocc.no/atc</td>
        <td>s.c. implant</td>
        <td>S.C. Implant</td>
        <td>S.C. implant</td>
    </tr>
    <tr>
        <td>21</td>
        <td>http://www.whocc.no/atc</td>
        <td>ocular</td>
        <td>Ocular</td>
        <td>Ocular (mata)</td>
    </tr>
    <tr>
        <td>22</td>
        <td>http://www.whocc.no/atc</td>
        <td>otic</td>
        <td>Otic</td>
        <td>Otic (telinga)</td>
    </tr>
    <tr>
        <td>23</td>
        <td>http://www.whocc.no/atc</td>
        <td>cutaneous</td>
        <td>Cutaneous</td>
        <td>Kutanea (kulit)</td>
    </tr>
    <tr>
        <td>24</td>
        <td>http://www.whocc.no/atc</td>
        <td>inj.subcutaneous</td>
        <td>Injection Subcutaneous</td>
        <td>Subkutan Injeksi (di bawah kulit)</td>
    </tr>
    <tr>
        <td>25</td>
        <td>http://www.whocc.no/atc</td>
        <td>inj.intramuscular</td>
        <td>Injection Intramuscular</td>
        <td>Intramuskular Injeksi (di dalam otot)</td>
    </tr>
    <tr>
        <td>26</td>
        <td>http://www.whocc.no/atc</td>
        <td>inj.intravenous</td>
        <td>Injection Intravenous</td>
        <td>Intravena Injeksi (ke pembuluh darah)</td>
    </tr>
    <tr>
        <td>27</td>
        <td>http://www.whocc.no/atc</td>
        <td>inj.intrathecal</td>
        <td>Injection Intrathecal</td>
        <td>Intratekal Injeksi (sekitar sumsum tulang belakang)</td>
    </tr>
    <tr>
        <td>28</td>
        <td>http://www.whocc.no/atc</td>
        <td>Chewing Gum</td>
        <td>Chewing Gum</td>
        <td>Dikunyah</td>
    </tr>
    <tr>
        <td>29</td>
        <td>http://www.whocc.no/atc</td>
        <td>ointment</td>
        <td>ointment</td>
        <td>Topikal</td>
    </tr>
    <tr>
        <td>30</td>
        <td>http://www.whocc.no/atc</td>
        <td>stomatologic</td>
        <td>stomatologic</td>
        <td>stomatologic</td>
    </tr>
</table>
        </div>
	</div>
<br>
<!--END Part 9-2-->
</div>
<!--END Part 9-->


<!--Part 10-->
### <div id="step10" style="font-weight: bold">Step 10. Pengeluaran Obat</div>

<div style="margin-left: 30px;">

> `CATATAN:`
>  Detail skema pengeluaran obat, dapat dilihat dalam [Portal SATUSEHAT](https://satusehat.kemkes.go.id/platform/docs/id/interoperability/anc-prio/#_14_pengiriman_data_pengeluaran_obat_tablet_tambah_darah).

<!--Part 10-1 Variable Daftar Nama Obat-->
<h4 style="font-weight: bold;">Daftar Nama Obat</h4>
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-10-1" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-10-1" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-10-1" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-10-1" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-10-1">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Medication-Create-Obat-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-10-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Medication",
    "meta": {
        "profile":  [
            "https://fhir.kemkes.go.id/r4/StructureDefinition/Medication"
        ]
    },
    "identifier":  [
        {
            "system": "http://sys-ids.kemkes.go.id/medication/<strong style="color:#00a7ff">&lcub;&lcub;ORGANIZATION_IHS_NUMBER1&rcub;&rcub;</strong>",
            "use": "official",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION_LOCAL_CODE&rcub;&rcub;</strong>"
        }
    ],
    "code": {
        "coding":  [
            {
                "system": "http://sys-ids.kemkes.go.id/kfa",
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION_VALUE&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION_VALUE&rcub;&rcub;</strong>"
            }
        ]
    },
    "status": "active",
    "manufacturer": {
        "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;ORGANIZATION_IHS_NUMBER2&rcub;&rcub;</strong>"
    },
    "form": {
        "coding":  [
            {
                "system": "http://terminology.kemkes.go.id/CodeSystem/medication-form",
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION_FORM&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION_FORM&rcub;&rcub;</strong>"
            }
        ]
    },
    "ingredient":  [
        {
            "itemCodeableConcept": {
                "coding":  [
                    {
                        "system": "http://sys-ids.kemkes.go.id/kfa",
                        "code": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION_INGREDIENT&rcub;&rcub;</strong>",
                        "display": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION_INGREDIENT&rcub;&rcub;</strong>"
                    }
                ]
            },
            "isActive": true,
            "strength": {
                "numerator": {
                    "value": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION_INGREDIENT_NUM&rcub;&rcub;</strong>",
                    "system": "http://unitsofmeasure.org",
                    "code": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION_INGREDIENT_UOM&rcub;&rcub;</strong>"
                },
                "denominator": {
                    "value": <strong style="color:#00a7ff">&lcub;&lcub;MEDICATION_INGREDIENT_DENUM&rcub;&rcub;</strong>,
                    "unit": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION_INGREDIENT_UOM&rcub;&rcub;</strong>",
                    "system": "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm",
                    "code": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION_INGREDIENT_UOM&rcub;&rcub;</strong>"
                }
            }
        }
    ],
    "extension":  [
        {
            "url": "https://fhir.kemkes.go.id/r4/StructureDefinition/MedicationType",
            "valueCodeableConcept": {
                "coding":  [
                    {
                        "system": "http://terminology.kemkes.go.id/CodeSystem/medication-type",
                        "code": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION_TYPE&rcub;&rcub;</strong>",
                        "display": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION_TYPE&rcub;&rcub;</strong>"
                    }
                ]
            }
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-10-1" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __MEDICATION_LOCAL_CODE__    		| Berisi data kode lokal obat di masing-masing institusi. Apabila data obat yang dikirimkan merupakan data obat racikan, Medication.identifier dapat dikosongkan.  |
| __MEDICATION_VALUE__          		|__(*)__ Berisi data kode obat yang digunakan akan menggunakan kode obat yang tersedia pada KFA (kamus farmasi dan alat kesehatan) dengan tipe data CodeableConcept. Medication.code wajib diisi apabila mengirimkan data obat non-racikan. Untuk pengiriman data racikan, Medication.code dapat dikosongkan. Referensi ke value set "Lampiran Terminologi Peresepan dan Pengeluaran Obat "|
| __MEDICATION_FORM__          		|__(*)__  Berisi data yang menjelaskan bentuk dari sediaan obat yang merujuk pada Peraturan Kepala Badan Pengawas Obat dan Makanan Republik Indonesia Nomor 24 Tahun 2017, dengan tipe data CodeableConcept. Referensi ke value set "Lampiran Terminologi Peresepan dan Pengeluaran Obat " |
| __MEDICATION_INGREDIENT__      			| Terdapat 2 cara pengisian Medication.ingredient yaitu: * Peresepan/pengeluaran obat non-racikan dan obat racikan dengan instruksi berikan dalam dosis demikian/ d.t.d * Peresepan/pengeluaran obat racikan non-d.t.d (bagi dalam bagian-bagian yang sama) dengan tipe data BackboneElement. Elemen ini WAJIB diisi apabila data yang dikirimkan adalah obat racikan. |
| __MEDICATION_INGREDIENT_NUM__; __MEDICATION_INGREDIENT_DENUM__        		| Berisi data informasi jumlah komposisi zat dalam obat (untuk zat aktif, maka diisi dengan kekuatan zat aktif obat) atau jumlah tablet yang dibutuhkan per jumlah pulveres/kapsul yang akan diresepkan dengan tipe data Ratio, yang umumnya nilai satuan kekuatan zat aktif mengacu pada tiga data terminologi, yaitu: UCUM, orderableDrugForm, dan SNOMED CT. |
| __MEDICATION_INGREDIENT_UOM__      			| Satuan pengukuran untuk numerator dan denumerator komposisi zat dalam obat. Referensi ke value set "UCUM"|
| __MEDICATION_TYPE__      			| Berisi satu atau lebih data bertipe Extension yang digunakan menyimpan informasi apakah obat yang diresepkan atau dikeluarkan merupakan obat non-racikan, obat racikan dengan instruksi berikan dalam dosis demikian/ d.t.d, atau obat racikan non-d.t.d, yang nilai dan strukturnya mengacu pada extension tambahan dengan nama <a href="https://simplifier.net/guide/SATUSEHAT-FHIR-R4-Implementation-Guide/Home/Extensions/MedicationType.page.md?version=current">MedicationType.</a> |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>

<div role="tabpanel" class="tab-pane" id="valueset-10-1" style="border: 1px solid #e8edee; padding: 15px 10px;">

Lampiran Aturan Konsumsi Obat dapat diakses pada <a href="https://satusehat.kemkes.go.id/platform/docs/id/interoperability/anc-prio/#_13_pengiriman_data_peresepan_obat_tablet_tambah_darah:~:text=dalam%20Tabel%2015.-,Tabel%2016.,-Tatacara%20pengisian%20MedicationDispense">SATUSEHAT Portal - Tabel 16. Tatacara pengisian MedicationDispense.dosageInstruction[i].timing.repeat</a><br>

Cara/ rute pemberian obat
<table class="table-fhir-resources" style="table-layout: fixed; width: 100%">
    <tr>
        <th style="width: 5%">No.</th>
        <th>MedicationRequest.dosageInstruction.route.coding.system </th>
        <th>MedicationRequest.dosageInstruction.route.coding.code</th>
        <th>MedicationRequest.dosageInstruction.route.coding.display</th>
        <th>Keterangan </th>
    </tr>
    <tr>
        <td>1</td>
        <td>http://www.whocc.no/atc</td>
        <td>implant</td>
        <td>Implant</td>
        <td>Implant</td>
    </tr>
    <tr>
        <td>2</td>
        <td>http://www.whocc.no/atc</td>
        <td>Inhal</td>
        <td>Inhalation</td>
        <td>Inhalasi (dihirup)</td>
    </tr>
    <tr>
        <td>3</td>
        <td>http://www.whocc.no/atc</td>
        <td>Instill</td>
        <td>Instillation</td>
        <td>Instillation</td>
    </tr>
    <tr>
        <td>4</td>
        <td>http://www.whocc.no/atc</td>
        <td>N</td>
        <td>Nasal</td>
        <td>Nasal</td>
    </tr>
    <tr>
        <td>5</td>
        <td>http://www.whocc.no/atc</td>
        <td>O</td>
        <td>Oral</td>
        <td>Oral</td>
    </tr>
    <tr>
        <td>6</td>
        <td>http://www.whocc.no/atc</td>
        <td>P</td>
        <td>Parenteral</td>
        <td>Parenteral</td>
    </tr>
    <tr>
        <td>7</td>
        <td>http://www.whocc.no/atc</td>
        <td>R</td>
        <td>Rectal</td>
        <td>Rektum</td>
    </tr>
    <tr>
        <td>8</td>
        <td>http://www.whocc.no/atc</td>
        <td>SL</td>
        <td>Sublingual/Buccal/Oromucosal</td>
        <td>Sublingual (dibawah lidah) / bukal (diantara gusi &amp; pipi)</td>
    </tr>
    <tr>
        <td>9</td>
        <td>http://www.whocc.no/atc</td>
        <td>TD</td>
        <td>Transdermal</td>
        <td>Transdermal</td>
    </tr>
    <tr>
        <td>10</td>
        <td>http://www.whocc.no/atc</td>
        <td>V</td>
        <td>Vaginal</td>
        <td>Vagina</td>
    </tr>
    <tr>
        <td>11</td>
        <td>http://www.whocc.no/atc</td>
        <td>Inhal.powder</td>
        <td>Inhalation Powder</td>
        <td>Bubuk inhalasi</td>
    </tr>
    <tr>
        <td>12</td>
        <td>http://www.whocc.no/atc</td>
        <td>Inhal.aerosol</td>
        <td>Inhalation Aerosol</td>
        <td>Aerosol inhalasi</td>
    </tr>
    <tr>
        <td>13</td>
        <td>http://www.whocc.no/atc</td>
        <td>Inhal.solution</td>
        <td>Inhalation Solution</td>
        <td>Larutan inhalasi</td>
    </tr>
    <tr>
        <td>14</td>
        <td>http://www.whocc.no/atc</td>
        <td>urethral</td>
        <td>Urethral</td>
        <td>Uretra</td>
    </tr>
    <tr>
        <td>15</td>
        <td>http://www.whocc.no/atc</td>
        <td>TD patch</td>
        <td>Transdermal Patch</td>
        <td>Transdermal patch</td>
    </tr>
    <tr>
        <td>16</td>
        <td>http://www.whocc.no/atc</td>
        <td>intravesical</td>
        <td>Intravesical</td>
        <td>Intravesical</td>
    </tr>
    <tr>
        <td>17</td>
        <td>http://www.whocc.no/atc</td>
        <td>Instill.solution</td>
        <td>Instillation Solution</td>
        <td>Instillation solution</td>
    </tr>
    <tr>
        <td>18</td>
        <td>http://www.whocc.no/atc</td>
        <td>lamella</td>
        <td>Lamella</td>
        <td>Ophtalmic</td>
    </tr>
    <tr>
        <td>19</td>
        <td>http://www.whocc.no/atc</td>
        <td>oral aerosol</td>
        <td>Oral Aerosol</td>
        <td>Aerosol oral</td>
    </tr>
    <tr>
        <td>20</td>
        <td>http://www.whocc.no/atc</td>
        <td>s.c. implant</td>
        <td>S.C. Implant</td>
        <td>S.C. implant</td>
    </tr>
    <tr>
        <td>21</td>
        <td>http://www.whocc.no/atc</td>
        <td>ocular</td>
        <td>Ocular</td>
        <td>Ocular (mata)</td>
    </tr>
    <tr>
        <td>22</td>
        <td>http://www.whocc.no/atc</td>
        <td>otic</td>
        <td>Otic</td>
        <td>Otic (telinga)</td>
    </tr>
    <tr>
        <td>23</td>
        <td>http://www.whocc.no/atc</td>
        <td>cutaneous</td>
        <td>Cutaneous</td>
        <td>Kutanea (kulit)</td>
    </tr>
    <tr>
        <td>24</td>
        <td>http://www.whocc.no/atc</td>
        <td>inj.subcutaneous</td>
        <td>Injection Subcutaneous</td>
        <td>Subkutan Injeksi (di bawah kulit)</td>
    </tr>
    <tr>
        <td>25</td>
        <td>http://www.whocc.no/atc</td>
        <td>inj.intramuscular</td>
        <td>Injection Intramuscular</td>
        <td>Intramuskular Injeksi (di dalam otot)</td>
    </tr>
    <tr>
        <td>26</td>
        <td>http://www.whocc.no/atc</td>
        <td>inj.intravenous</td>
        <td>Injection Intravenous</td>
        <td>Intravena Injeksi (ke pembuluh darah)</td>
    </tr>
    <tr>
        <td>27</td>
        <td>http://www.whocc.no/atc</td>
        <td>inj.intrathecal</td>
        <td>Injection Intrathecal</td>
        <td>Intratekal Injeksi (sekitar sumsum tulang belakang)</td>
    </tr>
    <tr>
        <td>28</td>
        <td>http://www.whocc.no/atc</td>
        <td>Chewing Gum</td>
        <td>Chewing Gum</td>
        <td>Dikunyah</td>
    </tr>
    <tr>
        <td>29</td>
        <td>http://www.whocc.no/atc</td>
        <td>ointment</td>
        <td>ointment</td>
        <td>Topikal</td>
    </tr>
    <tr>
        <td>30</td>
        <td>http://www.whocc.no/atc</td>
        <td>stomatologic</td>
        <td>stomatologic</td>
        <td>stomatologic</td>
    </tr>
</table>
        </div>
	</div>
<br>
<!--END Part 10-1-->

<!--Part 10-2-->
<h4 style="font-weight: bold;">Pengeluaran Obat</h4>
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-7-3" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-7-3" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-7-3" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-7-3" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-7-3">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-MedicationDispense-Create-Pengeluaran-Peresepan-Obat-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-7-3" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "MedicationDispense",
    "identifier":  [
        {
            "system": "http://sys-ids.kemkes.go.id/prescription/<strong style="color:#00a7ff">&lcub;&lcub;ORGANIZATION_IHS_NUMBER&rcub;&rcub;</strong>",
            "use": "official",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATIONDISPENSE_LOCAL_CODE&rcub;&rcub;</strong>"
        },
        {
            "system": "http://sys-ids.kemkes.go.id/prescription-item/<strong style="color:#00a7ff">&lcub;&lcub;ORGANIZATION_IHS_NUMBER&rcub;&rcub;</strong>",
            "use": "official",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION_LOCAL_CODE&rcub;&rcub;</strong>"
        }
    ],
    "status": "completed",
    "category": {
        "coding":  [
            {
                "system": "http://terminology.hl7.org/fhir/CodeSystem/medicationdispense-category",
                "code": "outpatient",
                "display": "Outpatient"
            }
        ]
    },
    "medicationReference": {
        "reference": "Medication/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_MEDICATION&rcub;&rcub;</strong>"
    },
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>",
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "context": {
        "reference": "Encounter/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_ENCOUNTER&rcub;&rcub;</strong>"
    },
    "performer":  [
        {
            "actor": {
                "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_NAME&rcub;&rcub;</strong>"
            }
        }
    ],
    "location": {
        "reference": "Location/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_LOCATION&rcub;&rcub;</strong>",
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_DISPLAY&rcub;&rcub;</strong>"
    },
    "authorizingPrescription":  [
        {
            "reference": "MedicationRequest/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_MEDICATIONREQUEST&rcub;&rcub;</strong>"
        }
    ],
    "quantity": {
        "system": "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm",
        "code": "<strong style="color:#00a7ff">&lcub;&lcub;DISPENSE_QTY_UNIT&rcub;&rcub;</strong>",
        "value": "<strong style="color:#00a7ff">&lcub;&lcub;DISPENSE_QTY&rcub;&rcub;</strong>"
    },
    "daysSupply": {
        "value": <strong style="color:#00a7ff">&lcub;&lcub;DISPENSE_SUPPLY&rcub;&rcub;</strong>,
        "unit": "Day",
        "system": "http://unitsofmeasure.org",
        "code": "d"
    },
    "whenPrepared": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION_PREPARED_DATE&rcub;&rcub;</strong>",
    "whenHandedOver": "<strong style="color:#00a7ff">&lcub;&lcub;MEDICATION_DISPENSE_DATE&rcub;&rcub;</strong>",
    "dosageInstruction":  [
        {
            "sequence": "<strong style="color:#00a7ff">&lcub;&lcub;DOSAGE_SEQUENCE_NO&rcub;&rcub;</strong>",
            "text": "<strong style="color:#00a7ff">&lcub;&lcub;DOSAGE_INSTRUCTION&rcub;&rcub;</strong>",
            "timing": {
                "repeat": {
                    "frequency": "<strong style="color:#00a7ff">&lcub;&lcub;DOSAGE_TIMING_REPEAT&rcub;&rcub;</strong>",
                    "period": "<strong style="color:#00a7ff">&lcub;&lcub;DOSAGE_TIMING_REPEAT&rcub;&rcub;</strong>",
                    "periodUnit": "<strong style="color:#00a7ff">&lcub;&lcub;DOSAGE_TIMING_REPEAT&rcub;&rcub;</strong>"
                }
            },
            "doseAndRate":  [
                {
                    "type": {
                        "coding":  [
                            {
                                "system": "http://terminology.hl7.org/CodeSystem/dose-rate-type",
                                "code": "ordered",
                                "display": "Ordered"
                            }
                        ]
                    },
                    "doseQuantity": {
                        "value": "<strong style="color:#00a7ff">&lcub;&lcub;DOSE_QTY&rcub;&rcub;</strong>",
                        "unit": "<strong style="color:#00a7ff">&lcub;&lcub;DOSE_QTY&rcub;&rcub;</strong>",
                        "system": "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm",
                        "code": "<strong style="color:#00a7ff">&lcub;&lcub;DOSE_QTY&rcub;&rcub;</strong>"
                    }
                }
            ]
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-7-3" style="border: 1px solid #e8edee; padding: 15px 10px;">


| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__   			| &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __MEDICATIONDISPENSE_LOCAL_CODE__    		| ID Lokal dispense secara umum Merupakan ID lokal di masing-masing institusi yang merepresentasikan suatu dispense terhadap satu resep yang dibuat oleh dokter (dapat terdiri dari lebih dari 1 obat dalam 1 resep).  |
| __MEDICATION_LOCAL_CODE__    		| ID Lokal Peresepan per-item obat Merupakan ID lokal di masing-masing institusi untuk setiap obat yang diresepkan dalam suatu resep.  |
| __ID_RESOURCE_MEDICATION__    		| Berisi data informasi obat yang diresepkan dengan tipe data Reference, yang direferensikan ke data yang tersimpan di resource Medication, yang nilainya merujuk ke &lcub;id-resource-MedicationReference&rcub; pada SATUSEHAT |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __PATIENT_NAME__      			| Nama pasien |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __MEDICATIONREQUEST_AUTHORED_DATE__      		| Berisi data waktu peresepan dengan tipe data dateTime, dengan format yang diperbolehkan YYYY-MM-DDThh:mm:ss+zz:zz. |
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __PRACTITIONER_NAME__    				| Nama dokter|
| __ID_RESOURCE_LOCATION__    			| &lcub;id-resource-location&rcub; pada SATUSEHAT |
| __LOCATION_DISPLAY__    			| Deskripsi lokasi |
| __ID_RESOURCE_MEDICATIONREQUEST__    			| &lcub;id-resource-MedicationRequest&rcub; pada SATUSEHAT |
| __DISPENSE_QTY_UNIT__    			| Nilai satuan kekuatan zat aktif |
| __DISPENSE_QTY__    			| Berisi data jumlah obat yang dikeluarkan dalam bentuk numerical dengan tipe data SimpleQuantity. |
| __DISPENSE_SUPPLY__    			| Berisi data jumlah pengobatan yang dinyatakan dalam satuan hari dengan tipe data SimpleQuantity. |
| __MEDICATION_PREPARED_DATE__    				| Berisi data yang berkaitan dengan kapan obat dikemas dan dicek dengan tipe data dateTime dengan format yang diperbolehkan  YYYY-MM-DDThh:mm:ss+zz:zz. |
| __MEDICATION_DISPENSE_DATE__    				| Berisi data yang berisikan data waktu pemberian obat kepada pasien atau penanggungjawab pasien dengan tipe data dateTime dengan format yang diperbolehkan  YYYY-MM-DDThh:mm:ss+zz:zz. |
| __DOSAGE_SEQUENCE_NO__    				| Berisi data paket aturan pakai dengan nilai sequence dengan tipe data integer.|
| __DOSAGE_INSTRUCTION__    				| Berisi satu atau lebih data aturan pakai obat dalam bentuk naratif dengan tipe data string.|
| __DOSAGE_TIMING_REPEAT__    				| __(*)__ berisi aturan kapan suatu obat harus dikonsumsi. Cara Pengisian referensi ke value set "Lampiran Aturan Konsumsi Obat"|
| __DOSE_QTY__    				| __(*)__ Berisi data jumlah obat yang diberikan perdosis. Cara Pengisian referensi ke value set "Lampiran Aturan Konsumsi Obat"|

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-7-3" style="border: 1px solid #e8edee; padding: 15px 10px;">

Lampiran Aturan Konsumsi Obat dapat diakses pada <a href="https://satusehat.kemkes.go.id/platform/docs/id/interoperability/anc-prio/#_13_pengiriman_data_peresepan_obat_tablet_tambah_darah:~:text=dalam%20Tabel%2015.-,Tabel%2016.,-Tatacara%20pengisian%20MedicationDispense">SATUSEHAT Portal - Tabel 16. Tatacara pengisian MedicationDispense.dosageInstruction[i].timing.repeat</a><br>
        </div>
	</div>
<br>
</div>
<!--END Part 10-->

<!--Part 11-->
### <div id="step11" style="font-weight: bold">Step 11. Data Diagnosis</div>
<!--Part 3-8-1 Variable Data Diagnosis-->
<div style="margin-left: 30px;">
Data diagnosis pasien dapat dikirimkan menggunakan resource Condition. Informasi diagnosis yang dimiliki pasien dilaporkan menggunakan kode ICD-10. Satu payload Condition hanya dapat digunakan untuk melaporkan 1 kode ICD-10. Sehingga apabila pasien memiliki 2 diagnosis, maka dikirimkan 2 payload Condition dengan 2 kode ICD-10 yang berbeda.

<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-8-1" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-8-1" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-8-1" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-8-1" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-8-1">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Condition-Create-Diagnosis-Pasien-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-8-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
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
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;CONDITION_VALUE&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;CONDITION_VALUE&rcub;&rcub;</strong>"
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

<div role="tabpanel" class="tab-pane" id="variabel-3-8-1" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __PATIENT_IHS_NUMBER__      | &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __PATIENT_NAME__           | Nama Pasien |
| __CONDITION_VALUE__           | Berisi data diagnosis menggunakan ICD-10 tahun 2010 |
| __CONDITION_ONSET_DATETIME__ | Tanggal perkiraan atau tanggal aktual atau tanggal-waktu kondisi mulai, menurut pendapat dokter.|
| __CONDITION_RECORDED_DATETIME__ | 	Tanggal kapan kondisi/keluhan ini tercatat dalam sistem (tanggal yang dibuat oleh sistem)|

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-8-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
            <div>
                [none]
            </div>
        </div>
<br>
</div>
<!--END Part 3-8-1-->
</div>
<!--END Part 11-->

<!--Part 12-->
### <div id="step12" style="font-weight: bold">Step 12. Kondisi Saat Meninggalkan Faskes</div>
<div style="margin-left: 30px;">

<!--Part 12-1-->
<h4>Kondisi Saat Keluar Faskes</h4>
    
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-9-1" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-9-1" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-9-1" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-9-1" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-9-1">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-Condition-Create-Kondisi-Pasien-Pulang-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-9-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
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
                "system": "<strong style="color:#00a7ff">&lcub;&lcub;CONDITION_VALUE&rcub;&rcub;</strong>",
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;CONDITION_VALUE&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;CONDITION_VALUE&rcub;&rcub;</strong>"
            }
        ]
    },
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>",
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "encounter": {
        "reference": "Encounter/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_ENCOUNTER&rcub;&rcub;</strong>"
    }
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-9-1" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __PATIENT_IHS_NUMBER__      | &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __PATIENT_NAME__           | Nama Pasien |
| __CONDITION_VALUE__           | Berisi data kondisi saat meninggalkan rumah sakit. Referensi ke value set "Kondisi saat meninggalkan rumah sakit" |
| __CONDITION_ONSET_DATETIME__ | Tanggal perkiraan atau tanggal aktual atau tanggal-waktu kondisi mulai, menurut pendapat dokter.|
| __CONDITION_RECORDED_DATETIME__ | 	Tanggal kapan kondisi/keluhan ini tercatat dalam sistem (tanggal yang dibuat oleh sistem)|

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-9-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
Kondisi saat meninggalkan rumah sakit
<table class="table-fhir-resources" style="table-layout: fixed; width: 100%">
    <tr>
        <th style="width: 5%">No.</th>
        <th>Condition.code.coding.system</th>
        <th>Condition.code.coding.code</th>
        <th>Condition.code.coding.display</th>
        <th>Keterangan </th>
    </tr>
    <tr>
        <td>1</td>
        <td>http://snomed.info/sct</td>
        <td>359746009</td>
        <td>Patient's condition stable</td>
        <td>Stabil</td>
    </tr>
    <tr>
        <td>2</td>
        <td>http://snomed.info/sctc</td>
        <td>162668006</td>
        <td>Patient's condition unstable</td>
        <td>Tidak stabil</td>
    </tr>
    <tr>
        <td>3</td>
        <td>http://snomed.info/sctc</td>
        <td>268910001</td>
        <td>Patient's condition improved</td>
        <td>Perbaikan</td>
    </tr>
</table>
        </div>
    </div>
<br>
<!--END Part 3-9-1-->


<!--Part 12-2-->
<h4>Waktu Kematian</h4>
    
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-12-2" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-12-2" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-12-2" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-12-2" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-12-2">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC/Observation-Create-Waktu-Kematian-1.json}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-12-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "exam",
                    "display": "Exam"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://loinc.org",
                "code": "81956-5",
                "display": "Date and time of death [TimeStamp]"
            },
            {
                "system": "http://terminology.kemkes.go.id/CodeSystem/anc-custom-codes",
                "code": "ANC.SS.DE56",
                "display": "Waktu Kematian"
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
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>"
        }
    ],
    "valueDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_VALUE&rcub;&rcub;</strong>"
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-12-2" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __PATIENT_IHS_NUMBER__      			| &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __ID_RESOURCE_ENCOUNTER__      		| &lcub;id-resource-Encounter&rcub; pada SATUSEHAT untuk data kunjungan |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __PRACTITIONER_IHS_NUMBER__    				| &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __OBSERVATION_VALUE__          		| Nilai observasi |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-12-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
            <div>
                [none]
            </div>
        </div>
    </div>
<br>
<!--END Part 12-2-->
</div>
<!--END Part 12-->

<!--Part 13-->
### <div id="step13" style="font-weight: bold">Step 13. Rencana Tindak lanjut / Cara Keluar</div>

<div style="margin-left: 30px;">
<p>
Kunjungan selesai Saat kunjungan pasien selesai, dilakukan pembaharuan data kunjungan dengan menambahkan informasi diagnosis, periode kunjungan selesai, kondisi saat meninggalkan fasilitas pelayanan kesehatan, dan rencana tindak lanjut/cara keluar dari fasilitas pelayanan kesehatan, kunjungan ANC serta UUID dari EpisodeOfCare untuk kehamilan yang terkait. Pengiriman data dilakukan melalui metode PUT. Isi Encounter.id dengan UUID balikan dari SATUSEHAT setelah melakukan POST data kunjungan pertama kali.
</p>


<!--Part 13-1-1-->
<h4 style="font-weight: bold;">Pasien dipulangkan dan kontrol kembali</h4>

<div style="margin-left: 30px;">
<h4 style="font-weight: bold;">Update Data Kunjungan</h4>
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-10-2" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-10-2" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-10-2" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-10-2" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-10-2">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC/Encounter-Create-Pembaharuan-Kunjungan-Dipulangkan.json}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-10-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Encounter",
    "identifier": [
        {
            "system": "http://sys-ids.kemkes.go.id/encounter/<strong style="color:#00a7ff">&lcub;&lcub;ORGANIZATION_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_LOCAL_CODE&rcub;&rcub;</strong>"
        },
        {
            "system": "http://terminology.kemkes.go.id/CodeSystem/episodeofcare/ANC",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;STATUS_KUNJUNGAN_ANC&rcub;&rcub;</strong>"
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
                "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_NAME&rcub;&rcub;</strong>"
            }
        }
    ],
    "period": {
        "start": "<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_PERIOD1_START&rcub;&rcub;</strong>"
        "end": "<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_PERIOD1_END&rcub;&rcub;</strong>"
    },
    "location": [
        {
            "location": {
                "reference": "Location/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_LOCATION&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_NAME&rcub;&rcub;</strong>"
            }
        }
    ],
    "diagnosis":  [
        {
            "condition": {
                "reference": "Condition/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_CONDITION&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;DIAGNOSIS_DISPLAY&rcub;&rcub;</strong>"
            },
            "use": {
                "coding":  [
                    {
                        "system": "http://terminology.hl7.org/CodeSystem/diagnosis-role",
                        "code": "DD",
                        "display": "Discharge diagnosis"
                    }
                ]
            },
            "rank": <strong style="color:#00a7ff">&lcub;&lcub;DIAGNOSIS_RANK&rcub;&rcub;</strong>
        }
    ],
    "statusHistory":  [
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
                "start": "<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_PERIOD1_START&rcub;&rcub;</strong>",
                "end": "<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_PERIOD1_END&rcub;&rcub;</strong>"
            }
        },
        {
            "status": "finished",
            "period": {
                "start": "<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_PERIOD1_START&rcub;&rcub;</strong>",
                "end": "<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_PERIOD1_END&rcub;&rcub;</strong>"
            }
        }
    ],
    "hospitalization": {
        "dischargeDisposition": {
            "coding":  [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/discharge-disposition",
                    "code": "home",
                    "display": "Home"
                }
            ],
            "text": "<strong style="color:#00a7ff">&lcub;&lcub;HOSPITALIZATION_DESCRIPTION&rcub;&rcub;</strong>"
        }
    },
    "serviceProvider": {
        "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;ORGANIZATION_IHS_NUMBER&rcub;&rcub;</strong>"
    },
    "episodeOfCare":  [
        {
            "reference": "EpisodeOfCare/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_EPISODEOFCARE&rcub;&rcub;</strong>"
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-10-2" style="border: 1px solid #e8edee; padding: 15px 10px;">


| Variabel                   | Deskripsi |
| ---------------------------| --------- |
| __ORGANIZATION_IHS_NUMBER__    | &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __ENCOUNTER_LOCAL_CODE__   | ID Lokal untuk Kunjungan/Encounter |
| __STATUS_KUNJUNGAN_ANC__   | __(*)__ Status kunjungan ANC yang menyatakan apakah kunjungan tersebut masuk kedalam kunjungan K1 akses, kunjungan K1 murni, kunjungan K2 dan lain sebagainya. Referensi ke value set "Status Kunjungan ANC"|
| __PATIENT_IHS_NUMBER__     | &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __PATIENT_NAME__           | Nama Pasien |
| __PRACTITIONER_IHS_NUMBER__      | &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __DOCTOR_NAME__            | Nama Dokter/Nakes |
| __ENCOUNTER_PERIOD1_START__| Waktu mulai/check-in kunjungan |
| __ENCOUNTER_PERIOD1_END__  | Waktu selesai/check-out kunjungan |
| __ID_RESOURCE_LOCATION__  | ID Location tempat kunjungan dilakukan |
| __LOCATION_NAME__  | Nama lokasi tempat dilakukan kunjungan |
| __ID_RESOURCE_CONDITION__  | Berisi satu atau lebih data diagnosis dari pasien. Diagnosa bisa berupa diagnosa awal dan/atau pulang dengan tipe data Reference, yang direferensikan ke data yang tersimpan di resource Condition. Di mana isi dari parameter {id-resource-Condition} adalah ID Condition yang didapatkan dari server. |
| __DIAGNOSIS_DISPLAY__  | Deskripsi diagnosis  |
| __DIAGNOSIS_RANK__  | Jika ada lebih dari 1 kondisi, maka gunakan elemen rank untuk mengurutkan mana diagnosa yang lebih utama. Semakin kecil angkanya, maka semakin utama, dengan tipe data positiveInt.  |
| __HOSPITALIZATION_DESCRIPTION__| Berisi data kategori atau tipe lokasi setelah pasien dipulangkan dengan tipe data free-text |
| __ID_RESOURCE_EPISODEOFCARE__| &lcub;ihs-resource-EpisodeOfCare&rcub; pada SATUSEHAT |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-10-2" style="border: 1px solid #e8edee; padding: 15px 10px;">

<div>Status kunjungan ANC</div>

| No | Kode | Display | System  |
|-|-|-|-|
| 1 | K1A | Kunjungan K1 akses | [http://terminology.kemkes.go.id/CodeSystem/episodeofcare/ANC](http://terminology.kemkes.go.id/CodeSystem/episodeofcare/ANC)  |
| 2 | K1M | Kunjungan K1 murni | http://terminology.kemkes.go.id/CodeSystem/episodeofcare/ANC  |
| 3 | K2 | Kunjungan K2 | http://terminology.kemkes.go.id/CodeSystem/episodeofcare/ANC  |
| 4 | K3 | Kunjungan K3 | http://terminology.kemkes.go.id/CodeSystem/episodeofcare/ANC  |
| 5 | K4 | Kunjungan K4 | http://terminology.kemkes.go.id/CodeSystem/episodeofcare/ANC  |
| 6 | K5 | Kunjungan K5 | http://terminology.kemkes.go.id/CodeSystem/episodeofcare/ANC  |
| 7 | K6 | Kunjungan K6 | http://terminology.kemkes.go.id/CodeSystem/episodeofcare/ANC  |

</div>
</div>
<br>
<!--END Part 13-1-1-->

<!--END Part 13-1-2-->
<h4 style="font-weight: bold;">Instruksi untuk Kontrol Kembali</h4>
    
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-11-1" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-11-1" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-11-1" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-11-1" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-11-1">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-ServiceRequest-Create-PermintaanKontrolBulanan-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-11-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "ServiceRequest",
    "identifier":  [
        {
            "system": "http://sys-ids.kemkes.go.id/servicerequest/<strong style="color:#00a7ff">&lcub;&lcub;ORGANIZATION_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;SERVICEREQUEST_LOCAL_CODE&rcub;&rcub;</strong>"
        }
    ],
    "status": "active",
    "intent": "original-order",
    "priority": "routine",
    "code": {
        "coding":  [
            {
                "system": "http://snomed.info/sct",
                "code": "3457005",
                "display": "Patient referral (procedure)"
            }
        ]
    },
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>"
    },
    "encounter": {
        "reference": "Encounter/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_ENCOUNTER&rcub;&rcub;</strong>"
    },
    "occurrenceDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;SERVICEREQUEST_OCCUR&rcub;&rcub;</strong>",
    "requester": {
        "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER1&rcub;&rcub;</strong>",
                "display": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_NAME1&rcub;&rcub;</strong>"
    },
    "performer":  [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER2&rcub;&rcub;</strong>",
                "display": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_NAME2&rcub;&rcub;</strong>"
        }
    ],
    "reasonCode":  [
        {
            "coding":  [
                {
                    "system": "<strong style="color:#00a7ff">&lcub;&lcub;SERVICEREQUEST_REASON_CODE&rcub;&rcub;</strong>",
                    "code": "<strong style="color:#00a7ff">&lcub;&lcub;SERVICEREQUEST_REASON_CODE&rcub;&rcub;</strong>",
                    "display": "<strong style="color:#00a7ff">&lcub;&lcub;SERVICEREQUEST_REASON_CODE&rcub;&rcub;</strong>"
                }
            ],
            "text": "<strong style="color:#00a7ff">&lcub;&lcub;SERVICEREQUEST_REASON&rcub;&rcub;</strong>"
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-11-1" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                   | Deskripsi |
| ---------------------------| --------- |
| __ORGANIZATION_IHS_NUMBER__    | &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __ENCOUNTER_LOCAL_CODE__   | ID Lokal untuk Kunjungan/Encounter |
| __STATUS_KUNJUNGAN_ANC__   | __(*)__ Status kunjungan ANC yang menyatakan apakah kunjungan tersebut masuk kedalam kunjungan K1 akses, kunjungan K1 murni, kunjungan K2 dan lain sebagainya. Referensi ke value set "Status Kunjungan ANC"|
| __PATIENT_IHS_NUMBER__     | &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __PATIENT_NAME__           | Nama Pasien |
| __PRACTITIONER_IHS_NUMBER__      | &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __DOCTOR_NAME__            | Nama Dokter/Nakes |
| __ENCOUNTER_PERIOD1_START__| Waktu mulai/check-in kunjungan |
| __ENCOUNTER_PERIOD1_END__  | Waktu selesai/check-out kunjungan |
| __ID_RESOURCE_LOCATION__  | ID Location tempat kunjungan dilakukan |
| __LOCATION_NAME__  | Nama lokasi tempat dilakukan kunjungan |
| __ID_RESOURCE_CONDITION__  | Berisi satu atau lebih data diagnosis dari pasien. Diagnosa bisa berupa diagnosa awal dan/atau pulang dengan tipe data Reference, yang direferensikan ke data yang tersimpan di resource Condition. Di mana isi dari parameter {id-resource-Condition} adalah ID Condition yang didapatkan dari server. |
| __DIAGNOSIS_DISPLAY__  | Deskripsi diagnosis  |
| __DIAGNOSIS_RANK__  | Jika ada lebih dari 1 kondisi, maka gunakan elemen rank untuk mengurutkan mana diagnosa yang lebih utama. Semakin kecil angkanya, maka semakin utama, dengan tipe data positiveInt.  |
| __HOSPITALIZATION_DESCRIPTION__| Berisi data kategori atau tipe lokasi setelah pasien dipulangkan dengan tipe data free-text |
| __ID_RESOURCE_EPISODEOFCARE__| &lcub;ihs-resource-EpisodeOfCare&rcub; pada SATUSEHAT |
| __SERVICEREQUEST_LOCATION__| Berisi data mengenai informasi lokasi di mana permintaan seharusnya terjadi, dalam bentuk kode |
| __DISCHARGE_INSTRUCTION__| Berisi data instruksi untuk pasien. Data terkait “Dalam Keadaan Darurat dapat Menghubungi” dapat diisikan dalam elemen ini dengan tipe data string. |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-3-11-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
            <div>
                [none]
            </div>
        </div>
    </div>
<br>
<!--END Part 13-1-2-->
</div>
<!--END Part 13-1-->

<!--Part 13-2-->
<h4 style="font-weight: bold;">Apabila pasien dirujuk</h4>
<div style="margin-left: 30px;">
<!--Part 13-2-1-->
<h4 style="font-weight: bold;">Update Data Kunjungan</h4>
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-13-2-1" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-13-2-1" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-13-2-1" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-13-2-1" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-13-2-1">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC/Encounter-Create-Pembaharuan-Kunjungan-Dirujuk.json}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-13-2-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Encounter",
    "identifier": [
        {
            "system": "http://sys-ids.kemkes.go.id/encounter/<strong style="color:#00a7ff">&lcub;&lcub;ORGANIZATION_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_LOCAL_CODE&rcub;&rcub;</strong>"
        },
        {
            "system": "http://terminology.kemkes.go.id/CodeSystem/episodeofcare/ANC",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;STATUS_KUNJUNGAN_ANC&rcub;&rcub;</strong>"
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
                "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_NAME&rcub;&rcub;</strong>"
            }
        }
    ],
    "period": {
        "start": "<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_PERIOD1_START&rcub;&rcub;</strong>"
        "end": "<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_PERIOD1_END&rcub;&rcub;</strong>"
    },
    "location": [
        {
            "location": {
                "reference": "Location/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_LOCATION&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_NAME&rcub;&rcub;</strong>"
            }
        }
    ],
    "diagnosis":  [
        {
            "condition": {
                "reference": "Condition/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_CONDITION&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;DIAGNOSIS_DISPLAY&rcub;&rcub;</strong>"
            },
            "use": {
                "coding":  [
                    {
                        "system": "http://terminology.hl7.org/CodeSystem/diagnosis-role",
                        "code": "DD",
                        "display": "Discharge diagnosis"
                    }
                ]
            },
            "rank": <strong style="color:#00a7ff">&lcub;&lcub;DIAGNOSIS_RANK&rcub;&rcub;</strong>
        }
    ],
    "statusHistory":  [
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
                "start": "<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_PERIOD1_START&rcub;&rcub;</strong>",
                "end": "<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_PERIOD1_END&rcub;&rcub;</strong>"
            }
        },
        {
            "status": "finished",
            "period": {
                "start": "<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_PERIOD1_START&rcub;&rcub;</strong>",
                "end": "<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_PERIOD1_END&rcub;&rcub;</strong>"
            }
        }
    ],
    "hospitalization": {
        "dischargeDisposition": {
            "coding":  [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/discharge-disposition",
                    "code": "home",
                    "display": "Home"
                }
            ],
            "text": "<strong style="color:#00a7ff">&lcub;&lcub;HOSPITALIZATION_DESCRIPTION&rcub;&rcub;</strong>"
        }
    },
    "serviceProvider": {
        "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;ORGANIZATION_IHS_NUMBER&rcub;&rcub;</strong>"
    },
    "episodeOfCare":  [
        {
            "reference": "EpisodeOfCare/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_EPISODEOFCARE&rcub;&rcub;</strong>"
        }
    ]
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-13-2-1" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                   | Deskripsi |
| ---------------------------| --------- |
| __ORGANIZATION_IHS_NUMBER__    | &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __ENCOUNTER_LOCAL_CODE__   | ID Lokal untuk Kunjungan/Encounter |
| __STATUS_KUNJUNGAN_ANC__   | __(*)__ Status kunjungan ANC yang menyatakan apakah kunjungan tersebut masuk kedalam kunjungan K1 akses, kunjungan K1 murni, kunjungan K2 dan lain sebagainya. Referensi ke value set "Status Kunjungan ANC"|
| __PATIENT_IHS_NUMBER__     | &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __PATIENT_NAME__           | Nama Pasien |
| __PRACTITIONER_IHS_NUMBER__      | &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __DOCTOR_NAME__            | Nama Dokter/Nakes |
| __ENCOUNTER_PERIOD1_START__| Waktu mulai/check-in kunjungan |
| __ENCOUNTER_PERIOD1_END__  | Waktu selesai/check-out kunjungan |
| __ID_RESOURCE_LOCATION__  | ID Location tempat kunjungan dilakukan |
| __LOCATION_NAME__  | Nama lokasi tempat dilakukan kunjungan |
| __ID_RESOURCE_CONDITION__  | Berisi satu atau lebih data diagnosis dari pasien. Diagnosa bisa berupa diagnosa awal dan/atau pulang dengan tipe data Reference, yang direferensikan ke data yang tersimpan di resource Condition. Di mana isi dari parameter {id-resource-Condition} adalah ID Condition yang didapatkan dari server. |
| __DIAGNOSIS_DISPLAY__  | Deskripsi diagnosis  |
| __DIAGNOSIS_RANK__  | Jika ada lebih dari 1 kondisi, maka gunakan elemen rank untuk mengurutkan mana diagnosa yang lebih utama. Semakin kecil angkanya, maka semakin utama, dengan tipe data positiveInt.  |
| __HOSPITALIZATION_DESCRIPTION__| Berisi data kategori atau tipe lokasi setelah pasien dipulangkan dengan tipe data free-text |
| __ID_RESOURCE_EPISODEOFCARE__| &lcub;ihs-resource-EpisodeOfCare&rcub; pada SATUSEHAT |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-13-2-1" style="border: 1px solid #e8edee; padding: 15px 10px;">

<div>Status kunjungan ANC</div>

| No | Kode | Display | System  |
|-|-|-|-|
| 1 | K1A | Kunjungan K1 akses | [http://terminology.kemkes.go.id/CodeSystem/episodeofcare/ANC](http://terminology.kemkes.go.id/CodeSystem/episodeofcare/ANC)  |
| 2 | K1M | Kunjungan K1 murni | http://terminology.kemkes.go.id/CodeSystem/episodeofcare/ANC  |
| 3 | K2 | Kunjungan K2 | http://terminology.kemkes.go.id/CodeSystem/episodeofcare/ANC  |
| 4 | K3 | Kunjungan K3 | http://terminology.kemkes.go.id/CodeSystem/episodeofcare/ANC  |
| 5 | K4 | Kunjungan K4 | http://terminology.kemkes.go.id/CodeSystem/episodeofcare/ANC  |
| 6 | K5 | Kunjungan K5 | http://terminology.kemkes.go.id/CodeSystem/episodeofcare/ANC  |
| 7 | K6 | Kunjungan K6 | http://terminology.kemkes.go.id/CodeSystem/episodeofcare/ANC  |
</div>
</div>
<br>
<!--END Part 13-2-1-->

<!--Part 13-2-2-->
<h4 style="font-weight: bold;">Instruksi pasien dirujuk</h4>
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-10-1" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-10-1" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-10-1" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-10-1" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-10-1">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:ANC-ServiceRequest-Create-PermintaanRujukan-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-10-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "ServiceRequest",
    "identifier":  [
        {
            "system": "http://sys-ids.kemkes.go.id/servicerequest/<strong style="color:#00a7ff">&lcub;&lcub;ORGANIZATION_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;SERVICEREQUEST_LOCAL_CODE&rcub;&rcub;</strong>"
        }
    ],
    "status": "active",
    "intent": "original-order",
    "priority": "routine",
    "code": {
        "coding":  [
            {
                "system": "http://snomed.info/sct",
                "code": "3457005",
                "display": "Patient referral (procedure)"
            }
        ]
    },
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>"
    },
    "encounter": {
        "reference": "Encounter/<strong style="color:#00a7ff">&lcub;&lcub;ID_RESOURCE_ENCOUNTER&rcub;&rcub;</strong>"
    },
    "occurrenceDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;SERVICEREQUEST_OCCUR&rcub;&rcub;</strong>",
    "requester": {
        "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER1&rcub;&rcub;</strong>",
                "display": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_NAME1&rcub;&rcub;</strong>"
    },
    "performer":  [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_IHS_NUMBER2&rcub;&rcub;</strong>",
                "display": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;PRACTITIONER_NAME2&rcub;&rcub;</strong>"
        }
    ],
    "reasonCode":  [
        {
            "coding":  [
                {
                    "system": "<strong style="color:#00a7ff">&lcub;&lcub;SERVICEREQUEST_REASON_CODE&rcub;&rcub;</strong>",
                    "code": "<strong style="color:#00a7ff">&lcub;&lcub;SERVICEREQUEST_REASON_CODE&rcub;&rcub;</strong>",
                    "display": "<strong style="color:#00a7ff">&lcub;&lcub;SERVICEREQUEST_REASON_CODE&rcub;&rcub;</strong>"
                }
            ],
            "text": "<strong style="color:#00a7ff">&lcub;&lcub;SERVICEREQUEST_REASON&rcub;&rcub;</strong>"
        }
    ],
    "locationCode":  [
        {
            "coding":  [
                {
                    "system": "<strong style="color:#00a7ff">&lcub;&lcub;SERVICEREQUEST_LOCATION&rcub;&rcub;</strong>",
                    "code": "<strong style="color:#00a7ff">&lcub;&lcub;SERVICEREQUEST_LOCATION&rcub;&rcub;</strong>",
                    "display": "<strong style="color:#00a7ff">&lcub;&lcub;SERVICEREQUEST_LOCATION&rcub;&rcub;</strong>"
                }
            ]
        }
    ],
    "patientInstruction": "<strong style="color:#00a7ff">&lcub;&lcub;DISCHARGE_INSTRUCTION&rcub;&rcub;</strong>"
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-10-1" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                   | Deskripsi |
| ---------------------------| --------- |
| __ORGANIZATION_IHS_NUMBER__    | &lcub;organization-ihs-number&rcub; pada SATUSEHAT |
| __ENCOUNTER_LOCAL_CODE__   | ID Lokal untuk Kunjungan/Encounter |
| __STATUS_KUNJUNGAN_ANC__   | __(*)__ Status kunjungan ANC yang menyatakan apakah kunjungan tersebut masuk kedalam kunjungan K1 akses, kunjungan K1 murni, kunjungan K2 dan lain sebagainya. Referensi ke value set "Status Kunjungan ANC"|
| __PATIENT_IHS_NUMBER__     | &lcub;patient-ihs-number&rcub; pada SATUSEHAT |
| __PATIENT_NAME__           | Nama Pasien |
| __PRACTITIONER_IHS_NUMBER__      | &lcub;practitioner-ihs-number&rcub; pada SATUSEHAT |
| __DOCTOR_NAME__            | Nama Dokter/Nakes |
| __ENCOUNTER_PERIOD1_START__| Waktu mulai/check-in kunjungan |
| __ENCOUNTER_PERIOD1_END__  | Waktu selesai/check-out kunjungan |
| __ID_RESOURCE_LOCATION__  | ID Location tempat kunjungan dilakukan |
| __LOCATION_NAME__  | Nama lokasi tempat dilakukan kunjungan |
| __ID_RESOURCE_CONDITION__  | Berisi satu atau lebih data diagnosis dari pasien. Diagnosa bisa berupa diagnosa awal dan/atau pulang dengan tipe data Reference, yang direferensikan ke data yang tersimpan di resource Condition. Di mana isi dari parameter {id-resource-Condition} adalah ID Condition yang didapatkan dari server. |
| __DIAGNOSIS_DISPLAY__  | Deskripsi diagnosis  |
| __DIAGNOSIS_RANK__  | Jika ada lebih dari 1 kondisi, maka gunakan elemen rank untuk mengurutkan mana diagnosa yang lebih utama. Semakin kecil angkanya, maka semakin utama, dengan tipe data positiveInt.  |
| __HOSPITALIZATION_DESCRIPTION__| Berisi data kategori atau tipe lokasi setelah pasien dipulangkan dengan tipe data free-text |
| __ID_RESOURCE_EPISODEOFCARE__| &lcub;ihs-resource-EpisodeOfCare&rcub; pada SATUSEHAT |
| __SERVICEREQUEST_LOCATION__| Berisi data mengenai informasi lokasi di mana permintaan seharusnya terjadi, dalam bentuk kode |
| __DISCHARGE_INSTRUCTION__| Berisi data instruksi untuk pasien. Data terkait “Dalam Keadaan Darurat dapat Menghubungi” dapat diisikan dalam elemen ini dengan tipe data string. |


> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>

        
<div role="tabpanel" class="tab-pane" id="valueset-3-10-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
            <div>
                [none]
            </div>
        </div>
    </div>
<br>
<!--END Part 13-2-2-->
    </div>
<!--END Part 13-2-->
    </div>

<!--Part 14-->
### <div id="step14" style="font-weight: bold">Step 14. Menutup Episode Kehamilan</div>
<!--Part 5-1 Menutup Episode Kehamilan-->
<div style="margin-left: 30px;">
<div>
Episode kehamilan yang didaftarkan saat pertama kali melakukan kunjungan ANC perlu ditutup untuk menandai berakhirnya periode kehamilan untuk seorang ibu. Informasi terkait penutupan episode kehamilan ini berkaitan dengan mengupdate nilai pada EpisodeOfCare.status dan menambahkan 1 objek EpisodeOfCare.statusHistory[i].status dengan isian “finished” serta mengisikan waktu penutupan episode kehamilan pada EpisodeOfCare.period.end dan EpisodeOfCare.statusHistory[i].periode.end dengan isian “finished” melalui metode PUT.<br><br>

Berakhirnya kehamilan ini dapat disebabkan oleh beberapa hal berikut:
<ol>
<li>Waktu terjadinya persalinan</li>
<li>Waktu terjadinya keguguran atau proses kuret.</li>
<li>Kehilangan kontak dan follow-up - tidak tersedianya informasi terkait berakhirnya kehamilan karena sistem tidak lagi mampu melacak pencatatan maupun follow-up terhadap episode kehamilan seorang ibu, maka waktu yang digunakan dapat memanfaatkan batas maksimum masa kehamilan dapat terjadi yaitu 44 minggu (308 hari) setelah tanggal HPHT.</li>
</ol>
</div>
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
        {{json:ANC/EpisodeOfCare-Create-Menutup-Episode-Kehamilan-1.json}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-5-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<pre   style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "EpisodeOfCare",
    "identifier": [
        {
            "system": "http://sys-ids.kemkes.go.id/episode-of-care/<strong style="color:#00a7ff">&lcub;&lcub;ORGANIZATION_IHS_NUMBER&rcub;&rcub;</strong>",
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
                "start": "<strong style="color:#00a7ff">&lcub;&lcub;EPISODEOFCARE_PERIOD1_START&rcub;&rcub;</strong>",
                "end": "<strong style="color:#00a7ff">&lcub;&lcub;EPISODEOFCARE_PERIOD1_END&rcub;&rcub;</strong>"
            }
        }
    ],
    "type": [
        {
            "coding": [
                {
                    "system": "http://terminology.kemkes.go.id/CodeSystem/episodeofcare-type",
                    "code": "ANC",
                    "display": "Antenatal Care"
                }
            ]
        }
    ],
    "patient": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>",
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "managingOrganization": {
        "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;ORGANIZATION_IHS_NUMBER&rcub;&rcub;</strong>"
    },
    "period": {
        "start": "<strong style="color:#00a7ff">&lcub;&lcub;EPISODEOFCARE_PERIOD1_START&rcub;&rcub;</strong>",
        "end": "<strong style="color:#00a7ff">&lcub;&lcub;EPISODEOFCARE_PERIOD1_END&rcub;&rcub;</strong>"
    }
}
</pre>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-5-1" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ORGANIZATION_IHS_NUMBER__    | ID organisasi induk yang didapatkan dari master sarana indeks |
| __EPISODEOFCARE_LOCAL_CODE__   | Berisi kode atau nomor internal sub organisasi |
| __EPISODEOFCARE_PERIOD1_START__| Waktu dimulainya suatu kategori status EpisodeOfCare |
| __EPISODEOFCARE_PERIOD1_END__| Diisi dengan waktu berakhirnya suatu kategori status EpisodeOfCare |
| __PATIENT_IHS_NUMBER__     | ID Patient yang didapatkan dari master pasien indeks |
| __PATIENT_NAME__           | Nama Pasien |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"

</div>
        
<div role="tabpanel" class="tab-pane" id="valueset-5-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
[none]
        </div>
    </div>
<br>
</div>
<!--END Part 14-->

## D. Referensi
<table style="background-color: #f6f8f8; border-radius: 10px;">
    <tr>
        <td style="padding: 10px 20px; width: 33%; vertical-align: top;">Postman ANC</td>
        <td style="padding: 10px 20px; ; width: 33%; vertical-align: top;">Playbook ANC </td>
        <td style="padding: 10px 20px; ; width: 33%; vertical-align: top;">Playbook ANC Prioritas SatuSehat</td>
    </tr>
    <tr>
        <td style="padding: 10px 20px; ;"><div style="background-color: lightblue; display: inline-block; border-radius: 4px; cursor: pointer; height: 32px; border: none; width: 123px; background-image: url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTI4IiBoZWlnaHQ9IjMyIiBmaWxsPSJub25lIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxyZWN0IHdpZHRoPSIxMjgiIGhlaWdodD0iMzIiIHJ4PSI0IiBmaWxsPSIjRkY2QzM3Ii8+PHBhdGggZD0iTTEyIDEwLjg4M2EuNS41IDAgMCAxIC43NTctLjQyOWw4LjUyOCA1LjExN2EuNS41IDAgMCAxIDAgLjg1OGwtOC41MjggNS4xMTdhLjUuNSAwIDAgMS0uNzU3LS40M1YxMC44ODRaTTI3Ljg4OSAyMC41MDloMS41OHYtMy4xOTdoMS42MTFsMS43MTMgMy4xOTdoMS43NjRsLTEuODg3LTMuNDZjMS4wMjctLjQxNCAxLjU2OC0xLjI5MiAxLjU2OC0yLjQ3NyAwLTEuNjY2LTEuMDc0LTIuNzktMy4wNzctMi43OWgtMy4yNzN2OC43MjdaTTI5LjQ2OCAxNnYtMi44OThoMS40NWMxLjE4IDAgMS43MDguNTQxIDEuNzA4IDEuNDcgMCAuOTMtLjUyOCAxLjQyOC0xLjcgMS40MjhIMjkuNDdaTTM5Ljc5NyAxNy43NTZjMCAuOTk3LS43MTIgMS40OTEtMS4zOTQgMS40OTEtLjc0MSAwLTEuMjM1LS41MjQtMS4yMzUtMS4zNTV2LTMuOTI5aC0xLjU0M3Y0LjE2OGMwIDEuNTcyLjg5NSAyLjQ2MyAyLjE4MiAyLjQ2My45OCAwIDEuNjctLjUxNiAxLjk2OS0xLjI0OWguMDY4djEuMTY0aDEuNDk1di02LjU0NmgtMS41NDJ2My43OTNaTTQ0LjQ2OCAxNi42NzNjMC0uOTQ2LjU3MS0xLjQ5MSAxLjM4NS0xLjQ5MS43OTcgMCAxLjI3NC41MjQgMS4yNzQgMS4zOTd2My45M2gxLjU0M1YxNi4zNGMuMDA0LTEuNTY4LS44OS0yLjQ2My0yLjI0MS0yLjQ2My0uOTggMC0xLjY1NC40NjktMS45NTIgMS4xOTdINDQuNHYtMS4xMTJoLTEuNDc0djYuNTQ2aDEuNTQydi0zLjgzNlpNNTMuMjE1IDIwLjUwOWgxLjU0MnYtNi41NDZoLTEuNTQydjYuNTQ2Wm0uNzc1LTcuNDc1Yy40OSAwIC44OTEtLjM3NS44OTEtLjgzNSAwLS40NjUtLjQtLjg0LS44OS0uODQtLjQ5NSAwLS44OTUuMzc1LS44OTUuODQgMCAuNDYuNC44MzUuODk0LjgzNVpNNTcuODg2IDE2LjY3M2MwLS45NDYuNTcxLTEuNDkxIDEuMzg1LTEuNDkxLjc5NyAwIDEuMjc0LjUyNCAxLjI3NCAxLjM5N3YzLjkzaDEuNTQzVjE2LjM0Yy4wMDQtMS41NjgtLjg5LTIuNDYzLTIuMjQxLTIuNDYzLS45OCAwLTEuNjU0LjQ2OS0xLjk1MiAxLjE5N2gtLjA3N3YtMS4xMTJoLTEuNDc0djYuNTQ2aDEuNTQydi0zLjgzNlpNNjYuNzAxIDIwLjUwOWgxLjU4MXYtMi45NWgxLjY3YzIuMDE2IDAgMy4wOTgtMS4yMSAzLjA5OC0yLjg4OSAwLTEuNjY2LTEuMDctMi44ODktMy4wNzYtMi44ODlINjYuN3Y4LjcyOFptMS41ODEtNC4yNXYtMy4xNTdoMS40NDljMS4xODQgMCAxLjcwOS42NCAxLjcwOSAxLjU2OSAwIC45MjgtLjUyNSAxLjU4OS0xLjcgMS41ODloLTEuNDU4Wk03Ny4xMTcgMjAuNjM2YzEuOTE3IDAgMy4xMzYtMS4zNSAzLjEzNi0zLjM3NSAwLTIuMDI4LTEuMjE5LTMuMzgzLTMuMTM2LTMuMzgzLTEuOTE4IDAtMy4xMzYgMS4zNTUtMy4xMzYgMy4zODMgMCAyLjAyNCAxLjIxOCAzLjM3NSAzLjEzNiAzLjM3NVptLjAwOC0xLjIzNWMtMS4wNiAwLTEuNTgtLjk0Ny0xLjU4LTIuMTQ0cy41Mi0yLjE1NiAxLjU4LTIuMTU2YzEuMDQ0IDAgMS41NjQuOTU5IDEuNTY0IDIuMTU2cy0uNTIgMi4xNDQtMS41NjQgMi4xNDRaTTg2LjczNiAxNS42OTNjLS4yMTMtMS4xMDgtMS4xLTEuODE1LTIuNjM0LTEuODE1LTEuNTc2IDAtMi42NS43NzUtMi42NDYgMS45ODYtLjAwNC45NTQuNTg0IDEuNTg1IDEuODQgMS44NDVsMS4xMTcuMjM0Yy42MDEuMTMyLjg4My4zNzUuODgzLjc0NiAwIC40NDctLjQ4Ni43ODQtMS4yMi43ODQtLjcwNyAwLTEuMTY3LS4zMDctMS4yOTktLjg5NWwtMS41MDQuMTQ1Yy4xOTIgMS4yMDIgMS4yMDEgMS45MTMgMi44MDggMS45MTMgMS42MzYgMCAyLjc5MS0uODQ4IDIuNzk1LTIuMDg4LS4wMDQtLjkzMy0uNjA1LTEuNTA0LTEuODQtMS43NzJsLTEuMTE3LS4yNGMtLjY2NS0uMTQ4LS45MjktLjM3OC0uOTI1LS43NTgtLjAwNC0uNDQzLjQ4Ni0uNzUgMS4xMy0uNzUuNzExIDAgMS4wODYuMzg4IDEuMjA2LjgxOWwxLjQwNi0uMTU0Wk05MS40MTcgMTMuOTYzaC0xLjI5MXYtMS41NjhoLTEuNTQzdjEuNTY4aC0uOTI5djEuMTkzaC45M3YzLjY0Yy0uMDEgMS4yMzEuODg1IDEuODM2IDIuMDQ0IDEuODAyYTMuMSAzLjEgMCAwIDAgLjkwOC0uMTUzbC0uMjYtMS4yMDZjLS4wODUuMDItLjI2LjA2LS40NTEuMDYtLjM4OCAwLS43LS4xMzctLjctLjc2di0zLjM4M2gxLjI5MnYtMS4xOTNaTTkyLjcwNyAyMC41MDloMS41NDN2LTMuOThjMC0uODA2LjUzNy0xLjM1MSAxLjIwMS0xLjM1MS42NTIgMCAxLjEuNDM4IDEuMSAxLjExMnY0LjIxOWgxLjUxM3YtNC4wODNjMC0uNzM3LjQzOS0xLjI0OCAxLjE4NC0xLjI0OC42MjIgMCAxLjExNy4zNjYgMS4xMTcgMS4xNzZ2NC4xNTVoMS41NDd2LTQuMzk0YzAtMS40NjItLjg0NC0yLjIzNy0yLjA0Ni0yLjIzNy0uOTUgMC0xLjY3NS40NjktMS45NjQgMS4xOTdoLS4wNjljLS4yNTEtLjc0MS0uODg2LTEuMTk3LTEuNzY4LTEuMTk3LS44NzggMC0xLjUzNC40NTEtMS44MDcgMS4xOTdoLS4wNzZ2LTEuMTEyaC0xLjQ3NXY2LjU0NlpNMTA1LjM2IDIwLjY0YzEuMDI3IDAgMS42NDEtLjQ4IDEuOTIyLTEuMDNoLjA1MXYuODk5aDEuNDgzdi00LjM4MWMwLTEuNzMtMS40MS0yLjI1LTIuNjU5LTIuMjUtMS4zNzYgMC0yLjQzMy42MTQtMi43NzQgMS44MDdsMS40NC4yMDRjLjE1NC0uNDQ3LjU4OC0uODMgMS4zNDItLjgzLjcxNiAwIDEuMTA4LjM2NiAxLjEwOCAxLjAxdi4wMjVjMCAuNDQzLS40NjQuNDY0LTEuNjE5LjU4OC0xLjI3LjEzNi0yLjQ4NC41MTUtMi40ODQgMS45OSAwIDEuMjg3Ljk0MiAxLjk2OSAyLjE5IDEuOTY5Wm0uNDAxLTEuMTMzYy0uNjQ0IDAtMS4xMDQtLjI5NC0xLjEwNC0uODYgMC0uNTkzLjUxNi0uODQgMS4yMDYtLjkzOC40MDUtLjA1NiAxLjIxNC0uMTU4IDEuNDE1LS4zMnYuNzcxYzAgLjczLS41ODggMS4zNDctMS41MTcgMS4zNDdaTTExMS45MSAxNi42NzNjMC0uOTQ2LjU3MS0xLjQ5MSAxLjM4NS0xLjQ5MS43OTcgMCAxLjI3NC41MjQgMS4yNzQgMS4zOTd2My45M2gxLjU0M1YxNi4zNGMuMDA0LTEuNTY4LS44OTEtMi40NjMtMi4yNDItMi40NjMtLjk4IDAtMS42NTMuNDY5LTEuOTUyIDEuMTk3aC0uMDc2di0xLjExMmgtMS40NzV2Ni41NDZoMS41NDN2LTMuODM2WiIgZmlsbD0iI2ZmZiIvPjwvc3ZnPg==');" onclick="window.open('https://www.postman.com/satusehat/workspace/satusehat-public/collection/27201552-bcb83802-dde7-4bb6-82bf-5d504a38f466?action=share&creator=19625975', '_blank');"></div></td>
        <td style="padding: 10px 20px; ;"><div style="display: inline-block; border-radius: 4px; cursor: pointer; height: 32px; border: none; width: 123px; background-image: url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB3aWR0aD0iMTI1IiB6b29tQW5kUGFuPSJtYWduaWZ5IiB2aWV3Qm94PSIwIDAgOTMuNzUgMzAuMDAwMDAxIiBoZWlnaHQ9IjQwIiBwcmVzZXJ2ZUFzcGVjdFJhdGlvPSJ4TWlkWU1pZCBtZWV0IiB2ZXJzaW9uPSIxLjAiPjxkZWZzPjxnLz48Y2xpcFBhdGggaWQ9ImE3ZDJlMzRmNmEiPjxwYXRoIGQ9Ik0gMS45NTcwMzEgMS4yNDYwOTQgTCA5MS45Njg3NSAxLjI0NjA5NCBMIDkxLjk2ODc1IDIzLjg3ODkwNiBMIDEuOTU3MDMxIDIzLjg3ODkwNiBaIE0gMS45NTcwMzEgMS4yNDYwOTQgIiBjbGlwLXJ1bGU9Im5vbnplcm8iLz48L2NsaXBQYXRoPjxjbGlwUGF0aCBpZD0iNzBhYjc4ZGEzNiI+PHBhdGggZD0iTSA0LjE0MDYyNSAxLjI0NjA5NCBMIDg5LjYwOTM3NSAxLjI0NjA5NCBDIDkwLjgxNjQwNiAxLjI0NjA5NCA5MS43OTI5NjkgMi4yMjI2NTYgOTEuNzkyOTY5IDMuNDI5Njg4IEwgOTEuNzkyOTY5IDIxLjUxOTUzMSBDIDkxLjc5Mjk2OSAyMi43MjY1NjIgOTAuODE2NDA2IDIzLjcwMzEyNSA4OS42MDkzNzUgMjMuNzAzMTI1IEwgNC4xNDA2MjUgMjMuNzAzMTI1IEMgMi45MzM1OTQgMjMuNzAzMTI1IDEuOTU3MDMxIDIyLjcyNjU2MiAxLjk1NzAzMSAyMS41MTk1MzEgTCAxLjk1NzAzMSAzLjQyOTY4OCBDIDEuOTU3MDMxIDIuMjIyNjU2IDIuOTMzNTk0IDEuMjQ2MDk0IDQuMTQwNjI1IDEuMjQ2MDk0ICIgY2xpcC1ydWxlPSJub256ZXJvIi8+PC9jbGlwUGF0aD48Y2xpcFBhdGggaWQ9IjM3ODA5ZDFmZWEiPjxwYXRoIGQ9Ik0gMTYuMTEzMjgxIDcuMjA3MDMxIEwgMTcuOTU3MDMxIDcuMjA3MDMxIEwgMTcuOTU3MDMxIDkuMDI3MzQ0IEwgMTYuMTEzMjgxIDkuMDI3MzQ0IFogTSAxNi4xMTMyODEgNy4yMDcwMzEgIiBjbGlwLXJ1bGU9Im5vbnplcm8iLz48L2NsaXBQYXRoPjxjbGlwUGF0aCBpZD0iMzQ1YzAxZDI0ZiI+PHBhdGggZD0iTSAxMC42Nzk2ODggNy4xOTkyMTkgTCAxNy45NTcwMzEgNy4xOTkyMTkgTCAxNy45NTcwMzEgMTcuMzkwNjI1IEwgMTAuNjc5Njg4IDE3LjM5MDYyNSBaIE0gMTAuNjc5Njg4IDcuMTk5MjE5ICIgY2xpcC1ydWxlPSJub256ZXJvIi8+PC9jbGlwUGF0aD48L2RlZnM+PGcgY2xpcC1wYXRoPSJ1cmwoI2E3ZDJlMzRmNmEpIj48ZyBjbGlwLXBhdGg9InVybCgjNzBhYjc4ZGEzNikiPjxwYXRoIGZpbGw9IiM0N2IwOGIiIGQ9Ik0gMS45NTcwMzEgMS4yNDYwOTQgTCA5MS45Njg3NSAxLjI0NjA5NCBMIDkxLjk2ODc1IDIzLjg3ODkwNiBMIDEuOTU3MDMxIDIzLjg3ODkwNiBaIE0gMS45NTcwMzEgMS4yNDYwOTQgIiBmaWxsLW9wYWNpdHk9IjEiIGZpbGwtcnVsZT0ibm9uemVybyIvPjwvZz48L2c+PGcgY2xpcC1wYXRoPSJ1cmwoIzM3ODA5ZDFmZWEpIj48cGF0aCBmaWxsPSIjZmZmZmZmIiBkPSJNIDE2LjEzNjcxOSA3LjIwNzAzMSBMIDE2LjE5OTIxOSA3LjIwNzAzMSBMIDE2LjI3MzQzOCA3LjIzNDM3NSBMIDE2LjM1MTU2MiA3LjI2NTYyNSBMIDE3Ljg5MDYyNSA4Ljc2NTYyNSBMIDE3Ljk1NzAzMSA4LjgyODEyNSBMIDE3Ljk1NzAzMSA5LjAwNzgxMiBMIDE2LjEzNjcxOSA5LjAwNzgxMiBMIDE2LjEzNjcxOSA3LjIwNzAzMSAiIGZpbGwtb3BhY2l0eT0iMSIgZmlsbC1ydWxlPSJldmVub2RkIi8+PC9nPjxnIGNsaXAtcGF0aD0idXJsKCMzNDVjMDFkMjRmKSI+PHBhdGggZmlsbD0iI2ZmZmZmZiIgZD0iTSAxMC44OTA2MjUgNy4yMDcwMzEgTCAxNS45MjE4NzUgNy4yMDcwMzEgTCAxNS45MjE4NzUgOS4yMTg3NSBMIDE3Ljk1NzAzMSA5LjIxODc1IEwgMTcuOTU3MDMxIDE3LjM4NjcxOSBMIDEwLjY3OTY4OCAxNy4zODY3MTkgTCAxMC42Nzk2ODggNy4yMDcwMzEgWiBNIDEyLjU1NDY4OCA5LjU1MDc4MSBDIDEyLjAyMzQzOCA5Ljg3NSAxMS42Nzk2ODggMTAuMzgyODEyIDExLjU0Njg3NSAxMC45Mzc1IEMgMTEuNDE0MDYyIDExLjQ5NjA5NCAxMS40OTYwOTQgMTIuMTAxNTYyIDExLjgyNDIxOSAxMi42MjUgQyAxMi4xNTIzNDQgMTMuMTUyMzQ0IDEyLjY2NDA2MiAxMy40OTYwOTQgMTMuMjI2NTYyIDEzLjYyNSBDIDEzLjYyODkwNiAxMy43MTg3NSAxNC4wNTQ2ODggMTMuNzAzMTI1IDE0LjQ1NzAzMSAxMy41NzAzMTIgTCAxNi4wOTM3NSAxNi4xODM1OTQgQyAxNi4xNjAxNTYgMTYuMjkyOTY5IDE2LjI1NzgxMiAxNi4zNzEwOTQgMTYuMzU5Mzc1IDE2LjQxNDA2MiBDIDE2LjQ4NDM3NSAxNi40NjQ4NDQgMTYuNjIxMDk0IDE2LjQ2NDg0NCAxNi43MzQzNzUgMTYuMzk0NTMxIEwgMTYuODgyODEyIDE2LjMwNDY4OCBDIDE2Ljk5NjA5NCAxNi4yMzQzNzUgMTcuMDU4NTk0IDE2LjExMzI4MSAxNy4wNjY0MDYgMTUuOTgwNDY5IEMgMTcuMDc0MjE5IDE1Ljg3MTA5NCAxNy4wNDI5NjkgMTUuNzUgMTYuOTc2NTYyIDE1LjY0MDYyNSBMIDE1LjMzOTg0NCAxMy4wMjczNDQgQyAxNS42NDA2MjUgMTIuNzI2NTYyIDE1Ljg0Mzc1IDEyLjM1NTQ2OSAxNS45Mzc1IDExLjk2MDkzOCBDIDE2LjA3MDMxMiAxMS40MDIzNDQgMTUuOTg4MjgxIDEwLjc5Njg3NSAxNS42NjAxNTYgMTAuMjczNDM4IEMgMTUuMzMyMDMxIDkuNzQ2MDk0IDE0LjgyMDMxMiA5LjQwMjM0NCAxNC4yNTc4MTIgOS4yNzM0MzggQyAxMy42OTUzMTIgOS4xNDQ1MzEgMTMuMDgyMDMxIDkuMjI2NTYyIDEyLjU1NDY4OCA5LjU1MDc4MSBaIE0gMTQuNDIxODc1IDEzLjEzMjgxMiBMIDE0LjQ2MDkzOCAxMy4xMTMyODEgQyAxNC40OTYwOTQgMTMuMTAxNTYyIDE0LjUyNzM0NCAxMy4wODU5MzggMTQuNTU0Njg4IDEzLjA3NDIxOSBMIDE0LjU1NDY4OCAxMy4wNzAzMTIgQyAxNC41NjY0MDYgMTMuMDY2NDA2IDE0LjU3NDIxOSAxMy4wNjI1IDE0LjU4NTkzOCAxMy4wNTQ2ODggQyAxNC42MjUgMTMuMDM1MTU2IDE0LjY2MDE1NiAxMy4wMTU2MjUgMTQuNjkxNDA2IDEyLjk5NjA5NCBDIDE0LjY5NTMxMiAxMi45OTYwOTQgMTQuNjk5MjE5IDEyLjk5MjE4OCAxNC43MDcwMzEgMTIuOTg4MjgxIEMgMTQuNzU3ODEyIDEyLjk1NzAzMSAxNC44MDg1OTQgMTIuOTIxODc1IDE0Ljg1NTQ2OSAxMi44ODY3MTkgQyAxNC44Nzg5MDYgMTIuODY3MTg4IDE0LjkwMjM0NCAxMi44NDc2NTYgMTQuOTI1NzgxIDEyLjgyODEyNSBMIDE0Ljk1MzEyNSAxMi44MDQ2ODggQyAxNS4yNDIxODggMTIuNTU0Njg4IDE1LjQzNzUgMTIuMjIyNjU2IDE1LjUyMzQzOCAxMS44NjMyODEgQyAxNS42Mjg5MDYgMTEuNDEwMTU2IDE1LjU2MjUgMTAuOTE3OTY5IDE1LjI5Njg3NSAxMC40OTYwOTQgQyAxNS4wMzEyNSAxMC4wNzAzMTIgMTQuNjE3MTg4IDkuNzkyOTY5IDE0LjE2MDE1NiA5LjY4NzUgQyAxMy43MDMxMjUgOS41ODIwMzEgMTMuMjA3MDMxIDkuNjQ0NTMxIDEyLjc3NzM0NCA5LjkxMDE1NiBDIDEyLjM1MTU2MiAxMC4xNzE4NzUgMTIuMDcwMzEyIDEwLjU4MjAzMSAxMS45NjA5MzggMTEuMDM1MTU2IEMgMTEuODU1NDY5IDExLjQ4ODI4MSAxMS45MjE4NzUgMTEuOTgwNDY5IDEyLjE4NzUgMTIuNDAyMzQ0IEMgMTIuNDUzMTI1IDEyLjgyODEyNSAxMi44NjcxODggMTMuMTA1NDY5IDEzLjMyNDIxOSAxMy4yMTA5MzggQyAxMy42ODM1OTQgMTMuMjk2ODc1IDE0LjA2NjQwNiAxMy4yNzM0MzggMTQuNDIxODc1IDEzLjEzMjgxMiAiIGZpbGwtb3BhY2l0eT0iMSIgZmlsbC1ydWxlPSJldmVub2RkIi8+PC9nPjxwYXRoIGZpbGw9IiMyMTIxMjEiIGQ9Ik0gMTYuNTA3ODEyIDE2LjAzNTE1NiBMIDE2LjUyMzQzOCAxNi4wMjM0MzggQyAxNi41MjM0MzggMTYuMDIzNDM4IDE2LjQ5NjA5NCAxNi4wNDI5NjkgMTYuNTA3ODEyIDE2LjAzNTE1NiAiIGZpbGwtb3BhY2l0eT0iMSIgZmlsbC1ydWxlPSJub256ZXJvIi8+PHBhdGggZmlsbD0iIzIxMjEyMSIgZD0iTSAxNi42NTYyNSAxNS45NDUzMTIgQyAxNi42Njc5NjkgMTUuOTM3NSAxNi42NDA2MjUgMTUuOTUzMTI1IDE2LjY0MDYyNSAxNS45NTMxMjUgTCAxNi42NTYyNSAxNS45NDUzMTIgIiBmaWxsLW9wYWNpdHk9IjEiIGZpbGwtcnVsZT0ibm9uemVybyIvPjxnIGZpbGw9IiNmZmZmZmYiIGZpbGwtb3BhY2l0eT0iMSI+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMjEuNTk0ODI5LCAxNS45NjAwNjIpIj48Zz48cGF0aCBkPSJNIDYuMzkwNjI1IC02LjUxNTYyNSBMIDMuNzY1NjI1IDAgTCAyLjU0Njg3NSAwIEwgLTAuMDc4MTI1IC02LjUxNTYyNSBMIDEgLTYuNTE1NjI1IEMgMS4xMjUgLTYuNTE1NjI1IDEuMjIyNjU2IC02LjQ4ODI4MSAxLjI5Njg3NSAtNi40Mzc1IEMgMS4zNjcxODggLTYuMzgyODEyIDEuNDIxODc1IC02LjMxMjUgMS40NTMxMjUgLTYuMjE4NzUgTCAyLjg1OTM3NSAtMi40Njg3NSBDIDIuOTIxODc1IC0yLjMyMDMxMiAyLjk3NjU2MiAtMi4xNjQwNjIgMy4wMzEyNSAtMiBDIDMuMDgyMDMxIC0xLjgzMjAzMSAzLjEyODkwNiAtMS42NjAxNTYgMy4xNzE4NzUgLTEuNDg0Mzc1IEMgMy4yMTA5MzggLTEuNjYwMTU2IDMuMjUzOTA2IC0xLjgzMjAzMSAzLjI5Njg3NSAtMiBDIDMuMzQ3NjU2IC0yLjE2NDA2MiAzLjM5ODQzOCAtMi4zMjAzMTIgMy40NTMxMjUgLTIuNDY4NzUgTCA0Ljg1OTM3NSAtNi4yMTg3NSBDIDQuODc4OTA2IC02LjI4OTA2MiA0LjkyNTc4MSAtNi4zNTkzNzUgNSAtNi40MjE4NzUgQyA1LjA4MjAzMSAtNi40ODQzNzUgNS4xNzk2ODggLTYuNTE1NjI1IDUuMjk2ODc1IC02LjUxNTYyNSBaIE0gNi4zOTA2MjUgLTYuNTE1NjI1ICIvPjwvZz48L2c+PC9nPjxnIGZpbGw9IiNmZmZmZmYiIGZpbGwtb3BhY2l0eT0iMSI+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMjcuOTAxNDYzLCAxNS45NjAwNjIpIj48Zz48cGF0aCBkPSJNIDEuNzgxMjUgLTQuNjI1IEwgMS43ODEyNSAwIEwgMC41NDY4NzUgMCBMIDAuNTQ2ODc1IC00LjYyNSBaIE0gMS45Mzc1IC01Ljk1MzEyNSBDIDEuOTM3NSAtNS44NDc2NTYgMS45MTQwNjIgLTUuNzUgMS44NzUgLTUuNjU2MjUgQyAxLjgzMjAzMSAtNS41NjI1IDEuNzczNDM4IC01LjQ3NjU2MiAxLjcwMzEyNSAtNS40MDYyNSBDIDEuNjI4OTA2IC01LjM0Mzc1IDEuNTQ2ODc1IC01LjI4OTA2MiAxLjQ1MzEyNSAtNS4yNSBDIDEuMzU5Mzc1IC01LjIxODc1IDEuMjU3ODEyIC01LjIwMzEyNSAxLjE1NjI1IC01LjIwMzEyNSBDIDEuMDUwNzgxIC01LjIwMzEyNSAwLjk1MzEyNSAtNS4yMTg3NSAwLjg1OTM3NSAtNS4yNSBDIDAuNzczNDM4IC01LjI4OTA2MiAwLjY5NTMxMiAtNS4zNDM3NSAwLjYyNSAtNS40MDYyNSBDIDAuNTUwNzgxIC01LjQ3NjU2MiAwLjQ5MjE4OCAtNS41NjI1IDAuNDUzMTI1IC01LjY1NjI1IEMgMC40MjE4NzUgLTUuNzUgMC40MDYyNSAtNS44NDc2NTYgMC40MDYyNSAtNS45NTMxMjUgQyAwLjQwNjI1IC02LjA1NDY4OCAwLjQyMTg3NSAtNi4xNDg0MzggMC40NTMxMjUgLTYuMjM0Mzc1IEMgMC40OTIxODggLTYuMzI4MTI1IDAuNTUwNzgxIC02LjQwNjI1IDAuNjI1IC02LjQ2ODc1IEMgMC42OTUzMTIgLTYuNTM5MDYyIDAuNzczNDM4IC02LjU5NzY1NiAwLjg1OTM3NSAtNi42NDA2MjUgQyAwLjk1MzEyNSAtNi42Nzk2ODggMS4wNTA3ODEgLTYuNzAzMTI1IDEuMTU2MjUgLTYuNzAzMTI1IEMgMS4yNTc4MTIgLTYuNzAzMTI1IDEuMzU5Mzc1IC02LjY3OTY4OCAxLjQ1MzEyNSAtNi42NDA2MjUgQyAxLjU0Njg3NSAtNi41OTc2NTYgMS42Mjg5MDYgLTYuNTM5MDYyIDEuNzAzMTI1IC02LjQ2ODc1IEMgMS43NzM0MzggLTYuNDA2MjUgMS44MzIwMzEgLTYuMzI4MTI1IDEuODc1IC02LjIzNDM3NSBDIDEuOTE0MDYyIC02LjE0ODQzOCAxLjkzNzUgLTYuMDU0Njg4IDEuOTM3NSAtNS45NTMxMjUgWiBNIDEuOTM3NSAtNS45NTMxMjUgIi8+PC9nPjwvZz48L2c+PGcgZmlsbD0iI2ZmZmZmZiIgZmlsbC1vcGFjaXR5PSIxIj48ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSgzMC4yMzcyNTQsIDE1Ljk2MDA2MikiPjxnPjxwYXRoIGQ9Ik0gMy40NTMxMjUgLTIuODU5Mzc1IEMgMy40NTMxMjUgLTIuOTkyMTg4IDMuNDI5Njg4IC0zLjExNzE4OCAzLjM5MDYyNSAtMy4yMzQzNzUgQyAzLjM1OTM3NSAtMy4zNDc2NTYgMy4zMDQ2ODggLTMuNDQ1MzEyIDMuMjM0Mzc1IC0zLjUzMTI1IEMgMy4xNjAxNTYgLTMuNjI1IDMuMDY2NDA2IC0zLjY5NTMxMiAyLjk1MzEyNSAtMy43NSBDIDIuODM1OTM4IC0zLjgwMDc4MSAyLjcwMzEyNSAtMy44MjgxMjUgMi41NDY4NzUgLTMuODI4MTI1IEMgMi4yNDIxODggLTMuODI4MTI1IDIuMDA3ODEyIC0zLjc0MjE4OCAxLjg0Mzc1IC0zLjU3ODEyNSBDIDEuNjc1NzgxIC0zLjQxMDE1NiAxLjU2NjQwNiAtMy4xNzE4NzUgMS41MTU2MjUgLTIuODU5Mzc1IFogTSAxLjUgLTIuMTI1IEMgMS41MzkwNjIgLTEuNjg3NSAxLjY2NDA2MiAtMS4zNjcxODggMS44NzUgLTEuMTcxODc1IEMgMi4wODIwMzEgLTAuOTcyNjU2IDIuMzUxNTYyIC0wLjg3NSAyLjY4NzUgLTAuODc1IEMgMi44NTE1NjIgLTAuODc1IDMgLTAuODk0NTMxIDMuMTI1IC0wLjkzNzUgQyAzLjI1IC0wLjk3NjU2MiAzLjM1OTM3NSAtMS4wMTk1MzEgMy40NTMxMjUgLTEuMDYyNSBDIDMuNTQ2ODc1IC0xLjExMzI4MSAzLjYyODkwNiAtMS4xNjAxNTYgMy43MDMxMjUgLTEuMjAzMTI1IEMgMy43ODUxNTYgLTEuMjQyMTg4IDMuODYzMjgxIC0xLjI2NTYyNSAzLjkzNzUgLTEuMjY1NjI1IEMgNC4wMzEyNSAtMS4yNjU2MjUgNC4xMDkzNzUgLTEuMjI2NTYyIDQuMTcxODc1IC0xLjE1NjI1IEwgNC41MzEyNSAtMC43MDMxMjUgQyA0LjM5NDUzMSAtMC41NDY4NzUgNC4yNDIxODggLTAuNDE0MDYyIDQuMDc4MTI1IC0wLjMxMjUgQyAzLjkyMTg3NSAtMC4yMTg3NSAzLjc1NzgxMiAtMC4xNDA2MjUgMy41OTM3NSAtMC4wNzgxMjUgQyAzLjQyNTc4MSAtMC4wMjM0Mzc1IDMuMjUzOTA2IDAuMDA3ODEyNSAzLjA3ODEyNSAwLjAzMTI1IEMgMi44OTg0MzggMC4wNTA3ODEyIDIuNzM0Mzc1IDAuMDYyNSAyLjU3ODEyNSAwLjA2MjUgQyAyLjI1MzkwNiAwLjA2MjUgMS45NTMxMjUgMC4wMDc4MTI1IDEuNjcxODc1IC0wLjA5Mzc1IEMgMS4zOTA2MjUgLTAuMTk1MzEyIDEuMTQ0NTMxIC0wLjM1MTU2MiAwLjkzNzUgLTAuNTYyNSBDIDAuNzI2NTYyIC0wLjc2OTUzMSAwLjU2MjUgLTEuMDIzNDM4IDAuNDM3NSAtMS4zMjgxMjUgQyAwLjMyMDMxMiAtMS42NDA2MjUgMC4yNjU2MjUgLTIgMC4yNjU2MjUgLTIuNDA2MjUgQyAwLjI2NTYyNSAtMi43MjY1NjIgMC4zMTY0MDYgLTMuMDIzNDM4IDAuNDIxODc1IC0zLjI5Njg3NSBDIDAuNTIzNDM4IC0zLjU3ODEyNSAwLjY3MTg3NSAtMy44MjAzMTIgMC44NTkzNzUgLTQuMDMxMjUgQyAxLjA1NDY4OCAtNC4yMzgyODEgMS4yOTY4NzUgLTQuMzk4NDM4IDEuNTc4MTI1IC00LjUxNTYyNSBDIDEuODU5Mzc1IC00LjY0MDYyNSAyLjE3MTg3NSAtNC43MDMxMjUgMi41MTU2MjUgLTQuNzAzMTI1IEMgMi44MTY0MDYgLTQuNzAzMTI1IDMuMDkzNzUgLTQuNjU2MjUgMy4zNDM3NSAtNC41NjI1IEMgMy41OTM3NSAtNC40Njg3NSAzLjgwNDY4OCAtNC4zMjgxMjUgMy45ODQzNzUgLTQuMTQwNjI1IEMgNC4xNzE4NzUgLTMuOTYwOTM4IDQuMzEyNSAtMy43NDIxODggNC40MDYyNSAtMy40ODQzNzUgQyA0LjUwNzgxMiAtMy4yMjI2NTYgNC41NjI1IC0yLjkyNTc4MSA0LjU2MjUgLTIuNTkzNzUgQyA0LjU2MjUgLTIuNSA0LjU1NDY4OCAtMi40MjE4NzUgNC41NDY4NzUgLTIuMzU5Mzc1IEMgNC41MzUxNTYgLTIuMjk2ODc1IDQuNTE5NTMxIC0yLjI1IDQuNSAtMi4yMTg3NSBDIDQuNDc2NTYyIC0yLjE4NzUgNC40NDUzMTIgLTIuMTYwMTU2IDQuNDA2MjUgLTIuMTQwNjI1IEMgNC4zNzUgLTIuMTI4OTA2IDQuMzMyMDMxIC0yLjEyNSA0LjI4MTI1IC0yLjEyNSBaIE0gMS41IC0yLjEyNSAiLz48L2c+PC9nPjwvZz48ZyBmaWxsPSIjZmZmZmZmIiBmaWxsLW9wYWNpdHk9IjEiPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKDM1LjA1MjU3NiwgMTUuOTYwMDYyKSI+PGc+PHBhdGggZD0iTSA3LjIxODc1IC00LjYyNSBMIDUuNzY1NjI1IDAgTCA0Ljc2NTYyNSAwIEMgNC43MTA5MzggMCA0LjY2NDA2MiAtMC4wMTU2MjUgNC42MjUgLTAuMDQ2ODc1IEMgNC41ODIwMzEgLTAuMDc4MTI1IDQuNTUwNzgxIC0wLjEzMjgxMiA0LjUzMTI1IC0wLjIxODc1IEwgMy43ODEyNSAtMi43MTg3NSBDIDMuNzUgLTIuODEyNSAzLjcyMjY1NiAtMi45MDYyNSAzLjcwMzEyNSAtMyBDIDMuNjc5Njg4IC0zLjEwMTU2MiAzLjY2MDE1NiAtMy4yMDMxMjUgMy42NDA2MjUgLTMuMjk2ODc1IEMgMy42MTcxODggLTMuMjAzMTI1IDMuNTk3NjU2IC0zLjEwMTU2MiAzLjU3ODEyNSAtMyBDIDMuNTU0Njg4IC0yLjkwNjI1IDMuNTMxMjUgLTIuODEyNSAzLjUgLTIuNzE4NzUgTCAyLjczNDM3NSAtMC4yMTg3NSBDIDIuNjkxNDA2IC0wLjA3MDMxMjUgMi42MDE1NjIgMCAyLjQ2ODc1IDAgTCAxLjUxNTYyNSAwIEwgMC4wNDY4NzUgLTQuNjI1IEwgMS4wNDY4NzUgLTQuNjI1IEMgMS4xMjg5MDYgLTQuNjI1IDEuMjAzMTI1IC00LjYwMTU2MiAxLjI2NTYyNSAtNC41NjI1IEMgMS4zMjgxMjUgLTQuNTE5NTMxIDEuMzY3MTg4IC00LjQ2ODc1IDEuMzkwNjI1IC00LjQwNjI1IEwgMS45Njg3NSAtMi4xMDkzNzUgQyAyIC0xLjk2MDkzOCAyLjAyMzQzOCAtMS44MjAzMTIgMi4wNDY4NzUgLTEuNjg3NSBDIDIuMDc4MTI1IC0xLjU1MDc4MSAyLjEwOTM3NSAtMS40MTQwNjIgMi4xNDA2MjUgLTEuMjgxMjUgQyAyLjE3MTg3NSAtMS40MTQwNjIgMi4yMDcwMzEgLTEuNTUwNzgxIDIuMjUgLTEuNjg3NSBDIDIuMjg5MDYyIC0xLjgyMDMxMiAyLjMzMjAzMSAtMS45NjA5MzggMi4zNzUgLTIuMTA5Mzc1IEwgMy4wNjI1IC00LjQyMTg3NSBDIDMuMDgyMDMxIC00LjQ4NDM3NSAzLjExNzE4OCAtNC41MzUxNTYgMy4xNzE4NzUgLTQuNTc4MTI1IEMgMy4yMzQzNzUgLTQuNjE3MTg4IDMuMzA0Njg4IC00LjY0MDYyNSAzLjM5MDYyNSAtNC42NDA2MjUgTCAzLjkzNzUgLTQuNjQwNjI1IEMgNC4wMTk1MzEgLTQuNjQwNjI1IDQuMDkzNzUgLTQuNjE3MTg4IDQuMTU2MjUgLTQuNTc4MTI1IEMgNC4yMTg3NSAtNC41MzUxNTYgNC4yNTc4MTIgLTQuNDg0Mzc1IDQuMjgxMjUgLTQuNDIxODc1IEwgNC45Mzc1IC0yLjEwOTM3NSBDIDQuOTc2NTYyIC0xLjk3MjY1NiA1LjAxNTYyNSAtMS44MzIwMzEgNS4wNDY4NzUgLTEuNjg3NSBDIDUuMDg1OTM4IC0xLjU1MDc4MSA1LjEyODkwNiAtMS40MTAxNTYgNS4xNzE4NzUgLTEuMjY1NjI1IEMgNS4xOTE0MDYgLTEuNDEwMTU2IDUuMjEwOTM4IC0xLjU1MDc4MSA1LjIzNDM3NSAtMS42ODc1IEMgNS4yNjU2MjUgLTEuODIwMzEyIDUuMzAwNzgxIC0xLjk2MDkzOCA1LjM0Mzc1IC0yLjEwOTM3NSBMIDUuOTM3NSAtNC40MDYyNSBDIDUuOTU3MDMxIC00LjQ2ODc1IDYgLTQuNTE5NTMxIDYuMDYyNSAtNC41NjI1IEMgNi4xMjUgLTQuNjAxNTYyIDYuMTk1MzEyIC00LjYyNSA2LjI4MTI1IC00LjYyNSBaIE0gNy4yMTg3NSAtNC42MjUgIi8+PC9nPjwvZz48L2c+PGcgZmlsbD0iI2ZmZmZmZiIgZmlsbC1vcGFjaXR5PSIxIj48ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSg0Mi4zMjQ5NjgsIDE1Ljk2MDA2MikiPjxnLz48L2c+PC9nPjxnIGZpbGw9IiNmZmZmZmYiIGZpbGwtb3BhY2l0eT0iMSI+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoNDQuNDU4NjI0LCAxNS45NjAwNjIpIj48Zz48cGF0aCBkPSJNIDIuODkwNjI1IC0zLjI4MTI1IEMgMy4zMDQ2ODggLTMuMjgxMjUgMy42MTMyODEgLTMuMzc4OTA2IDMuODEyNSAtMy41NzgxMjUgQyA0LjAwNzgxMiAtMy43ODUxNTYgNC4xMDkzNzUgLTQuMDY2NDA2IDQuMTA5Mzc1IC00LjQyMTg3NSBDIDQuMTA5Mzc1IC00LjU3ODEyNSA0LjA4MjAzMSAtNC43MjI2NTYgNC4wMzEyNSAtNC44NTkzNzUgQyAzLjk3NjU2MiAtNC45OTIxODggMy44OTg0MzggLTUuMTA5Mzc1IDMuNzk2ODc1IC01LjIwMzEyNSBDIDMuNzAzMTI1IC01LjI5Njg3NSAzLjU3ODEyNSAtNS4zNjcxODggMy40MjE4NzUgLTUuNDIxODc1IEMgMy4yNzM0MzggLTUuNDcyNjU2IDMuMDk3NjU2IC01LjUgMi44OTA2MjUgLTUuNSBMIDIuMDMxMjUgLTUuNSBMIDIuMDMxMjUgLTMuMjgxMjUgWiBNIDIuODkwNjI1IC02LjUxNTYyNSBDIDMuMzI4MTI1IC02LjUxNTYyNSAzLjcwNzAzMSAtNi40NjA5MzggNC4wMzEyNSAtNi4zNTkzNzUgQyA0LjM2MzI4MSAtNi4yNTM5MDYgNC42MzI4MTIgLTYuMTA5Mzc1IDQuODQzNzUgLTUuOTIxODc1IEMgNS4wNTA3ODEgLTUuNzM0Mzc1IDUuMjAzMTI1IC01LjUwNzgxMiA1LjI5Njg3NSAtNS4yNSBDIDUuMzk4NDM4IC01IDUuNDUzMTI1IC00LjcyMjY1NiA1LjQ1MzEyNSAtNC40MjE4NzUgQyA1LjQ1MzEyNSAtNC4wOTc2NTYgNS4zOTg0MzggLTMuODAwNzgxIDUuMjk2ODc1IC0zLjUzMTI1IEMgNS4xOTE0MDYgLTMuMjY5NTMxIDUuMDMxMjUgLTMuMDM5MDYyIDQuODEyNSAtMi44NDM3NSBDIDQuNjAxNTYyIC0yLjY1NjI1IDQuMzM1OTM4IC0yLjUwMzkwNiA0LjAxNTYyNSAtMi4zOTA2MjUgQyAzLjY5MTQwNiAtMi4yODUxNTYgMy4zMTY0MDYgLTIuMjM0Mzc1IDIuODkwNjI1IC0yLjIzNDM3NSBMIDIuMDMxMjUgLTIuMjM0Mzc1IEwgMi4wMzEyNSAwIEwgMC42ODc1IDAgTCAwLjY4NzUgLTYuNTE1NjI1IFogTSAyLjg5MDYyNSAtNi41MTU2MjUgIi8+PC9nPjwvZz48L2c+PGcgZmlsbD0iI2ZmZmZmZiIgZmlsbC1vcGFjaXR5PSIxIj48ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSg1MC4wOTE0NzEsIDE1Ljk2MDA2MikiPjxnPjxwYXRoIGQ9Ik0gMS43NjU2MjUgLTYuNzAzMTI1IEwgMS43NjU2MjUgMCBMIDAuNTE1NjI1IDAgTCAwLjUxNTYyNSAtNi43MDMxMjUgWiBNIDEuNzY1NjI1IC02LjcwMzEyNSAiLz48L2c+PC9nPjwvZz48ZyBmaWxsPSIjZmZmZmZmIiBmaWxsLW9wYWNpdHk9IjEiPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKDUyLjM3MzM1OSwgMTUuOTYwMDYyKSI+PGc+PHBhdGggZD0iTSAyLjkzNzUgLTEuOTM3NSBDIDIuNjMyODEyIC0xLjkxNDA2MiAyLjM3ODkwNiAtMS44ODI4MTIgMi4xNzE4NzUgLTEuODQzNzUgQyAxLjk3MjY1NiAtMS44MTI1IDEuODEyNSAtMS43NjU2MjUgMS42ODc1IC0xLjcwMzEyNSBDIDEuNTcwMzEyIC0xLjY0ODQzOCAxLjQ4ODI4MSAtMS41ODIwMzEgMS40Mzc1IC0xLjUgQyAxLjM5NDUzMSAtMS40MjU3ODEgMS4zNzUgLTEuMzQ3NjU2IDEuMzc1IC0xLjI2NTYyNSBDIDEuMzc1IC0xLjA3ODEyNSAxLjQyMTg3NSAtMC45NDUzMTIgMS41MTU2MjUgLTAuODc1IEMgMS42MTcxODggLTAuODAwNzgxIDEuNzU3ODEyIC0wLjc2NTYyNSAxLjkzNzUgLTAuNzY1NjI1IEMgMi4xNDQ1MzEgLTAuNzY1NjI1IDIuMzIwMzEyIC0wLjgwMDc4MSAyLjQ2ODc1IC0wLjg3NSBDIDIuNjI1IC0wLjk0NTMxMiAyLjc4MTI1IC0xLjA2MjUgMi45Mzc1IC0xLjIxODc1IFogTSAwLjQwNjI1IC0zLjk4NDM3NSBDIDAuNjc1NzgxIC00LjIzNDM3NSAwLjk3NjU2MiAtNC40MTQwNjIgMS4zMTI1IC00LjUzMTI1IEMgMS42NDQ1MzEgLTQuNjU2MjUgMiAtNC43MTg3NSAyLjM3NSAtNC43MTg3NSBDIDIuNjU2MjUgLTQuNzE4NzUgMi45MDYyNSAtNC42NzE4NzUgMy4xMjUgLTQuNTc4MTI1IEMgMy4zNDM3NSAtNC40OTIxODggMy41MjM0MzggLTQuMzY3MTg4IDMuNjcxODc1IC00LjIwMzEyNSBDIDMuODI4MTI1IC00LjA0Njg3NSAzLjk0MTQwNiAtMy44NTkzNzUgNC4wMTU2MjUgLTMuNjQwNjI1IEMgNC4wOTc2NTYgLTMuNDIxODc1IDQuMTQwNjI1IC0zLjE3NTc4MSA0LjE0MDYyNSAtMi45MDYyNSBMIDQuMTQwNjI1IDAgTCAzLjU3ODEyNSAwIEMgMy40NjA5MzggMCAzLjM3NSAtMC4wMTU2MjUgMy4zMTI1IC0wLjA0Njg3NSBDIDMuMjUgLTAuMDc4MTI1IDMuMTk1MzEyIC0wLjE0NDUzMSAzLjE1NjI1IC0wLjI1IEwgMy4wNjI1IC0wLjU0Njg3NSBDIDIuOTQ1MzEyIC0wLjQ1MzEyNSAyLjgzMjAzMSAtMC4zNjMyODEgMi43MTg3NSAtMC4yODEyNSBDIDIuNjEzMjgxIC0wLjIwNzAzMSAyLjUgLTAuMTQ0NTMxIDIuMzc1IC0wLjA5Mzc1IEMgMi4yNTc4MTIgLTAuMDM5MDYyNSAyLjEzMjgxMiAwIDIgMC4wMzEyNSBDIDEuODc1IDAuMDYyNSAxLjcyNjU2MiAwLjA3ODEyNSAxLjU2MjUgMC4wNzgxMjUgQyAxLjM1MTU2MiAwLjA3ODEyNSAxLjE2NDA2MiAwLjA1MDc4MTIgMSAwIEMgMC44MzIwMzEgLTAuMDYyNSAwLjY4NzUgLTAuMTQ0NTMxIDAuNTYyNSAtMC4yNSBDIDAuNDQ1MzEyIC0wLjM1MTU2MiAwLjM1MTU2MiAtMC40ODQzNzUgMC4yODEyNSAtMC42NDA2MjUgQyAwLjIxODc1IC0wLjgwNDY4OCAwLjE4NzUgLTAuOTg4MjgxIDAuMTg3NSAtMS4xODc1IEMgMC4xODc1IC0xLjM2MzI4MSAwLjIyNjU2MiAtMS41MzUxNTYgMC4zMTI1IC0xLjcwMzEyNSBDIDAuNDA2MjUgLTEuODc4OTA2IDAuNTU0Njg4IC0yLjAzNTE1NiAwLjc2NTYyNSAtMi4xNzE4NzUgQyAwLjk3MjY1NiAtMi4zMDQ2ODggMS4yNTM5MDYgLTIuNDIxODc1IDEuNjA5Mzc1IC0yLjUxNTYyNSBDIDEuOTYwOTM4IC0yLjYwOTM3NSAyLjQwNjI1IC0yLjY2MDE1NiAyLjkzNzUgLTIuNjcxODc1IEwgMi45Mzc1IC0yLjkwNjI1IEMgMi45Mzc1IC0zLjE5NTMxMiAyLjg3NSAtMy40MTAxNTYgMi43NSAtMy41NDY4NzUgQyAyLjYyNSAtMy42Nzk2ODggMi40NDUzMTIgLTMuNzUgMi4yMTg3NSAtMy43NSBDIDIuMDUwNzgxIC0zLjc1IDEuOTEwMTU2IC0zLjcyNjU2MiAxLjc5Njg3NSAtMy42ODc1IEMgMS42Nzk2ODggLTMuNjU2MjUgMS41NzgxMjUgLTMuNjEzMjgxIDEuNDg0Mzc1IC0zLjU2MjUgQyAxLjM5ODQzOCAtMy41MTk1MzEgMS4zMjAzMTIgLTMuNDc2NTYyIDEuMjUgLTMuNDM3NSBDIDEuMTc1NzgxIC0zLjM5NDUzMSAxLjA5Mzc1IC0zLjM3NSAxIC0zLjM3NSBDIDAuOTA2MjUgLTMuMzc1IDAuODI4MTI1IC0zLjM5NDUzMSAwLjc2NTYyNSAtMy40Mzc1IEMgMC43MTA5MzggLTMuNDc2NTYyIDAuNjY0MDYyIC0zLjUzMTI1IDAuNjI1IC0zLjU5Mzc1IFogTSAwLjQwNjI1IC0zLjk4NDM3NSAiLz48L2c+PC9nPjwvZz48ZyBmaWxsPSIjZmZmZmZmIiBmaWxsLW9wYWNpdHk9IjEiPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKDU2Ljk3MzA2OSwgMTUuOTYwMDYyKSI+PGc+PHBhdGggZD0iTSA0LjgxMjUgLTQuNjI1IEwgMi4zMTI1IDEuMjUgQyAyLjI2OTUzMSAxLjMzMjAzMSAyLjIxODc1IDEuMzk0NTMxIDIuMTU2MjUgMS40Mzc1IEMgMi4xMDE1NjIgMS40NzY1NjIgMi4wMTk1MzEgMS41IDEuOTA2MjUgMS41IEwgMC45ODQzNzUgMS41IEwgMS44NTkzNzUgLTAuMzc1IEwgMCAtNC42MjUgTCAxLjA5Mzc1IC00LjYyNSBDIDEuMTg3NSAtNC42MjUgMS4yNTc4MTIgLTQuNjAxNTYyIDEuMzEyNSAtNC41NjI1IEMgMS4zNjMyODEgLTQuNTE5NTMxIDEuNDA2MjUgLTQuNDY4NzUgMS40Mzc1IC00LjQwNjI1IEwgMi4zMTI1IC0yLjE4NzUgQyAyLjM0Mzc1IC0yLjEwMTU2MiAyLjM2NzE4OCAtMi4wMTU2MjUgMi4zOTA2MjUgLTEuOTIxODc1IEMgMi40MjE4NzUgLTEuODM1OTM4IDIuNDQ1MzEyIC0xLjc1MzkwNiAyLjQ2ODc1IC0xLjY3MTg3NSBDIDIuNTMxMjUgLTEuODQ3NjU2IDIuNTkzNzUgLTIuMDIzNDM4IDIuNjU2MjUgLTIuMjAzMTI1IEwgMy40ODQzNzUgLTQuNDA2MjUgQyAzLjUwMzkwNiAtNC40Njg3NSAzLjU0Njg3NSAtNC41MTk1MzEgMy42MDkzNzUgLTQuNTYyNSBDIDMuNjcxODc1IC00LjYwMTU2MiAzLjczODI4MSAtNC42MjUgMy44MTI1IC00LjYyNSBaIE0gNC44MTI1IC00LjYyNSAiLz48L2c+PC9nPjwvZz48ZyBmaWxsPSIjZmZmZmZmIiBmaWxsLW9wYWNpdHk9IjEiPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKDYxLjc1MjQ1MywgMTUuOTYwMDYyKSI+PGc+PHBhdGggZD0iTSAxLjc1IC0xLjIxODc1IEMgMS44NjMyODEgLTEuMDgyMDMxIDEuOTg4MjgxIC0wLjk4ODI4MSAyLjEyNSAtMC45Mzc1IEMgMi4yNjk1MzEgLTAuODgyODEyIDIuNDE0MDYyIC0wLjg1OTM3NSAyLjU2MjUgLTAuODU5Mzc1IEMgMi43MDcwMzEgLTAuODU5Mzc1IDIuODQzNzUgLTAuODgyODEyIDIuOTY4NzUgLTAuOTM3NSBDIDMuMDkzNzUgLTEgMy4xOTUzMTIgLTEuMDg1OTM4IDMuMjgxMjUgLTEuMjAzMTI1IEMgMy4zNzUgLTEuMzI4MTI1IDMuNDQ1MzEyIC0xLjQ4NDM3NSAzLjUgLTEuNjcxODc1IEMgMy41NTA3ODEgLTEuODY3MTg4IDMuNTc4MTI1IC0yLjEwOTM3NSAzLjU3ODEyNSAtMi4zOTA2MjUgQyAzLjU3ODEyNSAtMi42Mjg5MDYgMy41NTQ2ODggLTIuODMyMDMxIDMuNTE1NjI1IC0zIEMgMy40NzI2NTYgLTMuMTc1NzgxIDMuNDEwMTU2IC0zLjMyMDMxMiAzLjMyODEyNSAtMy40Mzc1IEMgMy4yNTM5MDYgLTMuNTUwNzgxIDMuMTYwMTU2IC0zLjYyODkwNiAzLjA0Njg3NSAtMy42NzE4NzUgQyAyLjk0MTQwNiAtMy43MjI2NTYgMi44MTY0MDYgLTMuNzUgMi42NzE4NzUgLTMuNzUgQyAyLjQ3MjY1NiAtMy43NSAyLjMwMDc4MSAtMy43MDcwMzEgMi4xNTYyNSAtMy42MjUgQyAyLjAxOTUzMSAtMy41MzkwNjIgMS44ODI4MTIgLTMuNDE0MDYyIDEuNzUgLTMuMjUgWiBNIDEuNzUgLTQuMDkzNzUgQyAxLjkzNzUgLTQuMjgxMjUgMi4xNDA2MjUgLTQuNDI1NzgxIDIuMzU5Mzc1IC00LjUzMTI1IEMgMi41NzgxMjUgLTQuNjQ0NTMxIDIuODI4MTI1IC00LjcwMzEyNSAzLjEwOTM3NSAtNC43MDMxMjUgQyAzLjM2NzE4OCAtNC43MDMxMjUgMy42MDE1NjIgLTQuNjQ4NDM4IDMuODEyNSAtNC41NDY4NzUgQyA0LjAzMTI1IC00LjQ0MTQwNiA0LjIxMDkzOCAtNC4yODkwNjIgNC4zNTkzNzUgLTQuMDkzNzUgQyA0LjUxNTYyNSAtMy44OTQ1MzEgNC42MzI4MTIgLTMuNjU2MjUgNC43MTg3NSAtMy4zNzUgQyA0LjgwMDc4MSAtMy4wOTM3NSA0Ljg0Mzc1IC0yLjc4MTI1IDQuODQzNzUgLTIuNDM3NSBDIDQuODQzNzUgLTIuMDYyNSA0Ljc5Njg3NSAtMS43MTg3NSA0LjcwMzEyNSAtMS40MDYyNSBDIDQuNjA5Mzc1IC0xLjEwMTU2MiA0LjQ3MjY1NiAtMC44NDM3NSA0LjI5Njg3NSAtMC42MjUgQyA0LjEyODkwNiAtMC40MDYyNSAzLjkyMTg3NSAtMC4yMzQzNzUgMy42NzE4NzUgLTAuMTA5Mzc1IEMgMy40Mjk2ODggMC4wMDM5MDYyNSAzLjE2NDA2MiAwLjA2MjUgMi44NzUgMC4wNjI1IEMgMi43MjY1NjIgMC4wNjI1IDIuNTk3NjU2IDAuMDQ2ODc1IDIuNDg0Mzc1IDAuMDE1NjI1IEMgMi4zNjcxODggLTAuMDAzOTA2MjUgMi4yNjU2MjUgLTAuMDM5MDYyNSAyLjE3MTg3NSAtMC4wOTM3NSBDIDIuMDc4MTI1IC0wLjE0NDUzMSAxLjk4ODI4MSAtMC4yMDMxMjUgMS45MDYyNSAtMC4yNjU2MjUgQyAxLjgyMDMxMiAtMC4zMzU5MzggMS43NSAtMC40MjE4NzUgMS42ODc1IC0wLjUxNTYyNSBMIDEuNjI1IC0wLjIzNDM3NSBDIDEuNjAxNTYyIC0wLjE0ODQzOCAxLjU2NjQwNiAtMC4wODU5Mzc1IDEuNTE1NjI1IC0wLjA0Njg3NSBDIDEuNDcyNjU2IC0wLjAxNTYyNSAxLjQxMDE1NiAwIDEuMzI4MTI1IDAgTCAwLjUxNTYyNSAwIEwgMC41MTU2MjUgLTYuNzAzMTI1IEwgMS43NSAtNi43MDMxMjUgWiBNIDEuNzUgLTQuMDkzNzUgIi8+PC9nPjwvZz48L2c+PGcgZmlsbD0iI2ZmZmZmZiIgZmlsbC1vcGFjaXR5PSIxIj48ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSg2Ni44ODIyMDYsIDE1Ljk2MDA2MikiPjxnPjxwYXRoIGQ9Ik0gMi41OTM3NSAtNC43MDMxMjUgQyAyLjk0NTMxMiAtNC43MDMxMjUgMy4yNjU2MjUgLTQuNjQ0NTMxIDMuNTQ2ODc1IC00LjUzMTI1IEMgMy44MjgxMjUgLTQuNDI1NzgxIDQuMDcwMzEyIC00LjI2OTUzMSA0LjI4MTI1IC00LjA2MjUgQyA0LjQ4ODI4MSAtMy44NTE1NjIgNC42NDQ1MzEgLTMuNjAxNTYyIDQuNzUgLTMuMzEyNSBDIDQuODYzMjgxIC0zLjAxOTUzMSA0LjkyMTg3NSAtMi42OTE0MDYgNC45MjE4NzUgLTIuMzI4MTI1IEMgNC45MjE4NzUgLTEuOTUzMTI1IDQuODYzMjgxIC0xLjYxNzE4OCA0Ljc1IC0xLjMyODEyNSBDIDQuNjQ0NTMxIC0xLjAzNTE1NiA0LjQ4ODI4MSAtMC43ODUxNTYgNC4yODEyNSAtMC41NzgxMjUgQyA0LjA3MDMxMiAtMC4zNjcxODggMy44MjgxMjUgLTAuMjA3MDMxIDMuNTQ2ODc1IC0wLjA5Mzc1IEMgMy4yNjU2MjUgMC4wMDc4MTI1IDIuOTQ1MzEyIDAuMDYyNSAyLjU5Mzc1IDAuMDYyNSBDIDIuMjUgMC4wNjI1IDEuOTI5Njg4IDAuMDA3ODEyNSAxLjY0MDYyNSAtMC4wOTM3NSBDIDEuMzU5Mzc1IC0wLjIwNzAzMSAxLjExMzI4MSAtMC4zNjcxODggMC45MDYyNSAtMC41NzgxMjUgQyAwLjcwNzAzMSAtMC43ODUxNTYgMC41NTA3ODEgLTEuMDM1MTU2IDAuNDM3NSAtMS4zMjgxMjUgQyAwLjMyMDMxMiAtMS42MTcxODggMC4yNjU2MjUgLTEuOTUzMTI1IDAuMjY1NjI1IC0yLjMyODEyNSBDIDAuMjY1NjI1IC0yLjY5MTQwNiAwLjMyMDMxMiAtMy4wMTk1MzEgMC40Mzc1IC0zLjMxMjUgQyAwLjU1MDc4MSAtMy42MDE1NjIgMC43MDcwMzEgLTMuODUxNTYyIDAuOTA2MjUgLTQuMDYyNSBDIDEuMTEzMjgxIC00LjI2OTUzMSAxLjM1OTM3NSAtNC40MjU3ODEgMS42NDA2MjUgLTQuNTMxMjUgQyAxLjkyOTY4OCAtNC42NDQ1MzEgMi4yNSAtNC43MDMxMjUgMi41OTM3NSAtNC43MDMxMjUgWiBNIDIuNTkzNzUgLTAuODU5Mzc1IEMgMi45NDUzMTIgLTAuODU5Mzc1IDMuMjA3MDMxIC0wLjk3NjU2MiAzLjM3NSAtMS4yMTg3NSBDIDMuNTUwNzgxIC0xLjQ2ODc1IDMuNjQwNjI1IC0xLjgzMjAzMSAzLjY0MDYyNSAtMi4zMTI1IEMgMy42NDA2MjUgLTIuNzg5MDYyIDMuNTUwNzgxIC0zLjE0ODQzOCAzLjM3NSAtMy4zOTA2MjUgQyAzLjIwNzAzMSAtMy42NDA2MjUgMi45NDUzMTIgLTMuNzY1NjI1IDIuNTkzNzUgLTMuNzY1NjI1IEMgMi4yMzgyODEgLTMuNzY1NjI1IDEuOTcyNjU2IC0zLjY0MDYyNSAxLjc5Njg3NSAtMy4zOTA2MjUgQyAxLjYyODkwNiAtMy4xNDg0MzggMS41NDY4NzUgLTIuNzg5MDYyIDEuNTQ2ODc1IC0yLjMxMjUgQyAxLjU0Njg3NSAtMS44MzIwMzEgMS42Mjg5MDYgLTEuNDY4NzUgMS43OTY4NzUgLTEuMjE4NzUgQyAxLjk3MjY1NiAtMC45NzY1NjIgMi4yMzgyODEgLTAuODU5Mzc1IDIuNTkzNzUgLTAuODU5Mzc1IFogTSAyLjU5Mzc1IC0wLjg1OTM3NSAiLz48L2c+PC9nPjwvZz48ZyBmaWxsPSIjZmZmZmZmIiBmaWxsLW9wYWNpdHk9IjEiPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKDcyLjA3MDM1NiwgMTUuOTYwMDYyKSI+PGc+PHBhdGggZD0iTSAyLjU5Mzc1IC00LjcwMzEyNSBDIDIuOTQ1MzEyIC00LjcwMzEyNSAzLjI2NTYyNSAtNC42NDQ1MzEgMy41NDY4NzUgLTQuNTMxMjUgQyAzLjgyODEyNSAtNC40MjU3ODEgNC4wNzAzMTIgLTQuMjY5NTMxIDQuMjgxMjUgLTQuMDYyNSBDIDQuNDg4MjgxIC0zLjg1MTU2MiA0LjY0NDUzMSAtMy42MDE1NjIgNC43NSAtMy4zMTI1IEMgNC44NjMyODEgLTMuMDE5NTMxIDQuOTIxODc1IC0yLjY5MTQwNiA0LjkyMTg3NSAtMi4zMjgxMjUgQyA0LjkyMTg3NSAtMS45NTMxMjUgNC44NjMyODEgLTEuNjE3MTg4IDQuNzUgLTEuMzI4MTI1IEMgNC42NDQ1MzEgLTEuMDM1MTU2IDQuNDg4MjgxIC0wLjc4NTE1NiA0LjI4MTI1IC0wLjU3ODEyNSBDIDQuMDcwMzEyIC0wLjM2NzE4OCAzLjgyODEyNSAtMC4yMDcwMzEgMy41NDY4NzUgLTAuMDkzNzUgQyAzLjI2NTYyNSAwLjAwNzgxMjUgMi45NDUzMTIgMC4wNjI1IDIuNTkzNzUgMC4wNjI1IEMgMi4yNSAwLjA2MjUgMS45Mjk2ODggMC4wMDc4MTI1IDEuNjQwNjI1IC0wLjA5Mzc1IEMgMS4zNTkzNzUgLTAuMjA3MDMxIDEuMTEzMjgxIC0wLjM2NzE4OCAwLjkwNjI1IC0wLjU3ODEyNSBDIDAuNzA3MDMxIC0wLjc4NTE1NiAwLjU1MDc4MSAtMS4wMzUxNTYgMC40Mzc1IC0xLjMyODEyNSBDIDAuMzIwMzEyIC0xLjYxNzE4OCAwLjI2NTYyNSAtMS45NTMxMjUgMC4yNjU2MjUgLTIuMzI4MTI1IEMgMC4yNjU2MjUgLTIuNjkxNDA2IDAuMzIwMzEyIC0zLjAxOTUzMSAwLjQzNzUgLTMuMzEyNSBDIDAuNTUwNzgxIC0zLjYwMTU2MiAwLjcwNzAzMSAtMy44NTE1NjIgMC45MDYyNSAtNC4wNjI1IEMgMS4xMTMyODEgLTQuMjY5NTMxIDEuMzU5Mzc1IC00LjQyNTc4MSAxLjY0MDYyNSAtNC41MzEyNSBDIDEuOTI5Njg4IC00LjY0NDUzMSAyLjI1IC00LjcwMzEyNSAyLjU5Mzc1IC00LjcwMzEyNSBaIE0gMi41OTM3NSAtMC44NTkzNzUgQyAyLjk0NTMxMiAtMC44NTkzNzUgMy4yMDcwMzEgLTAuOTc2NTYyIDMuMzc1IC0xLjIxODc1IEMgMy41NTA3ODEgLTEuNDY4NzUgMy42NDA2MjUgLTEuODMyMDMxIDMuNjQwNjI1IC0yLjMxMjUgQyAzLjY0MDYyNSAtMi43ODkwNjIgMy41NTA3ODEgLTMuMTQ4NDM4IDMuMzc1IC0zLjM5MDYyNSBDIDMuMjA3MDMxIC0zLjY0MDYyNSAyLjk0NTMxMiAtMy43NjU2MjUgMi41OTM3NSAtMy43NjU2MjUgQyAyLjIzODI4MSAtMy43NjU2MjUgMS45NzI2NTYgLTMuNjQwNjI1IDEuNzk2ODc1IC0zLjM5MDYyNSBDIDEuNjI4OTA2IC0zLjE0ODQzOCAxLjU0Njg3NSAtMi43ODkwNjIgMS41NDY4NzUgLTIuMzEyNSBDIDEuNTQ2ODc1IC0xLjgzMjAzMSAxLjYyODkwNiAtMS40Njg3NSAxLjc5Njg3NSAtMS4yMTg3NSBDIDEuOTcyNjU2IC0wLjk3NjU2MiAyLjIzODI4MSAtMC44NTkzNzUgMi41OTM3NSAtMC44NTkzNzUgWiBNIDIuNTkzNzUgLTAuODU5Mzc1ICIvPjwvZz48L2c+PC9nPjxnIGZpbGw9IiNmZmZmZmYiIGZpbGwtb3BhY2l0eT0iMSI+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoNzcuMjU4NTA2LCAxNS45NjAwNjIpIj48Zz48cGF0aCBkPSJNIDEuNzUgLTYuNzAzMTI1IEwgMS43NSAtMi44OTA2MjUgTCAxLjk1MzEyNSAtMi44OTA2MjUgQyAyLjAzNTE1NiAtMi44OTA2MjUgMi4wOTc2NTYgLTIuODk4NDM4IDIuMTQwNjI1IC0yLjkyMTg3NSBDIDIuMTc5Njg4IC0yLjk1MzEyNSAyLjIyNjU2MiAtMyAyLjI4MTI1IC0zLjA2MjUgTCAzLjI5Njg3NSAtNC40MjE4NzUgQyAzLjM0NzY1NiAtNC40OTIxODggMy40MDYyNSAtNC41NDY4NzUgMy40Njg3NSAtNC41NzgxMjUgQyAzLjUzOTA2MiAtNC42MDkzNzUgMy42MjUgLTQuNjI1IDMuNzE4NzUgLTQuNjI1IEwgNC44NTkzNzUgLTQuNjI1IEwgMy41MTU2MjUgLTIuOTM3NSBDIDMuNDEwMTU2IC0yLjgwMDc4MSAzLjI4OTA2MiAtMi42OTE0MDYgMy4xNTYyNSAtMi42MDkzNzUgQyAzLjIyNjU2MiAtMi41NTQ2ODggMy4yODkwNjIgLTIuNSAzLjM0Mzc1IC0yLjQzNzUgQyAzLjM5NDUzMSAtMi4zNzUgMy40NDE0MDYgLTIuMzA0Njg4IDMuNDg0Mzc1IC0yLjIzNDM3NSBMIDQuOTIxODc1IDAgTCAzLjgxMjUgMCBDIDMuNzA3MDMxIDAgMy42MTcxODggLTAuMDE1NjI1IDMuNTQ2ODc1IC0wLjA0Njg3NSBDIDMuNDg0Mzc1IC0wLjA3ODEyNSAzLjQyOTY4OCAtMC4xMzI4MTIgMy4zOTA2MjUgLTAuMjE4NzUgTCAyLjM0Mzc1IC0xLjkyMTg3NSBDIDIuMzAwNzgxIC0xLjk5MjE4OCAyLjI1MzkwNiAtMi4wMzkwNjIgMi4yMDMxMjUgLTIuMDYyNSBDIDIuMTYwMTU2IC0yLjA4MjAzMSAyLjA5NzY1NiAtMi4wOTM3NSAyLjAxNTYyNSAtMi4wOTM3NSBMIDEuNzUgLTIuMDkzNzUgTCAxLjc1IDAgTCAwLjUxNTYyNSAwIEwgMC41MTU2MjUgLTYuNzAzMTI1IFogTSAxLjc1IC02LjcwMzEyNSAiLz48L2c+PC9nPjwvZz48L3N2Zz4=');" onclick="window.open('https://drive.google.com/file/d/1A5xdqlIi1vv5_8du3MdgYInkz6Wlc3r_/view?usp=drive_link', '_blank');"></div></td>
        <td style="padding: 10px 20px;"><div style="background-color: lightblue; display: inline-block; border-radius: 4px; cursor: pointer; height: 32px; border: none; width: 123px; background-image: url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTI4IiBoZWlnaHQ9IjMyIiBmaWxsPSJub25lIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxyZWN0IHdpZHRoPSIxMjgiIGhlaWdodD0iMzIiIHJ4PSI0IiBmaWxsPSIjRkY2QzM3Ii8+PHBhdGggZD0iTTEyIDEwLjg4M2EuNS41IDAgMCAxIC43NTctLjQyOWw4LjUyOCA1LjExN2EuNS41IDAgMCAxIDAgLjg1OGwtOC41MjggNS4xMTdhLjUuNSAwIDAgMS0uNzU3LS40M1YxMC44ODRaTTI3Ljg4OSAyMC41MDloMS41OHYtMy4xOTdoMS42MTFsMS43MTMgMy4xOTdoMS43NjRsLTEuODg3LTMuNDZjMS4wMjctLjQxNCAxLjU2OC0xLjI5MiAxLjU2OC0yLjQ3NyAwLTEuNjY2LTEuMDc0LTIuNzktMy4wNzctMi43OWgtMy4yNzN2OC43MjdaTTI5LjQ2OCAxNnYtMi44OThoMS40NWMxLjE4IDAgMS43MDguNTQxIDEuNzA4IDEuNDcgMCAuOTMtLjUyOCAxLjQyOC0xLjcgMS40MjhIMjkuNDdaTTM5Ljc5NyAxNy43NTZjMCAuOTk3LS43MTIgMS40OTEtMS4zOTQgMS40OTEtLjc0MSAwLTEuMjM1LS41MjQtMS4yMzUtMS4zNTV2LTMuOTI5aC0xLjU0M3Y0LjE2OGMwIDEuNTcyLjg5NSAyLjQ2MyAyLjE4MiAyLjQ2My45OCAwIDEuNjctLjUxNiAxLjk2OS0xLjI0OWguMDY4djEuMTY0aDEuNDk1di02LjU0NmgtMS41NDJ2My43OTNaTTQ0LjQ2OCAxNi42NzNjMC0uOTQ2LjU3MS0xLjQ5MSAxLjM4NS0xLjQ5MS43OTcgMCAxLjI3NC41MjQgMS4yNzQgMS4zOTd2My45M2gxLjU0M1YxNi4zNGMuMDA0LTEuNTY4LS44OS0yLjQ2My0yLjI0MS0yLjQ2My0uOTggMC0xLjY1NC40NjktMS45NTIgMS4xOTdINDQuNHYtMS4xMTJoLTEuNDc0djYuNTQ2aDEuNTQydi0zLjgzNlpNNTMuMjE1IDIwLjUwOWgxLjU0MnYtNi41NDZoLTEuNTQydjYuNTQ2Wm0uNzc1LTcuNDc1Yy40OSAwIC44OTEtLjM3NS44OTEtLjgzNSAwLS40NjUtLjQtLjg0LS44OS0uODQtLjQ5NSAwLS44OTUuMzc1LS44OTUuODQgMCAuNDYuNC44MzUuODk0LjgzNVpNNTcuODg2IDE2LjY3M2MwLS45NDYuNTcxLTEuNDkxIDEuMzg1LTEuNDkxLjc5NyAwIDEuMjc0LjUyNCAxLjI3NCAxLjM5N3YzLjkzaDEuNTQzVjE2LjM0Yy4wMDQtMS41NjgtLjg5LTIuNDYzLTIuMjQxLTIuNDYzLS45OCAwLTEuNjU0LjQ2OS0xLjk1MiAxLjE5N2gtLjA3N3YtMS4xMTJoLTEuNDc0djYuNTQ2aDEuNTQydi0zLjgzNlpNNjYuNzAxIDIwLjUwOWgxLjU4MXYtMi45NWgxLjY3YzIuMDE2IDAgMy4wOTgtMS4yMSAzLjA5OC0yLjg4OSAwLTEuNjY2LTEuMDctMi44ODktMy4wNzYtMi44ODlINjYuN3Y4LjcyOFptMS41ODEtNC4yNXYtMy4xNTdoMS40NDljMS4xODQgMCAxLjcwOS42NCAxLjcwOSAxLjU2OSAwIC45MjgtLjUyNSAxLjU4OS0xLjcgMS41ODloLTEuNDU4Wk03Ny4xMTcgMjAuNjM2YzEuOTE3IDAgMy4xMzYtMS4zNSAzLjEzNi0zLjM3NSAwLTIuMDI4LTEuMjE5LTMuMzgzLTMuMTM2LTMuMzgzLTEuOTE4IDAtMy4xMzYgMS4zNTUtMy4xMzYgMy4zODMgMCAyLjAyNCAxLjIxOCAzLjM3NSAzLjEzNiAzLjM3NVptLjAwOC0xLjIzNWMtMS4wNiAwLTEuNTgtLjk0Ny0xLjU4LTIuMTQ0cy41Mi0yLjE1NiAxLjU4LTIuMTU2YzEuMDQ0IDAgMS41NjQuOTU5IDEuNTY0IDIuMTU2cy0uNTIgMi4xNDQtMS41NjQgMi4xNDRaTTg2LjczNiAxNS42OTNjLS4yMTMtMS4xMDgtMS4xLTEuODE1LTIuNjM0LTEuODE1LTEuNTc2IDAtMi42NS43NzUtMi42NDYgMS45ODYtLjAwNC45NTQuNTg0IDEuNTg1IDEuODQgMS44NDVsMS4xMTcuMjM0Yy42MDEuMTMyLjg4My4zNzUuODgzLjc0NiAwIC40NDctLjQ4Ni43ODQtMS4yMi43ODQtLjcwNyAwLTEuMTY3LS4zMDctMS4yOTktLjg5NWwtMS41MDQuMTQ1Yy4xOTIgMS4yMDIgMS4yMDEgMS45MTMgMi44MDggMS45MTMgMS42MzYgMCAyLjc5MS0uODQ4IDIuNzk1LTIuMDg4LS4wMDQtLjkzMy0uNjA1LTEuNTA0LTEuODQtMS43NzJsLTEuMTE3LS4yNGMtLjY2NS0uMTQ4LS45MjktLjM3OC0uOTI1LS43NTgtLjAwNC0uNDQzLjQ4Ni0uNzUgMS4xMy0uNzUuNzExIDAgMS4wODYuMzg4IDEuMjA2LjgxOWwxLjQwNi0uMTU0Wk05MS40MTcgMTMuOTYzaC0xLjI5MXYtMS41NjhoLTEuNTQzdjEuNTY4aC0uOTI5djEuMTkzaC45M3YzLjY0Yy0uMDEgMS4yMzEuODg1IDEuODM2IDIuMDQ0IDEuODAyYTMuMSAzLjEgMCAwIDAgLjkwOC0uMTUzbC0uMjYtMS4yMDZjLS4wODUuMDItLjI2LjA2LS40NTEuMDYtLjM4OCAwLS43LS4xMzctLjctLjc2di0zLjM4M2gxLjI5MnYtMS4xOTNaTTkyLjcwNyAyMC41MDloMS41NDN2LTMuOThjMC0uODA2LjUzNy0xLjM1MSAxLjIwMS0xLjM1MS42NTIgMCAxLjEuNDM4IDEuMSAxLjExMnY0LjIxOWgxLjUxM3YtNC4wODNjMC0uNzM3LjQzOS0xLjI0OCAxLjE4NC0xLjI0OC42MjIgMCAxLjExNy4zNjYgMS4xMTcgMS4xNzZ2NC4xNTVoMS41NDd2LTQuMzk0YzAtMS40NjItLjg0NC0yLjIzNy0yLjA0Ni0yLjIzNy0uOTUgMC0xLjY3NS40NjktMS45NjQgMS4xOTdoLS4wNjljLS4yNTEtLjc0MS0uODg2LTEuMTk3LTEuNzY4LTEuMTk3LS44NzggMC0xLjUzNC40NTEtMS44MDcgMS4xOTdoLS4wNzZ2LTEuMTEyaC0xLjQ3NXY2LjU0NlpNMTA1LjM2IDIwLjY0YzEuMDI3IDAgMS42NDEtLjQ4IDEuOTIyLTEuMDNoLjA1MXYuODk5aDEuNDgzdi00LjM4MWMwLTEuNzMtMS40MS0yLjI1LTIuNjU5LTIuMjUtMS4zNzYgMC0yLjQzMy42MTQtMi43NzQgMS44MDdsMS40NC4yMDRjLjE1NC0uNDQ3LjU4OC0uODMgMS4zNDItLjgzLjcxNiAwIDEuMTA4LjM2NiAxLjEwOCAxLjAxdi4wMjVjMCAuNDQzLS40NjQuNDY0LTEuNjE5LjU4OC0xLjI3LjEzNi0yLjQ4NC41MTUtMi40ODQgMS45OSAwIDEuMjg3Ljk0MiAxLjk2OSAyLjE5IDEuOTY5Wm0uNDAxLTEuMTMzYy0uNjQ0IDAtMS4xMDQtLjI5NC0xLjEwNC0uODYgMC0uNTkzLjUxNi0uODQgMS4yMDYtLjkzOC40MDUtLjA1NiAxLjIxNC0uMTU4IDEuNDE1LS4zMnYuNzcxYzAgLjczLS41ODggMS4zNDctMS41MTcgMS4zNDdaTTExMS45MSAxNi42NzNjMC0uOTQ2LjU3MS0xLjQ5MSAxLjM4NS0xLjQ5MS43OTcgMCAxLjI3NC41MjQgMS4yNzQgMS4zOTd2My45M2gxLjU0M1YxNi4zNGMuMDA0LTEuNTY4LS44OTEtMi40NjMtMi4yNDItMi40NjMtLjk4IDAtMS42NTMuNDY5LTEuOTUyIDEuMTk3aC0uMDc2di0xLjExMmgtMS40NzV2Ni41NDZoMS41NDN2LTMuODM2WiIgZmlsbD0iI2ZmZiIvPjwvc3ZnPg==');" onclick="window.open('https://satusehat.kemkes.go.id/platform/docs/id/interoperability/anc-prio/', '_blank');"></div></td>
    </tr>
</table>

<!--Dokumen Referensi:
* [Postman ANC]https://satusehat-fhir.postman.co/workspace/SATUSEHAT-UseCase~ed2ed615-fe1b-473d-9dc1-a0c425fb2f44/collection/7576678-44346c3c-f3d0-4579-9ed8-8b23eeb4b1d5?action=share&creator=19625975)
* [Postman RME SatuSehat](https://www.postman.com/satusehat/workspace/satusehat-public/overview)
* [Playbook ANC](https://drive.google.com/file/d/1nWsP9vK_iSW9tRG8r1l1McOr7m24Wz17/view?usp=share_link)-->