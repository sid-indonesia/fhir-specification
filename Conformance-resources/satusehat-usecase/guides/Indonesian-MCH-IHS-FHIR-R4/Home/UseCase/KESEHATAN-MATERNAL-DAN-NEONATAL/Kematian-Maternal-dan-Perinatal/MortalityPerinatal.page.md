# Pelaporan Kematian Anak
*Last Updated: 2023/10/20*

## A. Pendahuluan
Kasus kematian anak yang dilaporkan merupakan kematian bayi karena sebab apapun, yang dibagi menjadi:
<ul>
<li>Kematian anak dalam kandungan (intrauterine fetal death), yaitu kematian bayi didalam kandungan selama atau sebelum proses persalinan di Indonesia pada waktu tertentu karena sebab apapun.</li>
<li>Kematian neonatal, yaitu kematian bayi baru lahir usia 0-28 hari di Indonesia pada waktu tertentu karena sebab apapun.</li> 
<li>Kematian bayi, yaitu kematian anak usia 0-1 tahun  yang meninggal di Indonesia pada waktu tertentu karena sebab apapun.</li>
<li>Kematian balita, yaitu kematian anak usia 0-5 tahun di Indonesia pada waktu tertentu karena sebab apapun.</li>
</ul>

Dalam kasus kematian anak yang merupakan anak kembar, pelaporan kematian anak dilakukan untuk masing-masing anak. Selain itu, berdasarkan masa kematian anak, pelaporan kematian anak dibagi menjadi:
<ul>
<li>Pada saat kehamilan, yaitu kematian anak yang terjadi sebelum masa persalinan, atau disebut juga dengan anak <b>lahir mati</b></li>
<li>Setelah masa persalinan, yaitu kematian anak yang meninggal setelah masa persalinan, atau disebut juga dengan anak <b>lahir hidup</b></li>
</ul>

Dalam skenario Pelaporan Kematian Anak, kita menggunakan asumsi bahwa data pasien bayi atau janin sudah terdaftar di SATUSEHAT sehingga SATUSEHAT number untuk sang anak sudah terbentuk. Perlu diperhatikan juga bahwa data pasien di skenario ini terdiri dari 2 tipe pasien, yaitu pasien anak dan juga pasien Ibu. Perhatikan juga bahwa pasien "Ibu" disini selalu mengacu pada wanita yang melahirkan bayinya. Data terkait dengan ibu dari anak yang akan digunakan pada use-case ini bisa berupa riwayat kehamilan, persalinan, ataupun alamat domisili.

Implementasi pelaporan kasus kematian anak secara umum dapat dikelompokkan menjadi 2 tahapan proses sebagai berikut:
<ul>
    <li>
        <a title="Pencarian data pasien, nakes, dan fasyankes" href="#SearchPatientPractitionerOrganizationPerinatal"
            class="nhsd-a-link">Step 1. Pencarian data pasien, nakes, dan fasyankes</a>
    </li>
    <li>
        <a title="Pengiriman Notifikasi Pelaporan Kematian Anak" href="#PerinatalDeathNotification"
            class="nhsd-a-link">Step 2. Pengiriman notifikasi pelaporan kematian anak</a>
    </li>
</ul>

Tahapan alur pelaporan dan resource yang digunakan untuk pelaporan kematian anak dapat dilihat dalam Gambar 1. <br>
<center>
<!--<img src="https://victoriatjia.github.io/Guideline/SatuSehat/Specs%20Format%20FHIR/mortality_skema_kematian_anak.png" alt="mortality-skema-kematian-anak" title="Perinatal Death Notification Workflow" style="width: 60%;">-->
{{render:mortality_skema_kematian_anak_v4.png}}

*Gambar 1. Skema Pelaporan Kematian Anak*
</center>

Proses dimulai dengan meregistrasikan kasus yang berupa identitas pasien, nakes, dan fasyankes yang melaporkan kasus kematian. Apabila pasien anak meninggal saat sedang dalam perawatan di fasyankes (baik itu rawat jalan, rawat inap, ataupun IGD), maka data kunjungan pasien akan terlibat dalam alur pelaporan kematian. Selanjutnya, laporan notifikasi kematian anak yang terdiri dari data riwayat kematian anak, riwayat persalinan, dan riwayat kehamilan ibu akan dikirimkan ke Server SatuSehat, yang selanjutnya akan diverifikasi oleh penerima laporan yang berkompetensi untuk melakukan analisis lebih lanjut terhadap laporan tersebut.

## B. Strategi Pengiriman Data ke SATUSEHAT
Berhubung data notifikasi kematian berbentuk form sekali kirim, data yang dicatat dalam pelaporan kematian hanya data terakhir yang ditemukan oleh FASYANKES saat pasien meninggal, misalnya data kunjungan perawatan terakhir (khusus untuk kasus pasien yang meninggal saat sedang dalam masa perawatan), berat badan pasien saat meninggal, alamat meninggal, dsb. Sehingga metode pengiriman data ke SATUSEHAT yang sesuai dengan alur ini adalah menggunakan metode berbasis Bundle. Profil FHIR bernama Bundle dapat digunakan untuk mengirim seluruh resource yang terlibat pada alur pelayanan terkait dengan menggunakan satu langkah pengiriman.

Resource-resource yang terlibat di setiap tahapan alur pelaporan kematian anak adalah sebagai berikut:

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
	<td>Encounter</td>
	<td><i>Optional</i></td>
</tr>
<tr>
	<td>Foundation</td>
	<td>6</td>
	<td>Composition</td>
	<td><b>Required</b></td>
</tr>
<tr>
    <td rowspan="2">Clinical</td>
	<td>7</td>
	<td>Observation</td>
	<td><b>Required</b></td>
</tr>
<tr>
	<td>8</td>
	<td>Condition</td>
	<td><b>Required</b></td>
</tr>
</table>

*<font color="red">\*</font> Notes:*
1. __Required__: Entry resource harus dilibatkan setiap kali mengirimkan bundle
2. _Optional_: Entry resource dapat tidak dilibatkan setiap kali mengirimkan bundle

<!--Berikut adalah format Bundle data yang dikirim oleh masing-masing proses:
<center>
<img src="https://victoriatjia.github.io/Guideline/SatuSehat/Specs%20Format%20FHIR/mortality_resources_kematian_anak.png" alt="mortality-resources-kematian-anak" title="Perinatal Death Notification Resources" style="width: 60%;">
{{render:mortality-resources-kematian-anak}}

*Gambar 2. Struktur FHIR Resource dalam Pelaporan Kematian Anak*
</center>-->

## C. Langkah-Langkah Pengiriman Data ke SatuSehat
Untuk penjelasan terkait alur dan variabel yang digunakan dalam pelaporan kematian anak pada SATUSEHAT berikut ini akan dikategorikan berdasarkan masa kematian anak. Berikut variabel yang dikirimkan pada kematian lahir mati dan lahir hidup anak:

<table class="table-fhir-resources">
        <tr>
            <th>Kategori</th>
            <th>Variabel</th>
            <th>Form Lahir Mati</th>
            <th>Form Lahir Hidup</th>
        </tr>
        <tr>
            <td rowspan="12">Riwayat Kematian</td>
            <td>Jenis Kematian</td>
            <td>Y</td>
            <td>Y</td>
        </tr>
        <tr>
            <td>Tempat Meninggal Faskes*</td>
            <td>Y</td>
            <td>Y</td>
        </tr>
        <tr>
            <td>Tempat Meninggal Non Faskes*</td>
            <td>Y</td>
            <td>Y</td>
        </tr>
        <tr>
            <td>Tanggal dan jam Meninggal*</td>
            <td>Y</td>
            <td></td>
        </tr>
        <tr>
            <td>Masa Terjadi Kematian Anak</td>
            <td>Y</td>
            <td></td>
        </tr>
        <tr>
            <td>Dugaan sebab kematian</td>
            <td>Y</td>
            <td>Y</td>
        </tr>
        <tr>
            <td>Jenis Tempat Meninggal</td>
            <td>Y</td>
            <td></td>
        </tr>
        <tr>
            <td>Maserasi</td>
            <td>Y</td>
            <td></td>
        </tr>
        <tr>
            <td>Keluhan/gejala utama sebelum bayi meninggal</td>
            <td>Y</td>
            <td></td>
        </tr>
        <tr>
            <td>Kondisi ibu sebelum janin meninggal (Penyulit Obstetri/ Non Obstetri)</td>
            <td>Y</td>
            <td></td>
        </tr>
        <tr>
            <td>Usia Ketika Meninggal</td>
            <td></td>
            <td>Y</td>
        </tr>
        <tr>
            <td>Berat saat meninggal</td>
            <td></td>
            <td>Y</td>
        </tr>
        <tr>
            <td rowspan="6">Riwayat Persalinan</td>
            <td>Berat Lahir</td>
            <td>Y</td>
            <td></td>
        </tr>
        <tr>
            <td>Kelainan bawaan</td>
            <td>Y</td>
            <td></td>
        </tr>
        <tr>
            <td>Alamat lahir</td>
            <td></td>
            <td>Y</td>
        </tr>
        <tr>
            <td>Lokasi Tempat Bersalin</td>
            <td></td>
            <td>Y</td>
        </tr>
        <tr>
            <td>Urutan Kelahiran (Untuk bayi kembar)</td>
            <td></td>
            <td>Y</td>
        </tr>
        <tr>
            <td>Jenis tempat Bersalin</td>
            <td></td>
            <td>Y</td>
        </tr>
        <tr>
            <td rowspan="4">Riwayat Kehamilan</td>
            <td>Gravida</td>
            <td>Y</td>
            <td></td>
        </tr>
        <tr>
            <td>Usia Kehamilan</td>
            <td>Y</td>
            <td></td>
        </tr>
        <tr>
            <td>Tanggal HPHT</td>
            <td>Y</td>
            <td></td>
        </tr>
        <tr>
            <td>Kehamilan Tunggal/Kembar</td>
            <td></td>
            <td>Y</td>
        </tr>
        <tr>
            <td rowspan="3">Data Dasar Ibu</td>
            <td>Umur Ibu Ketika Anak Meninggal</td>
            <td>Y</td>
            <td></td>
        </tr>
        <tr>
            <td>Alamat Domisili</td>
            <td>Y</td>
            <td></td>
        </tr>
        <tr>
            <td>Alamat KTP</td>
            <td>Y</td>
        </tr>
</table>

### I. Lahir Mati
####  <div id="SearchPatientPractitionerOrganizationPerinatal"> Step 1. Pembuatan Data Pasien Bayi</div>
<div style="margin-left: 30px;">Dalam use case kematian anak lahir mati, dikarenakan ada pasien yang merupakan bayi baru lahir, maka pasien tersebut tidak akan memiliki {patient-ihs-number} di dalam MPI. Sehingga, fasyankes perlu mendaftarkan data pasien bayi baru lahir ini terlebih dahulu ke SATUSEHAT. Proses pembuatan {patient-ihs-number} pasien dapat dilakukan melalui FHIR API dengan metode POST. Untuk metode pembuatan data pasien di SATUSEHAT secara detail dapat dilihat dalam portal SATUSEHAT pada bagian <a href="https://satusehat.kemkes.go.id/platform/docs/id/master-data/master-patient-index/pasien-bayi/" target="_blank">Pasien Bayi Baru Lahir</a>.</div>

####  <div id="SearchPatientPractitionerOrganizationPerinatal"> Step 2. Mencari Data Pasien Ibu, Nakes, dan Fasyankes</div>
<div style="margin-left: 30px;">
Karena data pasien Ibu di dalam SATUSEHAT sudah terdaftar lebih dulu di *Master Patient Index* (MPI) Kementerian Kesehatan, sehingga registrasi data pasien Ibu tidak diperlukan. Dengan demikian maka entry data untuk resource Patient tidak perlu diikutsertakan dalam bundle data yang dikirim. 

Disamping itu, data Fasyankes yang melaporkan kasus kematian anak juga tidak perlu dikirimkan data alamat seperti provinsi, dan kabupaten/kota karena data sudah tersedia pada *Master Sarana Index* yang ada di SATUSEHAT, begitu juga dengan identitas data nakes yang mengisi data laporan kematian tersebut juga tidak perlu dikirimkan karena sudah tersedia di *Master Nakes Index* yang ada di SATUSEHAT. 

Proses pencarian data pasien Ibu, nakes, dan fasyankes dapat dilakukan melalui FHIR API dengan metode GET dengan parameter dibawah ini:

| No  | Data        | Resource      | Parameter Pencarian       |
| --- |------------ | ------------- | --------------------------|
| 1   | Pasien (Ibu)      | Patient       | NIK, Pasien SATUSEHAT Number    |
| 2   | Nakes       | Practitioner  | NIK, Nakes SATUSEHAT Number     |
| 3   | Fasyankes   | Organization  | Fasyankes SATUSEHAT Number      |

> `CATATAN:`
>  Metode pencarian data pasien, nakes, dan fasyankes di SATUSEHAT secara detail dapat dilihat dalam dokumen <a href="https://docs.google.com/document/d/1wGsuxUJcmWsGhTdAthe0pmcnsqtggLlQdFUG5fU4_T4/edit#heading=h.4fzggw2guay3" target="_blank">Petunjuk Teknis SATUSEHAT (Juknis SATSET)</a>.

Output yang didapatkan dari hasil pencarian maupun hasil pembuatan data pasien bayi (step 1) adalah serangkaian JSON yang didalamnya terdapat kolom "id". Id tersebut selanjutnya akan dilampirkan pada data pelaporan kematian di step berikutnya.

| No  | Data        | Contoh Id Resource | Disimpan pada Resource    |
| --- |------------ | -------------             |-------------              |
| 1   | Pasien (Anak)     | <font style="background: #E1D5E7">Patient/[PATIENT_IHS_NUMBER] </font>     |<font style="background: #E1D5E7"> Observation.subject</font>, <font style="background: #E1D5E7"> Condition.subject</font>, <font style="background: #E1D5E7"> Composition.subject</font>, <font style="background: #E1D5E7">Composition.section.focus</font>| 
| 2   | Pasien (Ibu)     | <font style="background: #FFF2CC">Patient/[PATIENT_IHS_NUMBER] </font>     | <font style="background: #FFF2CC"> Observation.subject</font>, <font style="background: #FFF2CC"> Condition.subject</font>, <font style="background: #FFF2CC"> Composition.section.focus </font>   | 
| 3   | Nakes       | <font style="background: #DAE8FC"> Practitioner/[DOCTOR_IHS_NUMBER] </font>   | <font style="background: #DAE8FC"> Observation.performer</font>, <font style="background: #DAE8FC">Condition.recorder</font>, <font style="background: #DAE8FC"> Composition.author </font>      |
| 4   | Fasyankes   | <font style="background: #D5E8D4">Organization/[FACILITY_IHS_NUMBER] </font> |   <font style="background: #D5E8D4">Observation.performer</font>, <font style="background: #D5E8D4">Composition.attester </font>     |

Contoh lampiran data pasien, nakes, dan fasyankes pada resource **Observation**:
<pre style="background: #F6F8F8;border: 1px solid #e8edee; color: black;">
{
    "resourceType": "Observation",
    <font style="background: #E1D5E7"> "subject"</font> : {
        <font style="background: #E1D5E7">"reference" : "Patient/100000030009"</font>,
        "display": "Baby of Teresa Lee (Fetus Not Named)"
    },
    "performer":  [
        {
            <font style="background: #DAE8FC">"reference": "Practitioner/N10000001"</font>,
            "display": "Dokter Bronsig"
        },
        {
            <font style="background: #D5E8D4">"reference" : "Organization/abddd50b-b22f-4d68-a1c3-d2c29a27698b"</font>,
            "display" : "Puskesmas Ibu Anak"
        }
    ]
    ...
    ...
    ...
}
</pre>

Contoh lampiran data pasien, nakes, dan fasyankes pada resource **Condition**:
<pre style="background: #F6F8F8;border: 1px solid #e8edee; color: black;">
{
    "resourceType": "Condition",
    <font style="background: #E1D5E7"> "subject"</font> : {
        <font style="background: #E1D5E7">"reference" : "Patient/100000030009"</font>,
        "display": "Baby of Teresa Lee (Fetus Not Named)"
    },
     <font style="background: #DAE8FC">"recorder"</font>:  {
        <font style="background: #DAE8FC">"reference": "Practitioner/N10000001"</font>,
        "display": "Dokter Bronsig"
    }
    ...
    ...
    ...
}
</pre>

Contoh lampiran data pasien, nakes, dan fasyankes pada resource **Composition**:
<pre style="background: #F6F8F8;border: 1px solid #e8edee; color: black;">
{
    "resourceType" : "Composition",
    "identifier" : {
        "system": "https://mpdn.kemkes.go.id/nmrkasus_kodeunik",
        "value" : "2361720002"
    },
    "status" : "final",
    "type" : {
        "coding" : [
            {
                "system" : "http://terminology.kemkes.go.id/CodeSystem/composition-type",
                "code" : "COM000002",
                "display" : "Form Lahir Mati"
            }
        ]
    },
    <font style="background: #E1D5E7"> "subject"</font> : {
        <font style="background: #E1D5E7">"reference" : "Patient/100000030009"</font>,
        "display": "Baby of Teresa Lee (Fetus Not Named)"
    },
    "date" : "2022-12-01T02:46:13-05:00",
    <font style="background: #DAE8FC">"author"</font> : [
        {
            <font style="background: #DAE8FC">"reference" : "Practitioner/N10000001"</font>,
            "display": "Dokter Bronsig"
        }
    ],
    "title" : "Notifikasi Kematian Perinatal",
    <font style="background: #D5E8D4">"attester"</font> : [
        {
            "mode" : "legal",
            "party" : {
                <font style="background: #D5E8D4">"reference" : "Organization/abddd50b-b22f-4d68-a1c3-d2c29a27698b"</font>,
                "display" : "Puskesmas Ibu Anak"
            }
        }
    ],
    "section" : [
        {
            "title" : "Riwayat Kematian Anak",
            <font style="background: #E1D5E7"> "focus" </font>: {
                <font style="background: #E1D5E7"> "reference" : "Patient/100000030009" </font>,
                "display": "Baby of Teresa Lee (Fetus Not Named)"
            },
            ...
            ...
            ...
        },
        {
            "title" : "Riwayat Persalinan",
            <font style="background: #E1D5E7"> "focus" </font>: {
                <font style="background: #E1D5E7"> "reference" : "Patient/100000030009" </font>,
                "display": "Baby of Teresa Lee (Fetus Not Named)"
            },
            ...
            ...
            ...
        },
        {
            "title" : "Riwayat Kehamilan",
             <font style="background: #FFF2CC"> "focus"  </font>: {
                <font style="background: #FFF2CC"> "reference" : "Patient/P02280547535" </font>, 
                "display": "Patient - Mother (Teresa Lee)"
            },
            ...
            ...
            ...
        },
        {
            "title" : "Data Dasar Ibu",
            <font style="background: #FFF2CC"> "focus"  </font>: {
                <font style="background: #FFF2CC"> "reference" : "Patient/P02280547535" </font>,
                "display": "Patient - Mother (Teresa Lee)"
            },
            ...
            ...
            ...
        }
    ] 
}
</pre>
</div>

#### <div id="PerinatalDeathNotification"> Step 3. Pengiriman notifikasi pelaporan kematian anak</div>

<!-- Indent margin-left 30px-->
<div style="margin-left: 30px;">
Pada dasarnya di step-3 ini akan dilakukan 1 kali pengiriman data ke server SATUSEHAT dengan menggunakan resource Bundle tipe "Transaction". Berikut data-data yang akan dimasukkan ke dalam resource Bundle:<br>

> `CATATAN:`
> Catatan riwayat kematian dan persalinan akan mereferensi ke *Patient.id* sang anak, sedangkan data kehamilan dan data dasar ibu akan mereferensi ke data ibunya dengan patokan referensi pada kolom Observation.subject dan juga Composition.section.focus. Dalam hal ini, ID Pasien yang mana merupakan SatuSehat Number akan menjadi kode unik yang digunakan untuk menghubungkan catatan medis sesuai dengan data pasien yang terkait.
</div>
<!--END Indent margin-left 30px-->


<!--Part 3.1.-->
<h4 style="margin-left: 30px;">3.1. Pendaftaran Kunjungan Pasien</h4>
<div style="margin-left: 60px;">
<p>
Kunjungan pasien dapat didefinisikan sebagai interaksi pasien terhadap suatu layanan fasyankes. Sebagai contoh, dalam satu rangkaian rawat jalan, seluruh rangkaian dapat didefinisikan sebagai satu Encounter. Data-data kunjungan pasien yang direkam meliputi kapan pertemuan tersebut mulai dan selesai, siapa tenaga kesehatan yang melayani, siapa subjek dari pelayanannya, dan informasi pendukung lainnya.
</p>

<h4 style="font-weight: bold;">Pencarian Kunjungan Sebelumnya</h4>
Apabila kasus kematian yang dilaporkan bersumber dari data kunjungan *existing*, maka akan dilakukan proses pencarian data Encounter, yang dapat dilakukan melalui FHIR API dengan metode GET. Untuk metode pencarian data kunjungan di SATUSEHAT secara detail dapat dilihat dalam dokumen <a href="https://docs.google.com/document/d/1wGsuxUJcmWsGhTdAthe0pmcnsqtggLlQdFUG5fU4_T4/edit#heading=h.yqn6u1jxip9e">Petunjuk Teknis SATUSEHAT (Juknis SATSET)</a>.

<h4 style="font-weight: bold;">Pembuatan Kunjungan Baru</h4>

<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-2-1-post-encounter" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-2-1-post-encounter" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-2-1-post-encounter" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-2-1-post-encounter" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-2-1-post-encounter">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:example/MortalityRecord/Encounter-Create-Pembuatan-Kunjungan-Baru-1.json}}
        </div>
    </div>
    
    <div role="tabpanel" class="tab-pane" id="data-2-1-post-encounter">
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Encounter",
    "identifier": [
        {
            "system": "http://sys-ids.kemkes.go.id/encounter/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_LOCAL_CODE&rcub;&rcub;</strong>"
        },
        {
            "system": "http://sys-ids.kemkes.go.id/mpdn/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;MPDN_NO_KASUS&rcub;&rcub;</strong>"
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
		
<div role="tabpanel" class="tab-pane" id="variabel-2-1-post-encounter" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ENCOUNTER_LOCAL_CODE__   | ID Lokal untuk Kunjungan/Encounter |
| __MPDN_NO_KASUS__   | No kasus MPDN |
| __PATIENT_IHS_NUMBER__     | SATUSEHAT ID Number untuk Pasien |
| __PATIENT_NAME__           | Nama Pasien |
| __DOCTOR_IHS_NUMBER__      | SATUSEHAT ID untuk Dokter/Nakes |
| __DOCTOR_NAME__            | Nama Dokter/Nakes |
| __FACILITY_IHS_NUMBER__    | SATUSEHAT ID untuk FASYANKES |
| __ENCOUNTER_PERIOD1_START__| Waktu mulai/check-in kunjungan |
| __ENCOUNTER_PERIOD1_END__  | Waktu mulai/check-out kunjungan |
| __ENCOUNTER_LOCATION_ID__  | ID Location tempat kunjungan dilakukan |
| __ENCOUNTER_LOCATION_NAME__| Nama Location tempat kunjungan dilakukan |				| Usia pasien ketika meninggal (dalam tahun) |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-2-1-post-encounter" style="border: 1px solid #e8edee; padding: 15px 10px;">
			<div>
				[none]
			</div>
		</div>
	</div>
	</div>
<br>
<!--Part 3.1.-->


<!--Part 3.2.-->
<h4 style="margin-left: 30px;">3.2. Riwayat Kematian </h4>
<!--Variable riwayat kematian-->
<div style="margin-left: 60px;">

<h4 style="font-weight: bold;">Jenis Kematian</h4>
	
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-p-2-1-1-10" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-p-2-1-1-10" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-p-2-1-1-10" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-p-2-1-1-10" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-p-2-1-1-10">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:example-MortalityRecord-Observation-Create-Jenis-Kematian-1}}
        </div>
    </div>
    
    <div role="tabpanel" class="tab-pane" id="data-p-2-1-1-10">
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "identifier": [
        {
            "system": "http://sys-ids.kemkes.go.id/observation/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_LOCAL_CODE&rcub;&rcub;</strong>"
        }
    ],
    "status": "final",
    "category":  [
        {
            "coding":  [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "survey",
                    "display": "Survey"
                }
            ]
        }
    ],
    "code": {
        "coding":  [
			{
                "system": "http://loinc.org",
                "code": "64710-7",
                "display": "Was your pregnancy a live birth, stillbirth, miscarriage, abortion, or ectopic pregnancy [PhenX]"
            }
        ]
    },
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>",
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "effectiveDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_EFFECTIVE_DATETIME&rcub;&rcub;</strong>",
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer":  [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_IHS_NUMBER&rcub;&rcub;</strong>",
            "display": "<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_NAME&rcub;&rcub;</strong>"
        },
        {
            "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "display": "<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_NAME&rcub;&rcub;</strong>"
        }
    ],
	"valueCodeableConcept": {
        "coding":  [
            {
                "system": "http://snomed.info/sct",
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;VALUE_OBSERVATION_CODE&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;VALUE_OBSERVATION_DISPLAY&rcub;&rcub;</strong>"
            }
        ]
    }
}
		</pre>
	</div>
		
<div role="tabpanel" class="tab-pane" id="variabel-p-2-1-1-10" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __FACILITY_IHS_NUMBER__   			| SATUSEHAT ID untuk FASYANKES |
| __FACILITY_NAME__           			| Nama FASYANKES |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| SATUSEHAT ID Number untuk Pasien |
| __PATIENT_NAME__           			| Nama Pasien 	|
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __DOCTOR_IHS_NUMBER__    				| SATUSEHAT ID untuk Dokter/Nakes |
| __DOCTOR_NAME__           			| Nama Dokter/Nakes |
| __VALUE_OBSERVATION_CODE__| __(*)__ Kode data jenis kematian |
| __VALUE_OBSERVATION_DISPLAY__| __(*)__ Deskripsi data jenis kematian |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-p-2-1-1-10" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Jenis Data                       | URL Kamus Terminology |
| ------------------------------ | --------- |
| __Jenis Kematian__   | #tba |

</div>
</div>
<!-- END Tab panes -->
<br>

<h4 style="font-weight: bold;">Alamat Meninggal</h4>
Alamat meninggal anak baik di dalam fasilitas kesehatan (e.g. Rumah Sakit, Puskesmas, dll) ataupun tempat meninggal di luar fasilitas kesehatan (e.g. kematian di jalanan pada saat merujuk).

<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-p-2-1-1-7" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-p-2-1-1-7" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-p-2-1-1-7" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-p-2-1-1-7" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-p-2-1-1-7">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
         {{json:example-MortalityRecord-Location-Create-Alamat-Meninggal-1}}
        </div>
    </div>
    
    <div role="tabpanel" class="tab-pane" id="data-p-2-1-1-7">
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Location",
    "name": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_NAME&rcub;&rcub;</strong>",
    "type":  [
        {
            "coding":  [
                {
                    "system": "http://hl7.org/fhir/us/vrdr/CodeSystem/vrdr-location-type-cs",
                    "code": "death",
                    "display": "death location"
                }
            ]
        }
    ],
    "address": {
        "use": "work",
        "line":  [
            "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_ADDRESS&rcub;&rcub;</strong>"
        ],
        "city": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_CITY&rcub;&rcub;</strong>",
        "postalCode": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_POSTAL_CODE&rcub;&rcub;</strong>",
        "country": "ID",
        "extension":  [
            {
                "url": "https://fhir.kemkes.go.id/r4/StructureDefinition/administrativeCode",
                "extension":  [
                    {
                        "url": "province",
                        "valueCode": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_PROVINCE_CODE&rcub;&rcub;</strong>"
                    },
                    {
                        "url": "city",
                        "valueCode": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_CITY_CODE&rcub;&rcub;</strong>"
                    },
                    {
                        "url": "district",
                        "valueCode": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_DISTRICT_CODE&rcub;&rcub;</strong>"
                    },
                    {
                        "url": "village",
                        "valueCode": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_VILLAGE_CODE&rcub;&rcub;</strong>"
                    },
                    {
                        "url": "rt",
                        "valueCode": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_RT&rcub;&rcub;</strong>"
                    },
                    {
                        "url": "rw",
                        "valueCode": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_RW&rcub;&rcub;</strong>"
                    }
                ]
            }
        ]
    }
}
			</pre>
		</div>
		
<div role="tabpanel" class="tab-pane" id="variabel-p-2-1-1-7" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __LOCATION_NAME__   | Nama lokasi |
| __LOCATION_ADDRESS__   | Alamat lokasi tempat tinggal |
| __LOCATION_CITY__     | Nama kota |
| __LOCATION_POSTAL_CODE__ | Kode pos  |
| __LOCATION_PROVINCE_CODE__      | Kode provinsi berdasarkan kemendagri |
| __LOCATION_CITY_CODE__           | Kode kabupaten berdasarkan kemendagri |
| __LOCATION_DISTRICT_CODE__ | Kode kecamatan berdasarkan kemendagri	|
| __LOCATION_VILLAGE_CODE__ | Kode kelurahan berdasarkan kemendagri	|
| __LOCATION_RT__ | Nomor RT	|
| __LOCATION_RW__ | Nomor RW	|

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-p-2-1-1-7" style="border: 1px solid #e8edee; padding: 15px 10px;">
			<div>
				[none]
			</div>
		</div>
	</div>
<br>

<h4 style="font-weight: bold;">Tanggal dan Jam Meninggal</h4>
	
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-p-2-1-1-1" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-p-2-1-1-1" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-p-2-1-1-1" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-p-2-1-1-1" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-p-2-1-1-1">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:example-MortalityRecord-Observation-Create-DateTime-Of-Death-1}}
        </div>
    </div>
    
    <div role="tabpanel" class="tab-pane" id="data-p-2-1-1-1">
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
   "identifier": [
        {
            "system": "http://sys-ids.kemkes.go.id/observation/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_LOCAL_CODE&rcub;&rcub;</strong>"
        }
    ],
    "status": "final",
    "category":  [
        {
            "coding":  [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "survey",
                    "display": "Survey"
                }
            ]
        }
    ],
    "code": {
        "coding":  [
            {
                "system": "http://loinc.org",
                "code": "81956-5",
                "display": "Date+time of death"
            },
            {
                "system": "http://fhir.org/guides/who/ikp-cds/CodeSystem/ikp-custom-codes",
                "code": "IKP.SS.DE1",
                "display": "Tanggal dan Jam Meninggal"
            }
        ]
    },
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>",
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "effectiveDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_EFFECTIVE_DATETIME&rcub;&rcub;</strong>",
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer":  [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_IHS_NUMBER&rcub;&rcub;</strong>",
            "display": "<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_NAME&rcub;&rcub;</strong>"
        },
        {
            "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "display": "<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_NAME&rcub;&rcub;</strong>"
        }
    ],
    "valueDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;VALUE_OBSERVATION&rcub;&rcub;</strong>"
}
		</pre>
	</div>
		
<div role="tabpanel" class="tab-pane" id="variabel-p-2-1-1-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __FACILITY_IHS_NUMBER__   			| SATUSEHAT ID untuk FASYANKES |
| __FACILITY_NAME__           			| Nama FASYANKES |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| SATUSEHAT ID Number untuk Pasien |
| __PATIENT_NAME__           			| Nama Pasien 	|
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __DOCTOR_IHS_NUMBER__    				| SATUSEHAT ID untuk Dokter/Nakes |
| __DOCTOR_NAME__           			| Nama Dokter/Nakes |
| __VALUE_OBSERVATION__					| Usia pasien ketika meninggal (dalam tahun) |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-p-2-1-1-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
			<div>
				[none]
			</div>
		</div>
	</div>
<!-- END Tab panes -->
<br>

<h4 style="font-weight: bold;">Masa Terjadi Kematian Anak</h4>
	
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-p-2-1-1-2" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-p-2-1-1-2" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-p-2-1-1-2" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-p-2-1-1-2" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-p-2-1-1-2">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:example-MortalityRecord-Observation-Create-Masa-Terjadi-Kematian-Anak-1}}
        </div>
    </div>
    
    <div role="tabpanel" class="tab-pane" id="data-p-2-1-1-2">
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
   "identifier": [
        {
            "system": "http://sys-ids.kemkes.go.id/observation/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_LOCAL_CODE&rcub;&rcub;</strong>"
        }
    ],
    "status": "final",
    "category":  [
        {
            "coding":  [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "survey",
                    "display": "Survey"
                }
            ]
        }
    ],
    "code": {
        "coding":  [
             {
                "system": "http://loinc.org",
                "code": "73811-2",
                "display": "Estimated timing of fetal death"
            },
            {
                "system": "http://fhir.org/guides/who/ikp-cds/CodeSystem/ikp-custom-codes",
                "code": "IKP.SS.DE2",
                "display": "Masa Terjadi Kematian Anak"
            }
        ]
    },
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>",
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "effectiveDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_EFFECTIVE_DATETIME&rcub;&rcub;</strong>",
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer":  [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_IHS_NUMBER&rcub;&rcub;</strong>",
            "display": "<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_NAME&rcub;&rcub;</strong>"
        },
        {
            "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "display": "<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_NAME&rcub;&rcub;</strong>"
        }
    ],
    "valueCodeableConcept": {
        "coding":  [
            {
                "system": "http://snomed.info/sct",
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;VALUE_OBSERVATION_CODE&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;VALUE_OBSERVATION_DISPLAY&rcub;&rcub;</strong>"
            }
        ]
    }
}
		</pre>
	</div>
		
<div role="tabpanel" class="tab-pane" id="variabel-p-2-1-1-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __FACILITY_IHS_NUMBER__   | SATUSEHAT ID untuk FASYANKES |
| __FACILITY_NAME__           			| Nama FASYANKES |
| __OBSERVATION_LOCAL_CODE__     | ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      | SATUSEHAT ID Number untuk Pasien |
| __PATIENT_NAME__           | Nama Pasien |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __DOCTOR_IHS_NUMBER__    | SATUSEHAT ID untuk Dokter/Nakes |
| __DOCTOR_NAME__            | Nama Dokter/Nakes |
| __VALUE_OBSERVATION_CODE__| __(*)__ Kode data masa terjadi kematian |
| __VALUE_OBSERVATION_DISPLAY__| __(*)__ Deskripsi data masa terjadi kematian |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-p-2-1-1-2" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Jenis Data                       | URL Kamus Terminology |
| ------------------------------ | --------- |
| __Masa terjadi kematian__   | #tba |
</div>
</div>
<!-- END Tab panes -->
<br>

<h4 style="font-weight: bold;">Dugaan Sebab Kematian</h4>

<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-p-2-1-1-4" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-p-2-1-1-4" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-p-2-1-1-4" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-p-2-1-1-4" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-p-2-1-1-4">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:example-MortalityRecord-Condition-Create-Dugaan-Sebab-Kematian-2}}
        </div>
    </div>
    
    <div role="tabpanel" class="tab-pane" id="data-p-2-1-1-4">
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Condition",
    "verificationStatus": {
        "coding":  [
            {
                "system": "http://terminology.hl7.org/CodeSystem/condition-ver-status",
                "code": "unconfirmed",
                "display": "Unconfirmed"
            }
        ]
    },
    "category":  [
        {
            "coding":  [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/condition-category",
                    "code": "encounter-diagnosis",
                    "display": "Encounter Diagnosis"
                },
                {
                    "system": "http://fhir.org/guides/who/ikp-cds/CodeSystem/ikp-custom-codes",
                    "code": "#tba",
                    "display": "Dugaan Sebab Kematian Bayi"
                }
            ]
        }
    ],
    "code": {
        "coding":  [
            {
                "system": "http://snomed.info/sct",
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;CONDITION_VALUE_CODE&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;CONDITION_VALUE_DISPLAY&rcub;&rcub;</strong>"
            }
        ]
    },
   
    "onsetDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;CONDITION_ONSET_DATETIME&rcub;&rcub;</strong>",
    "recordedDate": "<strong style="color:#00a7ff">&lcub;&lcub;CONDITION_RECORDED_DATETIME&rcub;&rcub;</strong>",
    "recorder": 
}
		</pre>
	</div>
		
