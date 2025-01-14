## {{page-title}}

Contoh Struktur Organisasi dapat dilihat pada gambar dibawah berikut : 

![Organizational Chart](https://raw.githubusercontent.com/fhir-kemkes/assets/main/Picture/OrganizationChart.png)

Organisasi merupakan data terkait struktur organisasi yang ada di dalam suatu institusi. Data struktur organisasi ini akan dijadikan referensi saat data pelayanan kesehatan dikirimkan ke SATUSEHAT. Institusi yang akan melakukan integrasi ke SATUSEHAT perlu melakukan registrasi atau mengirimkan data terkait struktur organisasi yang tersedia di dalam institusi tersebut (selanjutnya disebut suborganisasi). Institusi yang termasuk dalam kategori fasilitas pelayanan kesehatan (selanjutnya disebut organisasi induk), akan mendapatkan nomor SATUSEHAT dari Kementerian Kesehatan setelah melakukan registrasi. Organisasi induk selanjutnya akan mengirimkan struktur organisasi/suborganisasi yang ada dalam institusi tersebut. Contoh struktur organisasi dapat dilihat dalam gambar 1. Setiap suborganisasi dibawah organisasi induk perlu dikirimkan datanya ke SATUSEHAT. 

Data suborganisasi dikirimkan menggunakan resource *Organization* dengan metode *POST*. Resource *Organization* digunakan untuk mencatat data sekelompok orang atau organisasi dengan tujuan yang sama. Hal ini ditunjukkan dengan adanya struktur pengurus dari organisasi tersebut. Template pengisian organisasi dapat diakses pada tautan berikut : [Template Registrasi Organization & Location](https://docs.google.com/spreadsheets/d/1JBP2aUtPqCrsIyVvr2Mus1DMeLTumBn9a0azIHyv4f4/edit#gid=1571590515)


<div class="table-wrapper" markdown="block" style="overflow-x:scroll">
    <table class="table table-bordered">
        <tr>
            <td colspan=3>
                <p style="text-align:center"><b>Resource <a href="https://simplifier.net/guide/SATUSEHAT-FHIR-R4-Implementation-Guide/Home/FHIRProfiles/Organization.page.md?version=current", target="_blank">Organization</a></b></p>
            </td>
        </tr>
        <tr>
            <td>
                <b>Elemen Data / Path </b>
            </td>
            <td>
                <b>Tipe Mandatoris</b>
            </td>
            <td>
                <b>Deskripsi</b>
            </td>
        </tr>
        <tr>
            <td>
                Organization.identifier
            </td>
            <td>
                Optional (Omit Empty)
            </td>
            <td>
                <ul>
                    <li>Dapat diisi dengan informasi terkait kode/nomor internal suborganisasi yang dimiliki oleh organisasi induk</li>
                    <li>Format Pengisian</li>
                    <ul>
                        <li>Organization.identifier.use = official</li>
                        <li>Organization.identifier.system = <code>http://sys-ids.kemkes.go.id/Organization/&#123;&#123;OrganizationID&#125;&#125;</code><br>
                        OrganizationID adalah nomor SATUSEHAT organisasi induk yang didapatkan dari <i>Master Sarana Index</i><br>
                        Contoh pengisian : <code>http://sys-ids.kemkes.go.id/organization/10000004</code> </li>
                        <li>Organization.identifier.value = kode/nomor internal suborganisasi (contoh = R100005)</li>
                    </ul>
                </ul>
            </td>
        </tr>
        <tr>
            <td>
                Organization.active
            </td>
            <td>
                Mandatory
            </td>
            <td>
                <ul>
                    <li>Status keaktifan data organisasi </li>
                    <li>Format Pengisian boolean = true / false </li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>Organization.type</td>
            <td>Mandatory</td>
            <td>
                <ul>
                    <li>Tipe Organisasi</li>
                    <li>Format Pengisian</li>
                </ul>
                <table class="table table-bordered"  style="table-layout: fixed;">
                    <thead><tr>
                        <th style="word-wrap:break-word;">Organization.type.coding.system</th>
                        <th style="word-wrap:break-word;">Organization.type.coding.code</th>
                        <th style="word-wrap:break-word;">Organization.type.coding.display</th>
                        <th style="word-wrap:break-word;">Keterangan</th>
                    </tr></thead>
                    <tbody style="word-wrap:break-word;">
                        <tr>
                            <td>
                                <p><a href="http://hl7.org/fhir/R4/codesystem-organization-type.html">http://terminology.hl7.org/CodeSystem/organization-type</a></p>
                            </td>
                            <td>
                                <p><a href="http://hl7.org/fhir/R4/codesystem-organization-type.html#organization-type-prov">prov</a></p>
                            </td>
                            <td>
                                <p>Healthcare Provider</p>
                            </td>
                            <td>
                                <p>Fasilitas Pelayanan Kesehatan</p>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <p><a href="http://hl7.org/fhir/R4/codesystem-organization-type.html">http://terminology.hl7.org/CodeSystem/organization-type</a></p>
                            </td>
                            <td>
                                <p><a href="http://hl7.org/fhir/R4/codesystem-organization-type.html#organization-type-dept">dept</a></p>
                            </td>
                            <td>
                                <p>Hospital Department</p>
                            </td>
                            <td>
                                <p>Departemen dalam Rumah Sakit</p>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <p><a href="http://hl7.org/fhir/R4/codesystem-organization-type.html">http://terminology.hl7.org/CodeSystem/organization-type</a></p>
                            </td>
                            <td>
                                <p><a href="http://hl7.org/fhir/R4/codesystem-organization-type.html#organization-type-team">team</a></p>
                            </td>
                            <td>
                                <p>Organizational team</p>
                            </td>
                            <td>
                                <p>Kelompok praktisi/tenaga kesehatan yang menjalankan fungsi tertentu dalam suatu organisasi</p>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <p><a href="http://hl7.org/fhir/R4/codesystem-organization-type.html">http://terminology.hl7.org/CodeSystem/organization-type</a></p>
                            </td>
                            <td>
                                <p><a href="http://hl7.org/fhir/R4/codesystem-organization-type.html#organization-type-govt">govt</a></p>
                            </td>
                            <td>
                                <p>Government</p>
                            </td>
                            <td>
                                <p>Organisasi Pemerintah</p>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <p><a href="http://hl7.org/fhir/R4/codesystem-organization-type.html">http://terminology.hl7.org/CodeSystem/organization-type</a></p>
                            </td>
                            <td>
                                <p><a href="http://hl7.org/fhir/R4/codesystem-organization-type.html#organization-type-ins">ins</a></p>
                            </td>
                            <td>
                                <p>Insurance Company</p>
                            </td>
                            <td>
                                <p>Perusahaan Asuransi</p>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <p><a href="http://hl7.org/fhir/R4/codesystem-organization-type.html">http://terminology.hl7.org/CodeSystem/organization-type</a></p>
                            </td>
                            <td>
                                <p><a href="http://hl7.org/fhir/R4/codesystem-organization-type.html#organization-type-pay">pay</a></p>
                            </td>
                            <td>
                                <p>Payer</p>
                            </td>
                            <td>
                                <p>Badan Penjamin</p>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <p><a href="http://hl7.org/fhir/R4/codesystem-organization-type.html">http://terminology.hl7.org/CodeSystem/organization-type</a></p>
                            </td>
                            <td>
                                <p><a href="http://hl7.org/fhir/R4/codesystem-organization-type.html#organization-type-edu">edu</a></p>
                            </td>
                            <td>
                                <p>Educational Institute</p>
                            </td>
                            <td>
                                <p>Institusi Pendidikan/Penelitian</p>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <p><a href="http://hl7.org/fhir/R4/codesystem-organization-type.html">http://terminology.hl7.org/CodeSystem/organization-type</a></p>
                            </td>
                            <td>
                                <p><a href="http://hl7.org/fhir/R4/codesystem-organization-type.html#organization-type-reli">reli</a></p>
                            </td>
                            <td>
                                <p>Religious Institution</p>
                            </td>
                            <td>
                                <p>Organisasi Keagamaan</p>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <p><a href="http://hl7.org/fhir/R4/codesystem-organization-type.html">http://terminology.hl7.org/CodeSystem/organization-type</a></p>
                            </td>
                            <td>
                                <p><a href="http://hl7.org/fhir/R4/codesystem-organization-type.html#organization-type-crs">crs</a></p>
                            </td>
                            <td>
                                <p>Clinical Research Sponsor</p>
                            </td>
                            <td>
                                <p>Sponsor penelitian klinis</p>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <p><a href="http://hl7.org/fhir/R4/codesystem-organization-type.html">http://terminology.hl7.org/CodeSystem/organization-type</a></p>
                            </td>
                            <td>
                                <p><a href="http://hl7.org/fhir/R4/codesystem-organization-type.html#organization-type-cg">cg</a></p>
                            </td>
                            <td>
                                <p>Community Group</p>
                            </td>
                            <td>
                                <p>Kelompok Masyarakat</p>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <p><a href="http://hl7.org/fhir/R4/codesystem-organization-type.html">http://terminology.hl7.org/CodeSystem/organization-type</a></p>
                            </td>
                            <td>
                                <p><a href="http://hl7.org/fhir/R4/codesystem-organization-type.html#organization-type-bus">bus</a></p>
                            </td>
                            <td>
                                <p>Non-Healthcare Business or Corporation</p>
                            </td>
                            <td>
                                <p>Perusahaan diluar bidang kesehatan</p>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <p><a href="http://hl7.org/fhir/R4/codesystem-organization-type.html">http://terminology.hl7.org/CodeSystem/organization-type</a></p>
                            </td>
                            <td>
                                <p><a href="http://hl7.org/fhir/R4/codesystem-organization-type.html#organization-type-other">other</a></p>
                            </td>
                            <td>
                                <p>Other</p>
                            </td>
                            <td>
                                <p>Lain-lain</p>
                            </td>
                        </tr>
                    </tbody>
                </table>
                Catatan : 
                <p>Organisasi Induk penyedia layanan telemedisin bisa tetap menggunakan <i>prov</i> sebagai tipe organisasi</p>
            </td>
        </tr>
            <tr>
                <td>
                    Organization.name
                </td>
                <td>
                    Mandatory
                </td>
                <td>
                    <ul>
                        <li>
                            Nama Organisasi
                        </li>
                        <li>
                            Format Pengisian : string
                        </li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td>
                    Organization.alias
                </td>
                <td>
                    Optional (Omit Empty)
                </td>
                <td>
                    <ul>
                        <li>
                            Nama lain Organisasi
                        </li>
                        <li>
                            Format Pengisian : string
                        </li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td>
                    Organization.telecom
                </td>
                <td>
                    Optional (Omit Empty)
                </td>
                <td>
                    <ul>
                        <li>
                            Kontak organisasi secara umum
                        </li>
                        <li>
                            Dapat diisi &gt; 1 jenis kontak (nomor telepon, email, website)
                        </li>
                        <li>
                            Format Pengisian
                            <ul>
                                <li>
                                    Organization.telecom.system =
                                </li>
                            </ul>
                        </li>
                    </ul>
                        <table class="table table-bordered"  style="table-layout: fixed;">
                            <thead style="word-wrap:break-word;">
                                <tr>
                                    <th>
                                        Organization.telecom.system
                                    </th>
                                    <th>
                                        Keterangan
                                    </th>
                                </tr>
                            </thead>
                            <tbody style="word-wrap:break-word;">
                                <tr>
                                    <td>
                                        <a href="http://hl7.org/fhir/R4/codesystem-contact-point-system.html#contact-point-system-phone">phone</a>
                                    </td>
                                    <td>
                                        Nomor Telepon Kantor
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <a href="http://hl7.org/fhir/R4/codesystem-contact-point-system.html#contact-point-system-fax">fax</a>
                                    </td>
                                    <td>
                                        Nomor Fax
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <a href="http://hl7.org/fhir/R4/codesystem-contact-point-system.html#contact-point-system-email">email</a>
                                    </td>
                                    <td>
                                        Email Kantor
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <a href="http://hl7.org/fhir/R4/codesystem-contact-point-system.html#contact-point-system-pager">pager</a>
                                    </td>
                                    <td>
                                        Pager
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <a href="http://hl7.org/fhir/R4/codesystem-contact-point-system.html#contact-point-system-url">url</a>
                                    </td>
                                    <td>
                                        URL website kantor
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <a href="http://hl7.org/fhir/R4/codesystem-contact-point-system.html#contact-point-system-sms">sms</a>
                                    </td>
                                    <td>
                                        Nomor SMS kantor
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <a href="http://hl7.org/fhir/R4/codesystem-contact-point-system.html#contact-point-system-other">other</a>
                                    </td>
                                    <td>
                                        Lain-lain
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    <ul>
                        <li>
                            Organization.telecom.value = nomor/email/website kontak organisasi
                        </li>
                        <li>
                            Organization.telecom.use = work
                        </li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td>
                    Organization.address
            </td>
                <td>
                    Optional (Omit Empty)
                </td>
                <td>
                    <ul>
                        <li>
                            Alamat organisasi secara umum
                        </li>
                        <li>
                            Dapat diisi &gt;1 alamat
                        </li>
                        <li>
                            Format Pengisian
                            <ul>
                                <li>
                                    Organization.address.use = work
                                </li>
                                <li>
                                    Organization.address.type =
                                </li>
                            </ul>
                        </li>
                    </ul><br>
                        <table class="table table-bordered"  style="table-layout: fixed;">
                            <thead style="word-wrap:break-word;">
                                <tr>
                                    <th>
                                        Organization.address.type
                                    </th>
                                    <th>
                                        Keterangan
                                    </th>
                                </tr>
                            </thead>
                            <tbody style="word-wrap:break-word;">
                                <tr>
                                    <td>
                                        <a href="http://hl7.org/fhir/R4/codesystem-address-type.html#address-type-postal">postal</a>
                                    </td>
                                    <td>
                                        Alamat surat
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <a href="http://hl7.org/fhir/R4/codesystem-address-type.html#address-type-physical">physical</a>
                                    </td>
                                    <td>
                                        Alamat fisik yang dapat dikunjungi.
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <a href="http://hl7.org/fhir/R4/codesystem-address-type.html#address-type-both">both</a>
                                    </td>
                                    <td>
                                        Alamat yang bersifat fisik dan surat.
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    <br>
                    <ul>
                        <li>
                            Organization.address.line = Alamat lengkap organisasi
                        </li>
                        <li>
                            Organization.address.postalCode = kode pos
                        </li>
                        <li>
                            Organization.address.country = kode negara berdasarkan ISO 3316 2-letter (contoh : ID)
                        </li>
                        <li>
                            Organization.address.extension:administrativeCode.extension:province= kode provinsi berdasarkan kemendagri
                        </li>
                        <li>
                            Organization.address.extension:administrativeCode.extension:city = kode kabupaten berdasarkan kemendagri
                        </li>
                        <li>
                            Organization.address.extension:administrativeCode.extension:district = kode kecamatan berdasarkan kemendagri
                        </li>
                        <li>
                            Organization.address.extension:administrativeCode.extension:village = kode kelurahan berdasarkan kemendagri
                        </li>
                        <li>
                            Organization.address.extension:administrativeCode.extension:rt = nomor RT
                        </li>
                        <li>
                            Organization.address.extension:administrativeCode.extension:rw = nomor RW
                        </li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td>
                    Organization.partOf
                </td>
                <td>
                    Mandatory
                </td>
                <td>
                    <ul>
                        <li>
                            Wajib diisi apabila organisasi bagian dari organisasi lain (suborganisasi)
                        </li>
                        <li>
                            Format pengisian = <code>Organization/Nomor id struktur organisasi diatasnya</code>
                        </li>
                    </ul>
                    *Nomor id struktur organisasi diatasnya didapatkan setelah POST data suborganisasi. Format id dalam bentuk uuid
                    Contoh pengisian :
                    <ol>
                        <li>
                            Direktorat Medik, Keperawatan, dan Penunjang merupakan bagian dari RSUD Jati Asih
                            <ol>
                                <li>
                                    Nomor SATUSEHAT RSUD Jati Asih = 100000004
                                </li>
                                <li>
                                    Organization.partOf dari Direktorat Medik, keperawatan, dan penunjang = <code>Organization/100000004</code>
                                </li>
                            </ol>
                        </li>
                        <li>
                            Instalasi Rawat Jalan merupakan bagian dari direktorat medik, keperawatan, dan penunjang
                            <ol>
                                <li>
                                    id Direktorat Medik, Keperawatan, dan Penunjang = f2f269ff-0c7a-4769-9821-5c27b3fa3b9c
                                </li>
                                <li>
                                    Organization.partOf dari Instalasi Rawat Jalan = <code>Organization/f2f269ff-0c7a-4769-9821-5c27b3fa3b9c</code>
                                </li>
                            </ol>
                        </li>
                    </ol>
                </td>
            </tr>
            <tr>
                <td>
                    Organization.contact
                </td>
                <td>
                    Optional (Omit Empty)
                </td>
                <td>
                    <ul>
                        <li>
                            Kontak organisasi untuk tujuan tertentu (billing, administrasi, HR, dll.)
                        </li>
                        <li>
                            Format pengisian
                            <ul>
                                <li>
                                    Organization.contact.purpose
                                </li>
                            </ul>
                        </li>
                    </ul><br>
                        <table class="table table-bordered"  style="table-layout: fixed;">
                            <thead style="word-wrap:break-word;">
                                <tr>
                                    <th>
                                        Organization.contact.purpose.coding.system
                                    </th>
                                    <th>
                                        Organization.contact.purpose.coding.code
                                    </th>
                                    <th>
                                        Organization.contact.purpose.coding.display
                                    </th>
                                    <th>
                                        Keterangan
                                    </th>
                                </tr>
                            </thead>
                            <tbody style="word-wrap:break-word;">
                                <tr>
                                    <td>
                                        <a href="http://hl7.org/fhir/R4/codesystem-contactentity-type.html">http://terminology.hl7.org/CodeSystem/contactentity-type</a>
                                    </td>
                                    <td>
                                        <a href="http://hl7.org/fhir/R4/codesystem-contactentity-type.html#contactentity-type-BILL">BILL</a>
                                    </td>
                                    <td>
                                        Billing
                                    </td>
                                    <td>
                                        Billing
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <a href="http://hl7.org/fhir/R4/codesystem-contactentity-type.html">http://terminology.hl7.org/CodeSystem/contactentity-type</a>
                                    </td>
                                    <td>
                                        <a href="http://hl7.org/fhir/R4/codesystem-contactentity-type.html#contactentity-type-ADMIN">ADMIN</a>
                                    </td>
                                    <td>
                                        Administrative
                                    </td>
                                    <td>
                                        Administratif
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <a href="http://hl7.org/fhir/R4/codesystem-contactentity-type.html">http://terminology.hl7.org/CodeSystem/contactentity-type</a>
                                    </td>
                                    <td>
                                        <a href="http://hl7.org/fhir/R4/codesystem-contactentity-type.html#contactentity-type-HR">HR</a>
                                    </td>
                                    <td>
                                        Human Resource
                                    </td>
                                    <td>
                                        SDM seperti informasi staf/tenaga kesehatan
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <a href="http://hl7.org/fhir/R4/codesystem-contactentity-type.html">http://terminology.hl7.org/CodeSystem/contactentity-type</a>
                                    </td>
                                    <td>
                                        <a href="http://hl7.org/fhir/R4/codesystem-contactentity-type.html#contactentity-type-PAYOR">PAYOR</a>
                                    </td>
                                    <td>
                                        Payor
                                    </td>
                                    <td>
                                        Klaim asuransi, pembayaran
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <a href="http://hl7.org/fhir/R4/codesystem-contactentity-type.html">http://terminology.hl7.org/CodeSystem/contactentity-type</a>
                                    </td>
                                    <td>
                                        <a href="http://hl7.org/fhir/R4/codesystem-contactentity-type.html#contactentity-type-PATINF">PATINF</a>
                                    </td>
                                    <td>
                                        Patient
                                    </td>
                                    <td>
                                        Informasi umum untuk pasien
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <a href="http://hl7.org/fhir/R4/codesystem-contactentity-type.html">http://terminology.hl7.org/CodeSystem/contactentity-type</a>
                                    </td>
                                    <td>
                                        <a href="http://hl7.org/fhir/R4/codesystem-contactentity-type.html#contactentity-type-PRESS">PRESS</a>
                                    </td>
                                    <td>
                                        Press
                                    </td>
                                    <td>
                                        Pertanyaan terkait press
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    <br>
                    <ul>
                        <li>
                            Organization.contact.name = nama contact person terkait
                        </li>
                        <li>
                            Organization.contact.telecom = format pengisian sama dengan Organization.telecom
                        </li>
                        <li>
                            Organization.contact.address = format pengisian sama dengan Organization.address
                        </li>
                    </ul>
                </td>
            </tr>
        </tbody>
    </table>
</div>

<br><br>

#### Contoh Pengiriman Payload dapat dilihat pada link : 
{{pagelink:Home/Examples/ResourceExample/Organization.page.md,text:Contoh Penggunaan Resource Organization}}


<br><br><hr>

|<< {{pagelink:Home/Developer/Authentication.page.md,text:Autentikasi ke SATUSEHAT}} | {{pagelink:Home,text:Halaman Utama}} | {{pagelink:Home/Developer/Location.page.md,text:Registrasi Struktur Lokasi}} >> |
| --- |------------------------- | --------------- |