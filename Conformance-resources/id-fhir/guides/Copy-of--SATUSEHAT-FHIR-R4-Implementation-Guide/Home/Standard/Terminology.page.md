## {{page-title}}

1. **ICD-10 sebagai Standar Diagnosis**
   
   ICD-10 adalah Klasifikasi Statistik Internasional Tentang Penyakit dan Masalah Kesehatan Revisi ke 10 atau the 10th revision of the International Statistical Classification of Diseases and Related Health Problems (ICD). ICD-10 adalah daftar klasifikasi medis yang dikeluarkan oleh WHO.

   <br>
   
   Akses terhadap ICD-10 dapat dilakukan melalui website pihak ketiga [website ICD-10](https://www.icd10data.com/ICD10CM/Codes).

   URL system : ```http://hl7.org/fhir/sid/icd-10```

   <br>

2. **ICD-9-CM - Standar Penamaan Prosedur & Tindakan Medis**
   
   ICD-9-CM adalah Klasifikasi dan Kodefikasi Prosedur Internasional Revisi ke 9 Modifikasi Klinis atau International Classification of Procedure Code, 9th Revision, Clinical Modification (ICD-9-CM) adalah standar untuk penamaan prosedur dan tindakan medis yang dikeluarkan oleh WHO

   <br>
   
   Akses terhadap ICD-9 CM dapat dilakukan melalui website pihak ketiga [website ICD-9 CM](http://www.icd9data.com/).

   URL system :  ```http://hl7.org/fhir/sid/icd-9-cm```

   <br>
   
3. **LOINC - Standar Penamaan Uji Laboratorium**
   
   Logical Observation Identifiers Name and Codes (LOINC) adalah database dan standar universal untuk mengidentifikasi pengamatan laboratorium medis. Memudahkan pemahaman kode karena terdiri dari sekelompok identifikasi, nama, dan kode untuk mengidentifikasi pengukuran kondisi, observasi, dan dokumen kesehatan

   <br>
   
   Akses terhadap LOINC dapat dilakukan melalui website pihak ketiga [LOINC search](https://loinc.org/search/). Anda memerlukan untuk membuat akun terlebih dahulu sebelum mengakses website LOINC search.

   Untuk melihat contoh mappingan LOINC yang sudah dilakukan tim DTO, dapat mengakses link pada website DTO [LOINC mapping example](https://dto.kemkes.go.id/terminology/loinc).

   URL system :  ```http://loinc.org```


   <br>


4. **SNOMED-CT - Standar Penamaan Istilah Klinis**
   
   SNOMED Clinical Terms (CT) adalah sebuah sistem yang menyediakan kosakata komprehensif konsep medis, termasuk kondisi medis dan anatomi, serta tes medis, perawatan, dan prosedur.

   <br>

   Akses terhadap SNOMED-CT dapat dilakukan melalui website pihak ketiga [SNOMED IPS Browser](https://ips-browser.snomedtools.org/).

   URL system :  ```http://snomed.info/sct```


   <br>
   

5. **Kamus Farmalkes KFA - Standar Penamaan Istilah Farmasi & Alat Kesehatan**
   
   Kamus Farmasi dan Alat Kesehatan (KFA) adalah kamus yang memuat kode unik produk farmasi dan alkes sehingga dapat digunakan dan diintegrasikan pada semua sistem  yang digunakan pelaku industri kesehatan.

   <br>

   Akses terhadap KFA dapat dilakukan melalui website DTO [KFA Browser](https://dto.kemkes.go.id/kfa-browser).

   URL system :  ```http://sys-ids.kemkes.go.id/kfa```


   <br>
   

6. **Kamus CVX - Standar Kode Vaksin**
   
   Kode CVX adalah kode yang menunjukkan produk yang digunakan dalam vaksinasi. Mereka dikelola oleh *Centers for Disease Control and Prevention (CDC), Immunization Information System Support Branch (IISSB)* yang digunakan dalam transmisi data HL7.
   
   <br>

   Akses terhadap klasifikasi terminologi CVX dan grup vaksinasi dapat mengacu pada lampiran Playbook Imunisasi.

   URL system :  ```http://hl7.org/fhir/sid/cvx```


   <br>
   

7. **Kamus Terminologi Kemenkes - Standar Istilah Klinis atau Klasifikasi Pendukung**

   Kamus Terminologi Kemenkes adalah terminologi yang dibuat untuk memenuhi kebutuhan use-case yang diterapkan di Indonesia. Umumnya terminologi ini mengikuti dengan nama use-case yang digunakan.
   
   <br>

   Akses terhadap terminology kemkes sementara ini dapat dilihat melalui Playbook use-case masing-masing.

   URL system :  ```http://terminology.kemkes.go.id/CodeSystem/[Set]``` atau ```http://fhir.kemkes.go.id/Questionnaire/[QuestionnaireSet]``` (untuk resource *QuestionnaireResponse / Questionnaire*)


   <br>
   

8. **Terminology HL7 - Standar Istilah Bawaan dari HL7 FHIR**

   Terminology HL7 merupakan terminologi bawaan dari HL7 FHIR yang digunakan untuk mendukung operasional dan melengkapi opsi pilihan yang direkomendasikan oleh HL.
   
   <br>

   Akses terhadap CodeSystem / ValueSet terminology kemkes sementara ini dapat dilihat melalui website [HL7 Terminology CodeSystems](https://terminology.hl7.org/4.0.0/codesystems.html).

   URL system :  ```http://terminology.hl7.org/CodeSystem/[Set]```


   <br>
   

<br>
<p style="text-align:right"><a href="#">Back to top</a></p>
<br>
<hr>