<div role="tabpanel" class="tab-pane" id="variabel-p-2-1-1-4" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __CONDITION_VALUE_CODE__     | __(*)__ Kode data dugaan sebab kematian |
| __CONDITION_VALUE_DISPLAY__ | __(*)__ Deskripsi data dugaan sebab kematian |
| __PATIENT_IHS_NUMBER__      | SATUSEHAT ID Number untuk Pasien |
| __PATIENT_NAME__           | Nama Pasien |
| __CONDITION_ONSET_DATETIME__ | Tanggal perkiraan atau tanggal aktual atau tanggal-waktu kondisi mulai, menurut pendapat dokter.|
| __CONDITION_RECORDED_DATETIME__ | 	Tanggal kapan kondisi/keluhan ini tercatat dalam sistem (tanggal yang dibuat oleh sistem)|
| __DOCTOR_IHS_NUMBER__    | SATUSEHAT ID untuk Dokter/Nakes |
| __DOCTOR_NAME__            | Nama Dokter/Nakes |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-p-2-1-1-4" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Jenis Data                       | URL Kamus Terminology |
| ------------------------------ | --------- |
| __Dugaan sebab kematian__   | #tba |
</div>
</div>
<!-- END Tab panes -->
<br>


<h4 style="font-weight: bold;">Jenis Tempat Meninggal</h4>

<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-p-2-1-1-6" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-p-2-1-1-6" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-p-2-1-1-6" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-p-2-1-1-6" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-p-2-1-1-6">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
         {{json:example-MortalityRecord-Observation-Create-Jenis-Tempat-Meninggal-2}}
        </div>
    </div>
    
    <div role="tabpanel" class="tab-pane" id="data-p-2-1-1-6">
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "identifier":  [
        {
            "system": "http://sys-ids.kemkes.go.id/observation/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_LOCAL_CODE&rcub;&rcub;</strong>"
        }
    ],
    "status": "final",
    "code": {
        "coding":  [
            {
                "system": "http://fhir.org/guides/who/ikm-cds/CodeSystem/ikm-custom-codes",
                "code": "IKM.SS.DE19",
                "display": "Jenis Tempat Meninggal"
            }
        ]
    },
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>",
		"display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "effectiveDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_EFFECTIVE_DATETIME&rcub;&rcub;</strong>",
	"issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer":  [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_IHS_NUMBER&rcub;&rcub;</strong>",
            "display": "<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_NAME&rcub;&rcub;</strong>"
        },
        {
            "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "display": "<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_NAME&rcub;&rcub;</strong>"
        }
    ],
    "valueCodeableConcept": {
        "coding":  [
            {
                "system": "http://snomed.info/sct",
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;VALUE_OBSERVATION_CODE&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;VALUE_OBSERVATION_DESCRIPTION&rcub;&rcub;</strong>"
            }
        ]
    }
}
			</pre>
		</div>
		
<div role="tabpanel" class="tab-pane" id="variabel-p-2-1-1-6" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __FACILITY_IHS_NUMBER__   | SATUSEHAT ID untuk FASYANKES |
| __FACILITY_NAME__           			| Nama FASYANKES |
| __OBSERVATION_LOCAL_CODE__     | ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      | SATUSEHAT ID Number untuk Pasien |
| __PATIENT_NAME__           | Nama Pasien |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __DOCTOR_IHS_NUMBER__    | SATUSEHAT ID untuk Dokter/Nakes |
| __DOCTOR_NAME__            | Nama Dokter/Nakes |
| __VALUE_OBSERVATION_CODE__| __(*)__ Kode data jenis tempat meninggal|
| __VALUE_OBSERVATION_DESCRIPTION__| __(*)__ Deskripsi data jenis tempat meninggal|

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-p-2-1-1-6" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Jenis Data                       | URL Kamus Terminology |
| ------------------------------ | --------- |
| __Jenis tempat meninggal__   | #tba |

</div>
</div>
<!-- END Tab panes -->
<br>

<h4 style="font-weight: bold;">Maserasi</h4>
	
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-p-2-1-1-3" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-p-2-1-1-3" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-p-2-1-1-3" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-p-2-1-1-3" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-p-2-1-1-3">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:example-MortalityRecord-Observation-Create-Maserasi-1}}
        </div>
    </div>
    
    <div role="tabpanel" class="tab-pane" id="data-p-2-1-1-3">
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
   "identifier": [
        {
            "system": "http://sys-ids.kemkes.go.id/observation/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_LOCAL_CODE&rcub;&rcub;</strong>"
        }
    ],
    "status": "final",
    "category":  [
        {
            "coding":  [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "survey",
                    "display": "Survey"
                }
            ]
        }
    ],
    "code": {
        "coding":  [
            {
                "system": "#tba",
                "code": "#tba",
                "display": "Macerated"
            }
        ]
    },
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>",
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "effectiveDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_EFFECTIVE_DATETIME&rcub;&rcub;</strong>",
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer":  [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_IHS_NUMBER&rcub;&rcub;</strong>",
            "display": "<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_NAME&rcub;&rcub;</strong>"
        },
        {
            "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "display": "<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_NAME&rcub;&rcub;</strong>"
        }
    ],
    "valueCodeableConcept": {
        "coding":  [
            {
                "system": "http://snomed.info/sct",
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;VALUE_OBSERVATION_CODE&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;VALUE_OBSERVATION_DISPLAY&rcub;&rcub;</strong>"
            }
        ]
    }
}
		</pre>
	</div>
		
<div role="tabpanel" class="tab-pane" id="variabel-p-2-1-1-3" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __FACILITY_IHS_NUMBER__   | SATUSEHAT ID untuk FASYANKES |
| __FACILITY_NAME__           			| Nama FASYANKES |
| __OBSERVATION_LOCAL_CODE__     | ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      | SATUSEHAT ID Number untuk Pasien |
| __PATIENT_NAME__           | Nama Pasien |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __DOCTOR_IHS_NUMBER__    | SATUSEHAT ID untuk Dokter/Nakes |
| __DOCTOR_NAME__            | Nama Dokter/Nakes |
| __VALUE_OBSERVATION_CODE__| __(*)__ Kode data tingkat maserasi |
| __VALUE_OBSERVATION_DISPLAY__| __(*)__ Deskripsi data tingkat maserasi |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-p-2-1-1-3" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Jenis Data                       | URL Kamus Terminology |
| ------------------------------ | --------- |
| __Tingkat maserasi__   | #tba |
</div>
</div>
<!-- END Tab panes -->
<br>

<h4 style="font-weight: bold;">Keluhan/Gejala Utama Sebelum Bayi Meninggal</h4>
	
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-p-2-1-1-5" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-p-2-1-1-5" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-p-2-1-1-5" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-p-2-1-1-5" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-p-2-1-1-5">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:example-MortalityRecord-Condition-Create-Keluhan-Gejala-Utama-1}}
        </div>
    </div>
    
    <div role="tabpanel" class="tab-pane" id="data-p-2-1-1-5">
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Condition",
    "verificationStatus": {
        "coding":  [
            {
                "system": "http://terminology.hl7.org/CodeSystem/condition-ver-status",
                "code": "confirmed",
                "display": "Confirmed"
            }
        ]
    },
    "category":  [
        {
            "coding":  [
				{
                    "system": "http://terminology.hl7.org/CodeSystem/condition-category",
                    "code": "problem-list-item",
                    "display": "Problem List Item"
                },
                {
                    "system": "http://loinc.org",
                    "code": "75321-0",
                    "display": "Clinical finding"
                }
            ]
        }
    ],
    "code": {
        "coding":  [
            {
                "system": "http://snomed.info/sct",
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;CONDITION_VALUE_CODE&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;CONDITION_VALUE_DISPLAY&rcub;&rcub;</strong>"
            }
        ]
    },
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>",
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "onsetDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;CONDITION_ONSET_DATETIME&rcub;&rcub;</strong>",
    "recordedDate": "<strong style="color:#00a7ff">&lcub;&lcub;CONDITION_RECORDED_DATETIME&rcub;&rcub;</strong>",
    "recorder": {
        "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_IHS_NUMBER&rcub;&rcub;</strong>",
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_NAME&rcub;&rcub;</strong>"
    }
}
		</pre>
	</div>
		
<div role="tabpanel" class="tab-pane" id="variabel-p-2-1-1-5" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __CONDITION_VALUE_CODE__     | __(*)__ Kode data keluhan/ gejala utama sebelum meninggal |
| __CONDITION_VALUE_DISPLAY__ | __(*)__ Deskripsi data keluhan/ gejala utama sebelum meninggal |
| __PATIENT_IHS_NUMBER__      | SATUSEHAT ID Number untuk Pasien |
| __PATIENT_NAME__           | Nama Pasien |
| __CONDITION_ONSET_DATETIME__ | Tanggal perkiraan atau tanggal aktual atau tanggal-waktu kondisi mulai, menurut pendapat dokter.|
| __CONDITION_RECORDED_DATETIME__ | 	Tanggal kapan kondisi/keluhan ini tercatat dalam sistem (tanggal yang dibuat oleh sistem)|
| __DOCTOR_IHS_NUMBER__    | SATUSEHAT ID untuk Dokter/Nakes |
| __DOCTOR_NAME__            | Nama Dokter/Nakes |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-p-2-1-1-5" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Jenis Data                       | URL Kamus Terminology |
| ------------------------------ | --------- |
| __Keluhan/ gejala utama sebelum meninggal__   | #tba |
</div>
</div>
<!-- END Tab panes -->
<br>

<h4 style="font-weight: bold;">Kondisi Ibu Sebelum Janin Meninggal</h4>	
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-p-2-1-1-11" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-p-2-1-1-11" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-p-2-1-1-11" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-p-2-1-1-11" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-p-2-1-1-11">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:example-MortalityRecord-Condition-Create-Keluhan-Gejala-Utama-2}}
        </div>
    </div>
    
    <div role="tabpanel" class="tab-pane" id="data-p-2-1-1-11">
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Condition",
    "verificationStatus": {
        "coding":  [
            {
                "system": "http://terminology.hl7.org/CodeSystem/condition-ver-status",
                "code": "confirmed",
                "display": "Confirmed"
            }
        ]
    },
    "category":  [
        {
            "coding":  [
				{
                    "system": "http://terminology.hl7.org/CodeSystem/condition-category",
                    "code": "problem-list-item",
                    "display": "Problem List Item"
                },
                {
                    "system": "http://loinc.org",
                    "code": "75321-0",
                    "display": "Clinical finding"
                }
            ]
        }
    ],
    "code": {
        "coding":  [
            {
                "system": "http://snomed.info/sct",
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;CONDITION_VALUE_CODE&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;CONDITION_VALUE_DISPLAY&rcub;&rcub;</strong>"
            }
        ]
    },
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>",
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "onsetDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;CONDITION_ONSET_DATETIME&rcub;&rcub;</strong>",
    "recordedDate": "<strong style="color:#00a7ff">&lcub;&lcub;CONDITION_RECORDED_DATETIME&rcub;&rcub;</strong>",
    "recorder": {
        "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_IHS_NUMBER&rcub;&rcub;</strong>",
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_NAME&rcub;&rcub;</strong>"
    }
}
		</pre>
	</div>
		
<div role="tabpanel" class="tab-pane" id="variabel-p-2-1-1-11" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __CONDITION_VALUE_CODE__     | __(*)__ Kode data kondisi Ibu sebelum janin meninggal|
| __CONDITION_VALUE_DISPLAY__ | __(*)__ Deskripsi data kondisi Ibu sebelum janin meninggal |
| __PATIENT_IHS_NUMBER__      | SATUSEHAT ID Number untuk Pasien |
| __PATIENT_NAME__           | Nama Pasien |
| __CONDITION_ONSET_DATETIME__ | Tanggal perkiraan atau tanggal aktual atau tanggal-waktu kondisi mulai, menurut pendapat dokter.|
| __CONDITION_RECORDED_DATETIME__ | 	Tanggal kapan kondisi/keluhan ini tercatat dalam sistem (tanggal yang dibuat oleh sistem)|
| __DOCTOR_IHS_NUMBER__    | SATUSEHAT ID untuk Dokter/Nakes |
| __DOCTOR_NAME__            | Nama Dokter/Nakes |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-p-2-1-1-11" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Jenis Data                       | URL Kamus Terminology |
| ------------------------------ | --------- |
| __Kondisi Ibu sebelum janin meninggal__   | #tba |
</div>
</div>
<br>

</div>
<!--END Variable riwayat kematian-->
<!--END Part 2.1.-->


<!--Part 2.2.-->
<h4 style="margin-left: 30px;"> 3.2. Riwayat Persalinan</h4>

<!--Variable riwayat persalinan-->
<div style="margin-left: 60px;">
<h4 style="font-weight: bold;">Berat Lahir</h4>	
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-p-2-1-2-1" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-p-2-1-2-1" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-p-2-1-2-1" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-p-2-1-2-1" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-p-2-1-2-1">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:example-MortalityRecord-Observation-Create-BodyWeight-At-Birth-1}}
        </div>
    </div>
    
    <div role="tabpanel" class="tab-pane" id="data-p-2-1-2-1">
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "identifier": [
        {
            "system": "http://sys-ids.kemkes.go.id/observation/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_LOCAL_CODE&rcub;&rcub;</strong>"
        }
    ],
    "status": "final",
    "category":  [
        {
            "coding":  [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "survey",
                    "display": "Survey"
                }
            ]
        }
    ],
    "code": {
        "coding":  [
			{
                "system": "http://loinc.org",
                "code": "8339-4",
                "display": "Birth weight Measured"
            }
        ]
    },
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>",
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "effectiveDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_EFFECTIVE_DATETIME&rcub;&rcub;</strong>",
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer":  [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_IHS_NUMBER&rcub;&rcub;</strong>",
            "display": "<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_NAME&rcub;&rcub;</strong>"
        },
        {
            "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "display": "<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_NAME&rcub;&rcub;</strong>"
        }
    ],
	"valueQuantity": {
        "value": <strong style="color:#00a7ff">&lcub;&lcub;VALUE_OBSERVATION&rcub;&rcub;</strong>,
        "unit": "gram",
        "system": "http://unitsofmeasure.org",
        "code": "g"
    }
}
		</pre>
	</div>
		
<div role="tabpanel" class="tab-pane" id="variabel-p-2-1-2-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __FACILITY_IHS_NUMBER__   			| SATUSEHAT ID untuk FASYANKES |
| __FACILITY_NAME__           			| Nama FASYANKES |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| SATUSEHAT ID Number untuk Pasien |
| __PATIENT_NAME__           			| Nama Pasien 	|
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __DOCTOR_IHS_NUMBER__    				| SATUSEHAT ID untuk Dokter/Nakes |
| __DOCTOR_NAME__           			| Nama Dokter/Nakes |
| __VALUE_OBSERVATION__					| Berat bayi ketika lahir (dalam gram) |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-p-2-1-2-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
			<div>
				[none]
			</div>
		</div>
	</div>
<!-- END Tab panes -->
<br>

<h4 style="font-weight: bold;">Kelainan Bawaan</h4>	
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-p-2-1-2-2" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-p-2-1-2-2" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-p-2-1-2-2" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-p-2-1-2-2" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-p-2-1-2-2">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:example-MortalityRecord-Observation-Create-KelainanBawaan-YesNo-1}}
        </div>
    </div>
    
    <div role="tabpanel" class="tab-pane" id="data-p-2-1-2-2">
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "identifier": [
        {
            "system": "http://sys-ids.kemkes.go.id/observation/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_LOCAL_CODE&rcub;&rcub;</strong>"
        }
    ],
    "status": "final",
    "category":  [
        {
            "coding":  [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "survey",
                    "display": "Survey"
                }
            ]
        }
    ],
    "code": {
        "coding":  [
			{
                "system": "http://snomed.info/sct",
                "code": "276654001",
                "display": "Congenital malformation"
            }
        ]
    },
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>",
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "effectiveDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_EFFECTIVE_DATETIME&rcub;&rcub;</strong>",
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer":  [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_IHS_NUMBER&rcub;&rcub;</strong>",
            "display": "<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_NAME&rcub;&rcub;</strong>"
        },
        {
            "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "display": "<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_NAME&rcub;&rcub;</strong>"
        }
    ],
	"valueBoolean": <strong style="color:#00a7ff">&lcub;&lcub;VALUE_OBSERVATION&rcub;&rcub;</strong>
}
		</pre>
	</div>
		
<div role="tabpanel" class="tab-pane" id="variabel-p-2-1-2-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __FACILITY_IHS_NUMBER__   			| SATUSEHAT ID untuk FASYANKES |
| __FACILITY_NAME__           			| Nama FASYANKES |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| SATUSEHAT ID Number untuk Pasien |
| __PATIENT_NAME__           			| Nama Pasien 	|
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __DOCTOR_IHS_NUMBER__    				| SATUSEHAT ID untuk Dokter/Nakes |
| __DOCTOR_NAME__           			| Nama Dokter/Nakes |
| __VALUE_OBSERVATION__					| Opsinya "true" apabila ada kelainan bawaan dan "false" apabila tidak ada|

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-p-2-1-2-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
			<div>
				[none]
			</div>
		</div>
	</div>
<!-- END Tab panes -->
<br>

</div>
<!--END Variable riwayat persalinan-->
<!--END Part 2.2.-->

<!--Part 2.3.-->
<h4 style="margin-left: 30px;"> 3.3. Riwayat Kehamilan </h4>

<!--Variable riwayat Kehamilan-->
<div style="margin-left: 60px;">
<h4 style="font-weight: bold;">Usia Kehamilan</h4>	
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-p-2-1-3-1" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-p-2-1-3-1" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-p-2-1-3-1" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-p-2-1-3-1" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-p-2-1-3-1">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:example-MortalityRecord-Observation-Create-Gestational-Age-Week-1}}
        </div>
    </div>
    
    <div role="tabpanel" class="tab-pane" id="data-p-2-1-3-1">
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "identifier": [
        {
            "system": "http://sys-ids.kemkes.go.id/observation/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_LOCAL_CODE&rcub;&rcub;</strong>"
        }
    ],
    "status": "final",
    "category":  [
        {
            "coding":  [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "survey",
                    "display": "Survey"
                }
            ]
        }
    ],
    "code": {
        "coding":  [
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
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>",
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "effectiveDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_EFFECTIVE_DATETIME&rcub;&rcub;</strong>",
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer":  [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_IHS_NUMBER&rcub;&rcub;</strong>",
            "display": "<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_NAME&rcub;&rcub;</strong>"
        },
        {
            "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "display": "<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_NAME&rcub;&rcub;</strong>"
        }
    ],
	"valueQuantity": {
        "value": "<strong style="color:#00a7ff">&lcub;&lcub;VALUE_OBSERVATION&rcub;&rcub;</strong>",
        "unit": "week",
        "system": "http://unitsofmeasure.org",
        "code": "wk"
    }
}
		</pre>
	</div>
		
<div role="tabpanel" class="tab-pane" id="variabel-p-2-1-3-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __FACILITY_IHS_NUMBER__   			| SATUSEHAT ID untuk FASYANKES |
| __FACILITY_NAME__           			| Nama FASYANKES |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| SATUSEHAT ID Number untuk Pasien |
| __PATIENT_NAME__           			| Nama Pasien 	|
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __DOCTOR_IHS_NUMBER__    				| SATUSEHAT ID untuk Dokter/Nakes |
| __DOCTOR_NAME__           			| Nama Dokter/Nakes |
| __VALUE_OBSERVATION__					| Usia kehamilan ibu (dalam minggu) |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-p-2-1-3-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
			<div>
				[none]
			</div>
		</div>
	</div>
<br>

<h4 style="font-weight: bold;">Gravida</h4>	
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-p-2-1-3-2" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-p-2-1-3-2" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-p-2-1-3-2" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-p-2-1-3-2" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-p-2-1-3-2">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:example-MortalityRecord-Observation-Create-Gravida-1}}
        </div>
    </div>
    
    <div role="tabpanel" class="tab-pane" id="data-p-2-1-3-2">
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "identifier": [
        {
            "system": "http://sys-ids.kemkes.go.id/observation/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_LOCAL_CODE&rcub;&rcub;</strong>"
        }
    ],
    "status": "final",
    "category":  [
        {
            "coding":  [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "survey",
                    "display": "Survey"
                }
            ]
        }
    ],
    "code": {
        "coding":  [
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
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>",
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "effectiveDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_EFFECTIVE_DATETIME&rcub;&rcub;</strong>",
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer":  [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_IHS_NUMBER&rcub;&rcub;</strong>",
            "display": "<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_NAME&rcub;&rcub;</strong>"
        },
        {
            "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "display": "<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_NAME&rcub;&rcub;</strong>"
        }
    ],
    "valueInteger": <strong style="color:#00a7ff">&lcub;&lcub;VALUE_OBSERVATION&rcub;&rcub;</strong>
}
		</pre>
	</div>
		
<div role="tabpanel" class="tab-pane" id="variabel-p-2-1-3-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __FACILITY_IHS_NUMBER__   			| SATUSEHAT ID untuk FASYANKES |
| __FACILITY_NAME__           			| Nama FASYANKES |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| SATUSEHAT ID Number untuk Pasien |
| __PATIENT_NAME__           			| Nama Pasien 	|
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __DOCTOR_IHS_NUMBER__    				| SATUSEHAT ID untuk Dokter/Nakes |
| __DOCTOR_NAME__           			| Nama Dokter/Nakes |
| __VALUE_OBSERVATION__					| Jumlah gravida (total kehamilan ibu) |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-p-2-1-3-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
			<div>
				[none]
			</div>
		</div>
	</div>
<br>

<h4 style="font-weight: bold;">Tanggal HPHT</h4>	
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-p-2-1-3-4" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-p-2-1-3-4" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-p-2-1-3-4" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-p-2-1-3-4" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-p-2-1-3-4">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:example-MortalityRecord-Observation-Create-Tanggal-HPHT-1}}
        </div>
    </div>
    
    <div role="tabpanel" class="tab-pane" id="data-p-2-1-3-4">
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
	"identifier": [
        {
            "system": "http://sys-ids.kemkes.go.id/observation/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_LOCAL_CODE&rcub;&rcub;</strong>"
        }
    ],
    "status": "final",
    "category":  [
        {
            "coding":  [
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
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>",
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "effectiveDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_EFFECTIVE_DATETIME&rcub;&rcub;</strong>",
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer":  [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_IHS_NUMBER&rcub;&rcub;</strong>",
            "display": "<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_NAME&rcub;&rcub;</strong>"
        },
        {
            "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "display": "<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_NAME&rcub;&rcub;</strong>"
        }
    ],
    "valueDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;VALUE_OBSERVATION&rcub;&rcub;</strong>"
}
		</pre>
	</div>
		
<div role="tabpanel" class="tab-pane" id="variabel-p-2-1-3-4" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __FACILITY_IHS_NUMBER__   | SATUSEHAT ID untuk FASYANKES |
| __FACILITY_NAME__           			| Nama FASYANKES |
| __OBSERVATION_LOCAL_CODE__     | ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      | SATUSEHAT ID Number untuk Pasien |
| __PATIENT_NAME__           | Nama Pasien |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __DOCTOR_IHS_NUMBER__    | SATUSEHAT ID untuk Dokter/Nakes |
| __DOCTOR_NAME__            | Nama Dokter/Nakes |
| __VALUE_OBSERVATION__| __(*)__ Tanggal terakhir menstruasi |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-p-2-1-3-4" style="border: 1px solid #e8edee; padding: 15px 10px;">
[none]
</div>
</div>
<br>
</div>
<!--END Variable riwayat Kehamilan-->
<!--END Part 2.3.-->


<!--Part 2.4-->
<h4 style="margin-left: 30px;">3.4. Data Dasar Ibu</h4>

<!--Variable Data Dasar Ibu-->
<div style="margin-left: 60px;">
Dalam kasus pelaporan kematian Ibu, ada keperluan untuk meminta informasi alamat domisili pasien yang terbaru, karena ada skenario dimana pasien mungkin tidak tinggal di alamat yang terdaftar di KTP mereka. Informasi alamat domisili saat ini dari ibu yang sudah meninggal sangat penting untuk melacak asal dan kondisi kesehatan ibu tersebut sebelum meninggal. Informasi tersebut dapat membantu dalam mengetahui faktor-faktor penyebab kematian dan memperbaiki pelayanan kesehatan maternal di masa depan. Selain itu, informasi alamat domisili sekarang juga dapat membantu dalam menghubungi keluarga dan kerabat dekat ibu yang meninggal untuk memberikan informasi lebih lanjut mengenai kondisi ibu tersebut.

<!--Variable Data Dasar Ibu-->
<h4 style="font-weight: bold;">Alamat Domisili</h4>
<p>Data alamat domisili akan diupdate pada resource Patient dengan metode PATCH, tambahan data dilakukan pada kolom Patient.address dengan Patient.address[x].use= "temp". Apabila alamat domisili pasien sudah tersedia sebelumnya, maka *operation* PATCH yang akan digunakan adalah op= "replace", sedangkan pada skenario menambahkan alamat domisili dapat menggunakan op= "add"</p>
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-2-1-3-1" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-2-1-3-1" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-2-1-3-1" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-2-1-3-1" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-2-1-3-1">
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">[
    { 
        "op": "add", "path": "/address/1", "value": 
        {    
            "use": "temp",
            "line": [
                "Gd. Dr. Sujuki Lt.1, Jl. H.R. Rasuna Said Blok X5 Kav. 4-9 Kuningan"
            ],
            "city": "Jakarta index new1",
            "postalCode": "12950",
            "country": "ID",
            "extension": [
                {
                    "url": "https://fhir.kemkes.go.id/r4/StructureDefinition/administrativeCode",
                    "extension": [
                        {
                            "url": "province",
                            "valueCode": "10"
                        },
                        {
                            "url": "city",
                            "valueCode": "1010"
                        },
                        {
                            "url": "district",
                            "valueCode": "1010101"
                        },
                        {
                            "url": "village",
                            "valueCode": "1010101101"
                        },
                        {
                            "url": "rt",
                            "valueCode": "2"
                        },
                        {
                            "url": "rw",
                            "valueCode": "2"
                        }
                    ]
                }
            ]
        } 
    }
]
        </pre>
    </div>
    
    <div role="tabpanel" class="tab-pane" id="data-2-1-3-1">
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
[
    {
        "op": "replace",
        "path": "/address",
        "value": [
            {
                "use": "home",
                "line":  [
					"<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_ADDRESS&rcub;&rcub;</strong>"
				],
				"city": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_CITY&rcub;&rcub;</strong>",
				"postalCode": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_POSTAL_CODE&rcub;&rcub;</strong>",
                "country": "ID",
                "extension": [
                    {
                        "url": "https://fhir.kemkes.go.id/r4/StructureDefinition/administrativeCode",
                        "extension": [
                            {
								"url": "province",
								"valueCode": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_PROVINCE_CODE&rcub;&rcub;</strong>"
							},
							{
								"url": "city",
								"valueCode": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_CITY_CODE&rcub;&rcub;</strong>"
							},
							{
								"url": "district",
								"valueCode": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_DISTRICT_CODE&rcub;&rcub;</strong>"
							},
							{
								"url": "village",
								"valueCode": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_VILLAGE_CODE&rcub;&rcub;</strong>"
							},
							{
								"url": "rt",
								"valueCode": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_RT&rcub;&rcub;</strong>"
							},
							{
								"url": "rw",
								"valueCode": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_RW&rcub;&rcub;</strong>"
							}
                        ]
                    }
                ]
            },
            {
				"use": "temp",
				"line":  [
					"<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_ADDRESS&rcub;&rcub;</strong>"
				],
				"city": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_CITY&rcub;&rcub;</strong>",
				"postalCode": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_POSTAL_CODE&rcub;&rcub;</strong>",
				"country": "ID",
				"extension":  [
					{
						"url": "https://fhir.kemkes.go.id/r4/StructureDefinition/administrativeCode",
						"extension":  [
							{
								"url": "province",
								"valueCode": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_PROVINCE_CODE&rcub;&rcub;</strong>"
							},
							{
								"url": "city",
								"valueCode": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_CITY_CODE&rcub;&rcub;</strong>"
							},
							{
								"url": "district",
								"valueCode": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_DISTRICT_CODE&rcub;&rcub;</strong>"
							},
							{
								"url": "village",
								"valueCode": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_VILLAGE_CODE&rcub;&rcub;</strong>"
							},
							{
								"url": "rt",
								"valueCode": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_RT&rcub;&rcub;</strong>"
							},
							{
								"url": "rw",
								"valueCode": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_RW&rcub;&rcub;</strong>"
							}
						]
					}
				]
			}
		]
    }
]
			</pre>
		</div>
		
<div role="tabpanel" class="tab-pane" id="variabel-2-1-3-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __LOCATION_ADDRESS__   | Alamat lokasi tempat tinggal |
| __LOCATION_CITY__     | Nama kota |
| __LOCATION_POSTAL_CODE__ | Kode pos  |
| __LOCATION_PROVINCE_CODE__      | Kode provinsi berdasarkan kemendagri |
| __LOCATION_CITY_CODE__           | Kode kabupaten berdasarkan kemendagri |
| __LOCATION_DISTRICT_CODE__ | Kode kecamatan berdasarkan kemendagri	|
| __LOCATION_VILLAGE_CODE__ | Kode kelurahan berdasarkan kemendagri	|
| __LOCATION_RT__ | Nomor RT	|
| __LOCATION_RW__ | Nomor RW	|
| __LOCATION_PERIOD_START__ | 	Periode dimulainya masa tinggal ibu di lokasi domisili tersebut|
| __LOCATION_PERIOD_END__ |Periode berakhirnya masa tinggal ibu di lokasi domisili tersebut	|

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-2-1-3-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
			<div>
				[none]
			</div>
		</div>
	</div>
<br>

<h4 style="font-weight: bold;">Umur Ibu Ketika Anak Meninggal</h4>

<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-p-2-1-4-2" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-p-2-1-4-2" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-p-2-1-4-2" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-p-2-1-4-2" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-p-2-1-4-2">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
         {{json:example-MortalityRecord-Observation-Create-Age-1}}
        </div>
    </div>
    
    <div role="tabpanel" class="tab-pane" id="data-p-2-1-4-2">
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "identifier": [
        {
            "system": "http://sys-ids.kemkes.go.id/observation/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_LOCAL_CODE&rcub;&rcub;</strong>"
        }
    ],
    "status": "final",
    "category":  [
        {
            "coding":  [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "survey",
                    "display": "Survey"
                }
            ]
        }
    ],
    "code": {
        "coding":  [
            {
                "system": "http://loinc.org",
                "code": "30525-0",
                "display": "Age"
            }
        ]
    },
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>",
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "effectiveDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_EFFECTIVE_DATETIME&rcub;&rcub;</strong>",
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer":  [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_IHS_NUMBER&rcub;&rcub;</strong>",
            "display": "<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_NAME&rcub;&rcub;</strong>"
        },
        {
            "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "display": "<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_NAME&rcub;&rcub;</strong>"
        }
    ],
    "valueQuantity": {
        "value": "<strong style="color:#00a7ff">&lcub;&lcub;VALUE_OBSERVATION&rcub;&rcub;</strong>",
        "unit": "year",
        "system": "http://unitsofmeasure.org",
        "code": "a"
    }
}
			</pre>
		</div>
		
<div role="tabpanel" class="tab-pane" id="variabel-p-2-1-4-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __FACILITY_IHS_NUMBER__   			| SATUSEHAT ID untuk FASYANKES |
| __FACILITY_NAME__           			| Nama FASYANKES |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| SATUSEHAT ID Number untuk Pasien |
| __PATIENT_NAME__           			| Nama Pasien 	|
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __DOCTOR_IHS_NUMBER__    				| SATUSEHAT ID untuk Dokter/Nakes |
| __DOCTOR_NAME__           			| Nama Dokter/Nakes |
| __VALUE_OBSERVATION__					| Usia Ibu ketika anak meninggal (dalam tahun) |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-p-2-1-4-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
			<div>
				[none]
			</div>
		</div>
	</div>
<br>
</div>
<!--END variable data dasar ibu-->
<!--END Part 2.4.-->

<!--Part 2.2-->
<h4 style="margin-left: 30px;">2.5. Form laporan kematian Ibu</h4>

<div style="margin-left: 60px;">
Pada use-case pelaporan kematian Anak, resource Composition akan digunakan sebagai penghubung antara satu resource dengan resource lainnya. Composition akan menghubungkan data-data seperti tanggal meninggal, siapa bayi yang meninggal, siapa tenaga kesehatan yang melaporkan, dan informasi pendukung lainnya.<br>
Composition hanya menyimpan metadata resource yg berbentuk sebuah ID, misalnya kolom id pada resource Observation (Observation.id), resource Condition (Condition.id), dan resource pendukung lainnya. Resource Composition akan mereferensi ke data riwayat kematian (step 2.1.), riwayat persalinan (step 2.2.), riwayat kehamilan (step 2.3.), dan data dasar Ibu (step 2.4.)

<!--Variable Form Pelaporan Kematian Anak-->
<h4 style="font-weight: bold;">Composition Form Pelaporan Kematian Anak</h4>	
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-p-2-2" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-p-2-2" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-p-2-2" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-p-2-2" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-p-2-2">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:example-MortalityRecord-Composition-Create-Perinatal-Death-1}}
        </div>
    </div>
    
    <div role="tabpanel" class="tab-pane" id="data-p-2-2">
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
        </pre>
	</div>
		
<div role="tabpanel" class="tab-pane" id="variabel-p-2-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __COMPOSITION_LOCAL_CODE__   			| ID Lokal untuk Composition|
| __PATIENT_IHS_NUMBER__      			| SATUSEHAT ID Number untuk Pasien |
| __PATIENT_NAME__           			| Nama Pasien 	|
| __COMPOSITION_RECORD_DATETIME__       | Tanggal form ini dikirimkan ke (tanggal yang dibuat oleh sistem)|
| __DOCTOR_IHS_NUMBER__    				| SATUSEHAT ID untuk Dokter/Nakes |
| __DOCTOR_NAME__           			| Nama Dokter/Nakes |
| __FACILITY_IHS_NUMBER__   | SATUSEHAT ID untuk FASYANKES |
| __FACILITY_NAME__           			| Nama FASYANKES |
| __OBSERVATION1_FHIR_ID__    		| Observation ID data usia ketika meninggal (tahun) |
| __OBSERVATION2_FHIR_ID__    		| Observation ID data tanggal meninggal |
| __OBSERVATION3_FHIR_ID__    		| Observation ID data masa terjadi kematian ibu |
| __OBSERVATION4_FHIR_ID__    		| Observation ID data jenis tempat meninggal |
| __OBSERVATION5_FHIR_ID__    		| Observation ID data gravida |
| __OBSERVATION6_FHIR_ID__    		| Observation ID data paritas |
| __OBSERVATION7_FHIR_ID__    		| Observation ID data abortus |
| __OBSERVATION8_FHIR_ID__    		| Observation ID data usia kehamilan (bulan) |
| __CONDITION1_FHIR_ID__    		| Condition ID data dugaan sebab kematian |
| __LOCATION1_FHIR_ID__    			| Location ID data lokasi meninggal |
| __LOCATION2_FHIR_ID__    			| Location ID data alamat domisili |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-p-2-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
			<div>
				[none]
			</div>
		</div>
	</div>
