<h1><a href="https://simplifier.net/guide/SATUSEHAT-FHIR-R4-Implementation-Guide/Home/Examples/ResourceExample/Patient.page.md?version=current"  style="color:black">Contoh Pencarian (GET) Resource <i>Patient</i></a></h1>

<br><br>

<div id="accordion">
    <div class="card">
        <div class="card-header" id="PatientHeading-1">
            <h5 class="mb-0">
                <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#PatientCollapse-1" aria-expanded="false" aria-controls="PatientCollapse-1">
                    <h3 style="text-align:left">Contoh kasus 1:</h3>
                    <p>Pencarian Patient IHS Number dengan NIK <code>3171022809990001</code></p>
                </button>
            </h5>
        </div>
        <div id="PatientCollapse-1" class="collapse" aria-labelledby="PatientHeading-1" data-parent="#accordion">
            <div class="card-body">                
                <table class="table table-bordered">
                        <tr>
                                <td><b>Method</b></td>
                                <td>GET</td>
                        </tr>
                        <tr>
                                <td><b>Target URL</b></td>
                                <td><pre style="background: #F6F8F8;border: 1px solid #ffffff; color: maroon"><span style="color:green"><b>&#123;&#123;base_url&#125;&#125;</b></span>/Patient?identifier=https://fhir.kemkes.go.id/id/nik|3171022809990001</pre></td>
                        </tr>
                        <tr>
                                <td><b>Response</b></td>
                                <td>200</td>
                        </tr>
                        <tr>
                                <td><b>Catatan</b></td>
                                <td>Didalam response akan ada result set yang memunculkan Patient.id =<code>100000030009</code>. Simpan Patient.id ini untuk digunakan di resource lain</td>
                        </tr>
                </table>
                <div>
                        <ul class="nav nav-tabs" role="tablist">
                            <li role="presentation" class="active">
                                <a href="#response-organization-1" aria-controls="tree" role="tab" data-toggle="tab">Response</a>
                            </li>
                    </ul>
                    <div class="tab-content snippet" style="background: #F6F8F8;border: 1px solid #e8edee;">
                        <div role="tabpanel" class="tab-pane active" id="response-organization-1">
                                {{json:Example-Patient-Get-NIK}}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="card">
        <div class="card-header" id="PatientHeading-2">
            <h5 class="mb-0">
                <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#PatientCollapse-2" aria-expanded="false" aria-controls="PatientCollapse-2">
                    <h3 style="text-align:left">Contoh kasus 2:</h3>
                    <p>Pencarian Patient IHS Number dengan Nama <code>smith</code>, Gender <code>male</code>, dan birthdate <code>Januari 1980</code></p>
                </button>
            </h5>
        </div>
        <div id="PatientCollapse-2" class="collapse" aria-labelledby="PatientHeading-2" data-parent="#accordion">
            <div class="card-body">                
                <table class="table table-bordered">
                        <tr>
                                <td><b>Method</b></td>
                                <td>GET</td>
                        </tr>
                        <tr>
                                <td><b>Target URL</b></td>
                                <td><pre style="background: #F6F8F8;border: 1px solid #ffffff; color: maroon"><span style="color:green"><b>&#123;&#123;base_url&#125;&#125;</b></span>/Patient?name=smith&gender=male&birthdate=1980-01</pre></td>
                        </tr>
                        <tr>
                                <td><b>Response</b></td>
                                <td>200</td>
                        </tr>
                        <tr>
                                <td><b>Catatan</b></td>
                                <td>Didalam response akan ada result set yang memunculkan multipel Patient.id. Simpan Patient.id yang sesuai untuk digunakan di resource lain</td>
                        </tr>
                </table>
                <div>
                        <ul class="nav nav-tabs" role="tablist">
                            <li role="presentation" class="active">
                                <a href="#response-organization-2" aria-controls="tree" role="tab" data-toggle="tab">Response</a>
                            </li>
                    </ul>
                    <div class="tab-content snippet" style="background: #F6F8F8;border: 1px solid #e8edee;">
                        <div role="tabpanel" class="tab-pane active" id="response-organization-2">
                                {{json:Example-Patient-Get-Biodata}}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="card">
        <div class="card-header" id="PatientHeading-3">
            <h5 class="mb-0">
                <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#PatientCollapse-3" aria-expanded="false" aria-controls="PatientCollapse-3">
                    <h3 style="text-align:left">Contoh kasus 3:</h3>
                    <p>Pencarian identitas Patient menggunakan IHS Number <code>100000030009</code></p>
                </button>
            </h5>
        </div>
        <div id="PatientCollapse-3" class="collapse" aria-labelledby="PatientHeading-3" data-parent="#accordion">
            <div class="card-body">                
                <table class="table table-bordered">
                        <tr>
                                <td><b>Method</b></td>
                                <td>GET</td>
                        </tr>
                        <tr>
                                <td><b>Target URL</b></td>
                                <td><pre style="background: #F6F8F8;border: 1px solid #ffffff; color: maroon"><span style="color:green"><b>&#123;&#123;base_url&#125;&#125;</b></span>/Patient/100000030009</pre></td>
                        </tr>
                        <tr>
                                <td><b>Response</b></td>
                                <td>200</td>
                        </tr>
                        <tr>
                                <td><b>Catatan</b></td>
                                <td>Didalam response akan ada result set yang memunculkan identitas Patient yang terdaftar di SATUSEHAT</td>
                        </tr>
                </table>
                <div>
                        <ul class="nav nav-tabs" role="tablist">
                            <li role="presentation" class="active">
                                <a href="#response-organization-3" aria-controls="tree" role="tab" data-toggle="tab">Response</a>
                            </li>
                    </ul>
                    <div class="tab-content snippet" style="background: #F6F8F8;border: 1px solid #e8edee;">
                        <div role="tabpanel" class="tab-pane active" id="response-organization-3">
                                {{json:Example-Patient-Response-Get-ID}}
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