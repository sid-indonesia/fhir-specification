<h1><a href="https://simplifier.net/guide/SATUSEHAT-FHIR-R4-Implementation-Guide/Home/Examples/ResourceExample/Practitioner.page.md?version=current"  style="color:black">Contoh Pencarian (GET) Resource <i>Practitioner</i></a></h1>

<br><br>

<div id="accordion">
    <div class="card">
        <div class="card-header" id="PractitionerHeading-1">
            <h5 class="mb-0">
                <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#PractitionerCollapse-1" aria-expanded="false" aria-controls="PractitionerCollapse-1">
                    <h3 style="text-align:left">Contoh kasus 1:</h3>
                    <p>Pencarian Practitioner IHS Number dengan NIK <code>3328112107900004</code></p>
                </button>
            </h5>
        </div>
        <div id="PractitionerCollapse-1" class="collapse" aria-labelledby="PractitionerHeading-1" data-parent="#accordion">
            <div class="card-body">                
                <table class="table table-bordered">
                        <tr>
                                <td><b>Method</b></td>
                                <td>GET</td>
                        </tr>
                        <tr>
                                <td><b>Target URL</b></td>
                                <td><pre style="background: #F6F8F8;border: 1px solid #ffffff; color: maroon"><span style="color:green"><b>&#123;&#123;base_url&#125;&#125;</b></span>/Practitioner?identifier=https://fhir.kemkes.go.id/id/nik|3328112107900004</pre></td>
                        </tr>
                        <tr>
                                <td><b>Response</b></td>
                                <td>200</td>
                        </tr>
                        <tr>
                                <td><b>Catatan</b></td>
                                <td>Didalam response akan ada result set yang memunculkan Practitioner.id =<code>10000329187</code>. Simpan Practitioner.id ini untuk digunakan di resource lain</td>
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
                                {{json:Example-Practitioner-Get-NIK}}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="card">
        <div class="card-header" id="PractitionerHeading-2">
            <h5 class="mb-0">
                <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#PractitionerCollapse-2" aria-expanded="false" aria-controls="PractitionerCollapse-2">
                    <h3 style="text-align:left">Contoh kasus 2:</h3>
                    <p>Pencarian Practitioner IHS Number dengan Nama <code>bambang waluyo</code>, Gender <code>male</code>, dan birthdate tahun <code>1940</code></p>
                </button>
            </h5>
        </div>
        <div id="PractitionerCollapse-2" class="collapse" aria-labelledby="PractitionerHeading-2" data-parent="#accordion">
            <div class="card-body">                
                <table class="table table-bordered">
                        <tr>
                                <td><b>Method</b></td>
                                <td>GET</td>
                        </tr>
                        <tr>
                                <td><b>Target URL</b></td>
                                <td><pre style="background: #F6F8F8;border: 1px solid #ffffff; color: maroon"><span style="color:green"><b>&#123;&#123;base_url&#125;&#125;</b></span>/Practitioner?name=bambang waluyo&gender=male&birthdate=1940</pre></td>
                        </tr>
                        <tr>
                                <td><b>Response</b></td>
                                <td>200</td>
                        </tr>
                        <tr>
                                <td><b>Catatan</b></td>
                                <td>Didalam response akan ada result set yang memunculkan multipel Practitioner.id. Simpan Practitioner.id yang sesuai untuk digunakan di resource lain</td>
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
                                {{json:Example-Practitioner-Get-Biodata}}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="card">
        <div class="card-header" id="PractitionerHeading-3">
            <h5 class="mb-0">
                <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#PractitionerCollapse-3" aria-expanded="false" aria-controls="PractitionerCollapse-3">
                    <h3 style="text-align:left">Contoh kasus 3:</h3>
                    <p>Pencarian identitas Practitioner menggunakan IHS Number <code>N10000005</code></p>
                </button>
            </h5>
        </div>
        <div id="PractitionerCollapse-3" class="collapse" aria-labelledby="PractitionerHeading-3" data-parent="#accordion">
            <div class="card-body">                
                <table class="table table-bordered">
                        <tr>
                                <td><b>Method</b></td>
                                <td>GET</td>
                        </tr>
                        <tr>
                                <td><b>Target URL</b></td>
                                <td><pre style="background: #F6F8F8;border: 1px solid #ffffff; color: maroon"><span style="color:green"><b>&#123;&#123;base_url&#125;&#125;</b></span>/Practitioner/N10000005</pre></td>
                        </tr>
                        <tr>
                                <td><b>Response</b></td>
                                <td>200</td>
                        </tr>
                        <tr>
                                <td><b>Catatan</b></td>
                                <td>Didalam response akan ada result set yang memunculkan identitas Practitioner yang terdaftar di SATUSEHAT</td>
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
                                {{json:Example-Practitioner-Response-Get-ID}}
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