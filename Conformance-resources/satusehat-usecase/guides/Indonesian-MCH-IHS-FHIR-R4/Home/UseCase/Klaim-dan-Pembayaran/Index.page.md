# Implementasi Use Case Klaim dan Pembayaran
*Last Updated: 2023/09/17*

## A. Pendahuluan
Implementasi use case ini akan difokuskan pada proses integrasi antara BPJS dengan SATUSEHAT. Proses klaim biaya kesehatan yang terintegrasi antara BPJS dan SATUSEHAT dapat dilakukan di fasilitas pelayanan kesehatan (fasyankes) yang telah terintegrasi dengan SATUSEHAT. Data klinis dan data pembayaran yang dikirimkan oleh fasyankes ke SATUSEHAT ini nantinya akan dijadikan dasar verifikasi BPJS.

Tahapan alur integrasi dan resource yang digunakan pada proses klaim BPJS dengan SATUSEHAT secara keseluruhan dapat dilihat pada gambar dibawah ini: <br>
<center>
{{render:hf-integrasi-bpjs-satusehat-general}}

*Gambar 1. Skema integrasi data klaim BPJS dengan SATUSEHAT*
</center>

Implementasi proses klaim biaya perawatan pasien BPJS di fasilitas kesehatan secara umum dapat dikelompokkan menjadi 5 tahapan proses sebagai berikut:

<ol>
    <li>Prasyarat ketersediaan data kepesertaan BPJS</li>
    <li>Pengajuan Surat Eligibilitas Peserta (SEP)</li>
    <li>Pengiriman data klinis dan pembayaran pasien</li>
    <li>Pengajuan klaim biaya perawatan</li>
    <li>Verifikasi klaim biaya perawatan</li>
</ol>

Kelima tahapan proses integrasi ini melibatkan 3 organisasi pelaksana yang berbeda, yaitu fasyankes, BPJS, dan Pusjak (aplikasi E-Klaim), sehingga petunjuk cara implementasi yang akan dibahas di part selanjutnya akan dikategorikan berdasarkan:
<ol>
    <li> {{pagelink:Home/UseCase/Klaim-dan-Pembayaran/Fasyankes.page.md}}
    </li>
    <li> {{pagelink:Home/UseCase/Klaim-dan-Pembayaran/E-Klaim.page.md}}
    </li>
    <li> {{pagelink:Home/UseCase/Klaim-dan-Pembayaran/BPJS.page.md}}
    </li>
</ol>

<!--## B. Strategi Pengiriman Data ke SATUSEHAT-->
## B. Langkah-Langkah Pengiriman Data ke SATUSEHAT
### <div id="PengirimanDataKepesertaanBPJS">