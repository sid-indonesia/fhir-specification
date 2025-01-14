## <b>II. E-Klaim </b> 
*Last Updated: 2023/09/17*

#### <b>Step 1. Konversi format data E-Klaim ke format FHIR</b>
<div style="margin-left: 30px;">
<p>Sama seperti proses yang sudah berlangsung sebelumnya, pengajuan klaim oleh fasyankes tetap dilakukan melalui aplikasi <a href="https://inacbg.kemkes.go.id/index.php?XP_view=1&page=download" target="_blank">E-Klaim</a>. Aplikasi E-Klaim inilah yang nantinya akan melakukan konversi data klaim ke format FHIR (resource *Claim*) dan dikirimkan ke SATUSEHAT.</p>
<p>Resource *Claim* disini akan referensi ke data klinis seperti *Encounter*, *Observation*, dan data pendukung lainnya. Berhubung fasyankes diperbolehkan untuk melakukan pengajuan klaim terhadap beberapa kunjungan pasien secara sekaligus, maka dari itu 1 *Claim* (1 Nomor SEP) bisa mencakup lebih dari 1 data kunjungan pasien (resource *Encounter*).
</p>

<!--Part 1.1 Variable Klaim BPJS-->
<h4 style="font-weight: bold;">Klaim BPJS INACBG</h4>
	
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
        <div style="background: #F6F8F8;border: 1px solid #e8edee;">
        {{json:HealthFinancing-01KlaimBPJS-Claim-Create-Klaim-INACBG-1}}
        </div>
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
</div>