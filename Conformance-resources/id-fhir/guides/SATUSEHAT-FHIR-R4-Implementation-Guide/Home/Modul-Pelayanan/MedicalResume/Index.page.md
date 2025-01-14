## Pengenalan Use-case Resume Medis Rawat Jalan

{{index:current}}


<hr>

### **Introduksi Use-case Resume Medis Rawat Jalan**
<br>


Resume medis adalah resume yang diberikan oleh dokter kepada pasien yang telah menjalani perawatan di rumah sakit. Resume medis ini berisi informasi tentang kondisi pasien, diagnosis, tindakan medis, dan resep obat yang diberikan kepada pasien. Resume medis ini juga dapat digunakan oleh dokter lain untuk melihat kondisi pasien yang telah pernah dirawat oleh dokter lain. Resume medis ini juga dapat digunakan oleh pasien untuk melihat kondisi dirinya sendiri.

Tahapan alur layanan rawat jalan secara umum dapat dilihat pada Gambar 1 :

<br>
<a href="https://raw.githubusercontent.com/fhir-kemkes/assets/main/Picture/MedicalResumeIntroChart.png"><img src="https://raw.githubusercontent.com/fhir-kemkes/assets/main/Picture/MedicalResumeIntroChart.png" alt="Intro Chart" style="width:80%; border:1px solid; padding:10px 10px 10px 10px"/></a>
<br>
<p align="center"><a href="https://raw.githubusercontent.com/fhir-kemkes/assets/main/Picture/MedicalResumeIntroChart.png">Gambar 1. Alur Layanan Rawat Jalan</a></p>


<br>
<br>

<p>Peta jalan pengiriman data dari Sistem Informasi Fasilitas Kesehatan terlampir pada Gambar 2 :</p><br>

<a href="https://raw.githubusercontent.com/fhir-kemkes/assets/main/Picture/MedicalResumeFHIRChart.png"><img src="https://raw.githubusercontent.com/fhir-kemkes/assets/main/Picture/MedicalResumeFHIRChart.png" alt="Intro Chart" style="width:80%;border:1px solid; padding:10px 10px 10px 10px"/></a>
<br>
<p align="center"><a href="https://raw.githubusercontent.com/fhir-kemkes/assets/main/Picture/MedicalResumeFHIRChart.png">Gambar 2. Metode pengiriman Resource FHIR Resume Rawat Jalan</a></p>

<br><br>
Pada tabel dibawah terlampir adalah *FHIR resource* yang digunakan untuk resume medis rawat jalan :