<br>
</div>
<!--END Form Pelaporan Kematian Anak-->
<!--END Part 2.5.-->

<div style="margin-left: 30px;">
<h4>Setelah data pada step 2.1. - 2.5. sudah terbentuk, maka langkah selanjutnya adalah semua data akan dikirimkan secara bersamaan menggunakan resource Bundle dengan template dibawah ini:
</h4>

> `CATATAN:`
>  Bundle.entry adalah sebuah *Array*, yang bisa menampung lebih dari 1 data. Diisikan dengan semua data FHIR resource dalam format JSON yang sudah dibuat di part 2.1. - 2.5.

<h4 style="font-weight: bold;">Bundle Pengiriman Data Riwayat Kematian, Persalinan, Kehamilan, dan Data Dasar Ibu</h4>	
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-p-2-1-5" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-p-2-1-5" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-p-2-1-5" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-p-2-1-5" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-p-2-1-5">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:example/MortalityRecord/Encounter-Create-Bundle-Create-Perinatal-Death-Lahir-Hidup.json}}
        </div>
    </div>
    
    <div role="tabpanel" class="tab-pane" id="data-p-2-1-5">
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType" : "Bundle",
    "type" : "transaction",
    "entry" : [
        {
            "fullUrl" : "urn:uuid:<strong style="color:#00a7ff">&lcub;&lcub;BUNDLE_TEMPORARY_UUID&rcub;&rcub;</strong>",
            "resource" : <strong style="color:#00a7ff">&lcub;&lcub;BUNDLE_RESOURCE_VALUE&rcub;&rcub;</strong>,
            "request": {
                "method": "POST",
                "url": "<strong style="color:#00a7ff">&lcub;&lcub;BUNDLE_RESOURCE_URL_PATH&rcub;&rcub;</strong>"
            }
        }
    ]
}
		</pre>
	</div>
		
<div role="tabpanel" class="tab-pane" id="variabel-p-2-1-5" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __BUNDLE_TEMPORARY_UUID__   			| Digunakan untuk mengidentifikasi resource yang ada di dalam bundle secara sementara. Dapat menggunakan uuid yang dapat di generate di <a href="https://www.uuidgenerator.net/" target="_blank">UUID generator</a>.<br>Setelah mendapat uuid, input dengan format: "urn:uuid:[uuid number]"<br>Contoh "fullUrl": "urn:uuid:ba5a7dec-023f-45e1-adb9-1b9d71737a5f"|
| __BUNDLE_RESOURCE_VALUE__           			| Isi dari resource yang ingin dikirim. |
| __BUNDLE_RESOURCE_URL_PATH__    		| Jenis tipe resource yang ingin dikirim  |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-p-2-1-5" style="border: 1px solid #e8edee; padding: 15px 10px;">
			<div>
				[none]
			</div>
		</div>
	</div>
<br>
</div>

## D. Referensi:

<table style="background-color: #f6f8f8; border-radius: 10px;">
    <tr>
         <td style="padding: 10px 20px; width: 33%; vertical-align: top;">Postman Mortality Record</td>
        <td style="padding: 10px 20px; ; width: 33%; vertical-align: top;">Playbook Mortality Record</td>
        <td style="padding: 10px 20px; ; width: 33%; vertical-align: top;">Postman Resume Medis Rawat Jalan SatuSehat</td>
    </tr>
    <tr>
        <td style="padding: 10px 20px; ;"><div style="background-color: lightblue; display: inline-block; border-radius: 4px; cursor: pointer; height: 32px; border: none; width: 123px; background-image: url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTI4IiBoZWlnaHQ9IjMyIiBmaWxsPSJub25lIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxyZWN0IHdpZHRoPSIxMjgiIGhlaWdodD0iMzIiIHJ4PSI0IiBmaWxsPSIjRkY2QzM3Ii8+PHBhdGggZD0iTTEyIDEwLjg4M2EuNS41IDAgMCAxIC43NTctLjQyOWw4LjUyOCA1LjExN2EuNS41IDAgMCAxIDAgLjg1OGwtOC41MjggNS4xMTdhLjUuNSAwIDAgMS0uNzU3LS40M1YxMC44ODRaTTI3Ljg4OSAyMC41MDloMS41OHYtMy4xOTdoMS42MTFsMS43MTMgMy4xOTdoMS43NjRsLTEuODg3LTMuNDZjMS4wMjctLjQxNCAxLjU2OC0xLjI5MiAxLjU2OC0yLjQ3NyAwLTEuNjY2LTEuMDc0LTIuNzktMy4wNzctMi43OWgtMy4yNzN2OC43MjdaTTI5LjQ2OCAxNnYtMi44OThoMS40NWMxLjE4IDAgMS43MDguNTQxIDEuNzA4IDEuNDcgMCAuOTMtLjUyOCAxLjQyOC0xLjcgMS40MjhIMjkuNDdaTTM5Ljc5NyAxNy43NTZjMCAuOTk3LS43MTIgMS40OTEtMS4zOTQgMS40OTEtLjc0MSAwLTEuMjM1LS41MjQtMS4yMzUtMS4zNTV2LTMuOTI5aC0xLjU0M3Y0LjE2OGMwIDEuNTcyLjg5NSAyLjQ2MyAyLjE4MiAyLjQ2My45OCAwIDEuNjctLjUxNiAxLjk2OS0xLjI0OWguMDY4djEuMTY0aDEuNDk1di02LjU0NmgtMS41NDJ2My43OTNaTTQ0LjQ2OCAxNi42NzNjMC0uOTQ2LjU3MS0xLjQ5MSAxLjM4NS0xLjQ5MS43OTcgMCAxLjI3NC41MjQgMS4yNzQgMS4zOTd2My45M2gxLjU0M1YxNi4zNGMuMDA0LTEuNTY4LS44OS0yLjQ2My0yLjI0MS0yLjQ2My0uOTggMC0xLjY1NC40NjktMS45NTIgMS4xOTdINDQuNHYtMS4xMTJoLTEuNDc0djYuNTQ2aDEuNTQydi0zLjgzNlpNNTMuMjE1IDIwLjUwOWgxLjU0MnYtNi41NDZoLTEuNTQydjYuNTQ2Wm0uNzc1LTcuNDc1Yy40OSAwIC44OTEtLjM3NS44OTEtLjgzNSAwLS40NjUtLjQtLjg0LS44OS0uODQtLjQ5NSAwLS44OTUuMzc1LS44OTUuODQgMCAuNDYuNC44MzUuODk0LjgzNVpNNTcuODg2IDE2LjY3M2MwLS45NDYuNTcxLTEuNDkxIDEuMzg1LTEuNDkxLjc5NyAwIDEuMjc0LjUyNCAxLjI3NCAxLjM5N3YzLjkzaDEuNTQzVjE2LjM0Yy4wMDQtMS41NjgtLjg5LTIuNDYzLTIuMjQxLTIuNDYzLS45OCAwLTEuNjU0LjQ2OS0xLjk1MiAxLjE5N2gtLjA3N3YtMS4xMTJoLTEuNDc0djYuNTQ2aDEuNTQydi0zLjgzNlpNNjYuNzAxIDIwLjUwOWgxLjU4MXYtMi45NWgxLjY3YzIuMDE2IDAgMy4wOTgtMS4yMSAzLjA5OC0yLjg4OSAwLTEuNjY2LTEuMDctMi44ODktMy4wNzYtMi44ODlINjYuN3Y4LjcyOFptMS41ODEtNC4yNXYtMy4xNTdoMS40NDljMS4xODQgMCAxLjcwOS42NCAxLjcwOSAxLjU2OSAwIC45MjgtLjUyNSAxLjU4OS0xLjcgMS41ODloLTEuNDU4Wk03Ny4xMTcgMjAuNjM2YzEuOTE3IDAgMy4xMzYtMS4zNSAzLjEzNi0zLjM3NSAwLTIuMDI4LTEuMjE5LTMuMzgzLTMuMTM2LTMuMzgzLTEuOTE4IDAtMy4xMzYgMS4zNTUtMy4xMzYgMy4zODMgMCAyLjAyNCAxLjIxOCAzLjM3NSAzLjEzNiAzLjM3NVptLjAwOC0xLjIzNWMtMS4wNiAwLTEuNTgtLjk0Ny0xLjU4LTIuMTQ0cy41Mi0yLjE1NiAxLjU4LTIuMTU2YzEuMDQ0IDAgMS41NjQuOTU5IDEuNTY0IDIuMTU2cy0uNTIgMi4xNDQtMS41NjQgMi4xNDRaTTg2LjczNiAxNS42OTNjLS4yMTMtMS4xMDgtMS4xLTEuODE1LTIuNjM0LTEuODE1LTEuNTc2IDAtMi42NS43NzUtMi42NDYgMS45ODYtLjAwNC45NTQuNTg0IDEuNTg1IDEuODQgMS44NDVsMS4xMTcuMjM0Yy42MDEuMTMyLjg4My4zNzUuODgzLjc0NiAwIC40NDctLjQ4Ni43ODQtMS4yMi43ODQtLjcwNyAwLTEuMTY3LS4zMDctMS4yOTktLjg5NWwtMS41MDQuMTQ1Yy4xOTIgMS4yMDIgMS4yMDEgMS45MTMgMi44MDggMS45MTMgMS42MzYgMCAyLjc5MS0uODQ4IDIuNzk1LTIuMDg4LS4wMDQtLjkzMy0uNjA1LTEuNTA0LTEuODQtMS43NzJsLTEuMTE3LS4yNGMtLjY2NS0uMTQ4LS45MjktLjM3OC0uOTI1LS43NTgtLjAwNC0uNDQzLjQ4Ni0uNzUgMS4xMy0uNzUuNzExIDAgMS4wODYuMzg4IDEuMjA2LjgxOWwxLjQwNi0uMTU0Wk05MS40MTcgMTMuOTYzaC0xLjI5MXYtMS41NjhoLTEuNTQzdjEuNTY4aC0uOTI5djEuMTkzaC45M3YzLjY0Yy0uMDEgMS4yMzEuODg1IDEuODM2IDIuMDQ0IDEuODAyYTMuMSAzLjEgMCAwIDAgLjkwOC0uMTUzbC0uMjYtMS4yMDZjLS4wODUuMDItLjI2LjA2LS40NTEuMDYtLjM4OCAwLS43LS4xMzctLjctLjc2di0zLjM4M2gxLjI5MnYtMS4xOTNaTTkyLjcwNyAyMC41MDloMS41NDN2LTMuOThjMC0uODA2LjUzNy0xLjM1MSAxLjIwMS0xLjM1MS42NTIgMCAxLjEuNDM4IDEuMSAxLjExMnY0LjIxOWgxLjUxM3YtNC4wODNjMC0uNzM3LjQzOS0xLjI0OCAxLjE4NC0xLjI0OC42MjIgMCAxLjExNy4zNjYgMS4xMTcgMS4xNzZ2NC4xNTVoMS41NDd2LTQuMzk0YzAtMS40NjItLjg0NC0yLjIzNy0yLjA0Ni0yLjIzNy0uOTUgMC0xLjY3NS40NjktMS45NjQgMS4xOTdoLS4wNjljLS4yNTEtLjc0MS0uODg2LTEuMTk3LTEuNzY4LTEuMTk3LS44NzggMC0xLjUzNC40NTEtMS44MDcgMS4xOTdoLS4wNzZ2LTEuMTEyaC0xLjQ3NXY2LjU0NlpNMTA1LjM2IDIwLjY0YzEuMDI3IDAgMS42NDEtLjQ4IDEuOTIyLTEuMDNoLjA1MXYuODk5aDEuNDgzdi00LjM4MWMwLTEuNzMtMS40MS0yLjI1LTIuNjU5LTIuMjUtMS4zNzYgMC0yLjQzMy42MTQtMi43NzQgMS44MDdsMS40NC4yMDRjLjE1NC0uNDQ3LjU4OC0uODMgMS4zNDItLjgzLjcxNiAwIDEuMTA4LjM2NiAxLjEwOCAxLjAxdi4wMjVjMCAuNDQzLS40NjQuNDY0LTEuNjE5LjU4OC0xLjI3LjEzNi0yLjQ4NC41MTUtMi40ODQgMS45OSAwIDEuMjg3Ljk0MiAxLjk2OSAyLjE5IDEuOTY5Wm0uNDAxLTEuMTMzYy0uNjQ0IDAtMS4xMDQtLjI5NC0xLjEwNC0uODYgMC0uNTkzLjUxNi0uODQgMS4yMDYtLjkzOC40MDUtLjA1NiAxLjIxNC0uMTU4IDEuNDE1LS4zMnYuNzcxYzAgLjczLS41ODggMS4zNDctMS41MTcgMS4zNDdaTTExMS45MSAxNi42NzNjMC0uOTQ2LjU3MS0xLjQ5MSAxLjM4NS0xLjQ5MS43OTcgMCAxLjI3NC41MjQgMS4yNzQgMS4zOTd2My45M2gxLjU0M1YxNi4zNGMuMDA0LTEuNTY4LS44OTEtMi40NjMtMi4yNDItMi40NjMtLjk4IDAtMS42NTMuNDY5LTEuOTUyIDEuMTk3aC0uMDc2di0xLjExMmgtMS40NzV2Ni41NDZoMS41NDN2LTMuODM2WiIgZmlsbD0iI2ZmZiIvPjwvc3ZnPg==');" onclick="window.open('https://satusehat-fhir.postman.co/workspace/SATUSEHAT-UseCase~ed2ed615-fe1b-473d-9dc1-a0c425fb2f44/collection/24174700-c6e52265-7336-40c8-b6a8-6831f58ffbe1?action=share&creator=19625975', '_blank');"></div></td>
        <td style="padding: 10px 20px; ;"><div style="display: inline-block; border-radius: 4px; cursor: pointer; height: 32px; border: none; width: 123px; background-image: url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB3aWR0aD0iMTI1IiB6b29tQW5kUGFuPSJtYWduaWZ5IiB2aWV3Qm94PSIwIDAgOTMuNzUgMzAuMDAwMDAxIiBoZWlnaHQ9IjQwIiBwcmVzZXJ2ZUFzcGVjdFJhdGlvPSJ4TWlkWU1pZCBtZWV0IiB2ZXJzaW9uPSIxLjAiPjxkZWZzPjxnLz48Y2xpcFBhdGggaWQ9ImE3ZDJlMzRmNmEiPjxwYXRoIGQ9Ik0gMS45NTcwMzEgMS4yNDYwOTQgTCA5MS45Njg3NSAxLjI0NjA5NCBMIDkxLjk2ODc1IDIzLjg3ODkwNiBMIDEuOTU3MDMxIDIzLjg3ODkwNiBaIE0gMS45NTcwMzEgMS4yNDYwOTQgIiBjbGlwLXJ1bGU9Im5vbnplcm8iLz48L2NsaXBQYXRoPjxjbGlwUGF0aCBpZD0iNzBhYjc4ZGEzNiI+PHBhdGggZD0iTSA0LjE0MDYyNSAxLjI0NjA5NCBMIDg5LjYwOTM3NSAxLjI0NjA5NCBDIDkwLjgxNjQwNiAxLjI0NjA5NCA5MS43OTI5NjkgMi4yMjI2NTYgOTEuNzkyOTY5IDMuNDI5Njg4IEwgOTEuNzkyOTY5IDIxLjUxOTUzMSBDIDkxLjc5Mjk2OSAyMi43MjY1NjIgOTAuODE2NDA2IDIzLjcwMzEyNSA4OS42MDkzNzUgMjMuNzAzMTI1IEwgNC4xNDA2MjUgMjMuNzAzMTI1IEMgMi45MzM1OTQgMjMuNzAzMTI1IDEuOTU3MDMxIDIyLjcyNjU2MiAxLjk1NzAzMSAyMS41MTk1MzEgTCAxLjk1NzAzMSAzLjQyOTY4OCBDIDEuOTU3MDMxIDIuMjIyNjU2IDIuOTMzNTk0IDEuMjQ2MDk0IDQuMTQwNjI1IDEuMjQ2MDk0ICIgY2xpcC1ydWxlPSJub256ZXJvIi8+PC9jbGlwUGF0aD48Y2xpcFBhdGggaWQ9IjM3ODA5ZDFmZWEiPjxwYXRoIGQ9Ik0gMTYuMTEzMjgxIDcuMjA3MDMxIEwgMTcuOTU3MDMxIDcuMjA3MDMxIEwgMTcuOTU3MDMxIDkuMDI3MzQ0IEwgMTYuMTEzMjgxIDkuMDI3MzQ0IFogTSAxNi4xMTMyODEgNy4yMDcwMzEgIiBjbGlwLXJ1bGU9Im5vbnplcm8iLz48L2NsaXBQYXRoPjxjbGlwUGF0aCBpZD0iMzQ1YzAxZDI0ZiI+PHBhdGggZD0iTSAxMC42Nzk2ODggNy4xOTkyMTkgTCAxNy45NTcwMzEgNy4xOTkyMTkgTCAxNy45NTcwMzEgMTcuMzkwNjI1IEwgMTAuNjc5Njg4IDE3LjM5MDYyNSBaIE0gMTAuNjc5Njg4IDcuMTk5MjE5ICIgY2xpcC1ydWxlPSJub256ZXJvIi8+PC9jbGlwUGF0aD48L2RlZnM+PGcgY2xpcC1wYXRoPSJ1cmwoI2E3ZDJlMzRmNmEpIj48ZyBjbGlwLXBhdGg9InVybCgjNzBhYjc4ZGEzNikiPjxwYXRoIGZpbGw9IiM0N2IwOGIiIGQ9Ik0gMS45NTcwMzEgMS4yNDYwOTQgTCA5MS45Njg3NSAxLjI0NjA5NCBMIDkxLjk2ODc1IDIzLjg3ODkwNiBMIDEuOTU3MDMxIDIzLjg3ODkwNiBaIE0gMS45NTcwMzEgMS4yNDYwOTQgIiBmaWxsLW9wYWNpdHk9IjEiIGZpbGwtcnVsZT0ibm9uemVybyIvPjwvZz48L2c+PGcgY2xpcC1wYXRoPSJ1cmwoIzM3ODA5ZDFmZWEpIj48cGF0aCBmaWxsPSIjZmZmZmZmIiBkPSJNIDE2LjEzNjcxOSA3LjIwNzAzMSBMIDE2LjE5OTIxOSA3LjIwNzAzMSBMIDE2LjI3MzQzOCA3LjIzNDM3NSBMIDE2LjM1MTU2MiA3LjI2NTYyNSBMIDE3Ljg5MDYyNSA4Ljc2NTYyNSBMIDE3Ljk1NzAzMSA4LjgyODEyNSBMIDE3Ljk1NzAzMSA5LjAwNzgxMiBMIDE2LjEzNjcxOSA5LjAwNzgxMiBMIDE2LjEzNjcxOSA3LjIwNzAzMSAiIGZpbGwtb3BhY2l0eT0iMSIgZmlsbC1ydWxlPSJldmVub2RkIi8+PC9nPjxnIGNsaXAtcGF0aD0idXJsKCMzNDVjMDFkMjRmKSI+PHBhdGggZmlsbD0iI2ZmZmZmZiIgZD0iTSAxMC44OTA2MjUgNy4yMDcwMzEgTCAxNS45MjE4NzUgNy4yMDcwMzEgTCAxNS45MjE4NzUgOS4yMTg3NSBMIDE3Ljk1NzAzMSA5LjIxODc1IEwgMTcuOTU3MDMxIDE3LjM4NjcxOSBMIDEwLjY3OTY4OCAxNy4zODY3MTkgTCAxMC42Nzk2ODggNy4yMDcwMzEgWiBNIDEyLjU1NDY4OCA5LjU1MDc4MSBDIDEyLjAyMzQzOCA5Ljg3NSAxMS42Nzk2ODggMTAuMzgyODEyIDExLjU0Njg3NSAxMC45Mzc1IEMgMTEuNDE0MDYyIDExLjQ5NjA5NCAxMS40OTYwOTQgMTIuMTAxNTYyIDExLjgyNDIxOSAxMi42MjUgQyAxMi4xNTIzNDQgMTMuMTUyMzQ0IDEyLjY2NDA2MiAxMy40OTYwOTQgMTMuMjI2NTYyIDEzLjYyNSBDIDEzLjYyODkwNiAxMy43MTg3NSAxNC4wNTQ2ODggMTMuNzAzMTI1IDE0LjQ1NzAzMSAxMy41NzAzMTIgTCAxNi4wOTM3NSAxNi4xODM1OTQgQyAxNi4xNjAxNTYgMTYuMjkyOTY5IDE2LjI1NzgxMiAxNi4zNzEwOTQgMTYuMzU5Mzc1IDE2LjQxNDA2MiBDIDE2LjQ4NDM3NSAxNi40NjQ4NDQgMTYuNjIxMDk0IDE2LjQ2NDg0NCAxNi43MzQzNzUgMTYuMzk0NTMxIEwgMTYuODgyODEyIDE2LjMwNDY4OCBDIDE2Ljk5NjA5NCAxNi4yMzQzNzUgMTcuMDU4NTk0IDE2LjExMzI4MSAxNy4wNjY0MDYgMTUuOTgwNDY5IEMgMTcuMDc0MjE5IDE1Ljg3MTA5NCAxNy4wNDI5NjkgMTUuNzUgMTYuOTc2NTYyIDE1LjY0MDYyNSBMIDE1LjMzOTg0NCAxMy4wMjczNDQgQyAxNS42NDA2MjUgMTIuNzI2NTYyIDE1Ljg0Mzc1IDEyLjM1NTQ2OSAxNS45Mzc1IDExLjk2MDkzOCBDIDE2LjA3MDMxMiAxMS40MDIzNDQgMTUuOTg4MjgxIDEwLjc5Njg3NSAxNS42NjAxNTYgMTAuMjczNDM4IEMgMTUuMzMyMDMxIDkuNzQ2MDk0IDE0LjgyMDMxMiA5LjQwMjM0NCAxNC4yNTc4MTIgOS4yNzM0MzggQyAxMy42OTUzMTIgOS4xNDQ1MzEgMTMuMDgyMDMxIDkuMjI2NTYyIDEyLjU1NDY4OCA5LjU1MDc4MSBaIE0gMTQuNDIxODc1IDEzLjEzMjgxMiBMIDE0LjQ2MDkzOCAxMy4xMTMyODEgQyAxNC40OTYwOTQgMTMuMTAxNTYyIDE0LjUyNzM0NCAxMy4wODU5MzggMTQuNTU0Njg4IDEzLjA3NDIxOSBMIDE0LjU1NDY4OCAxMy4wNzAzMTIgQyAxNC41NjY0MDYgMTMuMDY2NDA2IDE0LjU3NDIxOSAxMy4wNjI1IDE0LjU4NTkzOCAxMy4wNTQ2ODggQyAxNC42MjUgMTMuMDM1MTU2IDE0LjY2MDE1NiAxMy4wMTU2MjUgMTQuNjkxNDA2IDEyLjk5NjA5NCBDIDE0LjY5NTMxMiAxMi45OTYwOTQgMTQuNjk5MjE5IDEyLjk5MjE4OCAxNC43MDcwMzEgMTIuOTg4MjgxIEMgMTQuNzU3ODEyIDEyLjk1NzAzMSAxNC44MDg1OTQgMTIuOTIxODc1IDE0Ljg1NTQ2OSAxMi44ODY3MTkgQyAxNC44Nzg5MDYgMTIuODY3MTg4IDE0LjkwMjM0NCAxMi44NDc2NTYgMTQuOTI1NzgxIDEyLjgyODEyNSBMIDE0Ljk1MzEyNSAxMi44MDQ2ODggQyAxNS4yNDIxODggMTIuNTU0Njg4IDE1LjQzNzUgMTIuMjIyNjU2IDE1LjUyMzQzOCAxMS44NjMyODEgQyAxNS42Mjg5MDYgMTEuNDEwMTU2IDE1LjU2MjUgMTAuOTE3OTY5IDE1LjI5Njg3NSAxMC40OTYwOTQgQyAxNS4wMzEyNSAxMC4wNzAzMTIgMTQuNjE3MTg4IDkuNzkyOTY5IDE0LjE2MDE1NiA5LjY4NzUgQyAxMy43MDMxMjUgOS41ODIwMzEgMTMuMjA3MDMxIDkuNjQ0NTMxIDEyLjc3NzM0NCA5LjkxMDE1NiBDIDEyLjM1MTU2MiAxMC4xNzE4NzUgMTIuMDcwMzEyIDEwLjU4MjAzMSAxMS45NjA5MzggMTEuMDM1MTU2IEMgMTEuODU1NDY5IDExLjQ4ODI4MSAxMS45MjE4NzUgMTEuOTgwNDY5IDEyLjE4NzUgMTIuNDAyMzQ0IEMgMTIuNDUzMTI1IDEyLjgyODEyNSAxMi44NjcxODggMTMuMTA1NDY5IDEzLjMyNDIxOSAxMy4yMTA5MzggQyAxMy42ODM1OTQgMTMuMjk2ODc1IDE0LjA2NjQwNiAxMy4yNzM0MzggMTQuNDIxODc1IDEzLjEzMjgxMiAiIGZpbGwtb3BhY2l0eT0iMSIgZmlsbC1ydWxlPSJldmVub2RkIi8+PC9nPjxwYXRoIGZpbGw9IiMyMTIxMjEiIGQ9Ik0gMTYuNTA3ODEyIDE2LjAzNTE1NiBMIDE2LjUyMzQzOCAxNi4wMjM0MzggQyAxNi41MjM0MzggMTYuMDIzNDM4IDE2LjQ5NjA5NCAxNi4wNDI5NjkgMTYuNTA3ODEyIDE2LjAzNTE1NiAiIGZpbGwtb3BhY2l0eT0iMSIgZmlsbC1ydWxlPSJub256ZXJvIi8+PHBhdGggZmlsbD0iIzIxMjEyMSIgZD0iTSAxNi42NTYyNSAxNS45NDUzMTIgQyAxNi42Njc5NjkgMTUuOTM3NSAxNi42NDA2MjUgMTUuOTUzMTI1IDE2LjY0MDYyNSAxNS45NTMxMjUgTCAxNi42NTYyNSAxNS45NDUzMTIgIiBmaWxsLW9wYWNpdHk9IjEiIGZpbGwtcnVsZT0ibm9uemVybyIvPjxnIGZpbGw9IiNmZmZmZmYiIGZpbGwtb3BhY2l0eT0iMSI+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMjEuNTk0ODI5LCAxNS45NjAwNjIpIj48Zz48cGF0aCBkPSJNIDYuMzkwNjI1IC02LjUxNTYyNSBMIDMuNzY1NjI1IDAgTCAyLjU0Njg3NSAwIEwgLTAuMDc4MTI1IC02LjUxNTYyNSBMIDEgLTYuNTE1NjI1IEMgMS4xMjUgLTYuNTE1NjI1IDEuMjIyNjU2IC02LjQ4ODI4MSAxLjI5Njg3NSAtNi40Mzc1IEMgMS4zNjcxODggLTYuMzgyODEyIDEuNDIxODc1IC02LjMxMjUgMS40NTMxMjUgLTYuMjE4NzUgTCAyLjg1OTM3NSAtMi40Njg3NSBDIDIuOTIxODc1IC0yLjMyMDMxMiAyLjk3NjU2MiAtMi4xNjQwNjIgMy4wMzEyNSAtMiBDIDMuMDgyMDMxIC0xLjgzMjAzMSAzLjEyODkwNiAtMS42NjAxNTYgMy4xNzE4NzUgLTEuNDg0Mzc1IEMgMy4yMTA5MzggLTEuNjYwMTU2IDMuMjUzOTA2IC0xLjgzMjAzMSAzLjI5Njg3NSAtMiBDIDMuMzQ3NjU2IC0yLjE2NDA2MiAzLjM5ODQzOCAtMi4zMjAzMTIgMy40NTMxMjUgLTIuNDY4NzUgTCA0Ljg1OTM3NSAtNi4yMTg3NSBDIDQuODc4OTA2IC02LjI4OTA2MiA0LjkyNTc4MSAtNi4zNTkzNzUgNSAtNi40MjE4NzUgQyA1LjA4MjAzMSAtNi40ODQzNzUgNS4xNzk2ODggLTYuNTE1NjI1IDUuMjk2ODc1IC02LjUxNTYyNSBaIE0gNi4zOTA2MjUgLTYuNTE1NjI1ICIvPjwvZz48L2c+PC9nPjxnIGZpbGw9IiNmZmZmZmYiIGZpbGwtb3BhY2l0eT0iMSI+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMjcuOTAxNDYzLCAxNS45NjAwNjIpIj48Zz48cGF0aCBkPSJNIDEuNzgxMjUgLTQuNjI1IEwgMS43ODEyNSAwIEwgMC41NDY4NzUgMCBMIDAuNTQ2ODc1IC00LjYyNSBaIE0gMS45Mzc1IC01Ljk1MzEyNSBDIDEuOTM3NSAtNS44NDc2NTYgMS45MTQwNjIgLTUuNzUgMS44NzUgLTUuNjU2MjUgQyAxLjgzMjAzMSAtNS41NjI1IDEuNzczNDM4IC01LjQ3NjU2MiAxLjcwMzEyNSAtNS40MDYyNSBDIDEuNjI4OTA2IC01LjM0Mzc1IDEuNTQ2ODc1IC01LjI4OTA2MiAxLjQ1MzEyNSAtNS4yNSBDIDEuMzU5Mzc1IC01LjIxODc1IDEuMjU3ODEyIC01LjIwMzEyNSAxLjE1NjI1IC01LjIwMzEyNSBDIDEuMDUwNzgxIC01LjIwMzEyNSAwLjk1MzEyNSAtNS4yMTg3NSAwLjg1OTM3NSAtNS4yNSBDIDAuNzczNDM4IC01LjI4OTA2MiAwLjY5NTMxMiAtNS4zNDM3NSAwLjYyNSAtNS40MDYyNSBDIDAuNTUwNzgxIC01LjQ3NjU2MiAwLjQ5MjE4OCAtNS41NjI1IDAuNDUzMTI1IC01LjY1NjI1IEMgMC40MjE4NzUgLTUuNzUgMC40MDYyNSAtNS44NDc2NTYgMC40MDYyNSAtNS45NTMxMjUgQyAwLjQwNjI1IC02LjA1NDY4OCAwLjQyMTg3NSAtNi4xNDg0MzggMC40NTMxMjUgLTYuMjM0Mzc1IEMgMC40OTIxODggLTYuMzI4MTI1IDAuNTUwNzgxIC02LjQwNjI1IDAuNjI1IC02LjQ2ODc1IEMgMC42OTUzMTIgLTYuNTM5MDYyIDAuNzczNDM4IC02LjU5NzY1NiAwLjg1OTM3NSAtNi42NDA2MjUgQyAwLjk1MzEyNSAtNi42Nzk2ODggMS4wNTA3ODEgLTYuNzAzMTI1IDEuMTU2MjUgLTYuNzAzMTI1IEMgMS4yNTc4MTIgLTYuNzAzMTI1IDEuMzU5Mzc1IC02LjY3OTY4OCAxLjQ1MzEyNSAtNi42NDA2MjUgQyAxLjU0Njg3NSAtNi41OTc2NTYgMS42Mjg5MDYgLTYuNTM5MDYyIDEuNzAzMTI1IC02LjQ2ODc1IEMgMS43NzM0MzggLTYuNDA2MjUgMS44MzIwMzEgLTYuMzI4MTI1IDEuODc1IC02LjIzNDM3NSBDIDEuOTE0MDYyIC02LjE0ODQzOCAxLjkzNzUgLTYuMDU0Njg4IDEuOTM3NSAtNS45NTMxMjUgWiBNIDEuOTM3NSAtNS45NTMxMjUgIi8+PC9nPjwvZz48L2c+PGcgZmlsbD0iI2ZmZmZmZiIgZmlsbC1vcGFjaXR5PSIxIj48ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSgzMC4yMzcyNTQsIDE1Ljk2MDA2MikiPjxnPjxwYXRoIGQ9Ik0gMy40NTMxMjUgLTIuODU5Mzc1IEMgMy40NTMxMjUgLTIuOTkyMTg4IDMuNDI5Njg4IC0zLjExNzE4OCAzLjM5MDYyNSAtMy4yMzQzNzUgQyAzLjM1OTM3NSAtMy4zNDc2NTYgMy4zMDQ2ODggLTMuNDQ1MzEyIDMuMjM0Mzc1IC0zLjUzMTI1IEMgMy4xNjAxNTYgLTMuNjI1IDMuMDY2NDA2IC0zLjY5NTMxMiAyLjk1MzEyNSAtMy43NSBDIDIuODM1OTM4IC0zLjgwMDc4MSAyLjcwMzEyNSAtMy44MjgxMjUgMi41NDY4NzUgLTMuODI4MTI1IEMgMi4yNDIxODggLTMuODI4MTI1IDIuMDA3ODEyIC0zLjc0MjE4OCAxLjg0Mzc1IC0zLjU3ODEyNSBDIDEuNjc1NzgxIC0zLjQxMDE1NiAxLjU2NjQwNiAtMy4xNzE4NzUgMS41MTU2MjUgLTIuODU5Mzc1IFogTSAxLjUgLTIuMTI1IEMgMS41MzkwNjIgLTEuNjg3NSAxLjY2NDA2MiAtMS4zNjcxODggMS44NzUgLTEuMTcxODc1IEMgMi4wODIwMzEgLTAuOTcyNjU2IDIuMzUxNTYyIC0wLjg3NSAyLjY4NzUgLTAuODc1IEMgMi44NTE1NjIgLTAuODc1IDMgLTAuODk0NTMxIDMuMTI1IC0wLjkzNzUgQyAzLjI1IC0wLjk3NjU2MiAzLjM1OTM3NSAtMS4wMTk1MzEgMy40NTMxMjUgLTEuMDYyNSBDIDMuNTQ2ODc1IC0xLjExMzI4MSAzLjYyODkwNiAtMS4xNjAxNTYgMy43MDMxMjUgLTEuMjAzMTI1IEMgMy43ODUxNTYgLTEuMjQyMTg4IDMuODYzMjgxIC0xLjI2NTYyNSAzLjkzNzUgLTEuMjY1NjI1IEMgNC4wMzEyNSAtMS4yNjU2MjUgNC4xMDkzNzUgLTEuMjI2NTYyIDQuMTcxODc1IC0xLjE1NjI1IEwgNC41MzEyNSAtMC43MDMxMjUgQyA0LjM5NDUzMSAtMC41NDY4NzUgNC4yNDIxODggLTAuNDE0MDYyIDQuMDc4MTI1IC0wLjMxMjUgQyAzLjkyMTg3NSAtMC4yMTg3NSAzLjc1NzgxMiAtMC4xNDA2MjUgMy41OTM3NSAtMC4wNzgxMjUgQyAzLjQyNTc4MSAtMC4wMjM0Mzc1IDMuMjUzOTA2IDAuMDA3ODEyNSAzLjA3ODEyNSAwLjAzMTI1IEMgMi44OTg0MzggMC4wNTA3ODEyIDIuNzM0Mzc1IDAuMDYyNSAyLjU3ODEyNSAwLjA2MjUgQyAyLjI1MzkwNiAwLjA2MjUgMS45NTMxMjUgMC4wMDc4MTI1IDEuNjcxODc1IC0wLjA5Mzc1IEMgMS4zOTA2MjUgLTAuMTk1MzEyIDEuMTQ0NTMxIC0wLjM1MTU2MiAwLjkzNzUgLTAuNTYyNSBDIDAuNzI2NTYyIC0wLjc2OTUzMSAwLjU2MjUgLTEuMDIzNDM4IDAuNDM3NSAtMS4zMjgxMjUgQyAwLjMyMDMxMiAtMS42NDA2MjUgMC4yNjU2MjUgLTIgMC4yNjU2MjUgLTIuNDA2MjUgQyAwLjI2NTYyNSAtMi43MjY1NjIgMC4zMTY0MDYgLTMuMDIzNDM4IDAuNDIxODc1IC0zLjI5Njg3NSBDIDAuNTIzNDM4IC0zLjU3ODEyNSAwLjY3MTg3NSAtMy44MjAzMTIgMC44NTkzNzUgLTQuMDMxMjUgQyAxLjA1NDY4OCAtNC4yMzgyODEgMS4yOTY4NzUgLTQuMzk4NDM4IDEuNTc4MTI1IC00LjUxNTYyNSBDIDEuODU5Mzc1IC00LjY0MDYyNSAyLjE3MTg3NSAtNC43MDMxMjUgMi41MTU2MjUgLTQuNzAzMTI1IEMgMi44MTY0MDYgLTQuNzAzMTI1IDMuMDkzNzUgLTQuNjU2MjUgMy4zNDM3NSAtNC41NjI1IEMgMy41OTM3NSAtNC40Njg3NSAzLjgwNDY4OCAtNC4zMjgxMjUgMy45ODQzNzUgLTQuMTQwNjI1IEMgNC4xNzE4NzUgLTMuOTYwOTM4IDQuMzEyNSAtMy43NDIxODggNC40MDYyNSAtMy40ODQzNzUgQyA0LjUwNzgxMiAtMy4yMjI2NTYgNC41NjI1IC0yLjkyNTc4MSA0LjU2MjUgLTIuNTkzNzUgQyA0LjU2MjUgLTIuNSA0LjU1NDY4OCAtMi40MjE4NzUgNC41NDY4NzUgLTIuMzU5Mzc1IEMgNC41MzUxNTYgLTIuMjk2ODc1IDQuNTE5NTMxIC0yLjI1IDQuNSAtMi4yMTg3NSBDIDQuNDc2NTYyIC0yLjE4NzUgNC40NDUzMTIgLTIuMTYwMTU2IDQuNDA2MjUgLTIuMTQwNjI1IEMgNC4zNzUgLTIuMTI4OTA2IDQuMzMyMDMxIC0yLjEyNSA0LjI4MTI1IC0yLjEyNSBaIE0gMS41IC0yLjEyNSAiLz48L2c+PC9nPjwvZz48ZyBmaWxsPSIjZmZmZmZmIiBmaWxsLW9wYWNpdHk9IjEiPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKDM1LjA1MjU3NiwgMTUuOTYwMDYyKSI+PGc+PHBhdGggZD0iTSA3LjIxODc1IC00LjYyNSBMIDUuNzY1NjI1IDAgTCA0Ljc2NTYyNSAwIEMgNC43MTA5MzggMCA0LjY2NDA2MiAtMC4wMTU2MjUgNC42MjUgLTAuMDQ2ODc1IEMgNC41ODIwMzEgLTAuMDc4MTI1IDQuNTUwNzgxIC0wLjEzMjgxMiA0LjUzMTI1IC0wLjIxODc1IEwgMy43ODEyNSAtMi43MTg3NSBDIDMuNzUgLTIuODEyNSAzLjcyMjY1NiAtMi45MDYyNSAzLjcwMzEyNSAtMyBDIDMuNjc5Njg4IC0zLjEwMTU2MiAzLjY2MDE1NiAtMy4yMDMxMjUgMy42NDA2MjUgLTMuMjk2ODc1IEMgMy42MTcxODggLTMuMjAzMTI1IDMuNTk3NjU2IC0zLjEwMTU2MiAzLjU3ODEyNSAtMyBDIDMuNTU0Njg4IC0yLjkwNjI1IDMuNTMxMjUgLTIuODEyNSAzLjUgLTIuNzE4NzUgTCAyLjczNDM3NSAtMC4yMTg3NSBDIDIuNjkxNDA2IC0wLjA3MDMxMjUgMi42MDE1NjIgMCAyLjQ2ODc1IDAgTCAxLjUxNTYyNSAwIEwgMC4wNDY4NzUgLTQuNjI1IEwgMS4wNDY4NzUgLTQuNjI1IEMgMS4xMjg5MDYgLTQuNjI1IDEuMjAzMTI1IC00LjYwMTU2MiAxLjI2NTYyNSAtNC41NjI1IEMgMS4zMjgxMjUgLTQuNTE5NTMxIDEuMzY3MTg4IC00LjQ2ODc1IDEuMzkwNjI1IC00LjQwNjI1IEwgMS45Njg3NSAtMi4xMDkzNzUgQyAyIC0xLjk2MDkzOCAyLjAyMzQzOCAtMS44MjAzMTIgMi4wNDY4NzUgLTEuNjg3NSBDIDIuMDc4MTI1IC0xLjU1MDc4MSAyLjEwOTM3NSAtMS40MTQwNjIgMi4xNDA2MjUgLTEuMjgxMjUgQyAyLjE3MTg3NSAtMS40MTQwNjIgMi4yMDcwMzEgLTEuNTUwNzgxIDIuMjUgLTEuNjg3NSBDIDIuMjg5MDYyIC0xLjgyMDMxMiAyLjMzMjAzMSAtMS45NjA5MzggMi4zNzUgLTIuMTA5Mzc1IEwgMy4wNjI1IC00LjQyMTg3NSBDIDMuMDgyMDMxIC00LjQ4NDM3NSAzLjExNzE4OCAtNC41MzUxNTYgMy4xNzE4NzUgLTQuNTc4MTI1IEMgMy4yMzQzNzUgLTQuNjE3MTg4IDMuMzA0Njg4IC00LjY0MDYyNSAzLjM5MDYyNSAtNC42NDA2MjUgTCAzLjkzNzUgLTQuNjQwNjI1IEMgNC4wMTk1MzEgLTQuNjQwNjI1IDQuMDkzNzUgLTQuNjE3MTg4IDQuMTU2MjUgLTQuNTc4MTI1IEMgNC4yMTg3NSAtNC41MzUxNTYgNC4yNTc4MTIgLTQuNDg0Mzc1IDQuMjgxMjUgLTQuNDIxODc1IEwgNC45Mzc1IC0yLjEwOTM3NSBDIDQuOTc2NTYyIC0xLjk3MjY1NiA1LjAxNTYyNSAtMS44MzIwMzEgNS4wNDY4NzUgLTEuNjg3NSBDIDUuMDg1OTM4IC0xLjU1MDc4MSA1LjEyODkwNiAtMS40MTAxNTYgNS4xNzE4NzUgLTEuMjY1NjI1IEMgNS4xOTE0MDYgLTEuNDEwMTU2IDUuMjEwOTM4IC0xLjU1MDc4MSA1LjIzNDM3NSAtMS42ODc1IEMgNS4yNjU2MjUgLTEuODIwMzEyIDUuMzAwNzgxIC0xLjk2MDkzOCA1LjM0Mzc1IC0yLjEwOTM3NSBMIDUuOTM3NSAtNC40MDYyNSBDIDUuOTU3MDMxIC00LjQ2ODc1IDYgLTQuNTE5NTMxIDYuMDYyNSAtNC41NjI1IEMgNi4xMjUgLTQuNjAxNTYyIDYuMTk1MzEyIC00LjYyNSA2LjI4MTI1IC00LjYyNSBaIE0gNy4yMTg3NSAtNC42MjUgIi8+PC9nPjwvZz48L2c+PGcgZmlsbD0iI2ZmZmZmZiIgZmlsbC1vcGFjaXR5PSIxIj48ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSg0Mi4zMjQ5NjgsIDE1Ljk2MDA2MikiPjxnLz48L2c+PC9nPjxnIGZpbGw9IiNmZmZmZmYiIGZpbGwtb3BhY2l0eT0iMSI+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoNDQuNDU4NjI0LCAxNS45NjAwNjIpIj48Zz48cGF0aCBkPSJNIDIuODkwNjI1IC0zLjI4MTI1IEMgMy4zMDQ2ODggLTMuMjgxMjUgMy42MTMyODEgLTMuMzc4OTA2IDMuODEyNSAtMy41NzgxMjUgQyA0LjAwNzgxMiAtMy43ODUxNTYgNC4xMDkzNzUgLTQuMDY2NDA2IDQuMTA5Mzc1IC00LjQyMTg3NSBDIDQuMTA5Mzc1IC00LjU3ODEyNSA0LjA4MjAzMSAtNC43MjI2NTYgNC4wMzEyNSAtNC44NTkzNzUgQyAzLjk3NjU2MiAtNC45OTIxODggMy44OTg0MzggLTUuMTA5Mzc1IDMuNzk2ODc1IC01LjIwMzEyNSBDIDMuNzAzMTI1IC01LjI5Njg3NSAzLjU3ODEyNSAtNS4zNjcxODggMy40MjE4NzUgLTUuNDIxODc1IEMgMy4yNzM0MzggLTUuNDcyNjU2IDMuMDk3NjU2IC01LjUgMi44OTA2MjUgLTUuNSBMIDIuMDMxMjUgLTUuNSBMIDIuMDMxMjUgLTMuMjgxMjUgWiBNIDIuODkwNjI1IC02LjUxNTYyNSBDIDMuMzI4MTI1IC02LjUxNTYyNSAzLjcwNzAzMSAtNi40NjA5MzggNC4wMzEyNSAtNi4zNTkzNzUgQyA0LjM2MzI4MSAtNi4yNTM5MDYgNC42MzI4MTIgLTYuMTA5Mzc1IDQuODQzNzUgLTUuOTIxODc1IEMgNS4wNTA3ODEgLTUuNzM0Mzc1IDUuMjAzMTI1IC01LjUwNzgxMiA1LjI5Njg3NSAtNS4yNSBDIDUuMzk4NDM4IC01IDUuNDUzMTI1IC00LjcyMjY1NiA1LjQ1MzEyNSAtNC40MjE4NzUgQyA1LjQ1MzEyNSAtNC4wOTc2NTYgNS4zOTg0MzggLTMuODAwNzgxIDUuMjk2ODc1IC0zLjUzMTI1IEMgNS4xOTE0MDYgLTMuMjY5NTMxIDUuMDMxMjUgLTMuMDM5MDYyIDQuODEyNSAtMi44NDM3NSBDIDQuNjAxNTYyIC0yLjY1NjI1IDQuMzM1OTM4IC0yLjUwMzkwNiA0LjAxNTYyNSAtMi4zOTA2MjUgQyAzLjY5MTQwNiAtMi4yODUxNTYgMy4zMTY0MDYgLTIuMjM0Mzc1IDIuODkwNjI1IC0yLjIzNDM3NSBMIDIuMDMxMjUgLTIuMjM0Mzc1IEwgMi4wMzEyNSAwIEwgMC42ODc1IDAgTCAwLjY4NzUgLTYuNTE1NjI1IFogTSAyLjg5MDYyNSAtNi41MTU2MjUgIi8+PC9nPjwvZz48L2c+PGcgZmlsbD0iI2ZmZmZmZiIgZmlsbC1vcGFjaXR5PSIxIj48ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSg1MC4wOTE0NzEsIDE1Ljk2MDA2MikiPjxnPjxwYXRoIGQ9Ik0gMS43NjU2MjUgLTYuNzAzMTI1IEwgMS43NjU2MjUgMCBMIDAuNTE1NjI1IDAgTCAwLjUxNTYyNSAtNi43MDMxMjUgWiBNIDEuNzY1NjI1IC02LjcwMzEyNSAiLz48L2c+PC9nPjwvZz48ZyBmaWxsPSIjZmZmZmZmIiBmaWxsLW9wYWNpdHk9IjEiPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKDUyLjM3MzM1OSwgMTUuOTYwMDYyKSI+PGc+PHBhdGggZD0iTSAyLjkzNzUgLTEuOTM3NSBDIDIuNjMyODEyIC0xLjkxNDA2MiAyLjM3ODkwNiAtMS44ODI4MTIgMi4xNzE4NzUgLTEuODQzNzUgQyAxLjk3MjY1NiAtMS44MTI1IDEuODEyNSAtMS43NjU2MjUgMS42ODc1IC0xLjcwMzEyNSBDIDEuNTcwMzEyIC0xLjY0ODQzOCAxLjQ4ODI4MSAtMS41ODIwMzEgMS40Mzc1IC0xLjUgQyAxLjM5NDUzMSAtMS40MjU3ODEgMS4zNzUgLTEuMzQ3NjU2IDEuMzc1IC0xLjI2NTYyNSBDIDEuMzc1IC0xLjA3ODEyNSAxLjQyMTg3NSAtMC45NDUzMTIgMS41MTU2MjUgLTAuODc1IEMgMS42MTcxODggLTAuODAwNzgxIDEuNzU3ODEyIC0wLjc2NTYyNSAxLjkzNzUgLTAuNzY1NjI1IEMgMi4xNDQ1MzEgLTAuNzY1NjI1IDIuMzIwMzEyIC0wLjgwMDc4MSAyLjQ2ODc1IC0wLjg3NSBDIDIuNjI1IC0wLjk0NTMxMiAyLjc4MTI1IC0xLjA2MjUgMi45Mzc1IC0xLjIxODc1IFogTSAwLjQwNjI1IC0zLjk4NDM3NSBDIDAuNjc1NzgxIC00LjIzNDM3NSAwLjk3NjU2MiAtNC40MTQwNjIgMS4zMTI1IC00LjUzMTI1IEMgMS42NDQ1MzEgLTQuNjU2MjUgMiAtNC43MTg3NSAyLjM3NSAtNC43MTg3NSBDIDIuNjU2MjUgLTQuNzE4NzUgMi45MDYyNSAtNC42NzE4NzUgMy4xMjUgLTQuNTc4MTI1IEMgMy4zNDM3NSAtNC40OTIxODggMy41MjM0MzggLTQuMzY3MTg4IDMuNjcxODc1IC00LjIwMzEyNSBDIDMuODI4MTI1IC00LjA0Njg3NSAzLjk0MTQwNiAtMy44NTkzNzUgNC4wMTU2MjUgLTMuNjQwNjI1IEMgNC4wOTc2NTYgLTMuNDIxODc1IDQuMTQwNjI1IC0zLjE3NTc4MSA0LjE0MDYyNSAtMi45MDYyNSBMIDQuMTQwNjI1IDAgTCAzLjU3ODEyNSAwIEMgMy40NjA5MzggMCAzLjM3NSAtMC4wMTU2MjUgMy4zMTI1IC0wLjA0Njg3NSBDIDMuMjUgLTAuMDc4MTI1IDMuMTk1MzEyIC0wLjE0NDUzMSAzLjE1NjI1IC0wLjI1IEwgMy4wNjI1IC0wLjU0Njg3NSBDIDIuOTQ1MzEyIC0wLjQ1MzEyNSAyLjgzMjAzMSAtMC4zNjMyODEgMi43MTg3NSAtMC4yODEyNSBDIDIuNjEzMjgxIC0wLjIwNzAzMSAyLjUgLTAuMTQ0NTMxIDIuMzc1IC0wLjA5Mzc1IEMgMi4yNTc4MTIgLTAuMDM5MDYyNSAyLjEzMjgxMiAwIDIgMC4wMzEyNSBDIDEuODc1IDAuMDYyNSAxLjcyNjU2MiAwLjA3ODEyNSAxLjU2MjUgMC4wNzgxMjUgQyAxLjM1MTU2MiAwLjA3ODEyNSAxLjE2NDA2MiAwLjA1MDc4MTIgMSAwIEMgMC44MzIwMzEgLTAuMDYyNSAwLjY4NzUgLTAuMTQ0NTMxIDAuNTYyNSAtMC4yNSBDIDAuNDQ1MzEyIC0wLjM1MTU2MiAwLjM1MTU2MiAtMC40ODQzNzUgMC4yODEyNSAtMC42NDA2MjUgQyAwLjIxODc1IC0wLjgwNDY4OCAwLjE4NzUgLTAuOTg4MjgxIDAuMTg3NSAtMS4xODc1IEMgMC4xODc1IC0xLjM2MzI4MSAwLjIyNjU2MiAtMS41MzUxNTYgMC4zMTI1IC0xLjcwMzEyNSBDIDAuNDA2MjUgLTEuODc4OTA2IDAuNTU0Njg4IC0yLjAzNTE1NiAwLjc2NTYyNSAtMi4xNzE4NzUgQyAwLjk3MjY1NiAtMi4zMDQ2ODggMS4yNTM5MDYgLTIuNDIxODc1IDEuNjA5Mzc1IC0yLjUxNTYyNSBDIDEuOTYwOTM4IC0yLjYwOTM3NSAyLjQwNjI1IC0yLjY2MDE1NiAyLjkzNzUgLTIuNjcxODc1IEwgMi45Mzc1IC0yLjkwNjI1IEMgMi45Mzc1IC0zLjE5NTMxMiAyLjg3NSAtMy40MTAxNTYgMi43NSAtMy41NDY4NzUgQyAyLjYyNSAtMy42Nzk2ODggMi40NDUzMTIgLTMuNzUgMi4yMTg3NSAtMy43NSBDIDIuMDUwNzgxIC0zLjc1IDEuOTEwMTU2IC0zLjcyNjU2MiAxLjc5Njg3NSAtMy42ODc1IEMgMS42Nzk2ODggLTMuNjU2MjUgMS41NzgxMjUgLTMuNjEzMjgxIDEuNDg0Mzc1IC0zLjU2MjUgQyAxLjM5ODQzOCAtMy41MTk1MzEgMS4zMjAzMTIgLTMuNDc2NTYyIDEuMjUgLTMuNDM3NSBDIDEuMTc1NzgxIC0zLjM5NDUzMSAxLjA5Mzc1IC0zLjM3NSAxIC0zLjM3NSBDIDAuOTA2MjUgLTMuMzc1IDAuODI4MTI1IC0zLjM5NDUzMSAwLjc2NTYyNSAtMy40Mzc1IEMgMC43MTA5MzggLTMuNDc2NTYyIDAuNjY0MDYyIC0zLjUzMTI1IDAuNjI1IC0zLjU5Mzc1IFogTSAwLjQwNjI1IC0zLjk4NDM3NSAiLz48L2c+PC9nPjwvZz48ZyBmaWxsPSIjZmZmZmZmIiBmaWxsLW9wYWNpdHk9IjEiPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKDU2Ljk3MzA2OSwgMTUuOTYwMDYyKSI+PGc+PHBhdGggZD0iTSA0LjgxMjUgLTQuNjI1IEwgMi4zMTI1IDEuMjUgQyAyLjI2OTUzMSAxLjMzMjAzMSAyLjIxODc1IDEuMzk0NTMxIDIuMTU2MjUgMS40Mzc1IEMgMi4xMDE1NjIgMS40NzY1NjIgMi4wMTk1MzEgMS41IDEuOTA2MjUgMS41IEwgMC45ODQzNzUgMS41IEwgMS44NTkzNzUgLTAuMzc1IEwgMCAtNC42MjUgTCAxLjA5Mzc1IC00LjYyNSBDIDEuMTg3NSAtNC42MjUgMS4yNTc4MTIgLTQuNjAxNTYyIDEuMzEyNSAtNC41NjI1IEMgMS4zNjMyODEgLTQuNTE5NTMxIDEuNDA2MjUgLTQuNDY4NzUgMS40Mzc1IC00LjQwNjI1IEwgMi4zMTI1IC0yLjE4NzUgQyAyLjM0Mzc1IC0yLjEwMTU2MiAyLjM2NzE4OCAtMi4wMTU2MjUgMi4zOTA2MjUgLTEuOTIxODc1IEMgMi40MjE4NzUgLTEuODM1OTM4IDIuNDQ1MzEyIC0xLjc1MzkwNiAyLjQ2ODc1IC0xLjY3MTg3NSBDIDIuNTMxMjUgLTEuODQ3NjU2IDIuNTkzNzUgLTIuMDIzNDM4IDIuNjU2MjUgLTIuMjAzMTI1IEwgMy40ODQzNzUgLTQuNDA2MjUgQyAzLjUwMzkwNiAtNC40Njg3NSAzLjU0Njg3NSAtNC41MTk1MzEgMy42MDkzNzUgLTQuNTYyNSBDIDMuNjcxODc1IC00LjYwMTU2MiAzLjczODI4MSAtNC42MjUgMy44MTI1IC00LjYyNSBaIE0gNC44MTI1IC00LjYyNSAiLz48L2c+PC9nPjwvZz48ZyBmaWxsPSIjZmZmZmZmIiBmaWxsLW9wYWNpdHk9IjEiPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKDYxLjc1MjQ1MywgMTUuOTYwMDYyKSI+PGc+PHBhdGggZD0iTSAxLjc1IC0xLjIxODc1IEMgMS44NjMyODEgLTEuMDgyMDMxIDEuOTg4MjgxIC0wLjk4ODI4MSAyLjEyNSAtMC45Mzc1IEMgMi4yNjk1MzEgLTAuODgyODEyIDIuNDE0MDYyIC0wLjg1OTM3NSAyLjU2MjUgLTAuODU5Mzc1IEMgMi43MDcwMzEgLTAuODU5Mzc1IDIuODQzNzUgLTAuODgyODEyIDIuOTY4NzUgLTAuOTM3NSBDIDMuMDkzNzUgLTEgMy4xOTUzMTIgLTEuMDg1OTM4IDMuMjgxMjUgLTEuMjAzMTI1IEMgMy4zNzUgLTEuMzI4MTI1IDMuNDQ1MzEyIC0xLjQ4NDM3NSAzLjUgLTEuNjcxODc1IEMgMy41NTA3ODEgLTEuODY3MTg4IDMuNTc4MTI1IC0yLjEwOTM3NSAzLjU3ODEyNSAtMi4zOTA2MjUgQyAzLjU3ODEyNSAtMi42Mjg5MDYgMy41NTQ2ODggLTIuODMyMDMxIDMuNTE1NjI1IC0zIEMgMy40NzI2NTYgLTMuMTc1NzgxIDMuNDEwMTU2IC0zLjMyMDMxMiAzLjMyODEyNSAtMy40Mzc1IEMgMy4yNTM5MDYgLTMuNTUwNzgxIDMuMTYwMTU2IC0zLjYyODkwNiAzLjA0Njg3NSAtMy42NzE4NzUgQyAyLjk0MTQwNiAtMy43MjI2NTYgMi44MTY0MDYgLTMuNzUgMi42NzE4NzUgLTMuNzUgQyAyLjQ3MjY1NiAtMy43NSAyLjMwMDc4MSAtMy43MDcwMzEgMi4xNTYyNSAtMy42MjUgQyAyLjAxOTUzMSAtMy41MzkwNjIgMS44ODI4MTIgLTMuNDE0MDYyIDEuNzUgLTMuMjUgWiBNIDEuNzUgLTQuMDkzNzUgQyAxLjkzNzUgLTQuMjgxMjUgMi4xNDA2MjUgLTQuNDI1NzgxIDIuMzU5Mzc1IC00LjUzMTI1IEMgMi41NzgxMjUgLTQuNjQ0NTMxIDIuODI4MTI1IC00LjcwMzEyNSAzLjEwOTM3NSAtNC43MDMxMjUgQyAzLjM2NzE4OCAtNC43MDMxMjUgMy42MDE1NjIgLTQuNjQ4NDM4IDMuODEyNSAtNC41NDY4NzUgQyA0LjAzMTI1IC00LjQ0MTQwNiA0LjIxMDkzOCAtNC4yODkwNjIgNC4zNTkzNzUgLTQuMDkzNzUgQyA0LjUxNTYyNSAtMy44OTQ1MzEgNC42MzI4MTIgLTMuNjU2MjUgNC43MTg3NSAtMy4zNzUgQyA0LjgwMDc4MSAtMy4wOTM3NSA0Ljg0Mzc1IC0yLjc4MTI1IDQuODQzNzUgLTIuNDM3NSBDIDQuODQzNzUgLTIuMDYyNSA0Ljc5Njg3NSAtMS43MTg3NSA0LjcwMzEyNSAtMS40MDYyNSBDIDQuNjA5Mzc1IC0xLjEwMTU2MiA0LjQ3MjY1NiAtMC44NDM3NSA0LjI5Njg3NSAtMC42MjUgQyA0LjEyODkwNiAtMC40MDYyNSAzLjkyMTg3NSAtMC4yMzQzNzUgMy42NzE4NzUgLTAuMTA5Mzc1IEMgMy40Mjk2ODggMC4wMDM5MDYyNSAzLjE2NDA2MiAwLjA2MjUgMi44NzUgMC4wNjI1IEMgMi43MjY1NjIgMC4wNjI1IDIuNTk3NjU2IDAuMDQ2ODc1IDIuNDg0Mzc1IDAuMDE1NjI1IEMgMi4zNjcxODggLTAuMDAzOTA2MjUgMi4yNjU2MjUgLTAuMDM5MDYyNSAyLjE3MTg3NSAtMC4wOTM3NSBDIDIuMDc4MTI1IC0wLjE0NDUzMSAxLjk4ODI4MSAtMC4yMDMxMjUgMS45MDYyNSAtMC4yNjU2MjUgQyAxLjgyMDMxMiAtMC4zMzU5MzggMS43NSAtMC40MjE4NzUgMS42ODc1IC0wLjUxNTYyNSBMIDEuNjI1IC0wLjIzNDM3NSBDIDEuNjAxNTYyIC0wLjE0ODQzOCAxLjU2NjQwNiAtMC4wODU5Mzc1IDEuNTE1NjI1IC0wLjA0Njg3NSBDIDEuNDcyNjU2IC0wLjAxNTYyNSAxLjQxMDE1NiAwIDEuMzI4MTI1IDAgTCAwLjUxNTYyNSAwIEwgMC41MTU2MjUgLTYuNzAzMTI1IEwgMS43NSAtNi43MDMxMjUgWiBNIDEuNzUgLTQuMDkzNzUgIi8+PC9nPjwvZz48L2c+PGcgZmlsbD0iI2ZmZmZmZiIgZmlsbC1vcGFjaXR5PSIxIj48ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSg2Ni44ODIyMDYsIDE1Ljk2MDA2MikiPjxnPjxwYXRoIGQ9Ik0gMi41OTM3NSAtNC43MDMxMjUgQyAyLjk0NTMxMiAtNC43MDMxMjUgMy4yNjU2MjUgLTQuNjQ0NTMxIDMuNTQ2ODc1IC00LjUzMTI1IEMgMy44MjgxMjUgLTQuNDI1NzgxIDQuMDcwMzEyIC00LjI2OTUzMSA0LjI4MTI1IC00LjA2MjUgQyA0LjQ4ODI4MSAtMy44NTE1NjIgNC42NDQ1MzEgLTMuNjAxNTYyIDQuNzUgLTMuMzEyNSBDIDQuODYzMjgxIC0zLjAxOTUzMSA0LjkyMTg3NSAtMi42OTE0MDYgNC45MjE4NzUgLTIuMzI4MTI1IEMgNC45MjE4NzUgLTEuOTUzMTI1IDQuODYzMjgxIC0xLjYxNzE4OCA0Ljc1IC0xLjMyODEyNSBDIDQuNjQ0NTMxIC0xLjAzNTE1NiA0LjQ4ODI4MSAtMC43ODUxNTYgNC4yODEyNSAtMC41NzgxMjUgQyA0LjA3MDMxMiAtMC4zNjcxODggMy44MjgxMjUgLTAuMjA3MDMxIDMuNTQ2ODc1IC0wLjA5Mzc1IEMgMy4yNjU2MjUgMC4wMDc4MTI1IDIuOTQ1MzEyIDAuMDYyNSAyLjU5Mzc1IDAuMDYyNSBDIDIuMjUgMC4wNjI1IDEuOTI5Njg4IDAuMDA3ODEyNSAxLjY0MDYyNSAtMC4wOTM3NSBDIDEuMzU5Mzc1IC0wLjIwNzAzMSAxLjExMzI4MSAtMC4zNjcxODggMC45MDYyNSAtMC41NzgxMjUgQyAwLjcwNzAzMSAtMC43ODUxNTYgMC41NTA3ODEgLTEuMDM1MTU2IDAuNDM3NSAtMS4zMjgxMjUgQyAwLjMyMDMxMiAtMS42MTcxODggMC4yNjU2MjUgLTEuOTUzMTI1IDAuMjY1NjI1IC0yLjMyODEyNSBDIDAuMjY1NjI1IC0yLjY5MTQwNiAwLjMyMDMxMiAtMy4wMTk1MzEgMC40Mzc1IC0zLjMxMjUgQyAwLjU1MDc4MSAtMy42MDE1NjIgMC43MDcwMzEgLTMuODUxNTYyIDAuOTA2MjUgLTQuMDYyNSBDIDEuMTEzMjgxIC00LjI2OTUzMSAxLjM1OTM3NSAtNC40MjU3ODEgMS42NDA2MjUgLTQuNTMxMjUgQyAxLjkyOTY4OCAtNC42NDQ1MzEgMi4yNSAtNC43MDMxMjUgMi41OTM3NSAtNC43MDMxMjUgWiBNIDIuNTkzNzUgLTAuODU5Mzc1IEMgMi45NDUzMTIgLTAuODU5Mzc1IDMuMjA3MDMxIC0wLjk3NjU2MiAzLjM3NSAtMS4yMTg3NSBDIDMuNTUwNzgxIC0xLjQ2ODc1IDMuNjQwNjI1IC0xLjgzMjAzMSAzLjY0MDYyNSAtMi4zMTI1IEMgMy42NDA2MjUgLTIuNzg5MDYyIDMuNTUwNzgxIC0zLjE0ODQzOCAzLjM3NSAtMy4zOTA2MjUgQyAzLjIwNzAzMSAtMy42NDA2MjUgMi45NDUzMTIgLTMuNzY1NjI1IDIuNTkzNzUgLTMuNzY1NjI1IEMgMi4yMzgyODEgLTMuNzY1NjI1IDEuOTcyNjU2IC0zLjY0MDYyNSAxLjc5Njg3NSAtMy4zOTA2MjUgQyAxLjYyODkwNiAtMy4xNDg0MzggMS41NDY4NzUgLTIuNzg5MDYyIDEuNTQ2ODc1IC0yLjMxMjUgQyAxLjU0Njg3NSAtMS44MzIwMzEgMS42Mjg5MDYgLTEuNDY4NzUgMS43OTY4NzUgLTEuMjE4NzUgQyAxLjk3MjY1NiAtMC45NzY1NjIgMi4yMzgyODEgLTAuODU5Mzc1IDIuNTkzNzUgLTAuODU5Mzc1IFogTSAyLjU5Mzc1IC0wLjg1OTM3NSAiLz48L2c+PC9nPjwvZz48ZyBmaWxsPSIjZmZmZmZmIiBmaWxsLW9wYWNpdHk9IjEiPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKDcyLjA3MDM1NiwgMTUuOTYwMDYyKSI+PGc+PHBhdGggZD0iTSAyLjU5Mzc1IC00LjcwMzEyNSBDIDIuOTQ1MzEyIC00LjcwMzEyNSAzLjI2NTYyNSAtNC42NDQ1MzEgMy41NDY4NzUgLTQuNTMxMjUgQyAzLjgyODEyNSAtNC40MjU3ODEgNC4wNzAzMTIgLTQuMjY5NTMxIDQuMjgxMjUgLTQuMDYyNSBDIDQuNDg4MjgxIC0zLjg1MTU2MiA0LjY0NDUzMSAtMy42MDE1NjIgNC43NSAtMy4zMTI1IEMgNC44NjMyODEgLTMuMDE5NTMxIDQuOTIxODc1IC0yLjY5MTQwNiA0LjkyMTg3NSAtMi4zMjgxMjUgQyA0LjkyMTg3NSAtMS45NTMxMjUgNC44NjMyODEgLTEuNjE3MTg4IDQuNzUgLTEuMzI4MTI1IEMgNC42NDQ1MzEgLTEuMDM1MTU2IDQuNDg4MjgxIC0wLjc4NTE1NiA0LjI4MTI1IC0wLjU3ODEyNSBDIDQuMDcwMzEyIC0wLjM2NzE4OCAzLjgyODEyNSAtMC4yMDcwMzEgMy41NDY4NzUgLTAuMDkzNzUgQyAzLjI2NTYyNSAwLjAwNzgxMjUgMi45NDUzMTIgMC4wNjI1IDIuNTkzNzUgMC4wNjI1IEMgMi4yNSAwLjA2MjUgMS45Mjk2ODggMC4wMDc4MTI1IDEuNjQwNjI1IC0wLjA5Mzc1IEMgMS4zNTkzNzUgLTAuMjA3MDMxIDEuMTEzMjgxIC0wLjM2NzE4OCAwLjkwNjI1IC0wLjU3ODEyNSBDIDAuNzA3MDMxIC0wLjc4NTE1NiAwLjU1MDc4MSAtMS4wMzUxNTYgMC40Mzc1IC0xLjMyODEyNSBDIDAuMzIwMzEyIC0xLjYxNzE4OCAwLjI2NTYyNSAtMS45NTMxMjUgMC4yNjU2MjUgLTIuMzI4MTI1IEMgMC4yNjU2MjUgLTIuNjkxNDA2IDAuMzIwMzEyIC0zLjAxOTUzMSAwLjQzNzUgLTMuMzEyNSBDIDAuNTUwNzgxIC0zLjYwMTU2MiAwLjcwNzAzMSAtMy44NTE1NjIgMC45MDYyNSAtNC4wNjI1IEMgMS4xMTMyODEgLTQuMjY5NTMxIDEuMzU5Mzc1IC00LjQyNTc4MSAxLjY0MDYyNSAtNC41MzEyNSBDIDEuOTI5Njg4IC00LjY0NDUzMSAyLjI1IC00LjcwMzEyNSAyLjU5Mzc1IC00LjcwMzEyNSBaIE0gMi41OTM3NSAtMC44NTkzNzUgQyAyLjk0NTMxMiAtMC44NTkzNzUgMy4yMDcwMzEgLTAuOTc2NTYyIDMuMzc1IC0xLjIxODc1IEMgMy41NTA3ODEgLTEuNDY4NzUgMy42NDA2MjUgLTEuODMyMDMxIDMuNjQwNjI1IC0yLjMxMjUgQyAzLjY0MDYyNSAtMi43ODkwNjIgMy41NTA3ODEgLTMuMTQ4NDM4IDMuMzc1IC0zLjM5MDYyNSBDIDMuMjA3MDMxIC0zLjY0MDYyNSAyLjk0NTMxMiAtMy43NjU2MjUgMi41OTM3NSAtMy43NjU2MjUgQyAyLjIzODI4MSAtMy43NjU2MjUgMS45NzI2NTYgLTMuNjQwNjI1IDEuNzk2ODc1IC0zLjM5MDYyNSBDIDEuNjI4OTA2IC0zLjE0ODQzOCAxLjU0Njg3NSAtMi43ODkwNjIgMS41NDY4NzUgLTIuMzEyNSBDIDEuNTQ2ODc1IC0xLjgzMjAzMSAxLjYyODkwNiAtMS40Njg3NSAxLjc5Njg3NSAtMS4yMTg3NSBDIDEuOTcyNjU2IC0wLjk3NjU2MiAyLjIzODI4MSAtMC44NTkzNzUgMi41OTM3NSAtMC44NTkzNzUgWiBNIDIuNTkzNzUgLTAuODU5Mzc1ICIvPjwvZz48L2c+PC9nPjxnIGZpbGw9IiNmZmZmZmYiIGZpbGwtb3BhY2l0eT0iMSI+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoNzcuMjU4NTA2LCAxNS45NjAwNjIpIj48Zz48cGF0aCBkPSJNIDEuNzUgLTYuNzAzMTI1IEwgMS43NSAtMi44OTA2MjUgTCAxLjk1MzEyNSAtMi44OTA2MjUgQyAyLjAzNTE1NiAtMi44OTA2MjUgMi4wOTc2NTYgLTIuODk4NDM4IDIuMTQwNjI1IC0yLjkyMTg3NSBDIDIuMTc5Njg4IC0yLjk1MzEyNSAyLjIyNjU2MiAtMyAyLjI4MTI1IC0zLjA2MjUgTCAzLjI5Njg3NSAtNC40MjE4NzUgQyAzLjM0NzY1NiAtNC40OTIxODggMy40MDYyNSAtNC41NDY4NzUgMy40Njg3NSAtNC41NzgxMjUgQyAzLjUzOTA2MiAtNC42MDkzNzUgMy42MjUgLTQuNjI1IDMuNzE4NzUgLTQuNjI1IEwgNC44NTkzNzUgLTQuNjI1IEwgMy41MTU2MjUgLTIuOTM3NSBDIDMuNDEwMTU2IC0yLjgwMDc4MSAzLjI4OTA2MiAtMi42OTE0MDYgMy4xNTYyNSAtMi42MDkzNzUgQyAzLjIyNjU2MiAtMi41NTQ2ODggMy4yODkwNjIgLTIuNSAzLjM0Mzc1IC0yLjQzNzUgQyAzLjM5NDUzMSAtMi4zNzUgMy40NDE0MDYgLTIuMzA0Njg4IDMuNDg0Mzc1IC0yLjIzNDM3NSBMIDQuOTIxODc1IDAgTCAzLjgxMjUgMCBDIDMuNzA3MDMxIDAgMy42MTcxODggLTAuMDE1NjI1IDMuNTQ2ODc1IC0wLjA0Njg3NSBDIDMuNDg0Mzc1IC0wLjA3ODEyNSAzLjQyOTY4OCAtMC4xMzI4MTIgMy4zOTA2MjUgLTAuMjE4NzUgTCAyLjM0Mzc1IC0xLjkyMTg3NSBDIDIuMzAwNzgxIC0xLjk5MjE4OCAyLjI1MzkwNiAtMi4wMzkwNjIgMi4yMDMxMjUgLTIuMDYyNSBDIDIuMTYwMTU2IC0yLjA4MjAzMSAyLjA5NzY1NiAtMi4wOTM3NSAyLjAxNTYyNSAtMi4wOTM3NSBMIDEuNzUgLTIuMDkzNzUgTCAxLjc1IDAgTCAwLjUxNTYyNSAwIEwgMC41MTU2MjUgLTYuNzAzMTI1IFogTSAxLjc1IC02LjcwMzEyNSAiLz48L2c+PC9nPjwvZz48L3N2Zz4=');" onclick="window.open('https://drive.google.com/file/d/1YhTx_rO483vr5B8ibZtgl57-_G-Q2EiK/view?usp=share_link', '_blank');"></div></td>
        <td style="padding: 10px 20px;"><div style="background-color: lightblue; display: inline-block; border-radius: 4px; cursor: pointer; height: 32px; border: none; width: 123px; background-image: url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTI4IiBoZWlnaHQ9IjMyIiBmaWxsPSJub25lIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxyZWN0IHdpZHRoPSIxMjgiIGhlaWdodD0iMzIiIHJ4PSI0IiBmaWxsPSIjRkY2QzM3Ii8+PHBhdGggZD0iTTEyIDEwLjg4M2EuNS41IDAgMCAxIC43NTctLjQyOWw4LjUyOCA1LjExN2EuNS41IDAgMCAxIDAgLjg1OGwtOC41MjggNS4xMTdhLjUuNSAwIDAgMS0uNzU3LS40M1YxMC44ODRaTTI3Ljg4OSAyMC41MDloMS41OHYtMy4xOTdoMS42MTFsMS43MTMgMy4xOTdoMS43NjRsLTEuODg3LTMuNDZjMS4wMjctLjQxNCAxLjU2OC0xLjI5MiAxLjU2OC0yLjQ3NyAwLTEuNjY2LTEuMDc0LTIuNzktMy4wNzctMi43OWgtMy4yNzN2OC43MjdaTTI5LjQ2OCAxNnYtMi44OThoMS40NWMxLjE4IDAgMS43MDguNTQxIDEuNzA4IDEuNDcgMCAuOTMtLjUyOCAxLjQyOC0xLjcgMS40MjhIMjkuNDdaTTM5Ljc5NyAxNy43NTZjMCAuOTk3LS43MTIgMS40OTEtMS4zOTQgMS40OTEtLjc0MSAwLTEuMjM1LS41MjQtMS4yMzUtMS4zNTV2LTMuOTI5aC0xLjU0M3Y0LjE2OGMwIDEuNTcyLjg5NSAyLjQ2MyAyLjE4MiAyLjQ2My45OCAwIDEuNjctLjUxNiAxLjk2OS0xLjI0OWguMDY4djEuMTY0aDEuNDk1di02LjU0NmgtMS41NDJ2My43OTNaTTQ0LjQ2OCAxNi42NzNjMC0uOTQ2LjU3MS0xLjQ5MSAxLjM4NS0xLjQ5MS43OTcgMCAxLjI3NC41MjQgMS4yNzQgMS4zOTd2My45M2gxLjU0M1YxNi4zNGMuMDA0LTEuNTY4LS44OS0yLjQ2My0yLjI0MS0yLjQ2My0uOTggMC0xLjY1NC40NjktMS45NTIgMS4xOTdINDQuNHYtMS4xMTJoLTEuNDc0djYuNTQ2aDEuNTQydi0zLjgzNlpNNTMuMjE1IDIwLjUwOWgxLjU0MnYtNi41NDZoLTEuNTQydjYuNTQ2Wm0uNzc1LTcuNDc1Yy40OSAwIC44OTEtLjM3NS44OTEtLjgzNSAwLS40NjUtLjQtLjg0LS44OS0uODQtLjQ5NSAwLS44OTUuMzc1LS44OTUuODQgMCAuNDYuNC44MzUuODk0LjgzNVpNNTcuODg2IDE2LjY3M2MwLS45NDYuNTcxLTEuNDkxIDEuMzg1LTEuNDkxLjc5NyAwIDEuMjc0LjUyNCAxLjI3NCAxLjM5N3YzLjkzaDEuNTQzVjE2LjM0Yy4wMDQtMS41NjgtLjg5LTIuNDYzLTIuMjQxLTIuNDYzLS45OCAwLTEuNjU0LjQ2OS0xLjk1MiAxLjE5N2gtLjA3N3YtMS4xMTJoLTEuNDc0djYuNTQ2aDEuNTQydi0zLjgzNlpNNjYuNzAxIDIwLjUwOWgxLjU4MXYtMi45NWgxLjY3YzIuMDE2IDAgMy4wOTgtMS4yMSAzLjA5OC0yLjg4OSAwLTEuNjY2LTEuMDctMi44ODktMy4wNzYtMi44ODlINjYuN3Y4LjcyOFptMS41ODEtNC4yNXYtMy4xNTdoMS40NDljMS4xODQgMCAxLjcwOS42NCAxLjcwOSAxLjU2OSAwIC45MjgtLjUyNSAxLjU4OS0xLjcgMS41ODloLTEuNDU4Wk03Ny4xMTcgMjAuNjM2YzEuOTE3IDAgMy4xMzYtMS4zNSAzLjEzNi0zLjM3NSAwLTIuMDI4LTEuMjE5LTMuMzgzLTMuMTM2LTMuMzgzLTEuOTE4IDAtMy4xMzYgMS4zNTUtMy4xMzYgMy4zODMgMCAyLjAyNCAxLjIxOCAzLjM3NSAzLjEzNiAzLjM3NVptLjAwOC0xLjIzNWMtMS4wNiAwLTEuNTgtLjk0Ny0xLjU4LTIuMTQ0cy41Mi0yLjE1NiAxLjU4LTIuMTU2YzEuMDQ0IDAgMS41NjQuOTU5IDEuNTY0IDIuMTU2cy0uNTIgMi4xNDQtMS41NjQgMi4xNDRaTTg2LjczNiAxNS42OTNjLS4yMTMtMS4xMDgtMS4xLTEuODE1LTIuNjM0LTEuODE1LTEuNTc2IDAtMi42NS43NzUtMi42NDYgMS45ODYtLjAwNC45NTQuNTg0IDEuNTg1IDEuODQgMS44NDVsMS4xMTcuMjM0Yy42MDEuMTMyLjg4My4zNzUuODgzLjc0NiAwIC40NDctLjQ4Ni43ODQtMS4yMi43ODQtLjcwNyAwLTEuMTY3LS4zMDctMS4yOTktLjg5NWwtMS41MDQuMTQ1Yy4xOTIgMS4yMDIgMS4yMDEgMS45MTMgMi44MDggMS45MTMgMS42MzYgMCAyLjc5MS0uODQ4IDIuNzk1LTIuMDg4LS4wMDQtLjkzMy0uNjA1LTEuNTA0LTEuODQtMS43NzJsLTEuMTE3LS4yNGMtLjY2NS0uMTQ4LS45MjktLjM3OC0uOTI1LS43NTgtLjAwNC0uNDQzLjQ4Ni0uNzUgMS4xMy0uNzUuNzExIDAgMS4wODYuMzg4IDEuMjA2LjgxOWwxLjQwNi0uMTU0Wk05MS40MTcgMTMuOTYzaC0xLjI5MXYtMS41NjhoLTEuNTQzdjEuNTY4aC0uOTI5djEuMTkzaC45M3YzLjY0Yy0uMDEgMS4yMzEuODg1IDEuODM2IDIuMDQ0IDEuODAyYTMuMSAzLjEgMCAwIDAgLjkwOC0uMTUzbC0uMjYtMS4yMDZjLS4wODUuMDItLjI2LjA2LS40NTEuMDYtLjM4OCAwLS43LS4xMzctLjctLjc2di0zLjM4M2gxLjI5MnYtMS4xOTNaTTkyLjcwNyAyMC41MDloMS41NDN2LTMuOThjMC0uODA2LjUzNy0xLjM1MSAxLjIwMS0xLjM1MS42NTIgMCAxLjEuNDM4IDEuMSAxLjExMnY0LjIxOWgxLjUxM3YtNC4wODNjMC0uNzM3LjQzOS0xLjI0OCAxLjE4NC0xLjI0OC42MjIgMCAxLjExNy4zNjYgMS4xMTcgMS4xNzZ2NC4xNTVoMS41NDd2LTQuMzk0YzAtMS40NjItLjg0NC0yLjIzNy0yLjA0Ni0yLjIzNy0uOTUgMC0xLjY3NS40NjktMS45NjQgMS4xOTdoLS4wNjljLS4yNTEtLjc0MS0uODg2LTEuMTk3LTEuNzY4LTEuMTk3LS44NzggMC0xLjUzNC40NTEtMS44MDcgMS4xOTdoLS4wNzZ2LTEuMTEyaC0xLjQ3NXY2LjU0NlpNMTA1LjM2IDIwLjY0YzEuMDI3IDAgMS42NDEtLjQ4IDEuOTIyLTEuMDNoLjA1MXYuODk5aDEuNDgzdi00LjM4MWMwLTEuNzMtMS40MS0yLjI1LTIuNjU5LTIuMjUtMS4zNzYgMC0yLjQzMy42MTQtMi43NzQgMS44MDdsMS40NC4yMDRjLjE1NC0uNDQ3LjU4OC0uODMgMS4zNDItLjgzLjcxNiAwIDEuMTA4LjM2NiAxLjEwOCAxLjAxdi4wMjVjMCAuNDQzLS40NjQuNDY0LTEuNjE5LjU4OC0xLjI3LjEzNi0yLjQ4NC41MTUtMi40ODQgMS45OSAwIDEuMjg3Ljk0MiAxLjk2OSAyLjE5IDEuOTY5Wm0uNDAxLTEuMTMzYy0uNjQ0IDAtMS4xMDQtLjI5NC0xLjEwNC0uODYgMC0uNTkzLjUxNi0uODQgMS4yMDYtLjkzOC40MDUtLjA1NiAxLjIxNC0uMTU4IDEuNDE1LS4zMnYuNzcxYzAgLjczLS41ODggMS4zNDctMS41MTcgMS4zNDdaTTExMS45MSAxNi42NzNjMC0uOTQ2LjU3MS0xLjQ5MSAxLjM4NS0xLjQ5MS43OTcgMCAxLjI3NC41MjQgMS4yNzQgMS4zOTd2My45M2gxLjU0M1YxNi4zNGMuMDA0LTEuNTY4LS44OTEtMi40NjMtMi4yNDItMi40NjMtLjk4IDAtMS42NTMuNDY5LTEuOTUyIDEuMTk3aC0uMDc2di0xLjExMmgtMS40NzV2Ni41NDZoMS41NDN2LTMuODM2WiIgZmlsbD0iI2ZmZiIvPjwvc3ZnPg==');" onclick="window.open('https://www.postman.com/satusehat/workspace/satusehat-public/overview', '_blank');"></div></td>
    </tr>
