## <b>III. BPJS</b> 
*Last Updated: 2023/09/17*

A. Prasyarat ketersediaan data kepesertaan BPJS</div>

<center>
<img src="https://victoriatjia.github.io/Guideline/SatuSehat/Specs%20Format%20FHIR/hf_integrasi_bpjs_satusehat_pendaftaran_data_kepesertaan.png" alt="hf-integrasi-bpjs-satusehat-pendaftaran-data-kepesertaan" title="Pengiriman Data Kepesertaan BPJS" style="width: 60%;">
<!--{{render:hf-integrasi-bpjs-satusehat-pendaftaran-data-kepesertaan}}-->

*Gambar 2. Skema penyediaan data kepesertaan BPJS*
</center>

<div style="margin-left: 30px;">
<p>Agar fasyankes bisa melakukan pengiriman data pengajuan klaim BPJS, data Master Kepesertaan BPJS wajib disediakan terlebih dahulu di SATUSEHAT. Hal ini dikarenakan data kepesertaan BPJS akan dijadikan referensi saat data klaim BPJS dikirimkan ke SATUSEHAT. Data Master Kepesertaan BPJS bersumber dari existing sistem BPJS sehingga perlu adanya mekanisme sinkronisasi data antara sistem BPJS kesehatan dengan SATUSEHAT.</p>
<p>Master Kepesertaan BPJS pada SATUSEHAT akan disimpan menggunakan salah satu resource dalam FHIR yaitu Coverage. Proses penambahan data peserta baru BPJS dapat dilakukan melalui FHIR API dengan metode POST, sedangkan proses perubahan data peserta existing BPJS (termasuk proses menonaktifkan data peserta BPJS) akan menggunakan metode PUT. Untuk contoh pengiriman data atau payload dari pembaharuan data kepesertaan BPJS dapat dilihat dalam Postman Collection.</p>

#### <b>1.1. Pembuatan Organisasi BPJS Kesehatan</b>
<div style="margin-left: 30px;">
Langkah awal sebelum mendaftarkan data kepesertaan BPJS di SATUSEHAT adalah organisasi BPJS Kesehatan wajib didaftarkan terlebih dahulu di SATUSEHAT. Hal ini dikarenakan data kepesertaan BPJS akan mereferensi ke {facility-ihs-number} milik BPJS Kesehatan.
<!--Part 1-1 Variable BPJS Kesehatan-->
<h4 style="font-weight: bold;">BPJS Kesehatan</h4>
	
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-1-1" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-1-1" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-1-1" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-1-1" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-1-1">
        <pre style="background: #F6F8F8;border: 1px solid #e8edee; color: black;">
            {
    "resourceType": "Organization",
    "active": true,
    "address":  [
        {
            "city": "Jakarta",
            "country": "ID",
            "extension":  [
                {
                    "extension":  [
                        {
                            "url": "province",
                            "valueCode": "10"
                        },
                        {
                            "url": "city",
                            "valueCode": "1010"
                        },
                        {
                            "url": "district",
                            "valueCode": "1010101"
                        },
                        {
                            "url": "village",
                            "valueCode": "1010101101"
                        }
                    ],
                    "url": "https://fhir.kemkes.go.id/r4/StructureDefinition/administrativeCode"
                }
            ],
            "line":  [
                "Jalan Matraman Raya No. 94 A, Kecamatan Menteng, Jakarta Pusat, DKI Jakarta"
            ],
            "postalCode": "10320",
            "type": "both",
            "use": "work"
        }
    ],
    "id": "a60f0623-80a0-4a97-a8c0-8bedb7844649",
    "identifier":  [
        {
            "system": "http://sys-ids.kemkes.go.id/organization/10080028",
            "use": "official",
            "value": "BPJS-K"
        }
    ],
    "meta": {
        "lastUpdated": "2023-05-19T16:18:04.201716+00:00",
        "versionId": "MTY4NDUxMzA4NDIwMTcxNjAwMA"
    },
    "name": "BPJS Kesehatan",
    "partOf": {
        "display": "BPJS Kesehatan",
        "reference": "Organization/10080028"
    },
    "telecom":  [
        {
            "system": "phone",
            "value": "022-655 2331"
        },
        {
            "system": "email",
            "value": "wbs@bpjs-kesehatan.go.id"
        },
        {
            "system": "fax",
            "value": "022-655 2323"
        }
    ],
    "type":  [
        {
            "coding":  [
                {
                    "code": "team",
                    "display": "Organizational team",
                    "system": "http://terminology.hl7.org/CodeSystem/organization-type"
                }
            ]
        }
    ]
}
        </pre>
        <!--<div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:}}
        </div>-->
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-1-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
#tba
</div>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-1-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
#tba
</div>
</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-1-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
			<div>
				[none]
			</div>
		</div>
	</div>
