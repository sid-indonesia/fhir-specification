# {{page-title}}


Sebelum dapat melakukan pertukaran data dari layanan SATUSEHAT, perlu dilakukan proses autentikasi terlebih dahulu. SATUSEHAT menggunakan autentikasi mengikuti standar protokol OAuth 2 dengan tipe pemberian akses (*grant type*)  adalah *client credentials*. Istilah autentikasi sendiri sebenarnya kurang tepat, karena protokol OAuth lebih kepada otorisasi/izin (*authorization*), yang didesain dengan tujuan agar memudahkan pemberian akses ke suatu resource atau data ke pihak lainnya berdasarkan tipe akses dan cakupan layanan yang diperbolehkan, baik dalam sistem yang manual, semi-otomatis, atau otomatis total.

Metode autentikasi layanan SATUSEHAT dapat dilakukan melalui FHIR OAuth API dengan *endpoint* utama sebagai berikut:

<br>

#### Endpoint

| **OAuth Base URL (Development)** | ```https://api-satusehat-dev.dto.kemkes.go.id/oauth2/v1```  |
| --- |------------------------- |
| **OAuth Base URL (Staging)** | ```https://api-satusehat-stg.dto.kemkes.go.id/oauth2/v1```  |
| **OAuth Base URL (Production)** | ```https://api-satusehat.kemkes.go.id/oauth2/v1```  |

<br>

#### Proses Mendapatkan Token

<table class="table table-bordered">
    <tr>
        <td><b>Method</b></td>
        <td>POST</td>
    </tr>
    <tr>
        <td><b>Target URL</b></td>
        <td><pre style="background: #F6F8F8;border: 1px solid #ffffff; color: maroon"><span style="color:green"><b>&#123;&#123;oauth_base_url&#125;&#125;</b></span>/accesstoken?grant_type=client_credentials</pre></td>
    </tr>
    <tr>
        <td><b>Header</b></td>
        <td><pre style="background: #F6F8F8;border: 1px solid #ffffff; color: maroon"><span style="color:green"><b>Content-Type:</b></span> application/x-www-form-urlencoded</pre></td>
    </tr>
    <tr>
        <td><b>Body (urlencoded)</b></td>
        <td><pre style="background: #F6F8F8;border: 1px solid #ffffff; color: maroon"><span style="color:green"><b>client_id:</b></span> &lt;nilai_client_id&gt; <br><span style="color:green"><b>client_secret:</b></span>&lt;nilai_client_secret&gt;</b></span></pre></td>
    </tr>
</table>

<br>

Berikut langkah-langkah untuk mendapatkan *access token* agar dapat melakukan pertukaran data dengan layanan SATUSEHAT:
1. Silakan melakukan pengajuan untuk mendapatkan client ID dan client secret dari tim DTO dengan mengirimkan email dengan subyek [Permintaan Client ID dan client secret] ke [ihs@dto.kemkes.go.id](mailto:ihs@dto.kemkes.go.id) dengan format:
   1. Nama
   2. Email
   3. Nama insitusi

2. Setelah dapat, isikan data tersebut sebagai *payload* untuk target API berikut:
    <pre style="background: #F6F8F8;border: 1px solid #ffffff; color: maroon"><span style="color:green"><b>&#123;&#123;oauth_base_url&#125;&#125;</b></span>/accesstoken?grant_type=client_credentials</pre>
3. Isikan data terkait request autentikasi sebagai body request dengan tipe konten <span style="color:green">(content-type):</span> ```application/x-www-form-urlencoded```, lalu tambahkan parameter serta isi nilai *client_id* dan *client_secret* dengan nilai yang sudah didapatkan saat pengajuan tadi.
4. Bila proses autentikasi berhasil, maka akan didapatkan *response* yang berisi *access token*, beserta informasi terkait rentang waktu access *token* tersebut dianggap *valid*.

<br>

Berikut contoh hasil response-nya:
<pre style="background: #F6F8F8;border: 1px solid #ffffff; color: maroon">{
  <span style="color:blue">"refresh_token_expires_in"</span>: "0",
  <span style="color:blue">"api_product_list"</span>: "[ihsv1]",
  <span style="color:blue">"api_product_list_json"</span>: [
    "ihsv1"
  ],
  <span style="color:blue">"organization_name"</span>: "ihs-1-339301",
  <span style="color:blue">"developer.</span>email": "rscm@test.com",
  <span style="color:blue">"token_type"</span>: "BearerToken",
  <span style="color:blue">"issued_at"</span>: "1656035748867",
  <span style="color:blue">"client_id"</span>: "6564BDpuLsOqw7EWgTGkSNnAGX12k1EKHz6NSRlfq46HqAGN",
  <span style="color:blue">"access_token"</span>: "RgQ5I5SWefv2Ka6oIaPKXNGCQSLo",
  <span style="color:blue">"application_name"</span>: "d6a8cb98-3008-4871-b86d-5a750b9f03e3",
  <span style="color:blue">"scope"</span>: "",
  <span style="color:blue">"expires_in"</span>: "3599",
  <span style="color:blue">"refresh_count": </span>"0",
  <span style="color:blue">"status"</span>: "approved"
}</pre>

<br>

Dari hasil response proses autentikasi tersebut nilai properti yang perlu diperhatikan adalah properti:
- *token_type*, tipe token yang perlu ada saat pertukaran data, berisi *BearerToken* yang berarti menggunakan otorisasi *Bearer* token
- *access_token*, nilai ini adalah token yang akan terus dipakai saat melakukan pertukaran data
- *expires_in*, menunjukan masa aktif *access_token* dalam detik, saat ini mempunyai masa aktif 1 jam (3600 detik)


<br>

Contoh autentikasi menggunakan cURL:
<pre style="background: #F6F8F8;border: 1px solid #ffffff; color: black">
curl --insecure --location --request POST 
<span style="color:blueviolet"><b>"https://api-satusehat-dev.dto.kemkes.go.id/oauth2/v1/accesstoken?grant_type=client_credentials"</b></span> --header 
<span style="color:blueviolet"><b>"Content-Type: application/x-www-form-urlencoded"</b></span> --data-urlencode 
<span style="color:blueviolet"><b>"client_id=&lt;nilai_client_id&gt;"</b></span> --data-urlencode <span style="color:blueviolet"><b>"client_secret=&lt;nilai_client_secret&gt;"</b></span>
</pre>


<br>
<br>

|<< {{pagelink:Home/Developer/Onboarding.page.md,text:Tahapan Integrasi}} | {{pagelink:Home,text:Halaman Utama}} | {{pagelink:Home/Developer/Organization.page.md,text:Registrasi Struktur Organisasi}} >> |
| --- |------------------------- | --------------- |