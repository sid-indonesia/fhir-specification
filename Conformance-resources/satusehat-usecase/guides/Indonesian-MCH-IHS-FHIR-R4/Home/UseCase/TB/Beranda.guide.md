# Implementasi Use Case Tuberkulosis
Implementasi pelaporan kasus Tuberculosis (TB) secara umum dapat dikelompokkan menjadi 5 tahapan proses sebagai berikut:

<ol type="A">
    <li>
        <a title="Registrasi Kasus" href="#CaseRegistration"
            class="nhsd-a-link">Registrasi Kasus</a>
    </li>
    <li>
        <a title="Pemeriksaan Penunjang" href="#CaseFinding"
            class="nhsd-a-link">Pemeriksaan Penunjang</a>
    </li>
    <li>
        <a title="Verifikasi Kasus" href="#CaseVerification"
            class="nhsd-a-link">Verifikasi Kasus</a>
    </li>
    <li>
        <a title="Kunjungan Pengobatan Bulanan" href="#MonthlyVisit"
            class="nhsd-a-link">Kunjungan Pengobatan Bulanan</a>
    </li>
    <li>
        <a title="Kunjungan Akhir Pengobatan" href="#EndOfCareVisit"
            class="nhsd-a-link">Kunjungan Akhir Pengobatan</a>
    </li>
</ol>

Proses dimulai dari megistrasikan kasus yang berupa identitas pasien dan FASYANKES tempat terjadinya pemeriksaan disertai dengan permintaan pemeriksaan penunjang (laboratorium dan radiologi) yang dibutuhkan untuk dapat melakukan case finding. Hasil temuan yang diperoleh dari pemeriksaan penunjang digunakan untuk memverifikasi data kasus untuk menentukan bagaimana perawatan(pengobatan) kasus Tuberculosis selanjutnya. 

Dalam pelaksanaannya proses **Registrasi Kasus, Pemeriksaan Penunjang hingga Verifikasi Kasus** dapat dilaksanakan satu rangkaian pencatatan di awal perekaman kasus. Sehingga proses perekaman data TB dapat dikelompokkan menjadi tiga sesuai dengan fase pelaksanaannya seperti yang tergambar pada diagram berikut.

<img src="https://raw.githubusercontent.com/kemkes/fhir-ig-tb-assets/main/images/tb-flow-2.jpg" alt="alt text" title="Tuberculosis Workflow" style="width: 100%;">

Data yang telah Terkonfirmasi Bakteriologis dan Terdiagnosis Klinis akan ditindaklanjuti dengan pencatatan pada kunjungan perawatan bulanan. Data kunjungan tiap bulan tersebut dicatat dan dikirim sesuai tata laksana yaitu pada bulan kedua, ketiga dan kelima secara rutin. Baru kemudian pada kunjungan akhir perawatan dilakukan pencatatan hasil akhir dan dikirimkan ke SATUSEHAT.

## Strategi Pengiriman data ke SATUSEHAT
SATUSEHAT menyediakan dua pilihan cara mengirimkan data use case Tuberkulosis:

### 1. Berbasis Resource
Data dapat dikirimkan secara berurutan sesuai resource yang terlibat pada alur pelayanan terkait. Sebagai contoh: ketika mengirimkan data registrasi pasus saja yang berisikan resource Encounter dan Condition, maka implementor mengirimkan resource-resource tersebut ke SATUSEHAT secara berurutan sesuai dependensinya.

### 2. Berbasis Bundle
Data dapat dikirimkan seluruh resource yang terlibat pada alur pelayanan terkait dengan menggunakan satu langkah pengiriman data ke SATUSEHAT menggunakan profil FHIR bernama Bundle.

---

Resource-resource yang terlibat di setiap tahapan alur pelayanan untuk use case Tuberkulosis adalah sebagai berikut:

| No  | Resource                  | Entry Mandatory |
| --- |:------------------------- | --------------- |
| 1   | __Encounter *__           | __Required__    |
| 2   | __Observation__           | __Required__    |
| 3   | __DiagnosticReport__      | __Required__    |
| 4   | __Condition__             | __Required__    |
| 5   | __EpisodeOfCare__         | __Required__    |
| 6   | __Medication__            | _Optional_      |
| 7   | __MedicationRequest__     | _Optional_      |
| 8   | __QuestionnaireResponse__ | __Required__    |

__* ) Profile Resource yang direkomendasikan tersedia pada proses pencatatan__
Mandatory )
1. __Required__: Entry resource harus dilibatkan setiap kali mengirimkan bundle
2. _Optional_: Entry resource dapat tidak dilibatkan setiap kali mengirimkan bundle

