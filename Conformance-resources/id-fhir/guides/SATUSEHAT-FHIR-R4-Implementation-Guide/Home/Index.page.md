<!-- #### For English version : [Click here](home/index_en.page.md) -->
#### For English version : {{pagelink:Home/Index_EN.page.md,text:Click Here}}

# Panduan Implementasi SATUSEHAT FHIR R4 Indonesia 1.0.0
Panduan Implementasi ini adalah *Pre-Release* 0.1.0 dari SATUSEHAT FHIR R4 (ID Core).

Panduan implementasi ini memberikan dukungan untuk mengintegrasikan HL7 FHIR ke SATUSEHAT / Indonesia Health Service Platform (IHS). Ini mencakup konteks proses bisnis, penerapan kasus, serta dan panduan untuk menerapkan profil FHIR untuk kasus perjalanan pasien dalam suatu organisasi fasilitas pelayanan kesehatan (fasyankes).

Panduan implementasi ini didasarkan pada FHIR R4.

Panduan ini sedang dikembangkan secara aktif oleh Digital Trasformation Office (DTO), Kementerian Kesehatan, Pemerintah Republik Indonesia dan konten dapat ditambahkan atau diperbarui secara berkala.

**Catatan:** Panduan Implementasi sedang dalam pengerjaan yang berkesinambungan dalam versi *pre-release*. Konten Panduan Implementasi ini mungkin masih mengandung kesalahan, teks tidak lengkap, konten tidak konsisten, dll.

## Latar belakang
SATUSEHAT (sebelumnya disebut Indonesia Health Service/IHS) adalah platform nasional yang menyimpan informasi identitas dan data klinis pasien yang telah mendapatkan pelayanan kesehatan di Indonesia. Ini memungkinkan suatu organisasi untuk mengidentifikasi pasien secara unik berdasarkan *identifier* lokal atau global (misalnya nomor RM atau IHS Digital Number atau NIK) dan informasi demografis. Repositori digital data kesehatan akan melakukan sentralisasi beberapa catatan duplikat dari berbagai sumber informasi organisasi guna meningkatan kualitas informasi klien di berbagai organisasi kesehatan.

## Lingkup
Lingkup pra-rilis ini hanya untuk menyediakan aset dan panduan FHIR untuk tinjauan eksternal. Panduan ini TIDAK untuk diterapkan pada lingkungan *production*, dan belum ada rilis terbaru yang dapat digunakan untuk tujuan tersebut.

## Audiens yang dituju
Audiens untuk spesifikasi ini termasuk vendor atau organisasi yang menerapkan spesifikasi yang terdapat dalam panduan ini sebagai bagian dari pengembangan platform SATUSEHAT. Ini termasuk audiens teknis dan bisnis yang akan menggunakannya untuk mengembangkan implementasi dan memvalidasi bahwa mereka sesuai dengan spesifikasi dan persyaratan organisasi pemangku kepentingan.

Pembaca diharapkan memiliki pemahaman dasar tentang HL7 FHIR, pertukaran data kesehatan umum, dan paradigma RESTful HL7 FHIR.

## Kontrol berkas
Versi elektronik dari panduan implementasi ini diakui sebagai satu-satunya versi yang valid.

## *Disclaimer*
Anda memahami bahwa informasi dalam spesifikasi ini dapat berubah sewaktu-waktu dan bahwa kami tidak dapat bertanggung jawab atas kelengkapan, kebaruan, keakuratan, atau penerapan spesifikasi ini, atau informasi apa pun yang terkandung di dalamnya, untuk kebutuhan Anda atau kebutuhan pihak lain mana pun.

## Lisensi
Panduan Penerapan ini dilisensikan di bawah Lisensi Internasional Creative Commons Attribution-NoDerivatives 4.0; Anda tidak boleh menggunakan file ini kecuali sesuai dengan Lisensi. Anda dapat memperoleh salinan Lisensi di http://creativecommons.org/licenses/by-nd/4.0.

Standar HL7® FHIR® Hak Cipta © 2011+ HL7 Standar HL7® FHIR® digunakan di bawah lisensi FHIR. Anda dapat memperoleh salinan lisensi FHIR di https://www.hl7.org/fhir/license.html.

## Penerbit
Dikembangkan dan ditulis oleh Digital Transformation Office, Kementerian Kesehatan, Pemerintah Indonesia (DTO) dan diterbitkan oleh DTO.