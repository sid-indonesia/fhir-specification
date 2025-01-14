## {{page-title}}

Untuk melakukan pendaftaran data nakes, diperlukan informasi SATUSEHAT ID dari nakes yang bersangkutan. Informasi terkait SATUSEHAT ID seorang pasien dapat didapatkan dari Master Nakes Index (MNI). MNI menyimpan data-data nakes dari seluruh sumber yang secara resmi menerbitkan daftar tenaga kesehatan. SATUSEHAT ID dapat disimpan secara di masing-masing sistem internal fasilitas kesehatan maupun mitra selain fasilitas kesehatan. SATUSEHAT ID akan mempermudah pelaporan pelayanan kesehatan yang berhubungan dengan nakes.

Metode pencarian data nakes dalam IHS dapat dilakukan melalui FHIR API dengan detail sbb:


#### Endpoint

| **Base URL (Development)** | ```https://api-satusehat-dev.dto.kemkes.go.id/fhir-r4/v1```  |
| --- |------------------------- |
| **Base URL (Staging)** | ```https://api-satusehat-stg.dto.kemkes.go.id/fhir-r4/v1```  |
| **Base URL (Production)** | ```https://api-satusehat.kemkes.go.id/fhir-r4/v1```  |

<br>

<p><b>Contoh endpoint pencarian dengan NIK:</b></p>
<pre style="background: #F6F8F8;border: 1px solid #000000; color: maroon"><span style="color:green"><b>&#123;&#123;base_url&#125;&#125;</b></span>/Practitioner?identifier=https://fhir.kemkes.go.id/id/nik|3171022809990001</pre>

<p><b>Contoh endpoint pencarian dengan IHS Number:</b></p>
<pre style="background: #F6F8F8;border: 1px solid #000000; color: maroon"><span style="color:green"><b>&#123;&#123;base_url&#125;&#125;</b></span>/Practitioner/100000030009</pre>
<pre style="background: #F6F8F8;border: 1px solid #000000; color: maroon"><span style="color:green"><b>&#123;&#123;base_url&#125;&#125;</b></span>/Practitioner?identifier=https://fhir.kemkes.go.id/id/ihs-number|100000030009</pre>

<!-- 
<p><b>Contoh endpoint pencarian dengan nama Nakes:</b></p>
<pre style="background: #F6F8F8;border: 1px solid #000000; color: maroon"><span style="color:green"><b>&#123;&#123;base_url&#125;&#125;</b></span>/Practitioner?given=budi</pre>
<pre style="background: #F6F8F8;border: 1px solid #000000; color: maroon"><span style="color:green"><b>&#123;&#123;base_url&#125;&#125;</b></span>/Practitioner?given:exact=budi</pre>
<pre style="background: #F6F8F8;border: 1px solid #000000; color: maroon"><span style="color:green"><b>&#123;&#123;base_url&#125;&#125;</b></span>/Practitioner?family=santoso</pre>
<pre style="background: #F6F8F8;border: 1px solid #000000; color: maroon"><span style="color:green"><b>&#123;&#123;base_url&#125;&#125;</b></span>/Practitioner?family:exact=budi</pre>
<pre style="background: #F6F8F8;border: 1px solid #000000; color: maroon"><span style="color:green"><b>&#123;&#123;base_url&#125;&#125;</b></span>/Practitioner?name=santoso</pre> -->


<!-- <p><b>Contoh endpoint pencarian dengan kombinasi nama Nakes & tanggal lahir:</b></p>
<pre style="background: #F6F8F8;border: 1px solid #000000; color: maroon"><span style="color:green"><b>&#123;&#123;base_url&#125;&#125;</b></span>/Practitioner?given=john&birthdate=1944-11-17</pre>
<pre style="background: #F6F8F8;border: 1px solid #000000; color: maroon"><span style="color:green"><b>&#123;&#123;base_url&#125;&#125;</b></span>/Practitioner?given=john&birthdate=1944</pre> -->

<p><b>Contoh endpoint pencarian dengan kombinasi nama Nakes , gender, dan tanggal lahir:</b></p>
<pre style="background: #F6F8F8;border: 1px solid #000000; color: maroon"><span style="color:green"><b>&#123;&#123;base_url&#125;&#125;</b></span>/Practitioner?name=john&gender=male&birthdate=1944-11-17</pre>
<pre style="background: #F6F8F8;border: 1px solid #000000; color: maroon"><span style="color:green"><b>&#123;&#123;base_url&#125;&#125;</b></span>/Practitioner?given=john&gender=male&birthdate=1944</pre>


<br><br>
#### Contoh Response hasil pencarian nakes dapat dilihat pada link : 
{{pagelink:Home/Examples/ResourceExample/Practitioner.page.md,text:Contoh Penggunaan Resource Practitioner}}

<br>
<br>

|<< {{pagelink:Home/Developer/Location.page.md,text:Registrasi Struktur Lokasi}} | {{pagelink:Home,text:Halaman Utama}} | {{pagelink:Home/UseCase,text:Lihat Contoh Penerapan}} >> |
| --- |------------------------- | --------------- |