</table>

### 2. Lahir Hidup
####  <div id="SearchPatientPractitionerOrganizationPerinatal"> Step 1. Pencarian data pasien, nakes, dan fasyankes</div>

<div style="margin-left: 30px;">
Karena data pasien di dalam SATUSEHAT sudah terdaftar lebih dulu di *Master Patient Index* (MPI) Kementerian Kesehatan, sehingga registrasi data pasien baru tidak diperlukan. Dengan demikian maka entry data untuk resource Patient tidak perlu diikutsertakan dalam bundle data yang dikirim. 

Disamping itu, data Fasyankes yang melaporkan kasus kematian anak juga tidak perlu dikirimkan data alamat seperti provinsi, dan kabupaten/kota karena data sudah tersedia pada *Master Sarana Index* yang ada di SATUSEHAT, begitu juga dengan identitas data nakes yang mengisi data laporan kematian tersebut juga tidak perlu dikirimkan karena sudah tersedia di *Master Nakes Index* yang ada di SATUSEHAT. 

Proses pencarian data pasien (baik untuk anak dan juga ibu), nakes, dan fasyankes dapat dilakukan melalui FHIR API dengan metode GET dengan parameter dibawah ini:

| No  | Data        | Resource      | Parameter Pencarian       |
| --- |------------ | ------------- | --------------------------|
| 1   | Pasien (Anak)      | Patient       | NIK Ibu, Pasien SATUSEHAT Number    |
| 1   | Pasien (Ibu)      | Patient       | NIK, Pasien SATUSEHAT Number    |
| 2   | Nakes       | Practitioner  | NIK, Nakes SATUSEHAT Number     |
| 3   | Fasyankes   | Organization  | Fasyankes SATUSEHAT Number      |

> `CATATAN:`
>  Untuk metode pencarian data pasien, nakes, dan fasyankes di SATUSEHAT secara detail dapat dilihat dalam dokumen <a href="https://docs.google.com/document/d/1wGsuxUJcmWsGhTdAthe0pmcnsqtggLlQdFUG5fU4_T4/edit#heading=h.4fzggw2guay3" target="_blank">Petunjuk Teknis SATUSEHAT (Juknis SATSET)</a>.


Output yang didapatkan dari hasil pencarian ini adalah serangkaian JSON yang didalamnya terdapat kolom "id". Id tersebut selanjutnya akan dilampirkan pada data-data form pelaporan kematian di step berikutnya.

| No  | Data        | Contoh Id Resource | Disimpan pada Resource    |
| --- |------------ | -------------             |-------------              |
| 1   | Pasien (Anak)     | <font style="background: #E1D5E7">Patient/[PATIENT_IHS_NUMBER] </font>     |<font style="background: #E1D5E7"> Observation.subject</font>, <font style="background: #E1D5E7"> Condition.subject</font>, <font style="background: #E1D5E7"> Composition.subject</font>, <font style="background: #E1D5E7">Composition.section.focus</font>| 
| 2   | Pasien (Ibu)     | <font style="background: #FFF2CC">Patient/[PATIENT_IHS_NUMBER] </font>     | <font style="background: #FFF2CC"> Observation.subject</font>, <font style="background: #FFF2CC"> Condition.subject</font>, <font style="background: #FFF2CC"> Composition.section.focus </font>   | 
| 3   | Nakes       | <font style="background: #DAE8FC"> Practitioner/[DOCTOR_IHS_NUMBER] </font>   | <font style="background: #DAE8FC"> Observation.performer</font>, <font style="background: #DAE8FC">Condition.recorder</font>, <font style="background: #DAE8FC"> Composition.author </font>      |
| 4   | Fasyankes   | <font style="background: #D5E8D4">Organization/[FACILITY_IHS_NUMBER] </font> |   <font style="background: #D5E8D4">Observation.performer</font>, <font style="background: #D5E8D4">Composition.attester </font>     |

Contoh lampiran data pasien, nakes, dan fasyankes pada resource **Observation**:
<pre style="background: #F6F8F8;border: 1px solid #e8edee; color: black;">
{
    "resourceType": "Observation",
    <font style="background: #E1D5E7"> "subject"</font> : {
        <font style="background: #E1D5E7">"reference" : "Patient/100000030009"</font>,
        "display": "Baby of Teresa Lee (Fetus Not Named)"
    },
    "performer":  [
        {
            <font style="background: #DAE8FC">"reference": "Practitioner/N10000001"</font>,
            "display": "Dokter Bronsig"
        },
        {
            <font style="background: #D5E8D4">"reference" : "Organization/abddd50b-b22f-4d68-a1c3-d2c29a27698b"</font>,
            "display" : "Puskesmas Ibu Anak"
        }
    ]
    ...
    ...
    ...
}
</pre>

Contoh lampiran data pasien, nakes, dan fasyankes pada resource **Condition**:
<pre style="background: #F6F8F8;border: 1px solid #e8edee; color: black;">
{
    "resourceType": "Condition",
    <font style="background: #E1D5E7"> "subject"</font> : {
        <font style="background: #E1D5E7">"reference" : "Patient/100000030009"</font>,
        "display": "Baby of Teresa Lee (Fetus Not Named)"
    },
     <font style="background: #DAE8FC">"recorder"</font>:  {
        <font style="background: #DAE8FC">"reference": "Practitioner/N10000001"</font>,
        "display": "Dokter Bronsig"
    }
    ...
    ...
    ...
}
</pre>

Contoh lampiran data pasien, nakes, dan fasyankes pada resource **Composition**:
<pre style="background: #F6F8F8;border: 1px solid #e8edee; color: black;">
{
    "resourceType" : "Composition",
    "identifier" : {
        "system": "https://mpdn.kemkes.go.id/nmrkasus_kodeunik",
        "value" : "2361720002"
    },
    "status" : "final",
    "type" : {
        "coding" : [
            {
                "system" : "http://fhir.org/guides/who/ikp-cds/CodeSystem/ikp-custom-codes",
                "code" : "IKP.SS",
                "display" : "Indonesia standard report of perinatal death notification - MPDN version"
            }
        ]
    },
    <font style="background: #E1D5E7"> "subject"</font> : {
        <font style="background: #E1D5E7">"reference" : "Patient/100000030009"</font>,
        "display": "Baby of Teresa Lee (Fetus Not Named)"
    },
    "date" : "2022-12-01T02:46:13-05:00",
    <font style="background: #DAE8FC">"author"</font> : [
        {
            <font style="background: #DAE8FC">"reference" : "Practitioner/N10000001"</font>,
            "display": "Dokter Bronsig"
        }
    ],
    "title" : "Notifikasi Kematian Perinatal",
    <font style="background: #D5E8D4">"attester"</font> : [
        {
            "mode" : "legal",
            "party" : {
                <font style="background: #D5E8D4">"reference" : "Organization/abddd50b-b22f-4d68-a1c3-d2c29a27698b"</font>,
                "display" : "Puskesmas Ibu Anak"
            }
        }
    ],
    "section" : [
        {
            "title" : "Riwayat Kematian Anak",
            <font style="background: #E1D5E7"> "focus" </font>: {
                <font style="background: #E1D5E7"> "reference" : "Patient/100000030009" </font>,
                "display": "Baby of Teresa Lee (Fetus Not Named)"
            },
            ...
            ...
            ...
        },
        {
            "title" : "Riwayat Persalinan",
            <font style="background: #E1D5E7"> "focus" </font>: {
                <font style="background: #E1D5E7"> "reference" : "Patient/100000030009" </font>,
                "display": "Baby of Teresa Lee (Fetus Not Named)"
            },
            ...
            ...
            ...
        },
        {
            "title" : "Riwayat Kehamilan",
             <font style="background: #FFF2CC"> "focus"  </font>: {
                <font style="background: #FFF2CC"> "reference" : "Patient/P02280547535" </font>, 
                "display": "Patient - Mother (Teresa Lee)"
            },
            ...
            ...
            ...
        },
        {
            "title" : "Data Dasar Ibu",
            <font style="background: #FFF2CC"> "focus"  </font>: {
                <font style="background: #FFF2CC"> "reference" : "Patient/P02280547535" </font>,
                "display": "Patient - Mother (Teresa Lee)"
            },
            ...
            ...
            ...
        }
    ] 
}
</pre>
</div>

#### <div id="PerinatalDeathNotification"> Step 2. Pengiriman notifikasi pelaporan kematian anak</div>

<!-- Indent margin-left 30px-->
<div style="margin-left: 30px;">
Pada dasarnya di step-2 ini akan dilakukan 1 kali pengiriman data ke server SATUSEHAT dengan menggunakan resource Bundle tipe "Transaction". Berikut data-data yang akan dimasukkan ke dalam resource Bundle:<br>

> `CATATAN:`
> Catatan riwayat kematian dan persalinan akan mereferensi ke *Patient.id* sang anak, sedangkan data kehamilan dan data dasar ibu akan mereferensi ke data ibunya dengan patokan referensi pada kolom Observation.subject dan juga Composition.section.focus. Dalam hal ini, ID Pasien yang mana merupakan SatuSehat Number akan menjadi kode unik yang digunakan untuk menghubungkan catatan medis sesuai dengan data pasien yang terkait.
</div>
<!--END Indent margin-left 30px-->


<!--Part 2.1.-->
<h4 style="margin-left: 30px;">2.1. Pendaftaran Kunjungan Pasien</h4>
<div style="margin-left: 60px;">
<p>
Kunjungan pasien dapat didefinisikan sebagai interaksi pasien terhadap suatu layanan fasyankes. Sebagai contoh, dalam satu rangkaian rawat jalan, seluruh rangkaian dapat didefinisikan sebagai satu Encounter. Data-data kunjungan pasien yang direkam meliputi kapan pertemuan tersebut mulai dan selesai, siapa tenaga kesehatan yang melayani, siapa subjek dari pelayanannya, dan informasi pendukung lainnya.
</p>

<h4 style="font-weight: bold;">Pencarian Kunjungan Sebelumnya</h4>
Apabila kasus kematian yang dilaporkan bersumber dari data kunjungan *existing*, maka akan dilakukan proses pencarian data Encounter, yang dapat dilakukan melalui FHIR API dengan metode GET. Untuk metode pencarian data kunjungan di SATUSEHAT secara detail dapat dilihat dalam dokumen <a href="https://docs.google.com/document/d/1wGsuxUJcmWsGhTdAthe0pmcnsqtggLlQdFUG5fU4_T4/edit#heading=h.yqn6u1jxip9e">Petunjuk Teknis SATUSEHAT (Juknis SATSET)</a>.

<h4 style="font-weight: bold;">Pembuatan Kunjungan Baru</h4>

<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-2-1-post-encounter" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-2-1-post-encounter" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-2-1-post-encounter" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-2-1-post-encounter" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-2-1-post-encounter">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:example/MortalityRecord/Encounter-Create-Pembuatan-Kunjungan-Baru-1.json}}
        </div>
    </div>
    
    <div role="tabpanel" class="tab-pane" id="data-2-1-post-encounter">
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Encounter",
    "identifier": [
        {
            "system": "http://sys-ids.kemkes.go.id/encounter/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;ENCOUNTER_LOCAL_CODE&rcub;&rcub;</strong>"
        },
        {
            "system": "http://sys-ids.kemkes.go.id/mpdn/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;MPDN_NO_KASUS&rcub;&rcub;</strong>"
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
		
<div role="tabpanel" class="tab-pane" id="variabel-2-1-post-encounter" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __ENCOUNTER_LOCAL_CODE__   | ID Lokal untuk Kunjungan/Encounter |
| __MPDN_NO_KASUS__   | No kasus MPDN |
| __PATIENT_IHS_NUMBER__     | SATUSEHAT ID Number untuk Pasien |
| __PATIENT_NAME__           | Nama Pasien |
| __DOCTOR_IHS_NUMBER__      | SATUSEHAT ID untuk Dokter/Nakes |
| __DOCTOR_NAME__            | Nama Dokter/Nakes |
| __FACILITY_IHS_NUMBER__    | SATUSEHAT ID untuk FASYANKES |
| __ENCOUNTER_PERIOD1_START__| Waktu mulai/check-in kunjungan |
| __ENCOUNTER_PERIOD1_END__  | Waktu mulai/check-out kunjungan |
| __ENCOUNTER_LOCATION_ID__  | ID Location tempat kunjungan dilakukan |
| __ENCOUNTER_LOCATION_NAME__| Nama Location tempat kunjungan dilakukan |				| Usia pasien ketika meninggal (dalam tahun) |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-2-1-post-encounter" style="border: 1px solid #e8edee; padding: 15px 10px;">
			<div>
				[none]
			</div>
		</div>
	</div>
	</div>
<br>
<!--Part 2.1.-->

<!--Part 2.2.-->
<h4 style="margin-left: 30px;">2.2. Riwayat Kematian </h4>

<!--Variable riwayat kematian-->
<div style="margin-left: 60px;">
<h4 style="font-weight: bold;">Dugaan Sebab Kematian</h4>

<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-p-2-1-1-4" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-p-2-1-1-4" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-p-2-1-1-4" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-p-2-1-1-4" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-p-2-1-1-4">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:example-MortalityRecord-Condition-Create-Dugaan-Sebab-Kematian-2}}
        </div>
    </div>
    
    <div role="tabpanel" class="tab-pane" id="data-p-2-1-1-4">
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "identifier":  [
        {
            "system": "http://sys-ids.kemkes.go.id/observation/1000004",
            "value": "O111111"
        }
    ],
    "status": "final",
    "category":  [
        {
            "coding":  [
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
				"system" : "http://terminology.kemkes.go.id/CodeSystem/clinical-term",
				"code" : "OC000033",
				"display" : "Dugaan Sebab Kematian"
			}
        ]
    },
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>",
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "encounter": {
        "reference": "Encounter/45e436ea-d6c7-4059-8cbe-e00fb2c665d8"
    },
    "effectiveDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_EFFECTIVE_DATETIME&rcub;&rcub;</strong>",
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer": [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_IHS_NUMBER&rcub;&rcub;</strong>",
            "display": "<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_NAME&rcub;&rcub;</strong>"
        },
        {
            "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "display": "<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_NAME&rcub;&rcub;</strong>"
        }
    ],
    "valueCodeableConcept" : {
        "coding" : [
            {
                "system": "http://snomed.info/sct",
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;VALUE_OBSERVATION_CODE&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;VALUE_OBSERVATION_DISPLAY&rcub;&rcub;</strong>"
            }
        ]
    }
}
		</pre>
	</div>
		
<div role="tabpanel" class="tab-pane" id="variabel-p-2-1-1-4" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __CONDITION_VALUE_CODE__     | __(*)__ Kode data dugaan sebab kematian |
| __CONDITION_VALUE_DISPLAY__ | __(*)__ Deskripsi data dugaan sebab kematian |
| __PATIENT_IHS_NUMBER__      | SATUSEHAT ID Number untuk Pasien |
| __PATIENT_NAME__           | Nama Pasien |
| __CONDITION_ONSET_DATETIME__ | Tanggal perkiraan atau tanggal aktual atau tanggal-waktu kondisi mulai, menurut pendapat dokter.|
| __CONDITION_RECORDED_DATETIME__ | 	Tanggal kapan kondisi/keluhan ini tercatat dalam sistem (tanggal yang dibuat oleh sistem)|
| __DOCTOR_IHS_NUMBER__    | SATUSEHAT ID untuk Dokter/Nakes |
| __DOCTOR_NAME__            | Nama Dokter/Nakes |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-p-2-1-1-4" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Jenis Data                       | URL Kamus Terminology |
| ------------------------------ | --------- |
| __Dugaan sebab kematian__   | #tba |
</div>
</div>
<!-- END Tab panes -->
<br>

<h4 style="font-weight: bold;">Usia Ketika Meninggal</h4>
	
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-p-2-1-1-8" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-p-2-1-1-8" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-p-2-1-1-8" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-p-2-1-1-8" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-p-2-1-1-8">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:example-MortalityRecord-Observation-Create-Age-At-Death-2}}
        </div>
    </div>
    
    <div role="tabpanel" class="tab-pane" id="data-p-2-1-1-8">
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "identifier": [
        {
            "system": "http://sys-ids.kemkes.go.id/observation/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_LOCAL_CODE&rcub;&rcub;</strong>"
        }
    ],
    "status": "final",
    "category":  [
        {
            "coding":  [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "survey",
                    "display": "Survey"
                }
            ]
        }
    ],
    "code": {
        "coding":  [
            {
                "system": "http://loinc.org",
                "code": "39016-1",
                "display": "Age at death"
            }
        ]
    },
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>",
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "effectiveDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_EFFECTIVE_DATETIME&rcub;&rcub;</strong>",
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer":  [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_IHS_NUMBER&rcub;&rcub;</strong>",
            "display": "<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_NAME&rcub;&rcub;</strong>"
        },
        {
            "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "display": "<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_NAME&rcub;&rcub;</strong>"
        }
    ],
    "component":  [
        {
            "code": {
                "coding":  [
                    {
                        "system": "http://hl7.org/fhir/ValueSet/age-units",
                        "code": "a",
                        "display": "year"
                    }
                ]
            },
            "valueQuantity": {
                "value": <strong style="color:#00a7ff">&lcub;&lcub;VALUE1_OBSERVATION&rcub;&rcub;</strong>,
                "unit": "year",
                "system": "http://unitsofmeasure.org",
                "code": "a"
            }
        },
        {
            "code": {
                "coding":  [
                    {
                        "system": "http://hl7.org/fhir/ValueSet/age-units",
                        "code": "mo",
                        "display": "month"
                    }
                ]
            },
            "valueQuantity": {
                "value": <strong style="color:#00a7ff">&lcub;&lcub;VALUE2_OBSERVATION&rcub;&rcub;</strong>,
                "unit": "month",
                "system": "http://unitsofmeasure.org",
                "code": "mo"
            }
        },
        {
            "code": {
                "coding":  [
                    {
                        "system": "http://hl7.org/fhir/ValueSet/age-units",
                        "code": "d",
                        "display": "day"
                    }
                ]
            },
            "valueQuantity": {
                "value": <strong style="color:#00a7ff">&lcub;&lcub;VALUE3_OBSERVATION&rcub;&rcub;</strong>,
                "unit": "day",
                "system": "http://unitsofmeasure.org",
                "code": "d"
            }
        },
        {
            "code": {
                "coding":  [
                    {
                        "system": "http://hl7.org/fhir/ValueSet/age-units",
                        "code": "h",
                        "display": "hour"
                    }
                ]
            },
            "valueQuantity": {
                "value": <strong style="color:#00a7ff">&lcub;&lcub;VALUE4_OBSERVATION&rcub;&rcub;</strong>,
                "unit": "hour",
                "system": "http://unitsofmeasure.org",
                "code": "h"
            }
        },
        {
            "code": {
                "coding":  [
                    {
                        "system": "http://hl7.org/fhir/ValueSet/age-units",
                        "code": "min",
                        "display": "minute"
                    }
                ]
            },
            "valueQuantity": {
                "value": <strong style="color:#00a7ff">&lcub;&lcub;VALUE5_OBSERVATION&rcub;&rcub;</strong>,
                "unit": "minute",
                "system": "http://unitsofmeasure.org",
                "code": "min"
            }
        }
    ]
}
		</pre>
	</div>
		
<div role="tabpanel" class="tab-pane" id="variabel-p-2-1-1-8" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __FACILITY_IHS_NUMBER__   			| SATUSEHAT ID untuk FASYANKES |
| __FACILITY_NAME__           			| Nama FASYANKES |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| SATUSEHAT ID Number untuk Pasien |
| __PATIENT_NAME__           			| Nama Pasien 	|
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __DOCTOR_IHS_NUMBER__    				| SATUSEHAT ID untuk Dokter/Nakes |
| __DOCTOR_NAME__           			| Nama Dokter/Nakes |
| __VALUE1_OBSERVATION__					| Usia pasien ketika meninggal (dalam tahun) |
| __VALUE2_OBSERVATION__					| Usia pasien ketika meninggal (dalam bulan) |
| __VALUE3_OBSERVATION__					| Usia pasien ketika meninggal (dalam hari) |
| __VALUE4_OBSERVATION__					| Usia pasien ketika meninggal (dalam jam) |
| __VALUE5_OBSERVATION__					| Usia pasien ketika meninggal (dalam menit) |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-p-2-1-1-8" style="border: 1px solid #e8edee; padding: 15px 10px;">
			<div>
				[none]
			</div>
		</div>
	</div>
<!-- END Tab panes -->
<br>

<h4 style="font-weight: bold;">Berat Saat Meninggal</h4>
	
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-p-2-1-1-9" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-p-2-1-1-9" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-p-2-1-1-9" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-p-2-1-1-9" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-p-2-1-1-9">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:example-MortalityRecord-Observation-Create-BodyWeight-At-Death-1}}
        </div>
    </div>
    
    <div role="tabpanel" class="tab-pane" id="data-p-2-1-1-9">
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "identifier": [
        {
            "system": "http://sys-ids.kemkes.go.id/observation/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_LOCAL_CODE&rcub;&rcub;</strong>"
        }
    ],
    "status": "final",
    "category":  [
        {
            "coding":  [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "survey",
                    "display": "Survey"
                }
            ]
        }
    ],
    "code": {
        "coding":  [
			{
                "system": "http://loinc.org",
                "code": "3141-9",
                "display": "Body weight Measured"
            }
        ]
    },
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>",
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "effectiveDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_EFFECTIVE_DATETIME&rcub;&rcub;</strong>",
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer":  [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_IHS_NUMBER&rcub;&rcub;</strong>",
            "display": "<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_NAME&rcub;&rcub;</strong>"
        },
        {
            "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "display": "<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_NAME&rcub;&rcub;</strong>"
        }
    ],
	"valueQuantity": {
        "value": <strong style="color:#00a7ff">&lcub;&lcub;VALUE_OBSERVATION&rcub;&rcub;</strong>,
        "unit": "gram",
        "system": "http://unitsofmeasure.org",
        "code": "g"
    }
}
		</pre>
	</div>
		
