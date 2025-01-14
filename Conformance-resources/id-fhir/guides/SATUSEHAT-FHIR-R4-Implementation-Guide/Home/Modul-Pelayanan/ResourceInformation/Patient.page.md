## Pendaftaran Pasien

Untuk melakukan pendaftaran data pasien, diperlukan informasi SATUSEHAT ID dari pasien yang bersangkutan. Informasi terkait SATUSEHAT ID seorang pasien dapat didapatkan dari Master Patient Index (MPI). MPI menyimpan data-data demografi pasien berskala nasional, mulai dari nama, tanggal lahir, alamat, nomor identitas resmi yang diterbitkan pemerintah, dan lain lain. SATUSEHAT ID dapat disimpan secara di masing-masing sistem internal fasyankes maupun partner non-fasyankes. SATUSEHAT ID akan mempermudah pelaporan pelayanan kesehatan yang berhubungan dengan pasien, karena partner tidak diwajibkan menyertakan data diri setiap ada pengiriman data. SATUSEHAT ID juga dapat digunakan untuk melihat data diri pasien secara menyeluruh.


Metode pencarian data pasien dalam SATUSEHAT dapat dilakukan melalui FHIR API dengan detail sbb:

#### Endpoint

| **Base URL (Development)** | ```https://api-satusehat-dev.dto.kemkes.go.id/fhir-r4/v1```  |
| --- |------------------------- |
| **Base URL (Staging)** | ```https://api-satusehat-stg.dto.kemkes.go.id/fhir-r4/v1```  |
| **Base URL (Production)** | ```https://api-satusehat.kemkes.go.id/fhir-r4/v1```  |


<p><b>Contoh endpoint pencarian dengan NIK:</b></p>
<pre style="background: #F6F8F8;border: 1px solid #000000; color: maroon"><span style="color:green"><b>&#123;&#123;base_url&#125;&#125;</b></span>/Patient?identifier=https://fhir.kemkes.go.id/id/nik|3273246309870001</pre>

<p><b>Contoh endpoint pencarian dengan IHS Number:</b></p>
<pre style="background: #F6F8F8;border: 1px solid #000000; color: maroon"><span style="color:green"><b>&#123;&#123;base_url&#125;&#125;</b></span>/Patient/100000030009</pre>
<pre style="background: #F6F8F8;border: 1px solid #000000; color: maroon"><span style="color:green"><b>&#123;&#123;base_url&#125;&#125;</b></span>/Patient?identifier=https://fhir.kemkes.go.id/id/ihs-number|100000030009</pre>

<p><b>Contoh endpoint pencarian dengan nama pasien, gender, tahun lahir:</b></p>
<pre style="background: #F6F8F8;border: 1px solid #000000; color: maroon"><span style="color:green"><b>&#123;&#123;base_url&#125;&#125;</b></span>/Patient?name=smith&birthdate=1980-01&gender=male</pre>

<br><br>
#### Contoh Response hasil pencarian pasien dapat dilihat pada link : 
{{pagelink:Home/Examples/ResourceExample/Patient.page.md,text:Contoh Penggunaan Resource Patient}}

<br>
<p style="text-align:right"><a href="#">Back to top</a></p>
<br>
<hr>