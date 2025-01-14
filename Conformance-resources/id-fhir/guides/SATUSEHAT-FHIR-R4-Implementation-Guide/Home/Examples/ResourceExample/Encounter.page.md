## {{page-title}}

<div id="accordion">
    <div class="card">
        <div class="card-header" id="EncounterHeading-1">
            <h5 class="mb-0">
                <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#EncounterCollapse-1" aria-expanded="false" aria-controls="EncounterCollapse-1">
                    <h3 style="text-align:left">Contoh kasus 1:</h3>
                    <p style="text-align:left">Kunjungan walk-in : Pasien Budi Santoso ke RSUD Jati Asih.<br>Patient IHS Number : <code>100000030009</code>, Practitioner IHS Number : <code>N10000001</code>, Organization induk IHS Number : <code>10000004</code>, Encounter.status : <code>arrived</code></p>
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
      <li role="presentation">
        <a href="#xml-encounter-1" aria-controls="xml" role="tab" data-toggle="tab">XML</a>
      </li>
      <li role="presentation" class="active">
        <a href="#json-encounter-1" aria-controls="json" role="tab" data-toggle="tab">JSON</a>
      </li>
        <li role="presentation">
        <a href="#table-encounter-1" aria-controls="table" role="tab" data-toggle="tab">Table</a>
      </li>
      <li role="presentation">
        <a href="#tree-encounter-1" aria-controls="tree" role="tab" data-toggle="tab">Tree</a>
      </li>
  </ul>

  <!-- Tab panes -->
  <div class="tab-content snippet" style="background: #F6F8F8;border: 1px solid #e8edee;">
    <div role="tabpanel" class="tab-pane" id="xml-encounter-1">
      {{xml:Example-Encounter-Registration-Payload}}
    </div>
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

<div class="card">
        <div class="card-header" id="EncounterHeading-2">
            <h5 class="mb-0">
                <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#EncounterCollapse-2" aria-expanded="false" aria-controls="EncounterCollapse-2">
                    <h3 style="text-align:left">Contoh kasus 2:</h3>
                    <p style="text-align:left">Masuk Pelayanan - Pasien Budi Santoso ke RSUD Jati Asih dengan dokter Bronsig dengan Encounter.Id awal : <code>2823ed1d-3e3e-434e-9a5b-9c579d192787</code><br>Patient IHS Number : <code>100000030009</code>, Practitioner IHS Number : <code>N10000001</code>, Organization induk IHS Number : <code>10000004</code>, Encounter.status : <code>inprogress</code></p>
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
      <li role="presentation">
        <a href="#xml-encounter-2" aria-controls="xml" role="tab" data-toggle="tab">XML</a>
      </li>
      <li role="presentation" class="active">
        <a href="#json-encounter-2" aria-controls="json" role="tab" data-toggle="tab">JSON</a>
      </li>
        <li role="presentation">
        <a href="#table-encounter-2" aria-controls="table" role="tab" data-toggle="tab">Table</a>
      </li>
      <li role="presentation">
        <a href="#tree-encounter-2" aria-controls="tree" role="tab" data-toggle="tab">Tree</a>
      </li>
  </ul>

  <!-- Tab panes -->
  <div class="tab-content snippet" style="background: #F6F8F8;border: 1px solid #e8edee;">
    <div role="tabpanel" class="tab-pane" id="xml-encounter-2">
      {{xml:Example-Encounter-Inprogress-Payload}}
    </div>
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

<br><br>

<br>
<p style="text-align:right"><a href="#">Back to top</a></p>
<br>
<hr>