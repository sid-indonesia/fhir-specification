## {{page-title}}


<br>

### A. **Apa itu FHIR?**

*Fast Healthcare Interoperability Resources* (FHIR) adalah sebuah standar global (internasional) yang menetapkan format data beserta elemen-elemennya (yang disebut "*resources*") dan sebuah standar antarmuka pemrograman aplikasi (API/Application Programming Interface) untuk pertukaran informasi resume rekam medis elektronik (RME). FHIR dibaca “fire” dalam bahasa Inggris (/faier/)

Standar ini dibuat oleh Health Level Seven International (HL7), yaitu sebuah organisasi standar pelayanan kesehatan (healthcare standards organization). Situs terkait: [HL7 FHIR](https://www.hl7.org/fhir/)

Masing-masing pengguna FHIR memiliki profil dimana profil FHIR Indonesia dapat dilihat di halaman {{pagelink:Home/FHIRProfiles/Index.page.md,text:FHIR Profiles}}.

#### Akronim FHIR:
```
F ast
H ealthcare
I nteroperability
R esources
```

<br>

### B. **Arsitektur FHIR**

Pada dasarnya, FHIR berisi dua komponen utama:

1. **Resources:**
    1. Kumpulan informasi yang mendefinisikan elemen data, batasan-batasan, dan relasi untuk "business object" yang paling relevan dengan pelayanan kesehatan. 
    2. Dari perspektif arsitektur berbasis model, resources FHIR secara konsep adalah setara dengan physical model yang dituangkan dalam format Extensible Markup Language (XML) atau JavaScript Object Notation (JSON)
2. **API:**
    1. Kumpulan antarmuka yang terdefinisi dengan baik untuk interoperasi antara dua aplikasi. Meskipun tidak diharuskan, spesifikasi FHIR menargetkan antarmuka RESTful untuk implementasi API. 

Untuk informasi lebih lanjut, dapat dilihat di [sini](https://www.hl7.org/fhir/)

<br>

### C. **Penjelasan Konsep Umum JSON FHIR**

Berikut adalah beberapa konsep umum yang digunakan di sistem FHIR:
1. Dalam struktur format JSON dalam *payload* maupun *response*, apabila ada elemen yang sifatnya opsional, maka elemen dalam file JSON akan/sudah di *omitempty*,
2. Dalam pengisian elemen “system”, URL yang tertulis tidak harus merupakan URL yang dapat diakses sebagai website. Namun hanya menjadi tanda pembatas ruang lingkup
3. Untuk setiap penyimpanan data yang ada di FHIR, metode yang dipakai adalah metode *key-value*. Key adalah sebagai penanda variabelnya (nama variabel) sedangkan *value* adalah nilai variabelnya

    Contoh penyimpanan data dengan metode key-value:

    | **Key** | **Value** |
    | --- |------------------------- |
    | Sistol | 120 |
    | Diastol | 80 |
    | Suhu Tubuh | 36.7 |

    Contoh penyimpanan data dengan metode tabular konvensional:

    | **Sistol** | **Diastol** | **Suhu Tubuh** |
    | --- |------------------------- | --------------- |
    | 120 | 80 | 36.7 |


<br>
<p style="text-align:right"><a href="#">Back to top</a></p>
<br>
<hr>