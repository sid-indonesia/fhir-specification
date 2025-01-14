## {{page-title}}

Kunjungan pasien adalah interaksi pasien terhadap suatu layanan fasyankes. Misal dalam satu rangkaian rawat jalan, seluruh rangkaian dapat didefinisikan sebagai satu “Encounter”. Namun, rangkaian rawat inap memungkinkan pasien memiliki beberapa “Encounter” terhadap satu jenis layanan yang sama. Data-data kunjungan pasien yang direkam meliputi kapan pertemuan tersebut mulai dan selesai, siapa tenaga kesehatan yang melayani, siapa subjek dari pelayanannya, dan informasi pendukung lainnya.


Pada saat pendaftaran kunjungan pasien, elemen berikut ini yang wajib dikirimkan 
1. Encounter.status
2. Encounter.statusHistory
3. Encounter.class
4. Encounter.subject 
5. Encounter.period.start
6. Encounter.location
7. Encounter.serviceProvider

Untuk elemen mandatoris lainnya dapat dikirimkan setelah kunjungan berakhir. 

<br><br>

<div class="table-wrapper" markdown="block" style="overflow-x:scroll">
    <table class="table table-bordered">
        <tbody style="word-wrap:break-word;">
            <tr>
                <td colspan="3">
                    <p style="text-align:center"><b>Resource <a href="https://simplifier.net/guide/SATUSEHAT-FHIR-R4-Implementation-Guide/Home/FHIRProfiles/Encounter.page.md?version=current", target="_blank">Encounter</a></b></p>
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
            <tr>
                <td>
                    Encounter.identifier
                </td>
                <td>
                    Optional (Omit Empty)
                </td>
                <td>
                    <ul>
                        <li>
                            ID internal faskes untuk kunjungan ini. Ini adalah ID resmi yang diterbitkan oleh faskes untuk menandai kunjungan pasien.
                        </li>
                        <li>
                            Format pengisian
                        </li>
                    </ul><br>
                        <table class="table table-bordered"  style="table-layout: fixed;">
                            <tbody style="word-wrap:break-word;">
                                <tr>
                                    <th>
                                        Encounter.identifier.system
                                    </th>
                                    <td>
                                        Referensi sistem / URL observasi ID lokal yang disimpan di sistem internal masing-masing organisasi<br>
                                        Format pengisian : <a href="http://sys-ids.kemkes.go.id/observation/%7B%7Borganization-ihs-number%7D%7D/%7B%7Bsubsystem">http://sys-ids.kemkes.go.id/encounter/&#123;&#123organization-ihs-number&#125;&#125/</a><br>
                                        Organization-ihs-number adalah nomor SATUSEHAT organisasi induk yang didapatkan dari master sarana index<br>
                                        Contoh : <a href="http://codesystem.kemkes.go.id/id/encounter/1000001">http://sys-ids.kemkes.go.id/encounter/1000004</a>
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        Encounter.identifier.use
                                    </th>
                                    <td>
                                        official
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        Encounter.identifier.value
                                    </td>
                                    <td>
                                        ID lokal/nomor kunjungan lokal yang disimpan di sistem internal masing2 organisasi<br>
                                        Contoh : 98457729
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    <br>
                </td>
            </tr>
            <tr>
                <td>
                    Encounter.status
                </td>
                <td>
                    Mandatoris
                </td>
                <td>
                    <ul>
                        <li>
                            Status tahapan dari pertemuan pasien
                        </li>
                        <br>
                        <table class="table table-bordered"  style="table-layout: fixed;">
                            <tbody style="word-wrap:break-word;">
                                <tr>
                                    <th>
                                        Encounter.status
                                    </th>
                                    <th>
                                        Keterangan
                                    </th>
                                </tr>
                                <tr>
                                    <td>
                                        planned
                                    </td>
                                    <td>
                                        Sudah direncanakan
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        arrived
                                    </td>
                                    <td>
                                        Sudah datang
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        triaged
                                    </td>
                                    <td>
                                        Triase
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        in-progress
                                    </td>
                                    <td>
                                        Sedang berlangsung
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        onleave
                                    </td>
                                    <td>
                                        Sedang pergi
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        finished
                                    </td>
                                    <td>
                                        Sudah selesai
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        cancelled
                                    </td>
                                    <td>
                                        Dibatalkan
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </ul>
                </td>
            </tr>
            <tr>
                <td>
                    Encounter.statusHistory
                </td>
                <td>
                    Mandatoris
                </td>
                <td>
                    <ul>
                        <li>
                            Penyimpanan riwayat status dari kunjungan pasien
                        </li>
                        <li>
                            Terdapat 3 status yang wajib dikirimkan datanya yaitu
                            <ul>
                                <li>
                                    arrived
                                </li>
                                <li>
                                    In-progress
                                </li>
                                <li>
                                    finished
                                </li>
                            </ul>
                        </li>
                    </ul><br>
                        <table class="table table-bordered"  style="table-layout: fixed;">
                            <tbody style="word-wrap:break-word;">
                                <tr>
                                    <th>
                                        Encounter.statusHistory.status
                                    </th>
                                    <td>
                                        Penjelasan tentang status dari kunjungan pasien
                                            <table class="table table-bordered"  style="table-layout: fixed;">
                                                <tbody style="word-wrap:break-word;">
                                                    <tr>
                                                        <th>
                                                            Kode
                                                        </th>
                                                        <th>
                                                            Keterangan
                                                        </th>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            planned
                                                        </td>
                                                        <td>
                                                            Sudah direncanakan
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            arrived
                                                        </td>
                                                        <td>
                                                            Sudah datang
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            triaged
                                                        </td>
                                                        <td>
                                                            Triase
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            in-progress
                                                        </td>
                                                        <td>
                                                            Sedang berlangsung
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            onleave
                                                        </td>
                                                        <td>
                                                            Sedang pergi
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            finished
                                                        </td>
                                                        <td>
                                                            Sudah selesai
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            cancelled
                                                        </td>
                                                        <td>
                                                            Dibatalkan
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        <br>
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        Encounter.statusHistory.period.start
                                    </th>
                                    <td>
                                        Waktu dimulainya suatu status kunjungan
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        Encounter.statusHistory.period.end
                                    </th>
                                    <td>
                                        Waktu berakhirnya suatu status kunjungan
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    <ul>
                        <li>
                            Cara pengisian Encounter.statusHistory.period untuk masing-masing status
                        </li>
                    </ul><br>
                        <table class="table table-bordered"  style="table-layout: fixed;">
                            <tbody style="word-wrap:break-word;">
                                <tr>
                                    <th>
                                        Elemen
                                    </th>
                                    <th>
                                        Keterangan
                                    </th>
                                    <th>
                                        Contoh
                                    </th>
                                </tr>
                                <tr>
                                    <th>
                                        Encounter.statusHistory.status (arrived)
                                    </th>
                                    <td>
                                        Status diisi dengan &ldquo;arrived&rdquo; yang menunjukkan pasien datang
                                    </td>
                                    <td>
                                        arrived
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        Encounter.statusHistory.period.start (arrived)
                                    </th>
                                    <td>
                                        Jam kedatangan pasien
                                    </td>
                                    <td>
                                        2022-06-14T07:00:00+07:00<br>
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        Encounter.statusHistory.period.end (arrived)
                                    </th>
                                    <td>
                                        Jam mulai dilakukan asesmen awal/pemeriksaan<br>
                                    </td>
                                    <td>
                                        2022-06-14T08:00:00+07:00<br>
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        Encounter.statusHistory.status (in-progress)
                                    </th>
                                    <td>
                                        Status diisi dengan &ldquo;in-progress&rdquo; yang menunjukkan pasien sedang dilakukan pemeriksaan oleh tenaga kesehatan
                                    </td>
                                    <td>
                                        in-progress
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        Encounter.statusHistory.period.start (in-progress)
                                    </th>
                                    <td>
                                        Jam mulai dilakukan asesmen awal/pemeriksaan
                                    </td>
                                    <td>
                                        2022-06-14T08:00:00+07:00
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        Encounter.statusHistory.period.end (in-progress)
                                    </th>
                                    <td>
                                        Jam pasien pulang<br>
                                    </td>
                                    <td>
                                        2022-06-14T09:00:00+07:00<br>
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        Encounter.statusHistory.status (finished)
                                    </th>
                                    <td>
                                        Status diisi dengan &ldquo;finished&rdquo; yang menunjukkan kunjungan pasien sudah selesai
                                    </td>
                                    <td>
                                        finished
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        Encounter.statusHistory.period.start (finished)
                                    </th>
                                    <td>
                                        Jam pasien pulang
                                    </td>
                                    <td>
                                        2022-06-14T09:00:00+07:00<br>
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        Encounter.statusHistory.period.end (finished)
                                    </th>
                                    <td>
                                        Jam pasien pulang<br>
                                    </td>
                                    <td>
                                        2022-06-14T09:00:00+07:00<br>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    <br>
                </td>
            </tr>
            <tr>
                <td>
                    Encounter.class
                </td>
                <td>
                    Mandatoris
                </td>
                <td>
                    Klasifikasi dari pertemuan pasien<br>
                        <table class="table table-bordered"  style="table-layout: fixed;">
                            <tbody style="word-wrap:break-word;">
                                <tr>
                                    <th>
                                        Encounter.class.system
                                    </th>
                                    <th>
                                        Encounter.class.code
                                    </th>
                                    <th>
                                        Encounter.class.display
                                    </th>
                                    <th>
                                        Keterangan
                                    </th>
                                </tr>
                                <tr>
                                    <td>
                                        http://terminology.hl7.org/CodeSystem/v3-ActCode
                                    </td>
                                    <td>
                                        AMB
                                    </td>
                                    <td>
                                        Ambulatory
                                    </td>
                                    <td>
                                        Digunakan untuk kunjungan Rawat Jalan
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        http://terminology.hl7.org/CodeSystem/v3-ActCode
                                    </td>
                                    <td>
                                        VR
                                    </td>
                                    <td>
                                        Virtual
                                    </td>
                                    <td>
                                        Digunakan untuk kunjungan dimana pasien dan tenaga kesehatan tidak berada dalam satu tempat, seperti telefon, email, chat, televideo konferensi
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    <br>
                </td>
            </tr>
            <tr>
                <td>
                    Encounter.classHistory
                </td>
                <td>
                    Optional (omit empty)
                </td>
                <td>
                    Penyimpanan riwayat klasifikasi dari kunjungan pasien. Encounter.classHistory memiliki 2 elemen yang wajib diisi apabila data disertakan yaitu
                    <ol>
                        <li>
                            Encounter.classHistory.class
                        </li>
                    </ol><br>
                        <table class="table table-bordered"  style="table-layout: fixed;">
                            <tbody style="word-wrap:break-word;">
                                <tr>
                                    <th>
                                        Encounter.classHistory.class.system
                                    </th>
                                    <th>
                                        Encounter.classHistory.class.code
                                    </th>
                                    <th>
                                        Encounter.classHistory.class.display
                                    </th>
                                    <th>
                                        Keterangan
                                    </th>
                                </tr>
                                <tr>
                                    <td>
                                        http://terminology.hl7.org/CodeSystem/v3-ActCode
                                    </td>
                                    <td>
                                        AMB
                                    </td>
                                    <td>
                                        Ambulatory
                                    </td>
                                    <td>
                                        Kunjungan Rawat Jalan
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        http://terminology.hl7.org/CodeSystem/v3-ActCode
                                    </td>
                                    <td>
                                        <a href="http://hl7.org/fhir/R4/v3/ActCode/cs.html#v3-ActCode-EMER">EMER</a>
                                    </td>
                                    <td>
                                        emergency
                                    </td>
                                    <td>
                                        Kunjungan Instalasi Gawat Darurat
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        http://terminology.hl7.org/CodeSystem/v3-ActCode
                                    </td>
                                    <td>
                                        <a href="http://hl7.org/fhir/R4/v3/ActCode/cs.html#v3-ActCode-FLD">FLD</a>
                                    </td>
                                    <td>
                                        field
                                    </td>
                                    <td>
                                        Kunjungan di lapangan
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        http://terminology.hl7.org/CodeSystem/v3-ActCode
                                    </td>
                                    <td>
                                        <a href="http://hl7.org/fhir/R4/v3/ActCode/cs.html#v3-ActCode-HH">HH</a>
                                    </td>
                                    <td>
                                        home health
                                    </td>
                                    <td>
                                        Kunjungan home care
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        http://terminology.hl7.org/CodeSystem/v3-ActCode
                                    </td>
                                    <td>
                                        <a href="http://hl7.org/fhir/R4/v3/ActCode/cs.html#v3-ActCode-IMP">IMP</a>
                                    </td>
                                    <td>
                                        inpatient encounter
                                    </td>
                                    <td>
                                        Kunjungan Rawat Inap
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        http://terminology.hl7.org/CodeSystem/v3-ActCode
                                    </td>
                                    <td>
                                        VR
                                    </td>
                                    <td>
                                        Virtual
                                    </td>
                                    <td>
                                        Kunjungan dimana pasien dan tenaga kesehatan tidak berada dalam satu tempat, seperti telefon, email, chat, televideo konferensi
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    <br>
                    <ol start="2">
                        <li>
                            Encounter.classHistory.period
                        </li>
                    </ol><br>
                        <table class="table table-bordered"  style="table-layout: fixed;">
                            <tbody style="word-wrap:break-word;">
                                <tr>
                                    <th>
                                        Encounter.classHistory.period.start
                                    </th>
                                    <td>
                                        Waktu dimulainya suatu klasifikasi kunjungan
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        Encounter.classHistory.period.end
                                    </th>
                                    <td>
                                        Waktu berakhirnya suatu klasifikasi kunjungan
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    <br>
                </td>
            </tr>
            <tr>
                <td>
                    Encounter.type
                </td>
                <td>
                    Optional (omit empty)
                </td>
                <td>
                    <ul>
                        <li>
                            Tipe spesifik dari kunjungan (contoh : konsultasi e-mail, surgical day-care, skilled nursing, rehabilitation)
                        </li>
                        <li>
                            Kode yang digunakan dapat merujuk pada link berikut : <a href="https://simplifier.net/packages/hl7.fhir.r4.core/4.0.1/files/80297">Link</a>
                        </li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td>
                    Encounter.serviceType
                </td>
                <td>
                    Optional (omit empty)
                </td>
                <td>
                    <ul>
                        <li>
                            Tipe spesifik dari layanan yang diberikan
                        </li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td>
                    Encounter.priority
                </td>
                <td>
                    Optional (omit empty)
                </td>
                <td>
                    <ul>
                        <li>
                            Indikasi urgensi dari kunjungan
                        </li>
                        <li>
                            Kode yang digunakan dapat merujuk pada link berikut : <a href="https://simplifier.net/packages/hl7.fhir.r4.core/4.0.1/files/79332">Link</a>
                        </li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td>
                    Encounter.subject
                </td>
                <td>
                    Mandatoris
                </td>
                <td>
                    Subjek dari pertemuan pasien<br>
                    <table class="table table-bordered"  style="table-layout: fixed;">
                        <tbody style="word-wrap:break-word;">
                            <tr>
                                <th>
                                    Encounter.subject.reference
                                </th>
                                <td>
                                    Subjek dari pertemuan, diisikan dengan SATUSEHAT ID pasien<br>
                                    Contoh:
                                    &quot;Patient/100000030009&quot;
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    Encounter.subject.display
                                </th>
                                <td>
                                    Nama pasien dalam free text
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <br>
                </td>
            </tr>
            <tr>
                <td>
                    Encounter.episodeOfCare
                </td>
                <td>
                    Optional (omit empty)
                </td>
                <td>
                    <ul>
                        <li>
                            Informasi episode perawatan yang dilakukan pada kunjungan ini
                        </li>
                        <li>
                            Merefer ke resourceEpisodeOfCare
                        </li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td>
                    Encounter.basedOn
                </td>
                <td>
                    Optional (omit empty)
                </td>
                <td>
                    <ul>
                        <li>
                            ServiceRequest atau permintaan yang mendasari kunjungan ini (contoh kunjungan didasari oleh permintaan rujukan)
                        </li>
                        <li>
                            Merefer ke resourceServiceRequest
                        </li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td>
                    Encounter.participant
                </td>
                <td>
                    Mandatoris
                </td>
                <td>
                    Partisipan pertemuan pasien<br>
                    <table class="table table-bordered"  style="table-layout: fixed;">
                        <tbody style="word-wrap:break-word;">
                            <tr>
                                <th>
                                    Encounter.participant.type.coding.system
                                </th>
                                <td>
                                    Sistem kodifikasi tipe partisipan:<br>
                                    http://terminology.hl7.org/CodeSystem/v3-ParticipationType
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    Encounter.participant.type.coding.code
                                </th>
                                <td>
                                    Untuk kasus rawat jalan, tipe partisipan dapat menggunakan &ldquo;ATND&rdquo;. Biasa ATND digunakan untuk DPJP pasien
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    Encounter.participant.type.coding.display
                                </th>
                                <td>
                                    attender
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    Encounter.participant.individual.reference
                                </th>
                                <td>
                                    Partisipan dari pertemuan, diisikan dengan SATUSEHAT ID dokter / tenaga kesehatan<br>
                                    Contoh:
                                    &quot;Practitioner/N10000001&quot;
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    Encounter.participant.individual.display
                                </th>
                                <td>
                                    Nama nakes dalamfree text
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <br>
                </td>
            </tr>
            <tr>
                <td>
                    Encounter.period
                </td>
                <td>
                    Mandatoris
                </td>
                <td>
                    Waktu dari pertemuan dimulai sampai selesai (arrivedtofinished)<br><br>
                    <table class="table table-bordered"  style="table-layout: fixed;">
                        <tbody style="word-wrap:break-word;">
                            <tr>
                                <th>
                                    Encounter.period.start
                                </th>
                                <td>
                                    Waktu mulai, sama dengan waktu kedatangan pasien
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    Encounter.period.end
                                </th>
                                <td>
                                    Waktu selesai, sama dengan waktu kepulangan pasien
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <br>
                </td>
            </tr>
            <tr>
                <td>
                    Encounter.length
                </td>
                <td>
                    Optional (omit empty)
                </td>
                <td>
                    <ul>
                        <li>
                            Jumlah waktu terjadinya kunjungan
                        </li>
                        <li>
                            Tipe data : <a href="http://hl7.org/fhir/R4/datatypes.html#Duration">Duration</a>
                        </li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td>
                    Encounter.reasonCode
                </td>
                <td>
                    Optional (omit empty)
                </td>
                <td>
                    <ul>
                        <li>
                            Kode alasan terjadinya kunjungan
                        </li>
                        <li>
                            Kode yang digunakan dapat merujuk pada link berikut : <a href="http://hl7.org/fhir/R4/valueset-encounter-reason.html">Link</a>
                        </li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td>
                    Encounter.reasonReference
                </td>
                <td>
                    Optional (omit empty)
                </td>
                <td>
                    <ul>
                        <li>
                            Alasan yang mendasari terjadinya kunjungan
                        </li>
                        <li>
                            Dapat merefer ke resource<a href="http://hl7.org/fhir/R4/condition.html">Condition</a> |<a href="http://hl7.org/fhir/R4/procedure.html">Procedure</a> |<a href="http://hl7.org/fhir/R4/observation.html">Observation</a> |<a href="http://hl7.org/fhir/R4/immunizationrecommendation.html">ImmunizationRecommendation</a>
                        </li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td>
                    Encounter.diagnosis
                </td>
                <td>
                    Mandatoris
                </td>
                <td>
                    Diagnosa yang dimiliki pasien. Diagnosa bisa berupa diagnosa awal dan/atau pulang. Diagnosa dapat diisikan sesuai dengan resource &ldquo;Condition&rdquo; dari pasien. &ldquo;Condition&rdquo; dalam diagnosa dapat dicatat lebih dari 1<br><br>
                    <table class="table table-bordered"  style="table-layout: fixed;">
                        <tbody style="word-wrap:break-word;">
                            <tr>
                                <th>
                                    Encounter.diagnosis.reference
                                </th>
                                <td>
                                    ID pada resource &ldquo;Condition&rdquo; yang sudah di create sebelumnya<br>
                                    Contoh:
                                    Condition/4bbbe654-14f5-4ab3-a36e-a1e307f67bb8
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    Encounter.diagnosis.display
                                </th>
                                <td>
                                    Penjelasan tentang diagnosa yang mengacu pada referensi kondisi pasien<br>
                                    Contoh:
                                    Tuberculosis of lung, confirmed by sputum microscopy with or without culture
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    Encounter.diagnosis.use.coding.system
                                </th>
                                <td>
                                    Penggunaan kode untuk mendeskripsikan jenis diagnosa<br>
                                    http://terminology.hl7.org/CodeSystem/diagnosis-role
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    Encounter.diagnosis.use.coding
                                </th>
                                <td>
                                    Kode yang digunakan untuk mendefinisikan jenis diagnosa pasien<br><br>
                                    <table class="table table-bordered"  style="table-layout: fixed;">
                                        <tbody style="word-wrap:break-word;">
                                            <tr>
                                                <th>
                                                    Encounter.diagnosis.use.coding.code
                                                </th>
                                                <th>
                                                    Encounter.diagnosis.use.coding.display
                                                </th>
                                                <th>
                                                    Keterangan
                                                </th>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <a href="https://www.hl7.org/fhir/codesystem-diagnosis-role.html#diagnosis-role-AD">AD</a>
                                                </td>
                                                <td>
                                                    Admission diagnosis
                                                </td>
                                                <td>
                                                    Diagnosa masuk
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <a href="https://www.hl7.org/fhir/codesystem-diagnosis-role.html#diagnosis-role-DD">DD</a>
                                                </td>
                                                <td>
                                                    Discharge diagnosis
                                                </td>
                                                <td>
                                                    Diagnosa pulang
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <a href="https://www.hl7.org/fhir/codesystem-diagnosis-role.html#diagnosis-role-CC">CC</a>
                                                </td>
                                                <td>
                                                    Chief complaint
                                                </td>
                                                <td>
                                                    Keluhan utama
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <a href="https://www.hl7.org/fhir/codesystem-diagnosis-role.html#diagnosis-role-CM">CM</a>
                                                </td>
                                                <td>
                                                    Comorbidity diagnosis
                                                </td>
                                                <td>
                                                    Diagnosa penyerta
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <a href="https://www.hl7.org/fhir/codesystem-diagnosis-role.html#diagnosis-role-pre-op">pre-op</a>
                                                </td>
                                                <td>
                                                    pre-op diagnosis
                                                </td>
                                                <td>
                                                    Diagnosa sebelum operasi
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <a href="https://www.hl7.org/fhir/codesystem-diagnosis-role.html#diagnosis-role-post-op">post-op</a>
                                                </td>
                                                <td>
                                                    post-op diagnosis
                                                </td>
                                                <td>
                                                    Diagnosa sesudah operasi
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <a href="https://www.hl7.org/fhir/codesystem-diagnosis-role.html#diagnosis-role-billing">billing</a>
                                                </td>
                                                <td>
                                                    Billing
                                                </td>
                                                <td>
                                                    Diagnosa untukBilling
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <br>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <br>
                    Jika ada lebih dari 1 kondisi, maka gunakan elemen rank untuk mengurutkan mana diagnosa yang lebih utama. Semakin kecil angkanya, maka semakin utama<br>
                    <table class="table table-bordered"  style="table-layout: fixed;">
                        <tbody style="word-wrap:break-word;">
                            <tr>
                                <th>
                                    Encounter.diagnosis.rank
                                </th>
                                <td>
                                    Numerik<br>
                                    Contoh: 1
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <br>
                </td>
            </tr>
            <tr>
                <td>
                    Encounter.account
                </td>
                <td>
                    Optional (omit empty)
                </td>
                <td>
                    <ul>
                        <li>
                            Akun yang digunakan untuk penagihan/billinguntuk pertemuan ini
                        </li>
                        <li>
                            Dapat merefer ke resourceaccount
                        </li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td>
                    Encounter.hospitalization.preAdmissionIdentifier
                </td>
                <td>
                    Optional (omit empty)
                </td>
                <td>
                    <ul>
                        <li>
                            Identifier untuk pre-admisi
                        </li>
                        <li>
                            Tipe data : <a href="http://hl7.org/fhir/R4/datatypes.html#Identifier">Identifier</a>
                        </li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td>
                    Encounter.hospitalization.origin
                </td>
                <td>
                    Optional (omit empty)
                </td>
                <td>
                    <ul>
                        <li>
                            Lokasi atau organisasi asal pasien sebelum terjadi admisi
                        </li>
                        <li>
                            Dapat merefer ke resourceLocationatauOrganization
                        </li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td>
                    Encounter.hospitalization.admitSource
                </td>
                <td>
                    Optional (omit empty)
                </td>
                <td>
                    <ul>
                        <li>
                            Asal dimana sebelum pasien dirawat/admisi
                        </li>
                        <li>
                            Kode pengisian dapat dilihat dalam link berikut : <a href="https://simplifier.net/packages/hl7.fhir.r4.core/4.0.1/files/80984">Link</a>
                        </li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td>
                    Encounter.hospitalization.reAdmission
                </td>
                <td>
                    Optional (omit empty)
                </td>
                <td>
                    <ul>
                        <li>
                            Tipe readmisi yang terjadi (bila ada). Bila elemen ini kosong, maka kunjungan tidak dianggap sebagai readmisi
                        </li>
                        <li>
                            Kode pengisian dapat dilihat dalam link berikut : <a href="https://simplifier.net/packages/hl7.fhir.r4.core/4.0.1/files/81712">Link</a>
                        </li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td>
                    Encounter.hospitalization.dietPreference
                </td>
                <td>
                    Optional (omit empty)
                </td>
                <td>
                    <ul>
                        <li>
                            Preferensi diet yang dilaporkan oleh pasien
                        </li>
                        <li>
                            Kode pengisian dapat dilihat dalam link berikut : <a href="https://simplifier.net/packages/hl7.fhir.r4.core/4.0.1/files/81748">Link</a>
                        </li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td>
                    Encounter.hospitalization.specialArrangement
                </td>
                <td>
                    Optional (omit empty)
                </td>
                <td>
                    <ul>
                        <li>
                            Permintaan khusus yang dibuat untuk kunjungan rawat inap ini seperti penyediaan peralatan khusus dan lain lain
                        </li>
                        <li>
                            Kode pengisian dapat dilihat dalam link berikut : <a href="https://simplifier.net/packages/hl7.fhir.r4.core/4.0.1/files/80150">Link</a>
                        </li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td>
                    Encounter.hospitalization.destination
                </td>
                <td>
                    Optional (omit empty)
                </td>
                <td>
                    <ul>
                        <li>
                            Lokasi/organisasi tempat pasien dipulangkan.
                        </li>
                        <li>
                            Dapat merefer ke resourceLocationatauOrganization
                        </li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td>
                    Encounter.hospitalization.dischargeDisposition
                </td>
                <td>
                    Mandatoris
                </td>
                <td>
                    <ul>
                        <li>
                            Kategori atau tipe lokasi setelah pasien dipulangkan
                        </li>
                        <li>
                            Kode pengisian dapat dilihat dalam link berikut : <a href="http://hl7.org/fhir/R4/valueset-encounter-discharge-disposition.html">Link</a>
                        </li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td>
                    Encounter.location
                </td>
                <td>
                    Mandatoris
                </td>
                <td>
                    Lokasi dari pertemuan pasien. Dapat diisi oleh ruangan periksa pasien / poli pemeriksaannya<br><br>
                    <table class="table table-bordered"  style="table-layout: fixed;">
                        <tbody style="word-wrap:break-word;">
                            <tr>
                                <th>
                                    Encounter.location.location.reference
                                </th>
                                <td>
                                    Kode referensi lokasi<br>
                                    Contoh pengisian : Location/ef011065-38c9-46f8-9c35-d1fe68966a3e
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    Encounter.location.location.display
                                </th>
                                <td>
                                    Nama jelas lokasi dalamfree text
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <br>
                </td>
            </tr>
            <tr>
                <td>
                    Encounter.serviceProvider
                </td>
                <td>
                    Mandatoris
                </td>
                <td>
                    <ul>
                        <li>
                            Informasi organisasi yang bertanggung jawab terhadap kunjungan tersebut
                        </li>
                        <li>
                            Data akan mereferensi ke resourceOrganizationinduk
                        </li>
                    </ul><br><br>
                    <table class="table table-bordered"  style="table-layout: fixed;">
                        <tbody style="word-wrap:break-word;">
                            <tr>
                                <th>
                                    Encounter.serviceProvider.reference
                                </th>
                                <td>
                                    Organization/10000004
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    Encounter.serviceProvider.display
                                </th>
                                <td>
                                    Nama Organisasi
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <br>
                </td>
            </tr>
            <tr>
                <td>
                    Encounter.partOf
                </td>
                <td>
                    Optional (omit empty)
                </td>
                <td>
                    <ul>
                        <li>
                            Kunjungan dimana kunjungan ini menjadi bagiannya (secara administratif atau dalam waktu)
                        </li>
                        <li>
                            Dapat merefer ke resource Encounter
                        </li>
                    </ul>
                </td>
            </tr>
        </tbody>
    </table>
</div>

<br>
<p style="text-align:right"><a href="#">Back to top</a></p>
<br>
<hr>