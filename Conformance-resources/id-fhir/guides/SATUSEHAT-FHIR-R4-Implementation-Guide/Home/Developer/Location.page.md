## {{page-title}}

Contoh Struktur Location dapat dilihat pada gambar dibawah berikut : 

<img src="https://raw.githubusercontent.com/fhir-kemkes/assets/main/Picture/LocationChart.png"  width="100%" height="100%">

Struktur lokasi merupakan lokasi fisik yang dapat berupa bangunan, ruangan yang menjadi tempat dimana layanan kesehatan dilakukan. Institusi yang akan melakukan integrasi ke SATUSEHAT perlu melakukan registrasi atau mengirimkan data terkait struktur lokasi yang tersedia di dalam institusi tersebut. Data struktur lokasi yang dimaksud adalah detail dan informasi posisi untuk tempat fisik di mana layanan disediakan dan sumber daya dan peserta dapat disimpan, ditemukan, ditampung, atau diakomodasi. Contoh struktur lokasi dapat dilihat dalam gambar 2. Setiap lokasi dari struktur tersebut perlu dikirimkan datanya ke SATUSEHAT untuk keperluan informasi dimana suatu layanan dilakukan. 

Data struktur dikirimkan menggunakan resource Location dengan metode POST. Template pengisian struktur lokasi dapat diakses pada link berikut : [Template Registrasi Organization & Location](https://docs.google.com/spreadsheets/d/1JBP2aUtPqCrsIyVvr2Mus1DMeLTumBn9a0azIHyv4f4/edit#gid=1571590515)

<div class="table-wrapper" markdown="block" style="overflow-x:scroll">
    <table class="table table-bordered">
        <thead>
            <tr>
                <td colspan="3">
                     <p style="text-align:center"><b>Resource <a href="https://simplifier.net/guide/SATUSEHAT-FHIR-R4-Implementation-Guide/Home/FHIRProfiles/Location.page.md?version=current", target="_blank">Location</a></b></p>
                </td>
            </tr>
            <tr>
                <td>
                    <b>Elemen Data / Path</b>
                </td>
                <td>
                    <b>Tipe Mandatoris</b>
                </td>
                <td>
                    <b>Deskripsi</b>
                </td>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>
                    Location.identifier
                </td>
                <td>
                    Optional (Omit Empty)
                </td>
                <td>
                    <ul>
                        <li>
                            Dapat diisi dengan informasi terkait kode/nomor internal lokasi yang dimiliki oleh organisasi
                        </li>
                        <li>
                            Format Pengisian
                            <ul>
                                <li>
                                    Location.identifier.use = official
                                </li>
                                <li>
                                    Organization.identifier.system =<code>http://sys-ids.kemkes.go.id/location/&#123;&#123;OrganizationID&#125;&#125;</code><br>
                                    OrganizationID adalah nomor SATUSEHAT organisasi induk yang didapatkan dari <i>Master Sarana Index</i><br>
                                    Contoh pengisian : <code>http://sys-ids.kemkes.go.id/location/10000004</code>
                                </li>
                                <li>
                                    Location.identifier.value = kode/nomor internal lokasi (contoh = G-2-R-1A)
                                </li>
                            </ul>
                        </li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td>
                    Location.status
                </td>
                <td>
                    Mandatory
                </td>
                <td>
                    <ul>
                        <li>
                            Status lokasi
                        </li>
                        <li>
                            Format pengisian : active/suspended/inactive
                        </li>
                    </ul><br>
                    <table class="table table-bordered"  style="table-layout: fixed;">
                        <thead><tr>
                            <tr>
                                <th style="word-wrap:break-word;">Location.status</th>
                                <th style="word-wrap:break-word;">Keterangan</th>
                            </tr>
                        </tr></thead>
                        <tbody style="word-wrap:break-word;">
                            <tr>
                                <td>
                                    active
                                </td>
                                <td>
                                    Lokasi sedang beroperasi
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    suspended
                                </td>
                                <td>
                                    Lokasi ditutup sementara
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    inactive
                                </td>
                                <td>
                                    Lokasi tidak lagi digunakan
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <br>
                </td>
            </tr>
            <tr>
                <td>
                    Location.operationalStatus<br>
                </td>
                <td>
                    Optional (Omit Empty)
                </td>
                <td>
                    <ul>
                        <li>
                            Status operasional lokasi, terutama digunakan untuk bed/kamar
                        </li>
                        <li>
                            Format pengisian
                        </li>
                    </ul><br>
                    <table class="table table-bordered"  style="table-layout: fixed;">
                        <thead><tr>
                                <th style="word-wrap:break-word;">
                                    Location.operationalStatus.system
                                </th>
                                <th style="word-wrap:break-word;">
                                    Location.operationalStatus.code
                                </th>
                                <th style="word-wrap:break-word;">
                                    Location.operationalStatus.display
                                </th>
                        </tr></thead>
                        <tbody style="word-wrap:break-word;">
                            <tr>
                                <td>
                                    <a href="http://terminology.hl7.org/CodeSystem/v2-0116">http://terminology.hl7.org/CodeSystem/v2-0116</a>
                                </td>
                                <td>
                                    C
                                </td>
                                <td>
                                    Closed
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <a href="http://terminology.hl7.org/CodeSystem/v2-0116">http://terminology.hl7.org/CodeSystem/v2-0116</a>
                                </td>
                                <td>
                                    H
                                </td>
                                <td>
                                    Housekeeping
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <a href="http://terminology.hl7.org/CodeSystem/v2-0116">http://terminology.hl7.org/CodeSystem/v2-0116</a>
                                </td>
                                <td>
                                    I
                                </td>
                                <td>
                                    Isolated
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <a href="http://terminology.hl7.org/CodeSystem/v2-0116">http://terminology.hl7.org/CodeSystem/v2-0116</a>
                                </td>
                                <td>
                                    K
                                </td>
                                <td>
                                    Contaminated
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <a href="http://terminology.hl7.org/CodeSystem/v2-0116">http://terminology.hl7.org/CodeSystem/v2-0116</a>
                                </td>
                                <td>
                                    O
                                </td>
                                <td>
                                    Occupied
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <a href="http://terminology.hl7.org/CodeSystem/v2-0116">http://terminology.hl7.org/CodeSystem/v2-0116</a>
                                </td>
                                <td>
                                    U
                                </td>
                                <td>
                                    Unoccupied
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    Location.name
                </td>
                <td>
                    Mandatory
                </td>
                <td>
                    <ul>
                        <li>
                            Nama lokasi
                        </li>
                        <li>
                            Format pengisian : string
                        </li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td>
                    Location.alias
                </td>
                <td>
                    Optional (Omit Empty)
                </td>
                <td>
                    <ul>
                        <li>
                            Nama lain lokasi
                        </li>
                        <li>
                            Format pengisian : string
                        </li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td>
                    Location.description
                </td>
                <td>
                    Optional (Omit Empty)
                </td>
                <td>
                    <ul>
                        <li>
                            Deskripsi lokasi
                        </li>
                        <li>
                            Format pengisian : string
                        </li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td>
                    Location.mode
                </td>
                <td>
                    Optional (Omit Empty)
                </td>
                <td>
                    <ul>
                        <li>
                            Informasi terkait apakah suatu lokasi merupakan lokasi spesifik (cth. Ruang Operasi A, Kamar Rawat Inap 215) atau kelompok/kelas lokasi (Ruang Operasi, Kamar Rawat Inap)
                        </li>
                        <li>
                            Untuk skenario resume rawat jalan, perlu mengirimkan lokasi spesifik
                        </li>
                    </ul><br><br>
                    <table class="table table-bordered"  style="table-layout: fixed;">
                        <thead><tr>
                                <th style="word-wrap:break-word;">
                                    Location.mode
                                </th>
                                <th style="word-wrap:break-word;">
                                    Keterangan
                                </th>
                            </tr>
                            <tr>
                                <td>
                                    instance
                                </td>
                                <td>
                                    Merepresentasikan lokasi spesifik
                                </td>
                        </tr></thead>
                        <tbody style="word-wrap:break-word;">
                            <tr>
                                <td>
                                    kind
                                </td>
                                <td>
                                    Merepresentasikan kelompok/kelas lokasi
                                </td>
                            </tr>
                        </tbody>
                    </table><br>
                </td>
            </tr>
            <tr>
                <td>
                    Location.type
                </td>
                <td>
                    Optional (Omit Empty)
                </td>
                <td>
                    <ul>
                        <li>
                            Tipe fungsi lokasi
                        </li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td>
                    Location.telecom
                </td>
                <td>
                    Optional (Omit Empty)
                </td>
                <td>
                    <ul>
                        <li>
                            Kontak lokasi
                        </li>
                        <li>
                            Format Pengisian
                            <ul>
                                <li>
                                    Location.telecom.system =
                                </li>
                            </ul>
                        </li>
                    </ul><br>
                    <table class="table table-bordered"  style="table-layout: fixed;">
                        <thead>
                            <tr>
                                <th style="word-wrap:break-word;">
                                    Location.telecom.system
                                </th>
                                <th style="word-wrap:break-word;">
                                    Keterangan
                                </th>
                        </tr></thead>
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
                            Location.telecom.value = nomor/email/website kontak
                        </li>
                        <li>
                            Location.telecom.use = work
                        </li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td>
                    Location.address
                </td>
                <td>
                    Optional (Omit Empty)
                </td>
                <td>
                    <ul>
                        <li>
                            Alamat lokasi
                        </li>
                        <li>
                            Format Pengisian
                            <ul>
                                <li>
                                    Location.address.use = work
                                </li>
                                <li>
                                    Location.address.type =
                                </li>
                            </ul>
                        </li>
                    </ul><br>
                    <table class="table table-bordered"  style="table-layout: fixed;">
                        <thead>
                            <tr>
                                <th style="word-wrap:break-word;">
                                    Location.address.type
                                </th>
                                <th style="word-wrap:break-word;">
                                    Keterangan
                                </th>
                            </tr></thead>
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
                    </table><br>
                    <ul>
                        <li>
                            Location.address.line = Alamat lengkap organisasi
                        </li>
                        <li>
                            Location.address.postalCode = kode pos
                        </li>
                        <li>
                            Location.address.country = kode negara berdasarkan ISO 3316 2-letter (contoh : ID)
                        </li>
                        <li>
                            Location.address.extension:administrativeCode.extension:province= kode provinsi berdasarkan kemendagri
                        </li>
                        <li>
                            Location.address.extension:administrativeCode.extension:city = kode kabupaten berdasarkan kemendagri
                        </li>
                        <li>
                            Location.address.extension:administrativeCode.extension:district = kode kecamatan berdasarkan kemendagri
                        </li>
                        <li>
                            Location.address.extension:administrativeCode.extension:village = kode kelurahan berdasarkan kemendagri
                        </li>
                        <li>
                            Location.address.extension:administrativeCode.extension:rt = nomor RT
                        </li>
                        <li>
                            Location.address.extension:administrativeCode.extension:rw = nomor RW
                        </li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td>
                    Location.physicalType
                </td>
                <td>
                    Mandatory
                </td>
                <td>
                    <ul>
                        <li>
                            Tipe fisik lokasi
                        </li>
                        <li>
                            Format Pengisian
                        </li>
                    </ul><br>
                    <table class="table table-bordered"  style="table-layout: fixed;">
                        <thead>
                            <tr>
                                <th style="word-wrap:break-word;">
                                    Location.physicalType.coding.system
                                </th>
                                <th style="word-wrap:break-word;">
                                Location.physicalType.coding.code
                                </th>
                                <th style="word-wrap:break-word;">
                                    Location.physicalType.coding.display
                                </th>
                                <th style="word-wrap:break-word;">
                                    Keterangan
                                </th>
                            </tr></thead>
                        <tbody style="word-wrap:break-word;">
                            <tr>
                                <td>
                                    <a href="http://terminology.hl7.org/CodeSystem/location-physical-type">http://terminology.hl7.org/CodeSystem/location-physical-type</a>
                                </td>
                                <td>
                                    <a href="http://hl7.org/fhir/R4/codesystem-location-physical-type.html#location-physical-type-si">si</a>
                                </td>
                                <td>
                                    Site
                                </td>
                                <td>
                                    Kumpulan bangunan atau lokasi lain seperti kompleks atau kampus.
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <a href="http://terminology.hl7.org/CodeSystem/location-physical-type">http://terminology.hl7.org/CodeSystem/location-physical-type</a>
                                </td>
                                <td>
                                    <a href="http://hl7.org/fhir/R4/codesystem-location-physical-type.html#location-physical-type-bu">bu</a>
                                </td>
                                <td>
                                    Building
                                </td>
                                <td>
                                    Setiap Bangunan atau struktur.
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <a href="http://terminology.hl7.org/CodeSystem/location-physical-type">http://terminology.hl7.org/CodeSystem/location-physical-type</a>
                                </td>
                                <td>
                                    <a href="http://hl7.org/fhir/R4/codesystem-location-physical-type.html#location-physical-type-wi">wi</a>
                                </td>
                                <td>
                                    Wing
                                </td>
                                <td>
                                    Sayap di dalam Gedung, sering berisi lantai, kamar, dan koridor.
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <a href="http://terminology.hl7.org/CodeSystem/location-physical-type">http://terminology.hl7.org/CodeSystem/location-physical-type</a>
                                </td>
                                <td>
                                    <a href="http://hl7.org/fhir/R4/codesystem-location-physical-type.html#location-physical-type-wa">wa</a>
                                </td>
                                <td>
                                    Ward
                                </td>
                                <td>
                                    Bangsal adalah bagian dari fasilitas medis yang mungkin berisi kamar dan jenis lokasi lainnya
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <a href="http://terminology.hl7.org/CodeSystem/location-physical-type">http://terminology.hl7.org/CodeSystem/location-physical-type</a>
                                </td>
                                <td>
                                    <a href="http://hl7.org/fhir/R4/codesystem-location-physical-type.html#location-physical-type-lvl">lvl</a>
                                </td>
                                <td>
                                    Level
                                </td>
                                <td>
                                    Lantai di Gedung/Struktur
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <a href="http://terminology.hl7.org/CodeSystem/location-physical-type">http://terminology.hl7.org/CodeSystem/location-physical-type</a>
                                </td>
                                <td>
                                    <a href="http://hl7.org/fhir/R4/codesystem-location-physical-type.html#location-physical-type-co">co</a>
                                </td>
                                <td>
                                    Corridor
                                </td>
                                <td>
                                    Setiap koridor di dalam Gedung, yang dapat menghubungkan kamar-kamar
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <a href="http://terminology.hl7.org/CodeSystem/location-physical-type">http://terminology.hl7.org/CodeSystem/location-physical-type</a>
                                </td>
                                <td>
                                    <a href="http://hl7.org/fhir/R4/codesystem-location-physical-type.html#location-physical-type-ro">ro</a>
                                </td>
                                <td>
                                    Room
                                </td>
                                <td>
                                    Sebuah ruang yang dialokasikan sebagai ruangan
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <a href="http://terminology.hl7.org/CodeSystem/location-physical-type">http://terminology.hl7.org/CodeSystem/location-physical-type</a>
                                </td>
                                <td>
                                    <a href="http://hl7.org/fhir/R4/codesystem-location-physical-type.html#location-physical-type-bd">bd</a>
                                </td>
                                <td>
                                    Bed
                                </td>
                                <td>
                                    Tempat tidur yang dapat ditempati
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <a href="http://terminology.hl7.org/CodeSystem/location-physical-type">http://terminology.hl7.org/CodeSystem/location-physical-type</a>
                                </td>
                                <td>
                                    <a href="http://hl7.org/fhir/R4/codesystem-location-physical-type.html#location-physical-type-ve">ve</a>
                                </td>
                                <td>
                                    Vehicle
                                </td>
                                <td>
                                    Alat transportasi
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <a href="http://terminology.hl7.org/CodeSystem/location-physical-type">http://terminology.hl7.org/CodeSystem/location-physical-type</a>
                                </td>
                                <td>
                                    <a href="http://hl7.org/fhir/R4/codesystem-location-physical-type.html#location-physical-type-ho">ho</a>
                                </td>
                                <td>
                                    House
                                </td>
                                <td>
                                    Rumah
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <a href="http://terminology.hl7.org/CodeSystem/location-physical-type">http://terminology.hl7.org/CodeSystem/location-physical-type</a>
                                </td>
                                <td>
                                    <a href="http://hl7.org/fhir/R4/codesystem-location-physical-type.html#location-physical-type-ca">ca</a>
                                </td>
                                <td>
                                    Cabinet
                                </td>
                                <td>
                                    Wadah yang dapat menyimpan barang, peralatan, obat-obatan atau barang lainnya.
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <a href="http://terminology.hl7.org/CodeSystem/location-physical-type">http://terminology.hl7.org/CodeSystem/location-physical-type</a>
                                </td>
                                <td>
                                    <a href="http://hl7.org/fhir/R4/codesystem-location-physical-type.html#location-physical-type-rd">rd</a>
                                </td>
                                <td>
                                    Road
                                </td>
                                <td>
                                    Jalan
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <a href="http://terminology.hl7.org/CodeSystem/location-physical-type">http://terminology.hl7.org/CodeSystem/location-physical-type</a>
                                </td>
                                <td>
                                    <a href="http://hl7.org/fhir/R4/codesystem-location-physical-type.html#location-physical-type-area">area</a>
                                </td>
                                <td>
                                    Area
                                </td>
                                <td>
                                    Area (contoh : zona risiko banjir, wilayah, wilayah kodepos)
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <a href="http://terminology.hl7.org/CodeSystem/location-physical-type">http://terminology.hl7.org/CodeSystem/location-physical-type</a>
                                </td>
                                <td>
                                    <a href="http://hl7.org/fhir/R4/codesystem-location-physical-type.html#location-physical-type-jdn">jdn</a>
                                </td>
                                <td>
                                    Jurisdiction
                                </td>
                                <td>
                                    Negara, Provinsi
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <a href="http://terminology.hl7.org/CodeSystem/location-physical-type">http://sys-ids.kemkes.go.id/CodeSystem/location-physical-type</a><br>
                                </td>
                                <td>
                                    vir
                                </td>
                                <td>
                                    Virtual
                                </td>
                                <td>
                                    Virtual
                                </td>
                            </tr>
                        </tbody>
                    </table><br>
                    Untuk lokasi pelayanan kesehatantelemedicine, maka lokasi yang diregistrasi contohnya adalah Ruang Chat,Video Call,Phone Callpada Location.name sesuai dengan pembagian di masing-masing institusi. Location.physicalType menggunakan kode &ldquo;vir&rdquo; untuk Virtual. 
                </td>
            </tr>
            <tr>
                <td>
                    Location.position
                </td>
                <td>
                    Optional (Omit Empty)
                </td>
                <td>
                    <ul>
                        <li>
                            Lokasi secara geografis (longitude, latitude, altitude)
                        </li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td>
                    Location.managingOrganization
                </td>
                <td>
                    Mandatory
                </td>
                <td>
                    <ul>
                        <li>
                            Organisasi pengelola lokasi
                        </li>
                        <li>
                            Reference ke data yang tersimpan di resourceOrganization
                        </li>
                        <li>
                            Format pengisian : Organization/Nomor Id Organisasi pengelola
                        </li>
                    </ul>
                    *Nomor id organisasi pengelola didapatkan dari Nomor SATUSEHAT fasyankes (organisasi induk) atau No id yang didapatkan setelah POST data suborganisasi. Contoh pengisian :
                    <ol>
                        <li>
                            Lokasi kompleks RSUD Jati Asih dikelola oleh Organisasi RSUD Jati Asih 
                        </li>
                        <li>
                            Nomor SATUSEHAT RSUD Jati Asih = 100000004
                        </li>
                        <li>
                            Location.managingOrganization dari RSUD Jati Asih = Organization/100000004
                        </li>
                    </ol>
                    <ol start="2">
                        <li>
                            Gedung Alamanda dikelola oleh Direktorat Medik, Keperawatan, dan Penunjang
                        </li>
                    </ol>
                    <ol>
                        <li>
                            id Direktorat Medik, Keperawatan, dan Penunjang = f2f269ff-0c7a-4769-9821-5c27b3fa3b9c
                        </li>
                        <li>
                            Location.managingOrganization dari Gedung Alamanda = Organization/f2f269ff-0c7a-4769-9821-5c27b3fa3b9c
                        </li>
                    </ol>
                </td>
            </tr>
            <tr>
                <td>
                    Location.partOf
                </td>
                <td>
                    Mandatory
                </td>
                <td>
                    <ul>
                        <li>
                            Wajib diisi apabila lokasi bagian dari lokasi lain (sublokasi)
                        </li>
                        <li>
                            Format pengisian = <code>Location/Nomor id struktur lokasi diatasnya</code>
                        </li>
                    </ul>
                    *Nomor id struktur lokasi diatasnya didapatkan setelah POST data sublokasi. Format id dalam bentuk uuid
                    Contoh pengisian :
                    <ol>
                        <li>
                            Gedung Alamanda merupakan bagian dari RSUD Jati Asih
                            <ol>
                                <li>
                                    id lokasi RSUD Jati Asih = <code>4adccec5-776d-435e-9ac5-98763cb216bb</code>
                                </li>
                                <li>
                                    Location.partOf dari Gedung Alamanda = <code>Organization/4adccec5-776d-435e-9ac5-98763cb216bb</code>
                                </li>
                            </ol>
                        </li>
                    </ol>
                </td>
            </tr>
            <tr>
                <td>
                    Location.hoursOfOperation
                </td>
                <td>
                    Optional (Omit Empty)
                </td>
                <td>
                    <ul>
                        <li>
                            Waktu lokasi beroperasi
                        </li>
                        <li>
                            Format pengisian
                        </li>
                    </ul>
                    Contoh 
                    <ol>
                        <li>
                            RSUD Jati Asih buka 7x24 jam
                        </li>
                    </ol><br>
                        <table class="table table-bordered"  style="table-layout: fixed;">
                            <tbody style="word-wrap:break-word;"><tr>
                                    <td>
                                        Location.hoursOfOperation.daysOfWeek
                                    </td>
                                    <td>
                                        mon, tue, wed, thu, fri, sat, sun
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Location.hoursOfOperation.allDay
                                    </td>
                                    <td>
                                        true
                                    </td>
                                </tr>
                            </tbody>
                        </table><br>
                    <ol start="2">
                        <li>
                            Poliklinik Paru buka Senin-Jumat pukul 07:00-17:00
                        </li>
                    </ol><br>
                        <table class="table table-bordered"  style="table-layout: fixed;">
                            <tbody style="word-wrap:break-word;">
                                <tr>
                                    <td>
                                        Location.hoursOfOperation.daysOfWeek
                                    </td>
                                    <td>
                                        mon, tue, wed, thu, fri
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Location.hoursOfOperation.allDay
                                    </td>
                                    <td>
                                        false
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Location.hoursOfOperation.openingTime
                                    </td>
                                    <td>
                                        07:00:00
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Location.hoursOfOperation.closingTime
                                    </td>
                                    <td>
                                        17:00:00
                                    </td>
                                </tr>
                            </tbody>
                        </table><br>
                </td>
            </tr>
            <tr>
                <td>
                    Location.availabilityExecptions
                </td>
                <td>
                    Optional (Omit Empty)
                </td>
                <td>
                    <ul>
                        <li>
                            Deskripsi kapan jam buka lokasi berbeda dari biasanya (contoh : Libur Nasional)
                        </li>
                        <li>
                            Format pengisian : string
                        </li>
                    </ul>
                </td>
            </tr>
        </tbody>
    </table>
</div>

<br><br>

#### Contoh Pengiriman Payload dapat dilihat pada link : 
{{pagelink:Home/Examples/ResourceExample/Location.page.md,text:Contoh Penggunaan Resource Location}}

<br><br><hr>


|<< {{pagelink:Home/Developer/Organization.page.md,text:Registrasi Struktur Organisasi}} | {{pagelink:Home,text:Halaman Utama}} | {{pagelink:Home/Developer/HealthcareProvider.page.md,text:Nomor SATUSEHAT Tenaga Kesehatan}} >> |
| --- |------------------------- | --------------- |