<br>
<!--END Part 1-1-->
</div>

#### <b>1.2. Pencarian Data Pasien</b>
<div style="margin-left: 30px;">
<p>Karena data pasien di dalam SATUSEHAT sudah terdaftar lebih dulu di *Master Patient Index* (MPI) Kementerian Kesehatan, sehingga registrasi data pasien baru tidak diperlukan.</p>
<p>Proses pencarian {patient-ihs-number} dari pasien dapat dilakukan melalui FHIR API dengan metode GET. Untuk metode pencarian data pasien di SATUSEHAT secara detail dapat dilihat dalam dokumen <a href="https://docs.google.com/document/d/1wGsuxUJcmWsGhTdAthe0pmcnsqtggLlQdFUG5fU4_T4/edit#heading=h.4fzggw2guay3" target="_blank">Petunjuk Teknis SATUSEHAT (Juknis SATSET)</a>.</p>
</div>

#### <b>1.3. Pembuatan Data Kepesertaan BPJS</b>
<div style="margin-left: 30px;">
Selanjutnya, data {facility-ihs-number} dan {patient-ihs-number} yang didapatkan dari step 1.1. dan step 1.2. akan dilampirkan pada resource Coverage seperti contoh dibawah ini:
<!--Part 1-3 Variable Kepesertaan BPJS-->
<h4 style="font-weight: bold;">Kepesertaan BPJS</h4>
	
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-1-3" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-1-3" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-1-3" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-1-3" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-1-3">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:HealthFinancing-01KlaimBPJS-Coverage-Create-Data-Kepesertaan-BPJS-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-1-3" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
#tba
</div>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-1-3" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
#tba
</div>
</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-1-3" style="border: 1px solid #e8edee; padding: 15px 10px;">
			<div>
				[none]
			</div>
		</div>
	</div>
<br>
<!--END Part 1-3-->
</div>

</div>

### <div id="VerifikasiKlaimBPJS"> B. Verifikasi data klaim dari fasyankes</div>

<div style="margin-left: 30px;">
<center>
{{render:hf-integrasi-bpjs-satusehat-verifikasi-klaim}}

*Gambar 4. Skema Verifikasi Klaim oleh BPJS Kesehatan*
</center>

<p>BPJS akan melakukan verifikasi data klaim fasyankes secara *monthly*. Data yang akan diverifikasi oleh tim BPJS adalah resource Claim yang dikirimkan oleh aplikasi E-Claim (step 2.4.). Data klinis dan pembayaran pada fasyankes (step 2.1.) juga akan digunakan dalam proses verifikasi ini.</p>

<!--Part 3-1 Variable Respons Klaim BPJS INACBG-->
<h4 style="font-weight: bold;">Respons Klaim BPJS INACBG</h4>
	
<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
        <a href="#example-3-1" aria-controls="example" role="tab" data-toggle="tab">Example</a>
    </li>
    <li role="presentation">
        <a href="#data-3-1" aria-controls="data" role="tab" data-toggle="tab">Template</a>
    </li>
    <li role="presentation">
        <a href="#variabel-3-1" aria-controls="variabel" role="tab" data-toggle="tab">Placeholder Variable</a>
    </li>
    <li role="presentation">
        <a href="#valueset-3-1" aria-controls="variabel" role="tab" data-toggle="tab">ValueSet</a>
    </li>
</ul>

<!-- Tab panes -->
<div class="tab-content snippet">
    <div role="tabpanel" class="tab-pane active" id="example-3-1">
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:HealthFinancing-01KlaimBPJS-ClaimResponse-Create-Response-Klaim-INACBG-1}}
        </div>
    </div>
    
<div role="tabpanel" class="tab-pane" id="data-3-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
#tba
</div>
</div>

<div role="tabpanel" class="tab-pane" id="variabel-3-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
<div>
#tba
</div>
</div>
		
<div role="tabpanel" class="tab-pane" id="valueset-3-1" style="border: 1px solid #e8edee; padding: 15px 10px;">
			<div>
				[none]
			</div>
		</div>
	</div>
<br>
<!--END Part 3-1-->