<div role="tabpanel" class="tab-pane" id="variabel-p-2-1-1-9" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __FACILITY_IHS_NUMBER__   			| SATUSEHAT ID untuk FASYANKES |
| __FACILITY_NAME__           			| Nama FASYANKES |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| SATUSEHAT ID Number untuk Pasien |
| __PATIENT_NAME__           			| Nama Pasien 	|
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __DOCTOR_IHS_NUMBER__    				| SATUSEHAT ID untuk Dokter/Nakes |
| __DOCTOR_NAME__           			| Nama Dokter/Nakes |
| __VALUE_OBSERVATION__					| Berat badan pasien saat meninggal (dalam gram) |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-p-2-1-1-9" style="border: 1px solid #e8edee; padding: 15px 10px;">
			<div>
				[none]
			</div>
		</div>
	</div>
<!-- END Tab panes -->
<br>

<h4 style="font-weight: bold;">Jenis Kematian</h4>
	
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-p-2-1-1-10" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-p-2-1-1-10" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-p-2-1-1-10" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-p-2-1-1-10" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-p-2-1-1-10">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:example-MortalityRecord-Observation-Create-Jenis-Kematian-1}}
        </div>
    </div>
    
    <div role="tabpanel" class="tab-pane" id="data-p-2-1-1-10">
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "identifier": [
        {
            "system": "http://sys-ids.kemkes.go.id/observation/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_LOCAL_CODE&rcub;&rcub;</strong>"
        }
    ],
    "status": "final",
    "category":  [
        {
            "coding":  [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "survey",
                    "display": "Survey"
                }
            ]
        }
    ],
    "code": {
        "coding":  [
			{
                "system": "http://loinc.org",
                "code": "64710-7",
                "display": "Was your pregnancy a live birth, stillbirth, miscarriage, abortion, or ectopic pregnancy [PhenX]"
            }
        ]
    },
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>",
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "effectiveDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_EFFECTIVE_DATETIME&rcub;&rcub;</strong>",
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer":  [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_IHS_NUMBER&rcub;&rcub;</strong>",
            "display": "<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_NAME&rcub;&rcub;</strong>"
        },
        {
            "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "display": "<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_NAME&rcub;&rcub;</strong>"
        }
    ],
	"valueCodeableConcept": {
        "coding":  [
            {
                "system": "http://snomed.info/sct",
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;VALUE_OBSERVATION_CODE&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;VALUE_OBSERVATION_DISPLAY&rcub;&rcub;</strong>"
            }
        ]
    }
}
		</pre>
	</div>
		
<div role="tabpanel" class="tab-pane" id="variabel-p-2-1-1-10" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __FACILITY_IHS_NUMBER__   			| SATUSEHAT ID untuk FASYANKES |
| __FACILITY_NAME__           			| Nama FASYANKES |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| SATUSEHAT ID Number untuk Pasien |
| __PATIENT_NAME__           			| Nama Pasien 	|
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __DOCTOR_IHS_NUMBER__    				| SATUSEHAT ID untuk Dokter/Nakes |
| __DOCTOR_NAME__           			| Nama Dokter/Nakes |
| __VALUE_OBSERVATION_CODE__| __(*)__ Kode data jenis kematian |
| __VALUE_OBSERVATION_DISPLAY__| __(*)__ Deskripsi data jenis kematian |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-p-2-1-1-10" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Jenis Data                       | URL Kamus Terminology |
| ------------------------------ | --------- |
| __Jenis Kematian__   | #tba |

</div>
</div>
<!-- END Tab panes -->
<br>
</div>
<!--END Variable riwayat kematian-->
<!--END Part 2.1.-->


<!--Part 2.2.-->
<h4 style="margin-left: 30px;"> 2.2. Riwayat Persalinan </h4>
<h4 style="font-weight: bold;">Alamat Lahir</h4>	
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-p-2-1-2-3" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-p-2-1-2-3" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-p-2-1-2-3" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-p-2-1-2-3" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-p-2-1-2-3">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:example-MortalityRecord-Location-Create-Alamat-Lahir-1}}
        </div>
    </div>
    
    <div role="tabpanel" class="tab-pane" id="data-p-2-1-2-3">
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Location",
    "name": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_NAME&rcub;&rcub;</strong>",
    "type":  [
        {
            "coding":  [
                {
                    "system": "http://loinc.org",
                    "code": "21842-0",
                    "display": "Birthplace"
                }
            ]
        }
    ],
    "address": {
        "use": "home",
        "line":  [
            "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_ADDRESS&rcub;&rcub;</strong>"
        ],
        "city": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_CITY&rcub;&rcub;</strong>",
        "postalCode": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_POSTAL_CODE&rcub;&rcub;</strong>",
        "country": "ID",
        "extension":  [
            {
                "url": "https://fhir.kemkes.go.id/r4/StructureDefinition/administrativeCode",
                "extension":  [
                    {
                        "url": "province",
                        "valueCode": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_PROVINCE_CODE&rcub;&rcub;</strong>"
                    },
                    {
                        "url": "city",
                        "valueCode": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_CITY_CODE&rcub;&rcub;</strong>"
                    },
                    {
                        "url": "district",
                        "valueCode": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_DISTRICT_CODE&rcub;&rcub;</strong>"
                    },
                    {
                        "url": "village",
                        "valueCode": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_VILLAGE_CODE&rcub;&rcub;</strong>"
                    },
                    {
                        "url": "rt",
                        "valueCode": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_RT&rcub;&rcub;</strong>"
                    },
                    {
                        "url": "rw",
                        "valueCode": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_RW&rcub;&rcub;</strong>"
                    }
                ]
            }
        ]
    }
}
		</pre>
	</div>
		
<div role="tabpanel" class="tab-pane" id="variabel-p-2-1-2-3" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __LOCATION_NAME__   | Nama lokasi |
| __LOCATION_ADDRESS__   | Alamat lokasi tempat tinggal |
| __LOCATION_CITY__     | Nama kota |
| __LOCATION_POSTAL_CODE__ | Kode pos  |
| __LOCATION_PROVINCE_CODE__      | Kode provinsi berdasarkan kemendagri |
| __LOCATION_CITY_CODE__           | Kode kabupaten berdasarkan kemendagri |
| __LOCATION_DISTRICT_CODE__ | Kode kecamatan berdasarkan kemendagri	|
| __LOCATION_VILLAGE_CODE__ | Kode kelurahan berdasarkan kemendagri	|
| __LOCATION_RT__ | Nomor RT	|
| __LOCATION_RW__ | Nomor RW	|

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-p-2-1-2-3" style="border: 1px solid #e8edee; padding: 15px 10px;">
			<div>
				[none]
			</div>
		</div>
	</div>
<br>

<h4 style="font-weight: bold;">Jenis Tempat Bersalin</h4>	
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-p-2-1-2-4" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-p-2-1-2-4" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-p-2-1-2-4" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-p-2-1-2-4" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-p-2-1-2-4">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:example-MortalityRecord-Observation-Create-Jenis-Tempat-Bersalin-1}}
        </div>
    </div>
    
    <div role="tabpanel" class="tab-pane" id="data-p-2-1-2-4">
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "identifier":  [
        {
            "system": "http://sys-ids.kemkes.go.id/observation/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_LOCAL_CODE&rcub;&rcub;</strong>"
        }
    ],
    "status": "final",
    "code": {
        "coding":  [
            {
                "system": "#tba",
                "code": "#tba",
                "display": "Jenis Tempat Bersalin"
            }
        ]
    },
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>",
                    "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "effectiveDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_EFFECTIVE_DATETIME&rcub;&rcub;</strong>",
                "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer":  [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_IHS_NUMBER&rcub;&rcub;</strong>",
            "display": "<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_NAME&rcub;&rcub;</strong>"
        },
        {
            "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "display": "<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_NAME&rcub;&rcub;</strong>"
        }
    ],
    "valueCodeableConcept": {
        "coding":  [
            {
                "system": "http://snomed.info/sct",
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;VALUE_OBSERVATION_CODE&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;VALUE_OBSERVATION_DESCRIPTION&rcub;&rcub;</strong>"
            }
        ]
    }
}
		</pre>
	</div>
		
<div role="tabpanel" class="tab-pane" id="variabel-p-2-1-2-4" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __FACILITY_IHS_NUMBER__   | SATUSEHAT ID untuk FASYANKES |
| __FACILITY_NAME__           			| Nama FASYANKES |
| __OBSERVATION_LOCAL_CODE__     | ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      | SATUSEHAT ID Number untuk Pasien |
| __PATIENT_NAME__           | Nama Pasien |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __DOCTOR_IHS_NUMBER__    | SATUSEHAT ID untuk Dokter/Nakes |
| __DOCTOR_NAME__            | Nama Dokter/Nakes |
| __VALUE_OBSERVATION_CODE__| __(*)__ Kode data jenis tempat bersalin|
| __VALUE_OBSERVATION_DESCRIPTION__| __(*)__ Deskripsi data jenis tempat bersalin|

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-p-2-1-2-4" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Jenis Data                       | URL Kamus Terminology |
| ------------------------------ | --------- |
| __Jenis tempat bersalin__   | #tba |
</div>
</div>
<br>

<h4 style="font-weight: bold;">Lokasi Tempat Bersalin</h4>	
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-p-2-1-2-5" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-p-2-1-2-5" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-p-2-1-2-5" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-p-2-1-2-5" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-p-2-1-2-5">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:example-MortalityRecord-Location-Create-Lokasi-Tempat-Bersalin-1}}
        </div>
    </div>
    
    <div role="tabpanel" class="tab-pane" id="data-p-2-1-2-5">
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Location",
    "name": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_NAME&rcub;&rcub;</strong>",
    "type":  [
        {
            "coding":  [
                {
				  "system": "#tba",
				  "code": "#tba",
				  "display": "Place of birth delivery"
				}
            ]
        }
    ],
    "address": {
        "line":  [
            "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_ADDRESS&rcub;&rcub;</strong>"
        ],
        "city": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_CITY&rcub;&rcub;</strong>",
        "postalCode": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_POSTAL_CODE&rcub;&rcub;</strong>",
        "country": "ID",
        "extension":  [
            {
                "url": "https://fhir.kemkes.go.id/r4/StructureDefinition/administrativeCode",
                "extension":  [
                    {
                        "url": "province",
                        "valueCode": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_PROVINCE_CODE&rcub;&rcub;</strong>"
                    },
                    {
                        "url": "city",
                        "valueCode": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_CITY_CODE&rcub;&rcub;</strong>"
                    },
                    {
                        "url": "district",
                        "valueCode": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_DISTRICT_CODE&rcub;&rcub;</strong>"
                    },
                    {
                        "url": "village",
                        "valueCode": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_VILLAGE_CODE&rcub;&rcub;</strong>"
                    },
                    {
                        "url": "rt",
                        "valueCode": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_RT&rcub;&rcub;</strong>"
                    },
                    {
                        "url": "rw",
                        "valueCode": "<strong style="color:#00a7ff">&lcub;&lcub;LOCATION_RW&rcub;&rcub;</strong>"
                    }
                ]
            }
        ]
    }
}
		</pre>
	</div>
		
<div role="tabpanel" class="tab-pane" id="variabel-p-2-1-2-5" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __LOCATION_NAME__   | Nama lokasi |
| __LOCATION_ADDRESS__   | Alamat lokasi tempat meninggal |
| __LOCATION_CITY__     | Nama kota |
| __LOCATION_POSTAL_CODE__ | Kode pos  |
| __LOCATION_PROVINCE_CODE__      | Kode provinsi berdasarkan kemendagri |
| __LOCATION_CITY_CODE__           | Kode kabupaten berdasarkan kemendagri |
| __LOCATION_DISTRICT_CODE__ | Kode kecamatan berdasarkan kemendagri	|
| __LOCATION_VILLAGE_CODE__ | Kode kelurahan berdasarkan kemendagri	|
| __LOCATION_RT__ | Nomor RT	|
| __LOCATION_RW__ | Nomor RW	|

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-p-2-1-2-5" style="border: 1px solid #e8edee; padding: 15px 10px;">
		<div>
			[none]
		</div>
	</div>
</div>
<br>

<h4 style="font-weight: bold;">Urutan Kelahiran (apabila kembar)</h4>	
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-p-2-1-2-6" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-p-2-1-2-6" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-p-2-1-2-6" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-p-2-1-2-6" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-p-2-1-2-6">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:example-MortalityRecord-Observation-Create-Urutan-Kelahiran-1}}
        </div>
    </div>
    
    <div role="tabpanel" class="tab-pane" id="data-p-2-1-2-6">
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
    "identifier": [
        {
            "system": "http://sys-ids.kemkes.go.id/observation/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_LOCAL_CODE&rcub;&rcub;</strong>"
        }
    ],
    "status": "final",
    "category":  [
        {
            "coding":  [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "survey",
                    "display": "Survey"
                }
            ]
        }
    ],
    "code": {
        "coding":  [
			{
                "system": "http://loinc.org",
                "code": "73771-8",
                "display": "Birth order"
            }
        ]
    },
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>",
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "effectiveDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_EFFECTIVE_DATETIME&rcub;&rcub;</strong>",
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer":  [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_IHS_NUMBER&rcub;&rcub;</strong>",
            "display": "<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_NAME&rcub;&rcub;</strong>"
        },
        {
            "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "display": "<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_NAME&rcub;&rcub;</strong>"
        }
    ],
    "valueInteger": <strong style="color:#00a7ff">&lcub;&lcub;VALUE_OBSERVATION&rcub;&rcub;</strong>
}
		</pre>
	</div>
		
<div role="tabpanel" class="tab-pane" id="variabel-p-2-1-2-6" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __FACILITY_IHS_NUMBER__   			| SATUSEHAT ID untuk FASYANKES |
| __FACILITY_NAME__           			| Nama FASYANKES |
| __OBSERVATION_LOCAL_CODE__    		| ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      			| SATUSEHAT ID Number untuk Pasien |
| __PATIENT_NAME__           			| Nama Pasien 	|
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __DOCTOR_IHS_NUMBER__    				| SATUSEHAT ID untuk Dokter/Nakes |
| __DOCTOR_NAME__           			| Nama Dokter/Nakes |
| __VALUE_OBSERVATION__					| Urutan kelahiran (apabila kembar)|

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-p-2-1-2-6" style="border: 1px solid #e8edee; padding: 15px 10px;">
		<div>
			[none]
		</div>
	</div>
</div>
<br>
</div>
<!--END Variable riwayat persalinan-->
<!--END Part 2.2.-->

<!--Part 2.3.-->
<h4 style="margin-left: 30px;"> 3.3. Riwayat Kehamilan </h4>

<!--Variable riwayat Kehamilan-->
<div style="margin-left: 60px;">
<h4 style="font-weight: bold;">Kehamilan Tunggal/Kembar</h4>	
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-p-2-1-3-3" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-p-2-1-3-3" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-p-2-1-3-3" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-p-2-1-3-3" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-p-2-1-3-3">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:example-MortalityRecord-Observation-Create-Birth-Plurality-Of-Pregnancy}}
        </div>
    </div>
    
    <div role="tabpanel" class="tab-pane" id="data-p-2-1-3-3">
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType": "Observation",
	"identifier": [
        {
            "system": "http://sys-ids.kemkes.go.id/observation/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "value": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_LOCAL_CODE&rcub;&rcub;</strong>"
        }
    ],
    "status": "final",
    "category":  [
        {
            "coding":  [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                    "code": "survey",
                    "display": "Survey"
                }
            ]
        }
    ],
    "code": {
        "coding":  [
			{
                "system": "http://loinc.org",
                "code": "57722-1",
                "display": "Birth plurality of Pregnancy"
            }
        ]
    },
    "subject": {
        "reference": "Patient/<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_IHS_NUMBER&rcub;&rcub;</strong>",
        "display": "<strong style="color:#00a7ff">&lcub;&lcub;PATIENT_NAME&rcub;&rcub;</strong>"
    },
    "effectiveDateTime": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_EFFECTIVE_DATETIME&rcub;&rcub;</strong>",
    "issued": "<strong style="color:#00a7ff">&lcub;&lcub;OBSERVATION_ISSUED&rcub;&rcub;</strong>",
    "performer":  [
        {
            "reference": "Practitioner/<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_IHS_NUMBER&rcub;&rcub;</strong>",
            "display": "<strong style="color:#00a7ff">&lcub;&lcub;DOCTOR_NAME&rcub;&rcub;</strong>"
        },
        {
            "reference": "Organization/<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_IHS_NUMBER&rcub;&rcub;</strong>",
            "display": "<strong style="color:#00a7ff">&lcub;&lcub;FACILITY_NAME&rcub;&rcub;</strong>"
        }
    ],
    "valueCodeableConcept": {
        "coding":  [
            {
                "system": "http://snomed.info/sct",
                "code": "<strong style="color:#00a7ff">&lcub;&lcub;VALUE_OBSERVATION_CODE&rcub;&rcub;</strong>",
                "display": "<strong style="color:#00a7ff">&lcub;&lcub;VALUE_OBSERVATION_DISPLAY&rcub;&rcub;</strong>"
            }
        ]
    }
}
		</pre>
	</div>
		
<div role="tabpanel" class="tab-pane" id="variabel-p-2-1-3-3" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __FACILITY_IHS_NUMBER__   | SATUSEHAT ID untuk FASYANKES |
| __FACILITY_NAME__           			| Nama FASYANKES |
| __OBSERVATION_LOCAL_CODE__     | ID Lokal untuk Observasi  |
| __PATIENT_IHS_NUMBER__      | SATUSEHAT ID Number untuk Pasien |
| __PATIENT_NAME__           | Nama Pasien |
| __OBSERVATION_EFFECTIVE_DATETIME__ 	| Tanggal dan waktu nilai observasi yang diamati dinyatakan benar |
| __OBSERVATION_ISSUED__ 				| Tanggal dan waktu versi observasi ini tersedia, biasanya setelah hasilnya ditinjau/direview dan diverifikasi|
| __DOCTOR_IHS_NUMBER__    | SATUSEHAT ID untuk Dokter/Nakes |
| __DOCTOR_NAME__            | Nama Dokter/Nakes |
| __VALUE_OBSERVATION_CODE__| __(*)__ Kode data kehamilan tunggal/kembar |
| __VALUE_OBSERVATION_DISPLAY__| __(*)__ Deskripsi data kehamilan tunggal/kembar |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-p-2-1-3-3" style="border: 1px solid #e8edee; padding: 15px 10px;">

| Jenis Data                       | URL Kamus Terminology |
| ------------------------------ | --------- |
| __Kehamilan tunggal/kembar__   | #tba |
</div>
</div>
<br>
</div>
<!--END Variable riwayat Kehamilan-->
<!--END Part 2.3.-->

<!--Part 2.2-->
<h4 style="margin-left: 30px;">2.5. Form laporan kematian Anak</h4>

<div style="margin-left: 60px;">
Pada use-case pelaporan kematian Anak, resource Composition akan digunakan sebagai penghubung antara satu resource dengan resource lainnya. Composition akan menghubungkan data-data seperti tanggal meninggal, siapa bayi yang meninggal, siapa tenaga kesehatan yang melaporkan, dan informasi pendukung lainnya.<br>
Composition hanya menyimpan metadata resource yg berbentuk sebuah ID, misalnya kolom id pada resource Observation (Observation.id), resource Condition (Condition.id), dan resource pendukung lainnya. Resource Composition akan mereferensi ke data riwayat kematian (step 2.1.), riwayat persalinan (step 2.2.), riwayat kehamilan (step 2.3.), dan data dasar Ibu (step 2.4.)

<!--Variable Form Pelaporan Kematian Anak-->
<h4 style="font-weight: bold;">Composition Form Pelaporan Kematian Anak</h4>	
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-p-2-2" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-p-2-2" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-p-2-2" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-p-2-2" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-p-2-2">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:example/MortalityRecord/Encounter-Create-Composition-Create-Perinatal-Death-Lahir-Hidup.json}}
        </div>
    </div>
    
    <div role="tabpanel" class="tab-pane" id="data-p-2-2">
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
        </pre>
	</div>
		
<div role="tabpanel" class="tab-pane" id="variabel-p-2-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __COMPOSITION_LOCAL_CODE__   			| ID Lokal untuk Composition|
| __PATIENT_IHS_NUMBER__      			| SATUSEHAT ID Number untuk Pasien |
| __PATIENT_NAME__           			| Nama Pasien 	|
| __COMPOSITION_RECORD_DATETIME__       | Tanggal form ini dikirimkan ke (tanggal yang dibuat oleh sistem)|
| __DOCTOR_IHS_NUMBER__    				| SATUSEHAT ID untuk Dokter/Nakes |
| __DOCTOR_NAME__           			| Nama Dokter/Nakes |
| __FACILITY_IHS_NUMBER__   | SATUSEHAT ID untuk FASYANKES |
| __FACILITY_NAME__           			| Nama FASYANKES |
| __OBSERVATION1_FHIR_ID__    		| Observation ID data usia ketika meninggal (tahun) |
| __OBSERVATION2_FHIR_ID__    		| Observation ID data tanggal meninggal |
| __OBSERVATION3_FHIR_ID__    		| Observation ID data masa terjadi kematian ibu |
| __OBSERVATION4_FHIR_ID__    		| Observation ID data jenis tempat meninggal |
| __OBSERVATION5_FHIR_ID__    		| Observation ID data gravida |
| __OBSERVATION6_FHIR_ID__    		| Observation ID data paritas |
| __OBSERVATION7_FHIR_ID__    		| Observation ID data abortus |
| __OBSERVATION8_FHIR_ID__    		| Observation ID data usia kehamilan (bulan) |
| __CONDITION1_FHIR_ID__    		| Condition ID data dugaan sebab kematian |
| __LOCATION1_FHIR_ID__    			| Location ID data lokasi meninggal |
| __LOCATION2_FHIR_ID__    			| Location ID data alamat domisili |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-p-2-2" style="border: 1px solid #e8edee; padding: 15px 10px;">
			<div>
				[none]
			</div>
		</div>
	</div>
<br>
</div>
<!--END Form Pelaporan Kematian Anak-->
<!--END Part 2.5.-->

<div style="margin-left: 30px;">
<h4>Setelah data pada step 2.1. - 2.5. sudah terbentuk, maka langkah selanjutnya adalah semua data akan dikirimkan secara bersamaan menggunakan resource Bundle dengan template dibawah ini:
</h4>

> `CATATAN:`
>  Bundle.entry adalah sebuah *Array*, yang bisa menampung lebih dari 1 data. Diisikan dengan semua data FHIR resource dalam format JSON yang sudah dibuat di part 2.1. - 2.5.

<h4 style="font-weight: bold;">Bundle Pengiriman Data Riwayat Kematian, Persalinan, Kehamilan, dan Data Dasar Ibu</h4>	
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-p-2-1-5" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-p-2-1-5" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-p-2-1-5" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-p-2-1-5" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-p-2-1-5">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:example-MortalityRecord-Bundle-Create-Perinatal-Death-1}}
        </div>
    </div>
    
    <div role="tabpanel" class="tab-pane" id="data-p-2-1-5">
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: maroon;">
{
    "resourceType" : "Bundle",
    "type" : "transaction",
    "entry" : [
        {
            "fullUrl" : "urn:uuid:<strong style="color:#00a7ff">&lcub;&lcub;BUNDLE_TEMPORARY_UUID&rcub;&rcub;</strong>",
            "resource" : <strong style="color:#00a7ff">&lcub;&lcub;BUNDLE_RESOURCE_VALUE&rcub;&rcub;</strong>,
            "request": {
                "method": "POST",
                "url": "<strong style="color:#00a7ff">&lcub;&lcub;BUNDLE_RESOURCE_URL_PATH&rcub;&rcub;</strong>"
            }
        }
    ]
}
		</pre>
	</div>
		
<div role="tabpanel" class="tab-pane" id="variabel-p-2-1-5" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>

| Variabel                       | Deskripsi |
| ------------------------------ | --------- |
| __BUNDLE_TEMPORARY_UUID__   			| Digunakan untuk mengidentifikasi resource yang ada di dalam bundle secara sementara. Dapat menggunakan uuid yang dapat di generate di <a href="https://www.uuidgenerator.net/" target="_blank">UUID generator</a>.<br>Setelah mendapat uuid, input dengan format: "urn:uuid:[uuid number]"<br>Contoh "fullUrl": "urn:uuid:ba5a7dec-023f-45e1-adb9-1b9d71737a5f"|
| __BUNDLE_RESOURCE_VALUE__           			| Isi dari resource yang ingin dikirim. |
| __BUNDLE_RESOURCE_URL_PATH__    		| Jenis tipe resource yang ingin dikirim  |

> `CATATAN:` <br>
> __(*)__: Jenis data yang memiliki terminologi spesifik. Kamus terminologi bisa ditemukan pada tab "ValueSet"
</div>
		</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-p-2-1-5" style="border: 1px solid #e8edee; padding: 15px 10px;">
			<div>
				[none]
			</div>
		</div>
	</div>
<br>
</div>

## D. Referensi:

