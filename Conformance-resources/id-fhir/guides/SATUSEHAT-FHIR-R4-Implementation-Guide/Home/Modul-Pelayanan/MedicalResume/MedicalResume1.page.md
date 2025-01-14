<h1><a href="https://simplifier.net/guide/SATUSEHAT-FHIR-R4-Implementation-Guide/Home/UseCase/MedicalResume/MedicalResume1.page.md?version=current"  style="color:black">Medical Resume Part 1 -- Kunjungan dan Diagnosis</a></h1>

<br>
<br>

Pada Medical Resume Part 1, akan dijelaskan bagaimana cara mengisi kunjungan dan diagnosis pasien. Kunjungan dan diagnosis merupakan data yang sangat penting untuk mengetahui kondisi pasien. Data ini merupakan data esensial yang didapatkan pada fasilitas kesehatan dasar dimulai dari praktik mandiri, klinik, puskesmas, dan rumah sakit. Informasi ini digunakan untuk menentukan tindakan selanjutnya yang akan dilakukan oleh dokter dan menentukan obat yang akan diberikan kepada pasien.

Sebelum memulai mengisi kunjungan dan diagnosis, pastikan bahwa Sistem Informasi sudah memiliki data prasyarat sebagai berikut : 
1. Informasi [*Organization*](https://simplifier.net/guide/SATUSEHAT-FHIR-R4-Implementation-Guide/Home/Developer/Organization.page.md?version=current) yang disimpan pada Sistem Informasi Fasyankes berupa Organisasi induk (```Organization IHS Number``` & nama fasyankes), dan identitas Sub Organisasi (Organization.id & nama suborganisasi).
2. Informasi [*Location*](https://simplifier.net/guide/SATUSEHAT-FHIR-R4-Implementation-Guide/Home/Developer/Location.page.md?version=current) poliklinik yang disimpan pada Sistem Informasi Fasyankes berupa ```Location.id``` dan identitas nama poliklinik.
3. Identitas [*Practitioner*](https://simplifier.net/guide/SATUSEHAT-FHIR-R4-Implementation-Guide/Home/Developer/Practitioner.page.md?version=current) yang disimpan pada Sistem Informasi Fasyankes berupa ```Practitioner IHS Number``` dan identitas nama dokter.
4. Identitas [*Patient*](https://simplifier.net/guide/SATUSEHAT-FHIR-R4-Implementation-Guide/Home/UseCase/ResourceInformation/Patient.page.md?version=current) yang disimpan pada Sistem Informasi Fasyankes berupa ```Patient IHS Number```.

<br><hr><br>

## Ilustrasi Kasus Resume Medis Part 1
Pasien bernama Budi Santoso melakukan kunjungan rawat jalan dengan Dokter Bronsig pada tanggal 14 Juni 2022 jam 7 pagi di RSUD Jati Asih. Budi selesai diperiksa oleh dokter dan didiagnosa dengan:
1. Primer: Penyakit Tuberkulosis Paru berdasarkan hasil tes sputum dan diabetes melitus tipe 2 
2. Sekunder: Diabetes Mellitus tanpa komplikasi

Resource used : [*Encounter*](https://simplifier.net/guide/SATUSEHAT-FHIR-R4-Implementation-Guide/Home/UseCase/ResourceInformation/Encounter.page.md?version=current), [*Condition*](https://simplifier.net/guide/SATUSEHAT-FHIR-R4-Implementation-Guide/Home/UseCase/ResourceInformation/Condition.page.md?version=current)


<p id="Encounter-MedicalResume-Arrived"></p>

### 1. Pendaftaran Kunjungan Pasien Walk-in

<div id="accordion">
    <div class="card">
        <div class="card-header" id="EncounterHeading-1">
            <h5 class="mb-0">
                <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#EncounterCollapse-1" aria-expanded="false" aria-controls="EncounterCollapse-1">
                    <h3 style="text-align:left">Langkah 1</h3>
                    <p style="text-align:left">Kunjungan awal - POST <code><i>Encounter</i></code>
                    <br>Status : <code>arrived</code></p>
                </button>
            </h5>
        </div>
        <div id="EncounterCollapse-1" class="collapse" aria-labelledby="EncounterHeading-1" data-parent="#accordion">
            <div class="card-body">                
                <table class="table table-bordered">
                        <tr>
                                <td><b>Method</b></td>
                                <td>POST</td>
                        </tr>
                        <tr>
                                <td><b>Target URL</b></td>
                                <td><pre style="background: #F6F8F8;border: 1px solid #ffffff; color: maroon"><span style="color:green"><b>&#123;&#123;base_url&#125;&#125;</b></span>/Encounter</pre></td>
                        </tr>
                </table>

<br>
<div>
    <ul class="nav nav-tabs" role="tablist">
      <li role="presentation" class="active">
        <a href="#json-encounter-1" aria-controls="json" role="tab" data-toggle="tab">JSON Payload</a>
      </li>
      <li role="presentation">
        <a href="#tree-encounter-1" aria-controls="tree" role="tab" data-toggle="tab">Payload TreeView</a>
      </li>
      <li role="presentation">
        <a href="#table-encounter-1" aria-controls="table" role="tab" data-toggle="tab">Payload TableView</a>
      </li>
  </ul>

  <!-- Tab panes -->
  <div class="tab-content snippet" style="background: #F6F8F8;border: 1px solid #e8edee;">
    <div role="tabpanel" class="tab-pane active" id="json-encounter-1">
      {{json:Example-Encounter-Registration-Payload}}
    </div>
    <div role="tabpanel" class="tab-pane" id="table-encounter-1">
      {{table:Example-Encounter-Registration-Payload}}
    </div>
    <div role="tabpanel" class="tab-pane" id="tree-encounter-1">
      {{tree:Example-Encounter-Registration-Payload}}
    </div>
  </div>
</div>


<br><br>

| **Response** | **201 Created** |
| --- | --- |
| **Catatan** | Didalam response akan ada Encounter.id =  ```2823ed1d-3e3e-434e-9a5b-9c579d192787``` yang di generate secara otomatis. Simpan Encounter.id ini untuk dirujuk oleh resource lain |


<br><br>

<div>
    <ul class="nav nav-tabs" role="tablist">
      <li role="presentation" class="active">
        <a href="#response-encounter-1" aria-controls="tree" role="tab" data-toggle="tab">Response</a>
      </li>
  </ul>

  <!-- Tab panes -->
  <div class="tab-content snippet" style="background: #F6F8F8;border: 1px solid #e8edee;">
    <div role="tabpanel" class="tab-pane active" id="response-encounter-1">
        {{json:Example-Encounter-Registration-Response}}
    </div>
  </div>
</div>
            </div>
        </div>
    </div>
</div>

<p id="Encounter-MedicalResume-Inprogress"></p>

### 2. Transisi Status Pelayanan Pasien menjadi dilayani

<div id="accordion">
    <div class="card">
        <div class="card-header" id="EncounterHeading-2">
            <h5 class="mb-0">
                <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#EncounterCollapse-2" aria-expanded="false" aria-controls="EncounterCollapse-2">
                    <h3 style="text-align:left">Langkah 2</h3>
                    <p style="text-align:left">Masuk Ruang Layanan - PUT <code><i>Encounter</i></code>
                    <br>Status : <code>inprogress</code></p>
                </button>
            </h5>
        </div>
        <div id="EncounterCollapse-2" class="collapse" aria-labelledby="EncounterHeading-2" data-parent="#accordion">
            <div class="card-body">                
                <table class="table table-bordered">
                        <tr>
                                <td><b>Method</b></td>
                                <td>PUT</td>
                        </tr>
                        <tr>
                                <td><b>Target URL</b></td>
                                <td><pre style="background: #F6F8F8;border: 1px solid #ffffff; color: maroon"><span style="color:green"><b>&#123;&#123;base_url&#125;&#125;</b></span>/Encounter/<span style="color:blue"><b>2823ed1d-3e3e-434e-9a5b-9c579d192787</span></b></pre></td>
                        </tr>
                </table>

<br>
<div>
    <ul class="nav nav-tabs" role="tablist">
      <li role="presentation" class="active">
        <a href="#json-encounter-2" aria-controls="json" role="tab" data-toggle="tab">JSON Payload</a>
      </li>
      <li role="presentation">
        <a href="#tree-encounter-2" aria-controls="tree" role="tab" data-toggle="tab">Payload TreeView</a>
      </li>
      <li role="presentation">
        <a href="#table-encounter-2" aria-controls="table" role="tab" data-toggle="tab">Payload TableView</a>
      </li>
  </ul>

  <!-- Tab panes -->
  <div class="tab-content snippet" style="background: #F6F8F8;border: 1px solid #e8edee;">
    <div role="tabpanel" class="tab-pane active" id="json-encounter-2">
      {{json:Example-Encounter-Inprogress-Payload}}
    </div>
    <div role="tabpanel" class="tab-pane" id="table-encounter-2">
      {{table:Example-Encounter-Inprogress-Payload}}
    </div>
    <div role="tabpanel" class="tab-pane" id="tree-encounter-2">
      {{tree:Example-Encounter-Inprogress-Payload}}
    </div>
  </div>
</div>


<br><br>

| **Response** | **200 OK** |
| --- | --- |
| **Catatan** | Encounter.id ```2823ed1d-3e3e-434e-9a5b-9c579d192787``` yang ada di response harap disimpan untuk dirujuk oleh resource lain atau PUT Encounter |


<br><br>

<div>
    <ul class="nav nav-tabs" role="tablist">
      <li role="presentation" class="active">
        <a href="#response-encounter-2" aria-controls="tree" role="tab" data-toggle="tab">Response</a>
      </li>
  </ul>

  <!-- Tab panes -->
  <div class="tab-content snippet" style="background: #F6F8F8;border: 1px solid #e8edee;">
    <div role="tabpanel" class="tab-pane active" id="response-encounter-2">
        {{json:Example-Encounter-Inprogress-Response}}
    </div>
  </div>
</div>
            </div>
        </div>
    </div>
</div>

<p id="Encounter-Diagnosis-Primary"></p>

### 3. Melakukan Pengiriman Diagnosa Primer

<div id="accordion">
    <div class="card">
        <div class="card-header" id="ConditionHeading-1">
            <h5 class="mb-0">
                <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#ConditionCollapse-1" aria-expanded="false" aria-controls="ConditionCollapse-1">
                    <h3 style="text-align:left">Langkah 3</h3>
                    <p style="text-align:left">Mengirimkan Diagnosa Primer - POST <code><i>Condition</i></code>
                    </p>
                </button>
            </h5>
        </div>
        <div id="ConditionCollapse-1" class="collapse" aria-labelledby="ConditionHeading-1" data-parent="#accordion">
            <div class="card-body">                
                <table class="table table-bordered">
                        <tr>
                                <td><b>Method</b></td>
                                <td>POST</td>
                        </tr>
                        <tr>
                                <td><b>Target URL</b></td>
                                <td><pre style="background: #F6F8F8;border: 1px solid #ffffff; color: maroon"><span style="color:green"><b>&#123;&#123;base_url&#125;&#125;</b></span>/Condition</pre></td>
                        </tr>
                </table>

<br>
<div>
    <ul class="nav nav-tabs" role="tablist">
      <li role="presentation" class="active">
        <a href="#json-condition-1" aria-controls="json" role="tab" data-toggle="tab">JSON Payload</a>
      </li>
      <li role="presentation">
        <a href="#tree-condition-1" aria-controls="tree" role="tab" data-toggle="tab">Payload TreeView</a>
      </li>
      <li role="presentation">
        <a href="#table-condition-1" aria-controls="table" role="tab" data-toggle="tab">Payload TableView</a>
      </li>
  </ul>

  <!-- Tab panes -->
  <div class="tab-content snippet" style="background: #F6F8F8;border: 1px solid #e8edee;">
    <div role="tabpanel" class="tab-pane active" id="json-condition-1">
      {{json:Example-Condition-A15.0-Payload}}
    </div>
    <div role="tabpanel" class="tab-pane" id="table-condition-1">
      {{table:Example-Condition-A15.0-Payload}}
    </div>
    <div role="tabpanel" class="tab-pane" id="tree-condition-1">
      {{tree:Example-Condition-A15.0-Payload}}
    </div>
  </div>
</div>


<br><br>

| **Response** | **201 Created** |
| --- | --- |
| **Catatan** | Didalam response akan ada Condition.id =  ```f2bc12fe-0ab2-4e5c-a3cd-32c66150cbe9``` yang di generate secara otomatis. Simpan Condition.id ini untuk dirujuk oleh resource Encounter |


<br><br>

<div>
    <ul class="nav nav-tabs" role="tablist">
      <li role="presentation" class="active">
        <a href="#response-condition-1" aria-controls="tree" role="tab" data-toggle="tab">Response</a>
      </li>
  </ul>

  <!-- Tab panes -->
  <div class="tab-content snippet" style="background: #F6F8F8;border: 1px solid #e8edee;">
    <div role="tabpanel" class="tab-pane active" id="response-condition-1">
        {{json:Example-Condition-A15.0-Response}}
    </div>
  </div>
</div>
            </div>
        </div>
    </div>
</div>

<p id="Encounter-Diagnosis-Secondary"></p>

### 4. Melakukan Pengiriman Diagnosa Secondary

<div id="accordion">
    <div class="card">
        <div class="card-header" id="ConditionHeading-2">
            <h5 class="mb-0">
                <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#ConditionCollapse-2" aria-expanded="false" aria-controls="ConditionCollapse-2">
                    <h3 style="text-align:left">Langkah 4</h3>
                    <p style="text-align:left">Mengirimkan Diagnosa Sekunder - POST <code><i>Condition</i></code>
                    </p>
                </button>
            </h5>
        </div>
        <div id="ConditionCollapse-2" class="collapse" aria-labelledby="ConditionHeading-2" data-parent="#accordion">
            <div class="card-body">                
                <table class="table table-bordered">
                        <tr>
                                <td><b>Method</b></td>
                                <td>POST</td>
                        </tr>
                        <tr>
                                <td><b>Target URL</b></td>
                                <td><pre style="background: #F6F8F8;border: 1px solid #ffffff; color: maroon"><span style="color:green"><b>&#123;&#123;base_url&#125;&#125;</b></span>/Condition</pre></td>
                        </tr>
                </table>

<br>
<div>
    <ul class="nav nav-tabs" role="tablist">
      <li role="presentation" class="active">
        <a href="#json-condition-2" aria-controls="json" role="tab" data-toggle="tab">JSON Payload</a>
      </li>
      <li role="presentation">
        <a href="#tree-condition-2" aria-controls="tree" role="tab" data-toggle="tab">Payload TreeView</a>
      </li>
      <li role="presentation">
        <a href="#table-condition-2" aria-controls="table" role="tab" data-toggle="tab">Payload TableView</a>
      </li>
  </ul>

  <!-- Tab panes -->
  <div class="tab-content snippet" style="background: #F6F8F8;border: 1px solid #e8edee;">
    <div role="tabpanel" class="tab-pane active" id="json-condition-2">
      {{json:Example-Condition-E11.9-Payload}}
    </div>
    <div role="tabpanel" class="tab-pane" id="table-condition-2">
      {{table:Example-Condition-E11.9-Payload}}
    </div>
    <div role="tabpanel" class="tab-pane" id="tree-condition-2">
      {{tree:Example-Condition-E11.9-Payload}}
    </div>
  </div>
</div>


<br><br>

| **Response** | **201 Created** |
| --- | --- |
| **Catatan** | Didalam response akan ada Condition.id =  ```ba0dd351-c30a-4659-994e-0013797b545b``` yang di generate secara otomatis. Simpan Condition.id ini untuk dirujuk oleh resource Encounter |


<br><br>

<div>
    <ul class="nav nav-tabs" role="tablist">
      <li role="presentation" class="active">
        <a href="#response-condition-2" aria-controls="tree" role="tab" data-toggle="tab">Response</a>
      </li>
  </ul>

  <!-- Tab panes -->
  <div class="tab-content snippet" style="background: #F6F8F8;border: 1px solid #e8edee;">
    <div role="tabpanel" class="tab-pane active" id="response-condition-2">
        {{json:Example-Condition-E11.9-Response}}
    </div>
  </div>
</div>
            </div>
        </div>
    </div>
</div>

<p id="Encounter-MedicalResume-Finished"></p>

### 5. Transisi Status Pelayanan Pasien menjadi Selesai



<br>
<br>
<p style="text-align:right"><a href="#">Back to top</a></p>
<br>
<hr>