<div class="table-wrapper" markdown="block" style="overflow-x:scroll">
    <table class="table table-bordered">
        <tbody style="word-wrap:break-word;">
            <tr>
                <td>
                    <b>No</b>
                </td>
                <td colspan="2">
                    <b>Variabel</b>
                </td>
                <td>
                    <b>Resource FHIR</b>
                </td>
                <td>
                    <b>Path FHIR</b>
                </td>
            </tr>
            <tr>
                <td>
                    1
                </td>
                <td colspan="2">
                    Identitas Umum Pasien
                </td>
                <td><br></td>
                <td><br></td>
            </tr>
            <tr>
                <td rowspan="19"><br></td>
                <td rowspan="3">
                    a
                </td>
                <td rowspan="3">
                    Nomor SATUSEHAT Pasien
                </td>
                <td rowspan="3">
                    Patient
                </td>
                <td>
                    Patient.identifier.use
                </td>
            </tr>
            <tr>
                <td>
                    Patient.identifier.system
                </td>
            </tr>
            <tr>
                <td>
                    Patient.identifier.value
                </td>
            </tr>
            <tr>
                <td>
                    b
                </td>
                <td>
                    Nama Lengkap
                </td>
                <td>
                    Patient
                </td>
                <td>
                    Patient.name.text
                </td>
            </tr>
            <tr>
                <td rowspan="3">
                    c
                </td>
                <td rowspan="3">
                    Nomor Induk Kependudukan (NIK)
                </td>
                <td rowspan="3">
                    Patient
                </td>
                <td>
                    Patient.identifier.use
                </td>
            </tr>
            <tr>
                <td>
                    Patient.identifier.system
                </td>
            </tr>
            <tr>
                <td>
                    Patient.identifier.value
                </td>
            </tr>
            <tr>
                <td rowspan="3">
                    d
                </td>
                <td rowspan="3">
                    Nomor Identitas Lain (Khusus WNA) : Nomor Paspor / KITAS
                </td>
                <td rowspan="3">
                    Patient
                </td>
                <td>
                    Patient.identifier.use
                </td>
            </tr>
            <tr>
                <td>
                    Patient.identifier.system
                </td>
            </tr>
            <tr>
                <td>
                    Patient.identifier.value
                </td>
            </tr>
            <tr>
                <td>
                    e
                </td>
                <td>
                    Tempat Lahir
                </td>
                <td>
                    Patient
                </td>
                <td>
                    Patient.extension:birthPlace
                </td>
            </tr>
            <tr>
                <td>
                    f
                </td>
                <td>
                    Tanggal Lahir
                </td>
                <td>
                    Patient
                </td>
                <td>
                    Patient.birthDate
                </td>
            </tr>
            <tr>
                <td>
                    g
                </td>
                <td>
                    Jenis Kelamin
                </td>
                <td>
                    Patient
                </td>
                <td>
                    Patient.gender
                </td>
            </tr>
            <tr>
                <td>
                    h
                </td>
                <td>
                    Nama Penjamin
                </td>
                <td>
                    Patient
                </td>
                <td>
                    Patient.contact.name.text<br>
                </td>
            </tr>
            <tr>
                <td rowspan="3">
                    i
                </td>
                <td rowspan="3">
                    Nomor Telepon Penjamin
                </td>
                <td rowspan="3">
                    Patient
                </td>
                <td>
                    Patient.contact.telecom.system
                </td>
            </tr>
            <tr>
                <td>
                    Patient.contact.telecom.value
                </td>
            </tr>
            <tr>
                <td>
                    Patient.contact.telecom.use
                </td>
            </tr>
            <tr>
                <td>
                    j
                </td>
                <td>
                    Ruangan / Kelas / Poli
                </td>
                <td>
                    Encounter
                </td>
                <td>
                    Encounter.location
                </td>
            </tr>
            <tr>
                <td>
                    k
                </td>
                <td>
                    Nama Dokter Penanggung Jawab Pelayanan (DPJP)
                </td>
                <td>
                    Encounter
                </td>
                <td>
                    Encounter.participant
                </td>
            </tr>
            <tr>
                <td>
                    2
                </td>
                <td colspan="2">
                    Tanggal dan Waktu Masuk
                </td>
                <td><br></td>
                <td><br></td>
            </tr>
            <tr>
                <td rowspan="2"><br></td>
                <td>
                    a
                </td>
                <td>
                    Tanggal Masuk
                </td>
                <td>
                    Encounter
                </td>
                <td>
                    Encounter.period.start
                </td>
            </tr>
            <tr>
                <td>
                    b
                </td>
                <td>
                    Jam masuk
                </td>
                <td>
                    Encounter
                </td>
                <td>
                    Encounter.period.start
                </td>
            </tr>
            <tr>
                <td>
                    3
                </td>
                <td colspan="2">
                    Tanggal dan Waktu Discharge Administrasi
                </td>
                <td><br></td>
                <td><br></td>
            </tr>
            <tr>
                <td rowspan="2"><br></td>
                <td>
                    a
                </td>
                <td>
                    Tanggal Discharge Administrasi
                </td>
                <td>
                    Encounter
                </td>
                <td>
                    Encounter.period.end
                </td>
            </tr>
            <tr>
                <td>
                    b
                </td>
                <td>
                    Jam Discharge Administrasi
                </td>
                <td>
                    Encounter
                </td>
                <td>
                    Encounter.period.end
                </td>
            </tr>
            <tr>
                <td>
                    4
                </td>
                <td colspan="2">
                    Diagnosis
                </td>
                <td><br></td>
                <td><br></td>
            </tr>
            <tr>
                <td rowspan="12"><br></td>
                <td rowspan="3">
                    a
                </td>
                <td rowspan="3">
                    Diagnosis Awal / Masuk
                </td>
                <td rowspan="2">
                    Encounter
                </td>
                <td>
                    Encounter.diagnosis.condition
                </td>
            </tr>
            <tr>
                <td>
                    Encounter.diagnosis.use
                </td>
            </tr>
            <tr>
                <td>
                    Condition
                </td>
                <td>
                    Condition.code
                </td>
            </tr>
            <tr>
                <td>
                    b
                </td>
                <td>
                    Diagnosis Akhir / Keluar
                </td>
                <td><br></td>
                <td><br></td>
            </tr>
            <tr>
                <td rowspan="8"><br></td>
                <td rowspan="4">
                    <ol>
                        <li>
                            Diagnosis Primer / Utama
                        </li>
                    </ol>
                </td>
                <td rowspan="3">
                    Encounter
                </td>
                <td>
                    Encounter.diagnosis.condition
                </td>
            </tr>
            <tr>
                <td>
                    Encounter.diagnosis.use
                </td>
            </tr>
            <tr>
                <td>
                    Encounter.diagnosis.rank
                </td>
            </tr>
            <tr>
                <td>
                    Condition
                </td>
                <td>
                    Condition.code
                </td>
            </tr>
            <tr>
                <td rowspan="4">
                    <ol start="2">
                        <li>
                            Diagnosis Sekunder / Penyerta
                        </li>
                    </ol>
                </td>
                <td rowspan="3">
                    Encounter
                </td>
                <td>
                    Encounter.diagnosis.condition.code
                </td>
            </tr>
            <tr>
                <td>
                    Encounter.diagnosis.use
                </td>
            </tr>
            <tr>
                <td>
                    Encounter.diagnosis.rank
                </td>
            </tr>
            <tr>
                <td>
                    Condition
                </td>
                <td>
                    Condition.code
                </td>
            </tr>
            <tr>
                <td>
                    5
                </td>
                <td colspan="2">
                    Pemeriksaan Penunjang
                </td>
                <td><br></td>
                <td><br></td>
            </tr>
            <tr>
                <td rowspan="3"><br></td>
                <td rowspan="3">
                    a
                </td>
                <td rowspan="3">
                    Laboratorium
                </td>
                <td rowspan="3">
                    Observation
                </td>
                <td>
                    Observation.category.coding
                </td>
            </tr>
            <tr>
                <td>
                    Observation.code.coding
                </td>
            </tr>
            <tr>
                <td>
                    Observation.value[x]
                </td>
            </tr>
            <tr>
                <td rowspan="2">
                    6
                </td>
                <td colspan="2" rowspan="2">
                    Tindakan / Prosedur Medis
                </td>
                <td rowspan="2">
                    Procedure
                </td>
                <td>
                    Procedure.code.coding
                </td>
            </tr>
            <tr>
                <td>
                    Procedure.category.coding
                </td>
            </tr>
            <tr>
                <td>
                    7
                </td>
                <td colspan="2">
                    Obat-obatan / Terapi
                </td>
                <td><br></td>
                <td><br></td>
            </tr>
            <tr>
                <td rowspan="11"><br></td>
                <td rowspan="2">
                    a
                </td>
                <td rowspan="2">
                    Nama Obat
                </td>
                <td>
                    Medication
                </td>
                <td>
                    Medication.code
                </td>
            </tr>
            <tr>
                <td>
                    MedicationRequest
                </td>
                <td>
                    MedicationRequest.medicationReference
                </td>
            </tr>
            <tr>
                <td rowspan="2">
                    b
                </td>
                <td rowspan="2">
                    Bentuk / Sediaan
                </td>
                <td>
                    Medication
                </td>
                <td>
                    Medication.form
                </td>
            </tr>
            <tr>
                <td>
                    MedicationRequest
                </td>
                <td>
                    MedicationRequest.medicationReference
                </td>
            </tr>
            <tr>
                <td>
                    c
                </td>
                <td>
                    Jumlah Obat
                </td>
                <td>
                    MedicationRequest
                </td>
                <td>
                    MedicationRequest.dispenseRequest.quantity
                </td>
            </tr>
            <tr>
                <td>
                    d
                </td>
                <td>
                    Metode / Rute Pemberian
                </td>
                <td>
                    MedicationRequest
                </td>
                <td>
                    MedicationRequest.dosageInstruction.route
                </td>
            </tr>
            <tr>
                <td>
                    e
                </td>
                <td>
                    Dosis Obat yang Diberikan
                </td>
                <td>
                    MedicationRequest
                </td>
                <td>
                    MedicationRequest.dosageInstruction.doseAndRate.doseQuantity.value
                </td>
            </tr>
            <tr>
                <td>
                    f
                </td>
                <td>
                    Unit
                </td>
                <td>
                    MedicationRequest
                </td>
                <td>
                    MedicationRequest.dosageInstruction.doseAndRate.doseQuantity.unit
                </td>
            </tr>
            <tr>
                <td>
                    g
                </td>
                <td>
                    Frekuensi / Interval
                </td>
                <td>
                    MedicationRequest
                </td>
                <td>
                    MedicationRequest.dosageInstruction.timing
                </td>
            </tr>
            <tr>
                <td rowspan="2">
                    h
                </td>
                <td rowspan="2">
                    Aturan Tambahan
                </td>
                <td rowspan="2">
                    MedicationRequest
                </td>
                <td>
                    MedicationRequest.dosageInstruction.additionalInstruction.coding
                </td>
            </tr>
            <tr>
                <td>
                    MedicationRequest.dosageInstruction.additionalInstruction.text
                </td>
            </tr>
            <tr>
                <td rowspan="4">
                    8
                </td>
                <td colspan="2" rowspan="4">
                    Diet
                </td>
                <td rowspan="4">
                    Composition
                </td>
                <td>
                    Composition.type
                </td>
            </tr>
            <tr>
                <td>
                    Composition.section.code.coding
                </td>
            </tr>
            <tr>
                <td>
                    Composition.text.status
                </td>
            </tr>
            <tr>
                <td>
                    Composition.text.div
                </td>
            </tr>
            <tr>
                <td rowspan="2">
                    9
                </td>
                <td colspan="2" rowspan="2">
                    Alergi
                </td>
                <td rowspan="2">
                    AllergyIntolerance
                </td>
                <td>
                    AllergyIntolerance.category.coding
                </td>
            </tr>
            <tr>
                <td>
                    AllergyIntolerance.code.coding
                </td>
            </tr>
            <tr>
                <td>
                    10
                </td>
                <td colspan="2">
                    Prognosis
                </td>
                <td>
                    ClinicalImpression
                </td>
                <td>
                    ClinicalImpression.prognosisCodeableConcept.coding
                </td>
            </tr>
            <tr>
                <td rowspan="2">
                    11
                </td>
                <td colspan="2" rowspan="2">
                    Kondisi Saat Meninggalkan Rumah Sakit
                </td>
                <td>
                    Condition
                </td>
                <td>
                    Condition.code
                </td>
            </tr>
            <tr>
                <td>
                    Encounter
                </td>
                <td>
                    Encounter.hospitalization.dischargeDisposition
                </td>
            </tr>
            <tr>
                <td rowspan="3">
                    12
                </td>
                <td colspan="2" rowspan="3">
                    Tingkat Kesadaran
                </td>
                <td rowspan="3">
                    Observation
                </td>
                <td>
                    Observation.category.coding
                </td>
            </tr>
            <tr>
                <td>
                    Observation.code.coding
                </td>
            </tr>
            <tr>
                <td>
                    Observation.valueCodeableConcept.coding
                </td>
            </tr>
            <tr>
                <td>
                    13
                </td>
                <td colspan="2">
                    Keadaan umum
                </td>
                <td><br></td>
                <td><br></td>
            </tr>
            <tr>
                <td rowspan="17"><br></td>
                <td>
                    a
                </td>
                <td>
                    Vital Sign
                </td>
                <td><br></td>
                <td><br></td>
            </tr>
            <tr>
                <td rowspan="16"><br></td>
                <td rowspan="3">
                    <ol>
                        <li>
                            Denyut jantung
                        </li>
                    </ol>
                </td>
                <td rowspan="3">
                    Observation
                </td>
                <td>
                    Observation.category.coding
                </td>
            </tr>
            <tr>
                <td>
                    Observation.code.coding
                </td>
            </tr>
            <tr>
                <td>
                    Observation.valueQuantity
                </td>
            </tr>
            <tr>
                <td rowspan="3">
                    <ol start="2">
                        <li>
                            Pernapasan
                        </li>
                    </ol>
                </td>
                <td rowspan="3">
                    Observation
                </td>
                <td>
                    Observation.category.coding
                </td>
            </tr>
            <tr>
                <td>
                    Observation.code.coding
                </td>
            </tr>
            <tr>
                <td>
                    Observation.valueQuantity
                </td>
            </tr>
            <tr>
                <td>
                    <ol start="3">
                        <li>
                            Tekanan darah
                        </li>
                    </ol>
                </td>
                <td><br></td>
                <td><br></td>
            </tr>
            <tr>
                <td rowspan="3">
                    *Sistole
                </td>
                <td rowspan="3">
                    Observation
                </td>
                <td>
                    Observation.category.coding
                </td>
            </tr>
            <tr>
                <td>
                    Observation.code.coding
                </td>
            </tr>
            <tr>
                <td>
                    Observation.valueQuantity
                </td>
            </tr>
            <tr>
                <td rowspan="3">
                    *Diastole
                </td>
                <td rowspan="3">
                    Observation
                </td>
                <td>
                    Observation.category.coding
                </td>
            </tr>
            <tr>
                <td>
                    Observation.code.coding
                </td>
            </tr>
            <tr>
                <td>
                    Observation.valueQuantity
                </td>
            </tr>
            <tr>
                <td rowspan="3">
                    <ol start="4">
                        <li>
                            Suhu tubuh
                        </li>
                    </ol>
                </td>
                <td rowspan="3">
                    Observation
                </td>
                <td>
                    Observation.category.coding
                </td>
            </tr>
            <tr>
                <td>
                    Observation.code.coding
                </td>
            </tr>
            <tr>
                <td>
                    Observation.valueQuantity
                </td>
            </tr>
            <tr>
                <td rowspan="2">
                    14
                </td>
                <td colspan="2" rowspan="2">
                    Rencana Tindak Lanjut / Cara Keluar dari Rumah Sakit
                </td>
                <td>
                    Encounter
                </td>
                <td>
                    Encounter.hospitalization.dischargeDisposition
                </td>
            </tr>
            <tr>
                <td>
                    ServiceRequest
                </td>
                <td>
                    ServiceRequest.code.coding
                </td>
            </tr>
            <tr>
                <td>
                    15
                </td>
                <td colspan="2">
                    Obat yang Dibawa Pulang
                </td>
                <td><br></td>
                <td><br></td>
            </tr>
            <tr>
                <td rowspan="11"><br></td>
                <td rowspan="2">
                    a
                </td>
                <td rowspan="2">
                    Nama Obat
                </td>
                <td>
                    Medication
                </td>
                <td>
                    Medication.code
                </td>
            </tr>
            <tr>
                <td>
                    MedicationDispense
                </td>
                <td>
                    MedicationDispense.medicationReference
                </td>
            </tr>
            <tr>
                <td rowspan="2">
                    b
                </td>
                <td rowspan="2">
                    Bentuk / Sediaan
                </td>
                <td>
                    Medication
                </td>
                <td>
                    Medication.form
                </td>
            </tr>
            <tr>
                <td>
                    MedicationDispense
                </td>
                <td>
                    MedicationDispense.medicationReference
                </td>
            </tr>
            <tr>
                <td>
                    c
                </td>
                <td>
                    Jumlah Obat
                </td>
                <td>
                    MedicationDispense
                </td>
                <td>
                    MedicationDispense.quantity
                </td>
            </tr>
            <tr>
                <td>
                    d
                </td>
                <td>
                    Metode / Rute Pemberian
                </td>
                <td>
                    MedicationDispense
                </td>
                <td>
                    MedicationDispense.dosageInstruction.route
                </td>
            </tr>
            <tr>
                <td>
                    e
                </td>
                <td>
                    Dosis Obat yang Diberikan
                </td>
                <td>
                    MedicationDispense
                </td>
                <td>
                    MedicationDispense.dosageInstruction.doseAndRate.doseQuantity.value
                </td>
            </tr>
            <tr>
                <td>
                    f
                </td>
                <td>
                    Unit
                </td>
                <td>
                    MedicationDispense
                </td>
                <td>
                    MedicationDispense.dosageInstruction.doseAndRate.doseQuantity.unit
                </td>
            </tr>
            <tr>
                <td>
                    g
                </td>
                <td>
                    Frekuensi / Interval
                </td>
                <td>
                    MedicationDispense
                </td>
                <td>
                    MedicationDispense.dosageInstruction.timing
                </td>
            </tr>
            <tr>
                <td rowspan="2">
                    h
                </td>
                <td rowspan="2">
                    Aturan Tambahan
                </td>
                <td rowspan="2">
                    MedicationDispense
                </td>
                <td>
                    MedicationDispense.dosageInstruction.additionalInstruction.coding
                </td>
            </tr>
            <tr>
                <td>
                    MedicationDispense.dosageInstruction.additionalInstruction.text
                </td>
            </tr>
            <tr>
                <td>
                    16
                </td>
                <td colspan="2">
                    Instruksi untuk Tindak Lanjut
                </td>
                <td><br></td>
                <td><br></td>
            </tr>
            <tr>
                <td rowspan="3"><br></td>
                <td>
                    a
                </td>
                <td>
                    Kontrol ke
                </td>
                <td rowspan="3">
                    ServiceRequest
                </td>
                <td>
                    ServiceRequest.performer.organization
                    ServiceRequest.performer.locationReference
                    ServiceRequest.performer.locationCode
                </td>
            </tr>
            <tr>
                <td>
                    b
                </td>
                <td>
                    Tanggal
                </td>
                <td>
                    ServiceRequest.occurenceDateTime
                </td>
            </tr>
            <tr>
                <td>
                    c
                </td>
                <td>
                    Dalam Keadaan Darurat dapat Menghubungi
                </td>
                <td>
                    ServiceRequest.patientInstruction
                </td>
            </tr>
            <tr>
                <td>
                    17
                </td>
                <td colspan="2">
                    Edukasi
                </td>
                <td>
                    Procedure
                </td>
                <td>
                    Procedure.code.coding
                </td>
            </tr>
            <tr>
                <td>
                    18
                </td>
                <td colspan="2">
                    Sarana Transportasi Untuk Rujuk
                </td>
                <td>
                    ServiceRequest
                </td>
                <td>
                    ServiceRequest.locationCode
                </td>
            </tr>
            <tr>
                <td>
                    19
                </td>
                <td colspan="2">
                    Pasien / Penanggung Jawab (Nama dan Tanda Tangan)
                </td>
                <td>
                    Encounter
                </td>
                <td>
                    Encounter.subject
                </td>
            </tr>
            <tr>
                <td>
                    20
                </td>
                <td colspan="2">
                    Dokter Penanggung Jawab Pelayanan (Nama dan Tanda Tangan)
                </td>
                <td>
                    Encounter
                </td>
                <td>
                    Encounter.participant
                    Encounter.participant.type
                </td>
            </tr>
        </tbody>
    </table>
</div>

<br>
<p style="text-align:right"><a href="#">Back to top</a>
<br>
<hr>
