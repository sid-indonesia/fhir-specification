<h1><a href="https://simplifier.net/guide/SATUSEHAT-FHIR-R4-Implementation-Guide/Home/Examples/ResourceExample/Location.page.md?version=current" style="color:black">Contoh Pengiriman (POST) Resource <i>Location</i></a></h1>

<div id="accordion">
    <div class="card">
        <div class="card-header" id="LocationHeading-1">
            <h5 class="mb-0">
                <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#LocationCollapse-1" aria-expanded="false" aria-controls="LocationCollapse-1">
                    <h3 style="text-align:left">Contoh kasus 1:</h3>
                    <p>RSUD Jati Asih mendaftarkan <code>Ruang Rawat Jalan 1A di Poliklinik Rawat Jalan</code></p>
                </button>
            </h5>
        </div>
        <div id="LocationCollapse-1" class="collapse" aria-labelledby="LocationHeading-1" data-parent="#accordion">
            <div class="card-body">                
                <table class="table table-bordered">
                        <tr>
                                <td><b>Method</b></td>
                                <td>POST</td>
                        </tr>
                        <tr>
                                <td><b>Target URL</b></td>
                                <td><pre style="background: #F6F8F8;border: 1px solid #ffffff; color: maroon"><span style="color:green"><b>&#123;&#123;base_url&#125;&#125;</b></span>/Location</pre></td>
                        </tr>
                </table>

<br>
<div>
    <ul class="nav nav-tabs" role="tablist">
      <li role="presentation">
        <a href="#xml-location-1" aria-controls="xml" role="tab" data-toggle="tab">XML</a>
      </li>
      <li role="presentation" class="active">
        <a href="#json-location-1" aria-controls="json" role="tab" data-toggle="tab">JSON</a>
      </li>
        <li role="presentation">
        <a href="#table-location-1" aria-controls="table" role="tab" data-toggle="tab">Table</a>
      </li>
      <li role="presentation">
        <a href="#tree-location-1" aria-controls="tree" role="tab" data-toggle="tab">Tree</a>
      </li>
  </ul>

  <!-- Tab panes -->
  <div class="tab-content snippet" style="background: #F6F8F8;border: 1px solid #e8edee;">
    <div role="tabpanel" class="tab-pane" id="xml-location-1">
      {{xml:Example-Location-Create-Payload}}
    </div>
    <div role="tabpanel" class="tab-pane active" id="json-location-1">
      {{json:Example-Location-Create-Payload}}
    </div>
    <div role="tabpanel" class="tab-pane" id="table-location-1">
      {{table:Example-Location-Create-Payload}}
    </div>
    <div role="tabpanel" class="tab-pane" id="tree-location-1">
      {{tree:Example-Location-Create-Payload}}
    </div>
  </div>
</div>

<br><br>

| **Response** | **201 Created** |
| --- | --- |
| **Catatan** | Didalam response akan ada Location.id =  ```dc01c797-547a-4e4d-97cd-4ece0630e380``` yang di generate secara otomatis. Simpan Location.id ini untuk digunakan di resource lain |


<br><br>

<div>
    <ul class="nav nav-tabs" role="tablist">
      <li role="presentation" class="active">
        <a href="#response-location-1" aria-controls="tree" role="tab" data-toggle="tab">Response</a>
      </li>
  </ul>

  <!-- Tab panes -->
  <div class="tab-content snippet" style="background: #F6F8F8;border: 1px solid #e8edee;">
    <div role="tabpanel" class="tab-pane active" id="response-location-1">
        {{json:Example-Location-Create-Response}}
    </div>
  </div>
</div>
            </div>
        </div>
    </div>
</div>

<br>
<p style="text-align:right"><a href="#">Back to top</a></p>
<br>
<hr>