<table style="background-color: #f6f8f8; border-radius: 10px;">
    <tr>
         <td style="padding: 10px 20px; width: 33%; vertical-align: top;">Postman Mortality Record</td>
        <td style="padding: 10px 20px; ; width: 33%; vertical-align: top;">Playbook Mortality Record</td>
        <td style="padding: 10px 20px; ; width: 33%; vertical-align: top;">Postman Resume Medis Rawat Jalan SatuSehat</td>
    </tr>
    <tr>
        <td style="padding: 10px 20px; ;"><div style="background-color: lightblue; display: inline-block; border-radius: 4px; cursor: pointer; height: 32px; border: none; width: 123px; background-image: url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTI4IiBoZWlnaHQ9IjMyIiBmaWxsPSJub25lIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxyZWN0IHdpZHRoPSIxMjgiIGhlaWdodD0iMzIiIHJ4PSI0IiBmaWxsPSIjRkY2QzM3Ii8+PHBhdGggZD0iTTEyIDEwLjg4M2EuNS41IDAgMCAxIC43NTctLjQyOWw4LjUyOCA1LjExN2EuNS41IDAgMCAxIDAgLjg1OGwtOC41MjggNS4xMTdhLjUuNSAwIDAgMS0uNzU3LS40M1YxMC44ODRaTTI3Ljg4OSAyMC41MDloMS41OHYtMy4xOTdoMS42MTFsMS43MTMgMy4xOTdoMS43NjRsLTEuODg3LTMuNDZjMS4wMjctLjQxNCAxLjU2OC0xLjI5MiAxLjU2OC0yLjQ3NyAwLTEuNjY2LTEuMDc0LTIuNzktMy4wNzctMi43OWgtMy4yNzN2OC43MjdaTTI5LjQ2OCAxNnYtMi44OThoMS40NWMxLjE4IDAgMS43MDguNTQxIDEuNzA4IDEuNDcgMCAuOTMtLjUyOCAxLjQyOC0xLjcgMS40MjhIMjkuNDdaTTM5Ljc5NyAxNy43NTZjMCAuOTk3LS43MTIgMS40OTEtMS4zOTQgMS40OTEtLjc0MSAwLTEuMjM1LS41MjQtMS4yMzUtMS4zNTV2LTMuOTI5aC0xLjU0M3Y0LjE2OGMwIDEuNTcyLjg5NSAyLjQ2MyAyLjE4MiAyLjQ2My45OCAwIDEuNjctLjUxNiAxLjk2OS0xLjI0OWguMDY4djEuMTY0aDEuNDk1di02LjU0NmgtMS41NDJ2My43OTNaTTQ0LjQ2OCAxNi42NzNjMC0uOTQ2LjU3MS0xLjQ5MSAxLjM4NS0xLjQ5MS43OTcgMCAxLjI3NC41MjQgMS4yNzQgMS4zOTd2My45M2gxLjU0M1YxNi4zNGMuMDA0LTEuNTY4LS44OS0yLjQ2My0yLjI0MS0yLjQ2My0uOTggMC0xLjY1NC40NjktMS45NTIgMS4xOTdINDQuNHYtMS4xMTJoLTEuNDc0djYuNTQ2aDEuNTQydi0zLjgzNlpNNTMuMjE1IDIwLjUwOWgxLjU0MnYtNi41NDZoLTEuNTQydjYuNTQ2Wm0uNzc1LTcuNDc1Yy40OSAwIC44OTEtLjM3NS44OTEtLjgzNSAwLS40NjUtLjQtLjg0LS44OS0uODQtLjQ5NSAwLS44OTUuMzc1LS44OTUuODQgMCAuNDYuNC44MzUuODk0LjgzNVpNNTcuODg2IDE2LjY3M2MwLS45NDYuNTcxLTEuNDkxIDEuMzg1LTEuNDkxLjc5NyAwIDEuMjc0LjUyNCAxLjI3NCAxLjM5N3YzLjkzaDEuNTQzVjE2LjM0Yy4wMDQtMS41NjgtLjg5LTIuNDYzLTIuMjQxLTIuNDYzLS45OCAwLTEuNjU0LjQ2OS0xLjk1MiAxLjE5N2gtLjA3N3YtMS4xMTJoLTEuNDc0djYuNTQ2aDEuNTQydi0zLjgzNlpNNjYuNzAxIDIwLjUwOWgxLjU4MXYtMi45NWgxLjY3YzIuMDE2IDAgMy4wOTgtMS4yMSAzLjA5OC0yLjg4OSAwLTEuNjY2LTEuMDctMi44ODktMy4wNzYtMi44ODlINjYuN3Y4LjcyOFptMS41ODEtNC4yNXYtMy4xNTdoMS40NDljMS4xODQgMCAxLjcwOS42NCAxLjcwOSAxLjU2OSAwIC45MjgtLjUyNSAxLjU4OS0xLjcgMS41ODloLTEuNDU4Wk03Ny4xMTcgMjAuNjM2YzEuOTE3IDAgMy4xMzYtMS4zNSAzLjEzNi0zLjM3NSAwLTIuMDI4LTEuMjE5LTMuMzgzLTMuMTM2LTMuMzgzLTEuOTE4IDAtMy4xMzYgMS4zNTUtMy4xMzYgMy4zODMgMCAyLjAyNCAxLjIxOCAzLjM3NSAzLjEzNiAzLjM3NVptLjAwOC0xLjIzNWMtMS4wNiAwLTEuNTgtLjk0Ny0xLjU4LTIuMTQ0cy41Mi0yLjE1NiAxLjU4LTIuMTU2YzEuMDQ0IDAgMS41NjQuOTU5IDEuNTY0IDIuMTU2cy0uNTIgMi4xNDQtMS41NjQgMi4xNDRaTTg2LjczNiAxNS42OTNjLS4yMTMtMS4xMDgtMS4xLTEuODE1LTIuNjM0LTEuODE1LTEuNTc2IDAtMi42NS43NzUtMi42NDYgMS45ODYtLjAwNC45NTQuNTg0IDEuNTg1IDEuODQgMS44NDVsMS4xMTcuMjM0Yy42MDEuMTMyLjg4My4zNzUuODgzLjc0NiAwIC40NDctLjQ4Ni43ODQtMS4yMi43ODQtLjcwNyAwLTEuMTY3LS4zMDctMS4yOTktLjg5NWwtMS41MDQuMTQ1Yy4xOTIgMS4yMDIgMS4yMDEgMS45MTMgMi44MDggMS45MTMgMS42MzYgMCAyLjc5MS0uODQ4IDIuNzk1LTIuMDg4LS4wMDQtLjkzMy0uNjA1LTEuNTA0LTEuODQtMS43NzJsLTEuMTE3LS4yNGMtLjY2NS0uMTQ4LS45MjktLjM3OC0uOTI1LS43NTgtLjAwNC0uNDQzLjQ4Ni0uNzUgMS4xMy0uNzUuNzExIDAgMS4wODYuMzg4IDEuMjA2LjgxOWwxLjQwNi0uMTU0Wk05MS40MTcgMTMuOTYzaC0xLjI5MXYtMS41NjhoLTEuNTQzdjEuNTY4aC0uOTI5djEuMTkzaC45M3YzLjY0Yy0uMDEgMS4yMzEuODg1IDEuODM2IDIuMDQ0IDEuODAyYTMuMSAzLjEgMCAwIDAgLjkwOC0uMTUzbC0uMjYtMS4yMDZjLS4wODUuMDItLjI2LjA2LS40NTEuMDYtLjM4OCAwLS43LS4xMzctLjctLjc2di0zLjM4M2gxLjI5MnYtMS4xOTNaTTkyLjcwNyAyMC41MDloMS41NDN2LTMuOThjMC0uODA2LjUzNy0xLjM1MSAxLjIwMS0xLjM1MS42NTIgMCAxLjEuNDM4IDEuMSAxLjExMnY0LjIxOWgxLjUxM3YtNC4wODNjMC0uNzM3LjQzOS0xLjI0OCAxLjE4NC0xLjI0OC42MjIgMCAxLjExNy4zNjYgMS4xMTcgMS4xNzZ2NC4xNTVoMS41NDd2LTQuMzk0YzAtMS40NjItLjg0NC0yLjIzNy0yLjA0Ni0yLjIzNy0uOTUgMC0xLjY3NS40NjktMS45NjQgMS4xOTdoLS4wNjljLS4yNTEtLjc0MS0uODg2LTEuMTk3LTEuNzY4LTEuMTk3LS44NzggMC0xLjUzNC40NTEtMS44MDcgMS4xOTdoLS4wNzZ2LTEuMTEyaC0xLjQ3NXY2LjU0NlpNMTA1LjM2IDIwLjY0YzEuMDI3IDAgMS42NDEtLjQ4IDEuOTIyLTEuMDNoLjA1MXYuODk5aDEuNDgzdi00LjM4MWMwLTEuNzMtMS40MS0yLjI1LTIuNjU5LTIuMjUtMS4zNzYgMC0yLjQzMy42MTQtMi43NzQgMS44MDdsMS40NC4yMDRjLjE1NC0uNDQ3LjU4OC0uODMgMS4zNDItLjgzLjcxNiAwIDEuMTA4LjM2NiAxLjEwOCAxLjAxdi4wMjVjMCAuNDQzLS40NjQuNDY0LTEuNjE5LjU4OC0xLjI3LjEzNi0yLjQ4NC41MTUtMi40ODQgMS45OSAwIDEuMjg3Ljk0MiAxLjk2OSAyLjE5IDEuOTY5Wm0uNDAxLTEuMTMzYy0uNjQ0IDAtMS4xMDQtLjI5NC0xLjEwNC0uODYgMC0uNTkzLjUxNi0uODQgMS4yMDYtLjkzOC40MDUtLjA1NiAxLjIxNC0uMTU4IDEuNDE1LS4zMnYuNzcxYzAgLjczLS41ODggMS4zNDctMS41MTcgMS4zNDdaTTExMS45MSAxNi42NzNjMC0uOTQ2LjU3MS0xLjQ5MSAxLjM4NS0xLjQ5MS43OTcgMCAxLjI3NC41MjQgMS4yNzQgMS4zOTd2My45M2gxLjU0M1YxNi4zNGMuMDA0LTEuNTY4LS44OTEtMi40NjMtMi4yNDItMi40NjMtLjk4IDAtMS42NTMuNDY5LTEuOTUyIDEuMTk3aC0uMDc2di0xLjExMmgtMS40NzV2Ni41NDZoMS41NDN2LTMuODM2WiIgZmlsbD0iI2ZmZiIvPjwvc3ZnPg==');" onclick="window.open('https://satusehat-fhir.postman.co/workspace/SATUSEHAT-UseCase~ed2ed615-fe1b-473d-9dc1-a0c425fb2f44/collection/24174700-c6e52265-7336-40c8-b6a8-6831f58ffbe1?action=share&creator=19625975', '_blank');"></div></td>
        <td style="padding: 10px 20px; ;"><div style="display: inline-block; border-radius: 4px; cursor: pointer; height: 32px; border: none; width: 123px; background-image: url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB3aWR0aD0iMTI1IiB6b29tQW5kUGFuPSJtYWduaWZ5IiB2aWV3Qm94PSIwIDAgOTMuNzUgMzAuMDAwMDAxIiBoZWlnaHQ9IjQwIiBwcmVzZXJ2ZUFzcGVjdFJhdGlvPSJ4TWlkWU1pZCBtZWV0IiB2ZXJzaW9uPSIxLjAiPjxkZWZzPjxnLz48Y2xpcFBhdGggaWQ9ImE3ZDJlMzRmNmEiPjxwYXRoIGQ9Ik0gMS45NTcwMzEgMS4yNDYwOTQgTCA5MS45Njg3NSAxLjI0NjA5NCBMIDkxLjk2ODc1IDIzLjg3ODkwNiBMIDEuOTU3MDMxIDIzLjg3ODkwNiBaIE0gMS45NTcwMzEgMS4yNDYwOTQgIiBjbGlwLXJ1bGU9Im5vbnplcm8iLz48L2NsaXBQYXRoPjxjbGlwUGF0aCBpZD0iNzBhYjc4ZGEzNiI+PHBhdGggZD0iTSA0LjE0MDYyNSAxLjI0NjA5NCBMIDg5LjYwOTM3NSAxLjI0NjA5NCBDIDkwLjgxNjQwNiAxLjI0NjA5NCA5MS43OTI5NjkgMi4yMjI2NTYgOTEuNzkyOTY5IDMuNDI5Njg4IEwgOTEuNzkyOTY5IDIxLjUxOTUzMSBDIDkxLjc5Mjk2OSAyMi43MjY1NjIgOTAuODE2NDA2IDIzLjcwMzEyNSA4OS42MDkzNzUgMjMuNzAzMTI1IEwgNC4xNDA2MjUgMjMuNzAzMTI1IEMgMi45MzM1OTQgMjMuNzAzMTI1IDEuOTU3MDMxIDIyLjcyNjU2MiAxLjk1NzAzMSAyMS41MTk1MzEgTCAxLjk1NzAzMSAzLjQyOTY4OCBDIDEuOTU3MDMxIDIuMjIyNjU2IDIuOTMzNTk0IDEuMjQ2MDk0IDQuMTQwNjI1IDEuMjQ2MDk0ICIgY2xpcC1ydWxlPSJub256ZXJvIi8+PC9jbGlwUGF0aD48Y2xpcFBhdGggaWQ9IjM3ODA5ZDFmZWEiPjxwYXRoIGQ9Ik0gMTYuMTEzMjgxIDcuMjA3MDMxIEwgMTcuOTU3MDMxIDcuMjA3MDMxIEwgMTcuOTU3MDMxIDkuMDI3MzQ0IEwgMTYuMTEzMjgxIDkuMDI3MzQ0IFogTSAxNi4xMTMyODEgNy4yMDcwMzEgIiBjbGlwLXJ1bGU9Im5vbnplcm8iLz48L2NsaXBQYXRoPjxjbGlwUGF0aCBpZD0iMzQ1YzAxZDI0ZiI+PHBhdGggZD0iTSAxMC42Nzk2ODggNy4xOTkyMTkgTCAxNy45NTcwMzEgNy4xOTkyMTkgTCAxNy45NTcwMzEgMTcuMzkwNjI1IEwgMTAuNjc5Njg4IDE3LjM5MDYyNSBaIE0gMTAuNjc5Njg4IDcuMTk5MjE5ICIgY2xpcC1ydWxlPSJub256ZXJvIi8+PC9jbGlwUGF0aD48L2RlZnM+PGcgY2xpcC1wYXRoPSJ1cmwoI2E3ZDJlMzRmNmEpIj48ZyBjbGlwLXBhdGg9InVybCgjNzBhYjc4ZGEzNikiPjxwYXRoIGZpbGw9IiM0N2IwOGIiIGQ9Ik0gMS45NTcwMzEgMS4yNDYwOTQgTCA5MS45Njg3NSAxLjI0NjA5NCBMIDkxLjk2ODc1IDIzLjg3ODkwNiBMIDEuOTU3MDMxIDIzLjg3ODkwNiBaIE0gMS45NTcwMzEgMS4yNDYwOTQgIiBmaWxsLW9wYWNpdHk9IjEiIGZpbGwtcnVsZT0ibm9uemVybyIvPjwvZz48L2c+PGcgY2xpcC1wYXRoPSJ1cmwoIzM3ODA5ZDFmZWEpIj48cGF0aCBmaWxsPSIjZmZmZmZmIiBkPSJNIDE2LjEzNjcxOSA3LjIwNzAzMSBMIDE2LjE5OTIxOSA3LjIwNzAzMSBMIDE2LjI3MzQzOCA3LjIzNDM3NSBMIDE2LjM1MTU2MiA3LjI2NTYyNSBMIDE3Ljg5MDYyNSA4Ljc2NTYyNSBMIDE3Ljk1NzAzMSA4LjgyODEyNSBMIDE3Ljk1NzAzMSA5LjAwNzgxMiBMIDE2LjEzNjcxOSA5LjAwNzgxMiBMIDE2LjEzNjcxOSA3LjIwNzAzMSAiIGZpbGwtb3BhY2l0eT0iMSIgZmlsbC1ydWxlPSJldmVub2RkIi8+PC9nPjxnIGNsaXAtcGF0aD0idXJsKCMzNDVjMDFkMjRmKSI+PHBhdGggZmlsbD0iI2ZmZmZmZiIgZD0iTSAxMC44OTA2MjUgNy4yMDcwMzEgTCAxNS45MjE4NzUgNy4yMDcwMzEgTCAxNS45MjE4NzUgOS4yMTg3NSBMIDE3Ljk1NzAzMSA5LjIxODc1IEwgMTcuOTU3MDMxIDE3LjM4NjcxOSBMIDEwLjY3OTY4OCAxNy4zODY3MTkgTCAxMC42Nzk2ODggNy4yMDcwMzEgWiBNIDEyLjU1NDY4OCA5LjU1MDc4MSBDIDEyLjAyMzQzOCA5Ljg3NSAxMS42Nzk2ODggMTAuMzgyODEyIDExLjU0Njg3NSAxMC45Mzc1IEMgMTEuNDE0MDYyIDExLjQ5NjA5NCAxMS40OTYwOTQgMTIuMTAxNTYyIDExLjgyNDIxOSAxMi42MjUgQyAxMi4xNTIzNDQgMTMuMTUyMzQ0IDEyLjY2NDA2MiAxMy40OTYwOTQgMTMuMjI2NTYyIDEzLjYyNSBDIDEzLjYyODkwNiAxMy43MTg3NSAxNC4wNTQ2ODggMTMuNzAzMTI1IDE0LjQ1NzAzMSAxMy41NzAzMTIgTCAxNi4wOTM3NSAxNi4xODM1OTQgQyAxNi4xNjAxNTYgMTYuMjkyOTY5IDE2LjI1NzgxMiAxNi4zNzEwOTQgMTYuMzU5Mzc1IDE2LjQxNDA2MiBDIDE2LjQ4NDM3NSAxNi40NjQ4NDQgMTYuNjIxMDk0IDE2LjQ2NDg0NCAxNi43MzQzNzUgMTYuMzk0NTMxIEwgMTYuODgyODEyIDE2LjMwNDY4OCBDIDE2Ljk5NjA5NCAxNi4yMzQzNzUgMTcuMDU4NTk0IDE2LjExMzI4MSAxNy4wNjY0MDYgMTUuOTgwNDY5IEMgMTcuMDc0MjE5IDE1Ljg3MTA5NCAxNy4wNDI5NjkgMTUuNzUgMTYuOTc2NTYyIDE1LjY0MDYyNSBMIDE1LjMzOTg0NCAxMy4wMjczNDQgQyAxNS42NDA2MjUgMTIuNzI2NTYyIDE1Ljg0Mzc1IDEyLjM1NTQ2OSAxNS45Mzc1IDExLjk2MDkzOCBDIDE2LjA3MDMxMiAxMS40MDIzNDQgMTUuOTg4MjgxIDEwLjc5Njg3NSAxNS42NjAxNTYgMTAuMjczNDM4IEMgMTUuMzMyMDMxIDkuNzQ2MDk0IDE0LjgyMDMxMiA5LjQwMjM0NCAxNC4yNTc4MTIgOS4yNzM0MzggQyAxMy42OTUzMTIgOS4xNDQ1MzEgMTMuMDgyMDMxIDkuMjI2NTYyIDEyLjU1NDY4OCA5LjU1MDc4MSBaIE0gMTQuNDIxODc1IDEzLjEzMjgxMiBMIDE0LjQ2MDkzOCAxMy4xMTMyODEgQyAxNC40OTYwOTQgMTMuMTAxNTYyIDE0LjUyNzM0NCAxMy4wODU5MzggMTQuNTU0Njg4IDEzLjA3NDIxOSBMIDE0LjU1NDY4OCAxMy4wNzAzMTIgQyAxNC41NjY0MDYgMTMuMDY2NDA2IDE0LjU3NDIxOSAxMy4wNjI1IDE0LjU4NTkzOCAxMy4wNTQ2ODggQyAxNC42MjUgMTMuMDM1MTU2IDE0LjY2MDE1NiAxMy4wMTU2MjUgMTQuNjkxNDA2IDEyLjk5NjA5NCBDIDE0LjY5NTMxMiAxMi45OTYwOTQgMTQuNjk5MjE5IDEyLjk5MjE4OCAxNC43MDcwMzEgMTIuOTg4MjgxIEMgMTQuNzU3ODEyIDEyLjk1NzAzMSAxNC44MDg1OTQgMTIuOTIxODc1IDE0Ljg1NTQ2OSAxMi44ODY3MTkgQyAxNC44Nzg5MDYgMTIuODY3MTg4IDE0LjkwMjM0NCAxMi44NDc2NTYgMTQuOTI1NzgxIDEyLjgyODEyNSBMIDE0Ljk1MzEyNSAxMi44MDQ2ODggQyAxNS4yNDIxODggMTIuNTU0Njg4IDE1LjQzNzUgMTIuMjIyNjU2IDE1LjUyMzQzOCAxMS44NjMyODEgQyAxNS42Mjg5MDYgMTEuNDEwMTU2IDE1LjU2MjUgMTAuOTE3OTY5IDE1LjI5Njg3NSAxMC40OTYwOTQgQyAxNS4wMzEyNSAxMC4wNzAzMTIgMTQuNjE3MTg4IDkuNzkyOTY5IDE0LjE2MDE1NiA5LjY4NzUgQyAxMy43MDMxMjUgOS41ODIwMzEgMTMuMjA3MDMxIDkuNjQ0NTMxIDEyLjc3NzM0NCA5LjkxMDE1NiBDIDEyLjM1MTU2MiAxMC4xNzE4NzUgMTIuMDcwMzEyIDEwLjU4MjAzMSAxMS45NjA5MzggMTEuMDM1MTU2IEMgMTEuODU1NDY5IDExLjQ4ODI4MSAxMS45MjE4NzUgMTEuOTgwNDY5IDEyLjE4NzUgMTIuNDAyMzQ0IEMgMTIuNDUzMTI1IDEyLjgyODEyNSAxMi44NjcxODggMTMuMTA1NDY5IDEzLjMyNDIxOSAxMy4yMTA5MzggQyAxMy42ODM1OTQgMTMuMjk2ODc1IDE0LjA2NjQwNiAxMy4yNzM0MzggMTQuNDIxODc1IDEzLjEzMjgxMiAiIGZpbGwtb3BhY2l0eT0iMSIgZmlsbC1ydWxlPSJldmVub2RkIi8+PC9nPjxwYXRoIGZpbGw9IiMyMTIxMjEiIGQ9Ik0gMTYuNTA3ODEyIDE2LjAzNTE1NiBMIDE2LjUyMzQzOCAxNi4wMjM0MzggQyAxNi41MjM0MzggMTYuMDIzNDM4IDE2LjQ5NjA5NCAxNi4wNDI5NjkgMTYuNTA3ODEyIDE2LjAzNTE1NiAiIGZpbGwtb3BhY2l0eT0iMSIgZmlsbC1ydWxlPSJub256ZXJvIi8+PHBhdGggZmlsbD0iIzIxMjEyMSIgZD0iTSAxNi42NTYyNSAxNS45NDUzMTIgQyAxNi42Njc5NjkgMTUuOTM3NSAxNi42NDA2MjUgMTUuOTUzMTI1IDE2LjY0MDYyNSAxNS45NTMxMjUgTCAxNi42NTYyNSAxNS45NDUzMTIgIiBmaWxsLW9wYWNpdHk9IjEiIGZpbGwtcnVsZT0ibm9uemVybyIvPjxnIGZpbGw9IiNmZmZmZmYiIGZpbGwtb3BhY2l0eT0iMSI+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMjEuNTk0ODI5LCAxNS45NjAwNjIpIj48Zz48cGF0aCBkPSJNIDYuMzkwNjI1IC02LjUxNTYyNSBMIDMuNzY1NjI1IDAgTCAyLjU0Njg3NSAwIEwgLTAuMDc4MTI1IC02LjUxNTYyNSBMIDEgLTYuNTE1NjI1IEMgMS4xMjUgLTYuNTE1NjI1IDEuMjIyNjU2IC02LjQ4ODI4MSAxLjI5Njg3NSAtNi40Mzc1IEMgMS4zNjcxODggLTYuMzgyODEyIDEuNDIxODc1IC02LjMxMjUgMS40NTMxMjUgLTYuMjE4NzUgTCAyLjg1OTM3NSAtMi40Njg3NSBDIDIuOTIxODc1IC0yLjMyMDMxMiAyLjk3NjU2MiAtMi4xNjQwNjIgMy4wMzEyNSAtMiBDIDMuMDgyMDMxIC0xLjgzMjAzMSAzLjEyODkwNiAtMS42NjAxNTYgMy4xNzE4NzUgLTEuNDg0Mzc1IEMgMy4yMTA5MzggLTEuNjYwMTU2IDMuMjUzOTA2IC0xLjgzMjAzMSAzLjI5Njg3NSAtMiBDIDMuMzQ3NjU2IC0yLjE2NDA2MiAzLjM5ODQzOCAtMi4zMjAzMTIgMy40NTMxMjUgLTIuNDY4NzUgTCA0Ljg1OTM3NSAtNi4yMTg3NSBDIDQuODc4OTA2IC02LjI4OTA2MiA0LjkyNTc4MSAtNi4zNTkzNzUgNSAtNi40MjE4NzUgQyA1LjA4MjAzMSAtNi40ODQzNzUgNS4xNzk2ODggLTYuNTE1NjI1IDUuMjk2ODc1IC02LjUxNTYyNSBaIE0gNi4zOTA2MjUgLTYuNTE1NjI1ICIvPjwvZz48L2c+PC9nPjxnIGZpbGw9IiNmZmZmZmYiIGZpbGwtb3BhY2l0eT0iMSI+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMjcuOTAxNDYzLCAxNS45NjAwNjIpIj48Zz48cGF0aCBkPSJNIDEuNzgxMjUgLTQuNjI1IEwgMS43ODEyNSAwIEwgMC41NDY4NzUgMCBMIDAuNTQ2ODc1IC00LjYyNSBaIE0gMS45Mzc1IC01Ljk1MzEyNSBDIDEuOTM3NSAtNS44NDc2NTYgMS45MTQwNjIgLTUuNzUgMS44NzUgLTUuNjU2MjUgQyAxLjgzMjAzMSAtNS41NjI1IDEuNzczNDM4IC01LjQ3NjU2MiAxLjcwMzEyNSAtNS40MDYyNSBDIDEuNjI4OTA2IC01LjM0Mzc1IDEuNTQ2ODc1IC01LjI4OTA2MiAxLjQ1MzEyNSAtNS4yNSBDIDEuMzU5Mzc1IC01LjIxODc1IDEuMjU3ODEyIC01LjIwMzEyNSAxLjE1NjI1IC01LjIwMzEyNSBDIDEuMDUwNzgxIC01LjIwMzEyNSAwLjk1MzEyNSAtNS4yMTg3NSAwLjg1OTM3NSAtNS4yNSBDIDAuNzczNDM4IC01LjI4OTA2MiAwLjY5NTMxMiAtNS4zNDM3NSAwLjYyNSAtNS40MDYyNSBDIDAuNTUwNzgxIC01LjQ3NjU2MiAwLjQ5MjE4OCAtNS41NjI1IDAuNDUzMTI1IC01LjY1NjI1IEMgMC40MjE4NzUgLTUuNzUgMC40MDYyNSAtNS44NDc2NTYgMC40MDYyNSAtNS45NTMxMjUgQyAwLjQwNjI1IC02LjA1NDY4OCAwLjQyMTg3NSAtNi4xNDg0MzggMC40NTMxMjUgLTYuMjM0Mzc1IEMgMC40OTIxODggLTYuMzI4MTI1IDAuNTUwNzgxIC02LjQwNjI1IDAuNjI1IC02LjQ2ODc1IEMgMC42OTUzMTIgLTYuNTM5MDYyIDAuNzczNDM4IC02LjU5NzY1NiAwLjg1OTM3NSAtNi42NDA2MjUgQyAwLjk1MzEyNSAtNi42Nzk2ODggMS4wNTA3ODEgLTYuNzAzMTI1IDEuMTU2MjUgLTYuNzAzMTI1IEMgMS4yNTc4MTIgLTYuNzAzMTI1IDEuMzU5Mzc1IC02LjY3OTY4OCAxLjQ1MzEyNSAtNi42NDA2MjUgQyAxLjU0Njg3NSAtNi41OTc2NTYgMS42Mjg5MDYgLTYuNTM5MDYyIDEuNzAzMTI1IC02LjQ2ODc1IEMgMS43NzM0MzggLTYuNDA2MjUgMS44MzIwMzEgLTYuMzI4MTI1IDEuODc1IC02LjIzNDM3NSBDIDEuOTE0MDYyIC02LjE0ODQzOCAxLjkzNzUgLTYuMDU0Njg4IDEuOTM3NSAtNS45NTMxMjUgWiBNIDEuOTM3NSAtNS45NTMxMjUgIi8+PC9nPjwvZz48L2c+PGcgZmlsbD0iI2ZmZmZmZiIgZmlsbC1vcGFjaXR5PSIxIj48ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSgzMC4yMzcyNTQsIDE1Ljk2MDA2MikiPjxnPjxwYXRoIGQ9Ik0gMy40NTMxMjUgLTIuODU5Mzc1IEMgMy40NTMxMjUgLTIuOTkyMTg4IDMuNDI5Njg4IC0zLjExNzE4OCAzLjM5MDYyNSAtMy4yMzQzNzUgQyAzLjM1OTM3NSAtMy4zNDc2NTYgMy4zMDQ2ODggLTMuNDQ1MzEyIDMuMjM0Mzc1IC0zLjUzMTI1IEMgMy4xNjAxNTYgLTMuNjI1IDMuMDY2NDA2IC0zLjY5NTMxMiAyLjk1MzEyNSAtMy43NSBDIDIuODM1OTM4IC0zLjgwMDc4MSAyLjcwMzEyNSAtMy44MjgxMjUgMi41NDY4NzUgLTMuODI4MTI1IEMgMi4yNDIxODggLTMuODI4MTI1IDIuMDA3ODEyIC0zLjc0MjE4OCAxLjg0Mzc1IC0zLjU3ODEyNSBDIDEuNjc1NzgxIC0zLjQxMDE1NiAxLjU2NjQwNiAtMy4xNzE4NzUgMS41MTU2MjUgLTIuODU5Mzc1IFogTSAxLjUgLTIuMTI1IEMgMS41MzkwNjIgLTEuNjg3NSAxLjY2NDA2MiAtMS4zNjcxODggMS44NzUgLTEuMTcxODc1IEMgMi4wODIwMzEgLTAuOTcyNjU2IDIuMzUxNTYyIC0wLjg3NSAyLjY4NzUgLTAuODc1IEMgMi44NTE1NjIgLTAuODc1IDMgLTAuODk0NTMxIDMuMTI1IC0wLjkzNzUgQyAzLjI1IC0wLjk3NjU2MiAzLjM1OTM3NSAtMS4wMTk1MzEgMy40NTMxMjUgLTEuMDYyNSBDIDMuNTQ2ODc1IC0xLjExMzI4MSAzLjYyODkwNiAtMS4xNjAxNTYgMy43MDMxMjUgLTEuMjAzMTI1IEMgMy43ODUxNTYgLTEuMjQyMTg4IDMuODYzMjgxIC0xLjI2NTYyNSAzLjkzNzUgLTEuMjY1NjI1IEMgNC4wMzEyNSAtMS4yNjU2MjUgNC4xMDkzNzUgLTEuMjI2NTYyIDQuMTcxODc1IC0xLjE1NjI1IEwgNC41MzEyNSAtMC43MDMxMjUgQyA0LjM5NDUzMSAtMC41NDY4NzUgNC4yNDIxODggLTAuNDE0MDYyIDQuMDc4MTI1IC0wLjMxMjUgQyAzLjkyMTg3NSAtMC4yMTg3NSAzLjc1NzgxMiAtMC4xNDA2MjUgMy41OTM3NSAtMC4wNzgxMjUgQyAzLjQyNTc4MSAtMC4wMjM0Mzc1IDMuMjUzOTA2IDAuMDA3ODEyNSAzLjA3ODEyNSAwLjAzMTI1IEMgMi44OTg0MzggMC4wNTA3ODEyIDIuNzM0Mzc1IDAuMDYyNSAyLjU3ODEyNSAwLjA2MjUgQyAyLjI1MzkwNiAwLjA2MjUgMS45NTMxMjUgMC4wMDc4MTI1IDEuNjcxODc1IC0wLjA5Mzc1IEMgMS4zOTA2MjUgLTAuMTk1MzEyIDEuMTQ0NTMxIC0wLjM1MTU2MiAwLjkzNzUgLTAuNTYyNSBDIDAuNzI2NTYyIC0wLjc2OTUzMSAwLjU2MjUgLTEuMDIzNDM4IDAuNDM3NSAtMS4zMjgxMjUgQyAwLjMyMDMxMiAtMS42NDA2MjUgMC4yNjU2MjUgLTIgMC4yNjU2MjUgLTIuNDA2MjUgQyAwLjI2NTYyNSAtMi43MjY1NjIgMC4zMTY0MDYgLTMuMDIzNDM4IDAuNDIxODc1IC0zLjI5Njg3NSBDIDAuNTIzNDM4IC0zLjU3ODEyNSAwLjY3MTg3NSAtMy44MjAzMTIgMC44NTkzNzUgLTQuMDMxMjUgQyAxLjA1NDY4OCAtNC4yMzgyODEgMS4yOTY4NzUgLTQuMzk4NDM4IDEuNTc4MTI1IC00LjUxNTYyNSBDIDEuODU5Mzc1IC00LjY0MDYyNSAyLjE3MTg3NSAtNC43MDMxMjUgMi41MTU2MjUgLTQuNzAzMTI1IEMgMi44MTY0MDYgLTQuNzAzMTI1IDMuMDkzNzUgLTQuNjU2MjUgMy4zNDM3NSAtNC41NjI1IEMgMy41OTM3NSAtNC40Njg3NSAzLjgwNDY4OCAtNC4zMjgxMjUgMy45ODQzNzUgLTQuMTQwNjI1IEMgNC4xNzE4NzUgLTMuOTYwOTM4IDQuMzEyNSAtMy43NDIxODggNC40MDYyNSAtMy40ODQzNzUgQyA0LjUwNzgxMiAtMy4yMjI2NTYgNC41NjI1IC0yLjkyNTc4MSA0LjU2MjUgLTIuNTkzNzUgQyA0LjU2MjUgLTIuNSA0LjU1NDY4OCAtMi40MjE4NzUgNC41NDY4NzUgLTIuMzU5Mzc1IEMgNC41MzUxNTYgLTIuMjk2ODc1IDQuNTE5NTMxIC0yLjI1IDQuNSAtMi4yMTg3NSBDIDQuNDc2NTYyIC0yLjE4NzUgNC40NDUzMTIgLTIuMTYwMTU2IDQuNDA2MjUgLTIuMTQwNjI1IEMgNC4zNzUgLTIuMTI4OTA2IDQuMzMyMDMxIC0yLjEyNSA0LjI4MTI1IC0yLjEyNSBaIE0gMS41IC0yLjEyNSAiLz48L2c+PC9nPjwvZz48ZyBmaWxsPSIjZmZmZmZmIiBmaWxsLW9wYWNpdHk9IjEiPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKDM1LjA1MjU3NiwgMTUuOTYwMDYyKSI+PGc+PHBhdGggZD0iTSA3LjIxODc1IC00LjYyNSBMIDUuNzY1NjI1IDAgTCA0Ljc2NTYyNSAwIEMgNC43MTA5MzggMCA0LjY2NDA2MiAtMC4wMTU2MjUgNC42MjUgLTAuMDQ2ODc1IEMgNC41ODIwMzEgLTAuMDc4MTI1IDQuNTUwNzgxIC0wLjEzMjgxMiA0LjUzMTI1IC0wLjIxODc1IEwgMy43ODEyNSAtMi43MTg3NSBDIDMuNzUgLTIuODEyNSAzLjcyMjY1NiAtMi45MDYyNSAzLjcwMzEyNSAtMyBDIDMuNjc5Njg4IC0zLjEwMTU2MiAzLjY2MDE1NiAtMy4yMDMxMjUgMy42NDA2MjUgLTMuMjk2ODc1IEMgMy42MTcxODggLTMuMjAzMTI1IDMuNTk3NjU2IC0zLjEwMTU2MiAzLjU3ODEyNSAtMyBDIDMuNTU0Njg4IC0yLjkwNjI1IDMuNTMxMjUgLTIuODEyNSAzLjUgLTIuNzE4NzUgTCAyLjczNDM3NSAtMC4yMTg3NSBDIDIuNjkxNDA2IC0wLjA3MDMxMjUgMi42MDE1NjIgMCAyLjQ2ODc1IDAgTCAxLjUxNTYyNSAwIEwgMC4wNDY4NzUgLTQuNjI1IEwgMS4wNDY4NzUgLTQuNjI1IEMgMS4xMjg5MDYgLTQuNjI1IDEuMjAzMTI1IC00LjYwMTU2MiAxLjI2NTYyNSAtNC41NjI1IEMgMS4zMjgxMjUgLTQuNTE5NTMxIDEuMzY3MTg4IC00LjQ2ODc1IDEuMzkwNjI1IC00LjQwNjI1IEwgMS45Njg3NSAtMi4xMDkzNzUgQyAyIC0xLjk2MDkzOCAyLjAyMzQzOCAtMS44MjAzMTIgMi4wNDY4NzUgLTEuNjg3NSBDIDIuMDc4MTI1IC0xLjU1MDc4MSAyLjEwOTM3NSAtMS40MTQwNjIgMi4xNDA2MjUgLTEuMjgxMjUgQyAyLjE3MTg3NSAtMS40MTQwNjIgMi4yMDcwMzEgLTEuNTUwNzgxIDIuMjUgLTEuNjg3NSBDIDIuMjg5MDYyIC0xLjgyMDMxMiAyLjMzMjAzMSAtMS45NjA5MzggMi4zNzUgLTIuMTA5Mzc1IEwgMy4wNjI1IC00LjQyMTg3NSBDIDMuMDgyMDMxIC00LjQ4NDM3NSAzLjExNzE4OCAtNC41MzUxNTYgMy4xNzE4NzUgLTQuNTc4MTI1IEMgMy4yMzQzNzUgLTQuNjE3MTg4IDMuMzA0Njg4IC00LjY0MDYyNSAzLjM5MDYyNSAtNC42NDA2MjUgTCAzLjkzNzUgLTQuNjQwNjI1IEMgNC4wMTk1MzEgLTQuNjQwNjI1IDQuMDkzNzUgLTQuNjE3MTg4IDQuMTU2MjUgLTQuNTc4MTI1IEMgNC4yMTg3NSAtNC41MzUxNTYgNC4yNTc4MTIgLTQuNDg0Mzc1IDQuMjgxMjUgLTQuNDIxODc1IEwgNC45Mzc1IC0yLjEwOTM3NSBDIDQuOTc2NTYyIC0xLjk3MjY1NiA1LjAxNTYyNSAtMS44MzIwMzEgNS4wNDY4NzUgLTEuNjg3NSBDIDUuMDg1OTM4IC0xLjU1MDc4MSA1LjEyODkwNiAtMS40MTAxNTYgNS4xNzE4NzUgLTEuMjY1NjI1IEMgNS4xOTE0MDYgLTEuNDEwMTU2IDUuMjEwOTM4IC0xLjU1MDc4MSA1LjIzNDM3NSAtMS42ODc1IEMgNS4yNjU2MjUgLTEuODIwMzEyIDUuMzAwNzgxIC0xLjk2MDkzOCA1LjM0Mzc1IC0yLjEwOTM3NSBMIDUuOTM3NSAtNC40MDYyNSBDIDUuOTU3MDMxIC00LjQ2ODc1IDYgLTQuNTE5NTMxIDYuMDYyNSAtNC41NjI1IEMgNi4xMjUgLTQuNjAxNTYyIDYuMTk1MzEyIC00LjYyNSA2LjI4MTI1IC00LjYyNSBaIE0gNy4yMTg3NSAtNC42MjUgIi8+PC9nPjwvZz48L2c+PGcgZmlsbD0iI2ZmZmZmZiIgZmlsbC1vcGFjaXR5PSIxIj48ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSg0Mi4zMjQ5NjgsIDE1Ljk2MDA2MikiPjxnLz48L2c+PC9nPjxnIGZpbGw9IiNmZmZmZmYiIGZpbGwtb3BhY2l0eT0iMSI+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoNDQuNDU4NjI0LCAxNS45NjAwNjIpIj48Zz48cGF0aCBkPSJNIDIuODkwNjI1IC0zLjI4MTI1IEMgMy4zMDQ2ODggLTMuMjgxMjUgMy42MTMyODEgLTMuMzc4OTA2IDMuODEyNSAtMy41NzgxMjUgQyA0LjAwNzgxMiAtMy43ODUxNTYgNC4xMDkzNzUgLTQuMDY2NDA2IDQuMTA5Mzc1IC00LjQyMTg3NSBDIDQuMTA5Mzc1IC00LjU3ODEyNSA0LjA4MjAzMSAtNC43MjI2NTYgNC4wMzEyNSAtNC44NTkzNzUgQyAzLjk3NjU2MiAtNC45OTIxODggMy44OTg0MzggLTUuMTA5Mzc1IDMuNzk2ODc1IC01LjIwMzEyNSBDIDMuNzAzMTI1IC01LjI5Njg3NSAzLjU3ODEyNSAtNS4zNjcxODggMy40MjE4NzUgLTUuNDIxODc1IEMgMy4yNzM0MzggLTUuNDcyNjU2IDMuMDk3NjU2IC01LjUgMi44OTA2MjUgLTUuNSBMIDIuMDMxMjUgLTUuNSBMIDIuMDMxMjUgLTMuMjgxMjUgWiBNIDIuODkwNjI1IC02LjUxNTYyNSBDIDMuMzI4MTI1IC02LjUxNTYyNSAzLjcwNzAzMSAtNi40NjA5MzggNC4wMzEyNSAtNi4zNTkzNzUgQyA0LjM2MzI4MSAtNi4yNTM5MDYgNC42MzI4MTIgLTYuMTA5Mzc1IDQuODQzNzUgLTUuOTIxODc1IEMgNS4wNTA3ODEgLTUuNzM0Mzc1IDUuMjAzMTI1IC01LjUwNzgxMiA1LjI5Njg3NSAtNS4yNSBDIDUuMzk4NDM4IC01IDUuNDUzMTI1IC00LjcyMjY1NiA1LjQ1MzEyNSAtNC40MjE4NzUgQyA1LjQ1MzEyNSAtNC4wOTc2NTYgNS4zOTg0MzggLTMuODAwNzgxIDUuMjk2ODc1IC0zLjUzMTI1IEMgNS4xOTE0MDYgLTMuMjY5NTMxIDUuMDMxMjUgLTMuMDM5MDYyIDQuODEyNSAtMi44NDM3NSBDIDQuNjAxNTYyIC0yLjY1NjI1IDQuMzM1OTM4IC0yLjUwMzkwNiA0LjAxNTYyNSAtMi4zOTA2MjUgQyAzLjY5MTQwNiAtMi4yODUxNTYgMy4zMTY0MDYgLTIuMjM0Mzc1IDIuODkwNjI1IC0yLjIzNDM3NSBMIDIuMDMxMjUgLTIuMjM0Mzc1IEwgMi4wMzEyNSAwIEwgMC42ODc1IDAgTCAwLjY4NzUgLTYuNTE1NjI1IFogTSAyLjg5MDYyNSAtNi41MTU2MjUgIi8+PC9nPjwvZz48L2c+PGcgZmlsbD0iI2ZmZmZmZiIgZmlsbC1vcGFjaXR5PSIxIj48ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSg1MC4wOTE0NzEsIDE1Ljk2MDA2MikiPjxnPjxwYXRoIGQ9Ik0gMS43NjU2MjUgLTYuNzAzMTI1IEwgMS43NjU2MjUgMCBMIDAuNTE1NjI1IDAgTCAwLjUxNTYyNSAtNi43MDMxMjUgWiBNIDEuNzY1NjI1IC02LjcwMzEyNSAiLz48L2c+PC9nPjwvZz48ZyBmaWxsPSIjZmZmZmZmIiBmaWxsLW9wYWNpdHk9IjEiPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKDUyLjM3MzM1OSwgMTUuOTYwMDYyKSI+PGc+PHBhdGggZD0iTSAyLjkzNzUgLTEuOTM3NSBDIDIuNjMyODEyIC0xLjkxNDA2MiAyLjM3ODkwNiAtMS44ODI4MTIgMi4xNzE4NzUgLTEuODQzNzUgQyAxLjk3MjY1NiAtMS44MTI1IDEuODEyNSAtMS43NjU2MjUgMS42ODc1IC0xLjcwMzEyNSBDIDEuNTcwMzEyIC0xLjY0ODQzOCAxLjQ4ODI4MSAtMS41ODIwMzEgMS40Mzc1IC0xLjUgQyAxLjM5NDUzMSAtMS40MjU3ODEgMS4zNzUgLTEuMzQ3NjU2IDEuMzc1IC0xLjI2NTYyNSBDIDEuMzc1IC0xLjA3ODEyNSAxLjQyMTg3NSAtMC45NDUzMTIgMS41MTU2MjUgLTAuODc1IEMgMS42MTcxODggLTAuODAwNzgxIDEuNzU3ODEyIC0wLjc2NTYyNSAxLjkzNzUgLTAuNzY1NjI1IEMgMi4xNDQ1MzEgLTAuNzY1NjI1IDIuMzIwMzEyIC0wLjgwMDc4MSAyLjQ2ODc1IC0wLjg3NSBDIDIuNjI1IC0wLjk0NTMxMiAyLjc4MTI1IC0xLjA2MjUgMi45Mzc1IC0xLjIxODc1IFogTSAwLjQwNjI1IC0zLjk4NDM3NSBDIDAuNjc1NzgxIC00LjIzNDM3NSAwLjk3NjU2MiAtNC40MTQwNjIgMS4zMTI1IC00LjUzMTI1IEMgMS42NDQ1MzEgLTQuNjU2MjUgMiAtNC43MTg3NSAyLjM3NSAtNC43MTg3NSBDIDIuNjU2MjUgLTQuNzE4NzUgMi45MDYyNSAtNC42NzE4NzUgMy4xMjUgLTQuNTc4MTI1IEMgMy4zNDM3NSAtNC40OTIxODggMy41MjM0MzggLTQuMzY3MTg4IDMuNjcxODc1IC00LjIwMzEyNSBDIDMuODI4MTI1IC00LjA0Njg3NSAzLjk0MTQwNiAtMy44NTkzNzUgNC4wMTU2MjUgLTMuNjQwNjI1IEMgNC4wOTc2NTYgLTMuNDIxODc1IDQuMTQwNjI1IC0zLjE3NTc4MSA0LjE0MDYyNSAtMi45MDYyNSBMIDQuMTQwNjI1IDAgTCAzLjU3ODEyNSAwIEMgMy40NjA5MzggMCAzLjM3NSAtMC4wMTU2MjUgMy4zMTI1IC0wLjA0Njg3NSBDIDMuMjUgLTAuMDc4MTI1IDMuMTk1MzEyIC0wLjE0NDUzMSAzLjE1NjI1IC0wLjI1IEwgMy4wNjI1IC0wLjU0Njg3NSBDIDIuOTQ1MzEyIC0wLjQ1MzEyNSAyLjgzMjAzMSAtMC4zNjMyODEgMi43MTg3NSAtMC4yODEyNSBDIDIuNjEzMjgxIC0wLjIwNzAzMSAyLjUgLTAuMTQ0NTMxIDIuMzc1IC0wLjA5Mzc1IEMgMi4yNTc4MTIgLTAuMDM5MDYyNSAyLjEzMjgxMiAwIDIgMC4wMzEyNSBDIDEuODc1IDAuMDYyNSAxLjcyNjU2MiAwLjA3ODEyNSAxLjU2MjUgMC4wNzgxMjUgQyAxLjM1MTU2MiAwLjA3ODEyNSAxLjE2NDA2MiAwLjA1MDc4MTIgMSAwIEMgMC44MzIwMzEgLTAuMDYyNSAwLjY4NzUgLTAuMTQ0NTMxIDAuNTYyNSAtMC4yNSBDIDAuNDQ1MzEyIC0wLjM1MTU2MiAwLjM1MTU2MiAtMC40ODQzNzUgMC4yODEyNSAtMC42NDA2MjUgQyAwLjIxODc1IC0wLjgwNDY4OCAwLjE4NzUgLTAuOTg4MjgxIDAuMTg3NSAtMS4xODc1IEMgMC4xODc1IC0xLjM2MzI4MSAwLjIyNjU2MiAtMS41MzUxNTYgMC4zMTI1IC0xLjcwMzEyNSBDIDAuNDA2MjUgLTEuODc4OTA2IDAuNTU0Njg4IC0yLjAzNTE1NiAwLjc2NTYyNSAtMi4xNzE4NzUgQyAwLjk3MjY1NiAtMi4zMDQ2ODggMS4yNTM5MDYgLTIuNDIxODc1IDEuNjA5Mzc1IC0yLjUxNTYyNSBDIDEuOTYwOTM4IC0yLjYwOTM3NSAyLjQwNjI1IC0yLjY2MDE1NiAyLjkzNzUgLTIuNjcxODc1IEwgMi45Mzc1IC0yLjkwNjI1IEMgMi45Mzc1IC0zLjE5NTMxMiAyLjg3NSAtMy40MTAxNTYgMi43NSAtMy41NDY4NzUgQyAyLjYyNSAtMy42Nzk2ODggMi40NDUzMTIgLTMuNzUgMi4yMTg3NSAtMy43NSBDIDIuMDUwNzgxIC0zLjc1IDEuOTEwMTU2IC0zLjcyNjU2MiAxLjc5Njg3NSAtMy42ODc1IEMgMS42Nzk2ODggLTMuNjU2MjUgMS41NzgxMjUgLTMuNjEzMjgxIDEuNDg0Mzc1IC0zLjU2MjUgQyAxLjM5ODQzOCAtMy41MTk1MzEgMS4zMjAzMTIgLTMuNDc2NTYyIDEuMjUgLTMuNDM3NSBDIDEuMTc1NzgxIC0zLjM5NDUzMSAxLjA5Mzc1IC0zLjM3NSAxIC0zLjM3NSBDIDAuOTA2MjUgLTMuMzc1IDAuODI4MTI1IC0zLjM5NDUzMSAwLjc2NTYyNSAtMy40Mzc1IEMgMC43MTA5MzggLTMuNDc2NTYyIDAuNjY0MDYyIC0zLjUzMTI1IDAuNjI1IC0zLjU5Mzc1IFogTSAwLjQwNjI1IC0zLjk4NDM3NSAiLz48L2c+PC9nPjwvZz48ZyBmaWxsPSIjZmZmZmZmIiBmaWxsLW9wYWNpdHk9IjEiPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKDU2Ljk3MzA2OSwgMTUuOTYwMDYyKSI+PGc+PHBhdGggZD0iTSA0LjgxMjUgLTQuNjI1IEwgMi4zMTI1IDEuMjUgQyAyLjI2OTUzMSAxLjMzMjAzMSAyLjIxODc1IDEuMzk0NTMxIDIuMTU2MjUgMS40Mzc1IEMgMi4xMDE1NjIgMS40NzY1NjIgMi4wMTk1MzEgMS41IDEuOTA2MjUgMS41IEwgMC45ODQzNzUgMS41IEwgMS44NTkzNzUgLTAuMzc1IEwgMCAtNC42MjUgTCAxLjA5Mzc1IC00LjYyNSBDIDEuMTg3NSAtNC42MjUgMS4yNTc4MTIgLTQuNjAxNTYyIDEuMzEyNSAtNC41NjI1IEMgMS4zNjMyODEgLTQuNTE5NTMxIDEuNDA2MjUgLTQuNDY4NzUgMS40Mzc1IC00LjQwNjI1IEwgMi4zMTI1IC0yLjE4NzUgQyAyLjM0Mzc1IC0yLjEwMTU2MiAyLjM2NzE4OCAtMi4wMTU2MjUgMi4zOTA2MjUgLTEuOTIxODc1IEMgMi40MjE4NzUgLTEuODM1OTM4IDIuNDQ1MzEyIC0xLjc1MzkwNiAyLjQ2ODc1IC0xLjY3MTg3NSBDIDIuNTMxMjUgLTEuODQ3NjU2IDIuNTkzNzUgLTIuMDIzNDM4IDIuNjU2MjUgLTIuMjAzMTI1IEwgMy40ODQzNzUgLTQuNDA2MjUgQyAzLjUwMzkwNiAtNC40Njg3NSAzLjU0Njg3NSAtNC41MTk1MzEgMy42MDkzNzUgLTQuNTYyNSBDIDMuNjcxODc1IC00LjYwMTU2MiAzLjczODI4MSAtNC42MjUgMy44MTI1IC00LjYyNSBaIE0gNC44MTI1IC00LjYyNSAiLz48L2c+PC9nPjwvZz48ZyBmaWxsPSIjZmZmZmZmIiBmaWxsLW9wYWNpdHk9IjEiPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKDYxLjc1MjQ1MywgMTUuOTYwMDYyKSI+PGc+PHBhdGggZD0iTSAxLjc1IC0xLjIxODc1IEMgMS44NjMyODEgLTEuMDgyMDMxIDEuOTg4MjgxIC0wLjk4ODI4MSAyLjEyNSAtMC45Mzc1IEMgMi4yNjk1MzEgLTAuODgyODEyIDIuNDE0MDYyIC0wLjg1OTM3NSAyLjU2MjUgLTAuODU5Mzc1IEMgMi43MDcwMzEgLTAuODU5Mzc1IDIuODQzNzUgLTAuODgyODEyIDIuOTY4NzUgLTAuOTM3NSBDIDMuMDkzNzUgLTEgMy4xOTUzMTIgLTEuMDg1OTM4IDMuMjgxMjUgLTEuMjAzMTI1IEMgMy4zNzUgLTEuMzI4MTI1IDMuNDQ1MzEyIC0xLjQ4NDM3NSAzLjUgLTEuNjcxODc1IEMgMy41NTA3ODEgLTEuODY3MTg4IDMuNTc4MTI1IC0yLjEwOTM3NSAzLjU3ODEyNSAtMi4zOTA2MjUgQyAzLjU3ODEyNSAtMi42Mjg5MDYgMy41NTQ2ODggLTIuODMyMDMxIDMuNTE1NjI1IC0zIEMgMy40NzI2NTYgLTMuMTc1NzgxIDMuNDEwMTU2IC0zLjMyMDMxMiAzLjMyODEyNSAtMy40Mzc1IEMgMy4yNTM5MDYgLTMuNTUwNzgxIDMuMTYwMTU2IC0zLjYyODkwNiAzLjA0Njg3NSAtMy42NzE4NzUgQyAyLjk0MTQwNiAtMy43MjI2NTYgMi44MTY0MDYgLTMuNzUgMi42NzE4NzUgLTMuNzUgQyAyLjQ3MjY1NiAtMy43NSAyLjMwMDc4MSAtMy43MDcwMzEgMi4xNTYyNSAtMy42MjUgQyAyLjAxOTUzMSAtMy41MzkwNjIgMS44ODI4MTIgLTMuNDE0MDYyIDEuNzUgLTMuMjUgWiBNIDEuNzUgLTQuMDkzNzUgQyAxLjkzNzUgLTQuMjgxMjUgMi4xNDA2MjUgLTQuNDI1NzgxIDIuMzU5Mzc1IC00LjUzMTI1IEMgMi41NzgxMjUgLTQuNjQ0NTMxIDIuODI4MTI1IC00LjcwMzEyNSAzLjEwOTM3NSAtNC43MDMxMjUgQyAzLjM2NzE4OCAtNC43MDMxMjUgMy42MDE1NjIgLTQuNjQ4NDM4IDMuODEyNSAtNC41NDY4NzUgQyA0LjAzMTI1IC00LjQ0MTQwNiA0LjIxMDkzOCAtNC4yODkwNjIgNC4zNTkzNzUgLTQuMDkzNzUgQyA0LjUxNTYyNSAtMy44OTQ1MzEgNC42MzI4MTIgLTMuNjU2MjUgNC43MTg3NSAtMy4zNzUgQyA0LjgwMDc4MSAtMy4wOTM3NSA0Ljg0Mzc1IC0yLjc4MTI1IDQuODQzNzUgLTIuNDM3NSBDIDQuODQzNzUgLTIuMDYyNSA0Ljc5Njg3NSAtMS43MTg3NSA0LjcwMzEyNSAtMS40MDYyNSBDIDQuNjA5Mzc1IC0xLjEwMTU2MiA0LjQ3MjY1NiAtMC44NDM3NSA0LjI5Njg3NSAtMC42MjUgQyA0LjEyODkwNiAtMC40MDYyNSAzLjkyMTg3NSAtMC4yMzQzNzUgMy42NzE4NzUgLTAuMTA5Mzc1IEMgMy40Mjk2ODggMC4wMDM5MDYyNSAzLjE2NDA2MiAwLjA2MjUgMi44NzUgMC4wNjI1IEMgMi43MjY1NjIgMC4wNjI1IDIuNTk3NjU2IDAuMDQ2ODc1IDIuNDg0Mzc1IDAuMDE1NjI1IEMgMi4zNjcxODggLTAuMDAzOTA2MjUgMi4yNjU2MjUgLTAuMDM5MDYyNSAyLjE3MTg3NSAtMC4wOTM3NSBDIDIuMDc4MTI1IC0wLjE0NDUzMSAxLjk4ODI4MSAtMC4yMDMxMjUgMS45MDYyNSAtMC4yNjU2MjUgQyAxLjgyMDMxMiAtMC4zMzU5MzggMS43NSAtMC40MjE4NzUgMS42ODc1IC0wLjUxNTYyNSBMIDEuNjI1IC0wLjIzNDM3NSBDIDEuNjAxNTYyIC0wLjE0ODQzOCAxLjU2NjQwNiAtMC4wODU5Mzc1IDEuNTE1NjI1IC0wLjA0Njg3NSBDIDEuNDcyNjU2IC0wLjAxNTYyNSAxLjQxMDE1NiAwIDEuMzI4MTI1IDAgTCAwLjUxNTYyNSAwIEwgMC41MTU2MjUgLTYuNzAzMTI1IEwgMS43NSAtNi43MDMxMjUgWiBNIDEuNzUgLTQuMDkzNzUgIi8+PC9nPjwvZz48L2c+PGcgZmlsbD0iI2ZmZmZmZiIgZmlsbC1vcGFjaXR5PSIxIj48ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSg2Ni44ODIyMDYsIDE1Ljk2MDA2MikiPjxnPjxwYXRoIGQ9Ik0gMi41OTM3NSAtNC43MDMxMjUgQyAyLjk0NTMxMiAtNC43MDMxMjUgMy4yNjU2MjUgLTQuNjQ0NTMxIDMuNTQ2ODc1IC00LjUzMTI1IEMgMy44MjgxMjUgLTQuNDI1NzgxIDQuMDcwMzEyIC00LjI2OTUzMSA0LjI4MTI1IC00LjA2MjUgQyA0LjQ4ODI4MSAtMy44NTE1NjIgNC42NDQ1MzEgLTMuNjAxNTYyIDQuNzUgLTMuMzEyNSBDIDQuODYzMjgxIC0zLjAxOTUzMSA0LjkyMTg3NSAtMi42OTE0MDYgNC45MjE4NzUgLTIuMzI4MTI1IEMgNC45MjE4NzUgLTEuOTUzMTI1IDQuODYzMjgxIC0xLjYxNzE4OCA0Ljc1IC0xLjMyODEyNSBDIDQuNjQ0NTMxIC0xLjAzNTE1NiA0LjQ4ODI4MSAtMC43ODUxNTYgNC4yODEyNSAtMC41NzgxMjUgQyA0LjA3MDMxMiAtMC4zNjcxODggMy44MjgxMjUgLTAuMjA3MDMxIDMuNTQ2ODc1IC0wLjA5Mzc1IEMgMy4yNjU2MjUgMC4wMDc4MTI1IDIuOTQ1MzEyIDAuMDYyNSAyLjU5Mzc1IDAuMDYyNSBDIDIuMjUgMC4wNjI1IDEuOTI5Njg4IDAuMDA3ODEyNSAxLjY0MDYyNSAtMC4wOTM3NSBDIDEuMzU5Mzc1IC0wLjIwNzAzMSAxLjExMzI4MSAtMC4zNjcxODggMC45MDYyNSAtMC41NzgxMjUgQyAwLjcwNzAzMSAtMC43ODUxNTYgMC41NTA3ODEgLTEuMDM1MTU2IDAuNDM3NSAtMS4zMjgxMjUgQyAwLjMyMDMxMiAtMS42MTcxODggMC4yNjU2MjUgLTEuOTUzMTI1IDAuMjY1NjI1IC0yLjMyODEyNSBDIDAuMjY1NjI1IC0yLjY5MTQwNiAwLjMyMDMxMiAtMy4wMTk1MzEgMC40Mzc1IC0zLjMxMjUgQyAwLjU1MDc4MSAtMy42MDE1NjIgMC43MDcwMzEgLTMuODUxNTYyIDAuOTA2MjUgLTQuMDYyNSBDIDEuMTEzMjgxIC00LjI2OTUzMSAxLjM1OTM3NSAtNC40MjU3ODEgMS42NDA2MjUgLTQuNTMxMjUgQyAxLjkyOTY4OCAtNC42NDQ1MzEgMi4yNSAtNC43MDMxMjUgMi41OTM3NSAtNC43MDMxMjUgWiBNIDIuNTkzNzUgLTAuODU5Mzc1IEMgMi45NDUzMTIgLTAuODU5Mzc1IDMuMjA3MDMxIC0wLjk3NjU2MiAzLjM3NSAtMS4yMTg3NSBDIDMuNTUwNzgxIC0xLjQ2ODc1IDMuNjQwNjI1IC0xLjgzMjAzMSAzLjY0MDYyNSAtMi4zMTI1IEMgMy42NDA2MjUgLTIuNzg5MDYyIDMuNTUwNzgxIC0zLjE0ODQzOCAzLjM3NSAtMy4zOTA2MjUgQyAzLjIwNzAzMSAtMy42NDA2MjUgMi45NDUzMTIgLTMuNzY1NjI1IDIuNTkzNzUgLTMuNzY1NjI1IEMgMi4yMzgyODEgLTMuNzY1NjI1IDEuOTcyNjU2IC0zLjY0MDYyNSAxLjc5Njg3NSAtMy4zOTA2MjUgQyAxLjYyODkwNiAtMy4xNDg0MzggMS41NDY4NzUgLTIuNzg5MDYyIDEuNTQ2ODc1IC0yLjMxMjUgQyAxLjU0Njg3NSAtMS44MzIwMzEgMS42Mjg5MDYgLTEuNDY4NzUgMS43OTY4NzUgLTEuMjE4NzUgQyAxLjk3MjY1NiAtMC45NzY1NjIgMi4yMzgyODEgLTAuODU5Mzc1IDIuNTkzNzUgLTAuODU5Mzc1IFogTSAyLjU5Mzc1IC0wLjg1OTM3NSAiLz48L2c+PC9nPjwvZz48ZyBmaWxsPSIjZmZmZmZmIiBmaWxsLW9wYWNpdHk9IjEiPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKDcyLjA3MDM1NiwgMTUuOTYwMDYyKSI+PGc+PHBhdGggZD0iTSAyLjU5Mzc1IC00LjcwMzEyNSBDIDIuOTQ1MzEyIC00LjcwMzEyNSAzLjI2NTYyNSAtNC42NDQ1MzEgMy41NDY4NzUgLTQuNTMxMjUgQyAzLjgyODEyNSAtNC40MjU3ODEgNC4wNzAzMTIgLTQuMjY5NTMxIDQuMjgxMjUgLTQuMDYyNSBDIDQuNDg4MjgxIC0zLjg1MTU2MiA0LjY0NDUzMSAtMy42MDE1NjIgNC43NSAtMy4zMTI1IEMgNC44NjMyODEgLTMuMDE5NTMxIDQuOTIxODc1IC0yLjY5MTQwNiA0LjkyMTg3NSAtMi4zMjgxMjUgQyA0LjkyMTg3NSAtMS45NTMxMjUgNC44NjMyODEgLTEuNjE3MTg4IDQuNzUgLTEuMzI4MTI1IEMgNC42NDQ1MzEgLTEuMDM1MTU2IDQuNDg4MjgxIC0wLjc4NTE1NiA0LjI4MTI1IC0wLjU3ODEyNSBDIDQuMDcwMzEyIC0wLjM2NzE4OCAzLjgyODEyNSAtMC4yMDcwMzEgMy41NDY4NzUgLTAuMDkzNzUgQyAzLjI2NTYyNSAwLjAwNzgxMjUgMi45NDUzMTIgMC4wNjI1IDIuNTkzNzUgMC4wNjI1IEMgMi4yNSAwLjA2MjUgMS45Mjk2ODggMC4wMDc4MTI1IDEuNjQwNjI1IC0wLjA5Mzc1IEMgMS4zNTkzNzUgLTAuMjA3MDMxIDEuMTEzMjgxIC0wLjM2NzE4OCAwLjkwNjI1IC0wLjU3ODEyNSBDIDAuNzA3MDMxIC0wLjc4NTE1NiAwLjU1MDc4MSAtMS4wMzUxNTYgMC40Mzc1IC0xLjMyODEyNSBDIDAuMzIwMzEyIC0xLjYxNzE4OCAwLjI2NTYyNSAtMS45NTMxMjUgMC4yNjU2MjUgLTIuMzI4MTI1IEMgMC4yNjU2MjUgLTIuNjkxNDA2IDAuMzIwMzEyIC0zLjAxOTUzMSAwLjQzNzUgLTMuMzEyNSBDIDAuNTUwNzgxIC0zLjYwMTU2MiAwLjcwNzAzMSAtMy44NTE1NjIgMC45MDYyNSAtNC4wNjI1IEMgMS4xMTMyODEgLTQuMjY5NTMxIDEuMzU5Mzc1IC00LjQyNTc4MSAxLjY0MDYyNSAtNC41MzEyNSBDIDEuOTI5Njg4IC00LjY0NDUzMSAyLjI1IC00LjcwMzEyNSAyLjU5Mzc1IC00LjcwMzEyNSBaIE0gMi41OTM3NSAtMC44NTkzNzUgQyAyLjk0NTMxMiAtMC44NTkzNzUgMy4yMDcwMzEgLTAuOTc2NTYyIDMuMzc1IC0xLjIxODc1IEMgMy41NTA3ODEgLTEuNDY4NzUgMy42NDA2MjUgLTEuODMyMDMxIDMuNjQwNjI1IC0yLjMxMjUgQyAzLjY0MDYyNSAtMi43ODkwNjIgMy41NTA3ODEgLTMuMTQ4NDM4IDMuMzc1IC0zLjM5MDYyNSBDIDMuMjA3MDMxIC0zLjY0MDYyNSAyLjk0NTMxMiAtMy43NjU2MjUgMi41OTM3NSAtMy43NjU2MjUgQyAyLjIzODI4MSAtMy43NjU2MjUgMS45NzI2NTYgLTMuNjQwNjI1IDEuNzk2ODc1IC0zLjM5MDYyNSBDIDEuNjI4OTA2IC0zLjE0ODQzOCAxLjU0Njg3NSAtMi43ODkwNjIgMS41NDY4NzUgLTIuMzEyNSBDIDEuNTQ2ODc1IC0xLjgzMjAzMSAxLjYyODkwNiAtMS40Njg3NSAxLjc5Njg3NSAtMS4yMTg3NSBDIDEuOTcyNjU2IC0wLjk3NjU2MiAyLjIzODI4MSAtMC44NTkzNzUgMi41OTM3NSAtMC44NTkzNzUgWiBNIDIuNTkzNzUgLTAuODU5Mzc1ICIvPjwvZz48L2c+PC9nPjxnIGZpbGw9IiNmZmZmZmYiIGZpbGwtb3BhY2l0eT0iMSI+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoNzcuMjU4NTA2LCAxNS45NjAwNjIpIj48Zz48cGF0aCBkPSJNIDEuNzUgLTYuNzAzMTI1IEwgMS43NSAtMi44OTA2MjUgTCAxLjk1MzEyNSAtMi44OTA2MjUgQyAyLjAzNTE1NiAtMi44OTA2MjUgMi4wOTc2NTYgLTIuODk4NDM4IDIuMTQwNjI1IC0yLjkyMTg3NSBDIDIuMTc5Njg4IC0yLjk1MzEyNSAyLjIyNjU2MiAtMyAyLjI4MTI1IC0zLjA2MjUgTCAzLjI5Njg3NSAtNC40MjE4NzUgQyAzLjM0NzY1NiAtNC40OTIxODggMy40MDYyNSAtNC41NDY4NzUgMy40Njg3NSAtNC41NzgxMjUgQyAzLjUzOTA2MiAtNC42MDkzNzUgMy42MjUgLTQuNjI1IDMuNzE4NzUgLTQuNjI1IEwgNC44NTkzNzUgLTQuNjI1IEwgMy41MTU2MjUgLTIuOTM3NSBDIDMuNDEwMTU2IC0yLjgwMDc4MSAzLjI4OTA2MiAtMi42OTE0MDYgMy4xNTYyNSAtMi42MDkzNzUgQyAzLjIyNjU2MiAtMi41NTQ2ODggMy4yODkwNjIgLTIuNSAzLjM0Mzc1IC0yLjQzNzUgQyAzLjM5NDUzMSAtMi4zNzUgMy40NDE0MDYgLTIuMzA0Njg4IDMuNDg0Mzc1IC0yLjIzNDM3NSBMIDQuOTIxODc1IDAgTCAzLjgxMjUgMCBDIDMuNzA3MDMxIDAgMy42MTcxODggLTAuMDE1NjI1IDMuNTQ2ODc1IC0wLjA0Njg3NSBDIDMuNDg0Mzc1IC0wLjA3ODEyNSAzLjQyOTY4OCAtMC4xMzI4MTIgMy4zOTA2MjUgLTAuMjE4NzUgTCAyLjM0Mzc1IC0xLjkyMTg3NSBDIDIuMzAwNzgxIC0xLjk5MjE4OCAyLjI1MzkwNiAtMi4wMzkwNjIgMi4yMDMxMjUgLTIuMDYyNSBDIDIuMTYwMTU2IC0yLjA4MjAzMSAyLjA5NzY1NiAtMi4wOTM3NSAyLjAxNTYyNSAtMi4wOTM3NSBMIDEuNzUgLTIuMDkzNzUgTCAxLjc1IDAgTCAwLjUxNTYyNSAwIEwgMC41MTU2MjUgLTYuNzAzMTI1IFogTSAxLjc1IC02LjcwMzEyNSAiLz48L2c+PC9nPjwvZz48L3N2Zz4=');" onclick="window.open('https://drive.google.com/file/d/1YhTx_rO483vr5B8ibZtgl57-_G-Q2EiK/view?usp=share_link', '_blank');"></div></td>
        <td style="padding: 10px 20px;"><div style="background-color: lightblue; display: inline-block; border-radius: 4px; cursor: pointer; height: 32px; border: none; width: 123px; background-image: url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTI4IiBoZWlnaHQ9IjMyIiBmaWxsPSJub25lIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxyZWN0IHdpZHRoPSIxMjgiIGhlaWdodD0iMzIiIHJ4PSI0IiBmaWxsPSIjRkY2QzM3Ii8+PHBhdGggZD0iTTEyIDEwLjg4M2EuNS41IDAgMCAxIC43NTctLjQyOWw4LjUyOCA1LjExN2EuNS41IDAgMCAxIDAgLjg1OGwtOC41MjggNS4xMTdhLjUuNSAwIDAgMS0uNzU3LS40M1YxMC44ODRaTTI3Ljg4OSAyMC41MDloMS41OHYtMy4xOTdoMS42MTFsMS43MTMgMy4xOTdoMS43NjRsLTEuODg3LTMuNDZjMS4wMjctLjQxNCAxLjU2OC0xLjI5MiAxLjU2OC0yLjQ3NyAwLTEuNjY2LTEuMDc0LTIuNzktMy4wNzctMi43OWgtMy4yNzN2OC43MjdaTTI5LjQ2OCAxNnYtMi44OThoMS40NWMxLjE4IDAgMS43MDguNTQxIDEuNzA4IDEuNDcgMCAuOTMtLjUyOCAxLjQyOC0xLjcgMS40MjhIMjkuNDdaTTM5Ljc5NyAxNy43NTZjMCAuOTk3LS43MTIgMS40OTEtMS4zOTQgMS40OTEtLjc0MSAwLTEuMjM1LS41MjQtMS4yMzUtMS4zNTV2LTMuOTI5aC0xLjU0M3Y0LjE2OGMwIDEuNTcyLjg5NSAyLjQ2MyAyLjE4MiAyLjQ2My45OCAwIDEuNjctLjUxNiAxLjk2OS0xLjI0OWguMDY4djEuMTY0aDEuNDk1di02LjU0NmgtMS41NDJ2My43OTNaTTQ0LjQ2OCAxNi42NzNjMC0uOTQ2LjU3MS0xLjQ5MSAxLjM4NS0xLjQ5MS43OTcgMCAxLjI3NC41MjQgMS4yNzQgMS4zOTd2My45M2gxLjU0M1YxNi4zNGMuMDA0LTEuNTY4LS44OS0yLjQ2My0yLjI0MS0yLjQ2My0uOTggMC0xLjY1NC40NjktMS45NTIgMS4xOTdINDQuNHYtMS4xMTJoLTEuNDc0djYuNTQ2aDEuNTQydi0zLjgzNlpNNTMuMjE1IDIwLjUwOWgxLjU0MnYtNi41NDZoLTEuNTQydjYuNTQ2Wm0uNzc1LTcuNDc1Yy40OSAwIC44OTEtLjM3NS44OTEtLjgzNSAwLS40NjUtLjQtLjg0LS44OS0uODQtLjQ5NSAwLS44OTUuMzc1LS44OTUuODQgMCAuNDYuNC44MzUuODk0LjgzNVpNNTcuODg2IDE2LjY3M2MwLS45NDYuNTcxLTEuNDkxIDEuMzg1LTEuNDkxLjc5NyAwIDEuMjc0LjUyNCAxLjI3NCAxLjM5N3YzLjkzaDEuNTQzVjE2LjM0Yy4wMDQtMS41NjgtLjg5LTIuNDYzLTIuMjQxLTIuNDYzLS45OCAwLTEuNjU0LjQ2OS0xLjk1MiAxLjE5N2gtLjA3N3YtMS4xMTJoLTEuNDc0djYuNTQ2aDEuNTQydi0zLjgzNlpNNjYuNzAxIDIwLjUwOWgxLjU4MXYtMi45NWgxLjY3YzIuMDE2IDAgMy4wOTgtMS4yMSAzLjA5OC0yLjg4OSAwLTEuNjY2LTEuMDctMi44ODktMy4wNzYtMi44ODlINjYuN3Y4LjcyOFptMS41ODEtNC4yNXYtMy4xNTdoMS40NDljMS4xODQgMCAxLjcwOS42NCAxLjcwOSAxLjU2OSAwIC45MjgtLjUyNSAxLjU4OS0xLjcgMS41ODloLTEuNDU4Wk03Ny4xMTcgMjAuNjM2YzEuOTE3IDAgMy4xMzYtMS4zNSAzLjEzNi0zLjM3NSAwLTIuMDI4LTEuMjE5LTMuMzgzLTMuMTM2LTMuMzgzLTEuOTE4IDAtMy4xMzYgMS4zNTUtMy4xMzYgMy4zODMgMCAyLjAyNCAxLjIxOCAzLjM3NSAzLjEzNiAzLjM3NVptLjAwOC0xLjIzNWMtMS4wNiAwLTEuNTgtLjk0Ny0xLjU4LTIuMTQ0cy41Mi0yLjE1NiAxLjU4LTIuMTU2YzEuMDQ0IDAgMS41NjQuOTU5IDEuNTY0IDIuMTU2cy0uNTIgMi4xNDQtMS41NjQgMi4xNDRaTTg2LjczNiAxNS42OTNjLS4yMTMtMS4xMDgtMS4xLTEuODE1LTIuNjM0LTEuODE1LTEuNTc2IDAtMi42NS43NzUtMi42NDYgMS45ODYtLjAwNC45NTQuNTg0IDEuNTg1IDEuODQgMS44NDVsMS4xMTcuMjM0Yy42MDEuMTMyLjg4My4zNzUuODgzLjc0NiAwIC40NDctLjQ4Ni43ODQtMS4yMi43ODQtLjcwNyAwLTEuMTY3LS4zMDctMS4yOTktLjg5NWwtMS41MDQuMTQ1Yy4xOTIgMS4yMDIgMS4yMDEgMS45MTMgMi44MDggMS45MTMgMS42MzYgMCAyLjc5MS0uODQ4IDIuNzk1LTIuMDg4LS4wMDQtLjkzMy0uNjA1LTEuNTA0LTEuODQtMS43NzJsLTEuMTE3LS4yNGMtLjY2NS0uMTQ4LS45MjktLjM3OC0uOTI1LS43NTgtLjAwNC0uNDQzLjQ4Ni0uNzUgMS4xMy0uNzUuNzExIDAgMS4wODYuMzg4IDEuMjA2LjgxOWwxLjQwNi0uMTU0Wk05MS40MTcgMTMuOTYzaC0xLjI5MXYtMS41NjhoLTEuNTQzdjEuNTY4aC0uOTI5djEuMTkzaC45M3YzLjY0Yy0uMDEgMS4yMzEuODg1IDEuODM2IDIuMDQ0IDEuODAyYTMuMSAzLjEgMCAwIDAgLjkwOC0uMTUzbC0uMjYtMS4yMDZjLS4wODUuMDItLjI2LjA2LS40NTEuMDYtLjM4OCAwLS43LS4xMzctLjctLjc2di0zLjM4M2gxLjI5MnYtMS4xOTNaTTkyLjcwNyAyMC41MDloMS41NDN2LTMuOThjMC0uODA2LjUzNy0xLjM1MSAxLjIwMS0xLjM1MS42NTIgMCAxLjEuNDM4IDEuMSAxLjExMnY0LjIxOWgxLjUxM3YtNC4wODNjMC0uNzM3LjQzOS0xLjI0OCAxLjE4NC0xLjI0OC42MjIgMCAxLjExNy4zNjYgMS4xMTcgMS4xNzZ2NC4xNTVoMS41NDd2LTQuMzk0YzAtMS40NjItLjg0NC0yLjIzNy0yLjA0Ni0yLjIzNy0uOTUgMC0xLjY3NS40NjktMS45NjQgMS4xOTdoLS4wNjljLS4yNTEtLjc0MS0uODg2LTEuMTk3LTEuNzY4LTEuMTk3LS44NzggMC0xLjUzNC40NTEtMS44MDcgMS4xOTdoLS4wNzZ2LTEuMTEyaC0xLjQ3NXY2LjU0NlpNMTA1LjM2IDIwLjY0YzEuMDI3IDAgMS42NDEtLjQ4IDEuOTIyLTEuMDNoLjA1MXYuODk5aDEuNDgzdi00LjM4MWMwLTEuNzMtMS40MS0yLjI1LTIuNjU5LTIuMjUtMS4zNzYgMC0yLjQzMy42MTQtMi43NzQgMS44MDdsMS40NC4yMDRjLjE1NC0uNDQ3LjU4OC0uODMgMS4zNDItLjgzLjcxNiAwIDEuMTA4LjM2NiAxLjEwOCAxLjAxdi4wMjVjMCAuNDQzLS40NjQuNDY0LTEuNjE5LjU4OC0xLjI3LjEzNi0yLjQ4NC41MTUtMi40ODQgMS45OSAwIDEuMjg3Ljk0MiAxLjk2OSAyLjE5IDEuOTY5Wm0uNDAxLTEuMTMzYy0uNjQ0IDAtMS4xMDQtLjI5NC0xLjEwNC0uODYgMC0uNTkzLjUxNi0uODQgMS4yMDYtLjkzOC40MDUtLjA1NiAxLjIxNC0uMTU4IDEuNDE1LS4zMnYuNzcxYzAgLjczLS41ODggMS4zNDctMS41MTcgMS4zNDdaTTExMS45MSAxNi42NzNjMC0uOTQ2LjU3MS0xLjQ5MSAxLjM4NS0xLjQ5MS43OTcgMCAxLjI3NC41MjQgMS4yNzQgMS4zOTd2My45M2gxLjU0M1YxNi4zNGMuMDA0LTEuNTY4LS44OTEtMi40NjMtMi4yNDItMi40NjMtLjk4IDAtMS42NTMuNDY5LTEuOTUyIDEuMTk3aC0uMDc2di0xLjExMmgtMS40NzV2Ni41NDZoMS41NDN2LTMuODM2WiIgZmlsbD0iI2ZmZiIvPjwvc3ZnPg==');" onclick="window.open('https://www.postman.com/satusehat/workspace/satusehat-public/overview', '_blank');"></div></td>
    </tr>
</table>