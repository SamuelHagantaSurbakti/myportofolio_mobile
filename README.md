# myportofolio_mobile

Nama: Samuel Haganta Surbakti


NPM: 2506612814


Kelas: PBP D

## Tugas 7
1. Jelaskan apa yang dimaksud dengan widget tree pada Flutter dan bagaimana hubungan induk-anak (parent-child) bekerja antar-widget!
    Widget tree adalah struktur yang menggambarkan bagaimana suatu widget, berisikan apa saja widget yang digunakan pada suatu widget karena widget dapat berupa nested widget. Hubungan parent-child antar widget hanya melambangkan widget mana yang membungkus widget apa. Widget parent adalah widget yang membungkus suatu widget, sedangkan widget adalah widget yang terbungkus dari suatu widget. Untuk menerapkan konsep parent-child, kita bisa menggunakan keyword child (satu widget) atau children (banyak widget).

2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya masing-masing
    MaterialApp: mengatur kerangka seluruh aplikasi (judul, tema, dan home page)
    MyHomePage: Widget buatan, berguna sebagai home page di sini kita mendefinisikan isinya.
    InfoCard: widget buatan, berfungsi untuk menampilkan kartu (NPM, nama, dan kelas)
    ItemCard: widget buatan, berfungsi untuk tombol menu
    Scaffold: Kerangka dasar satu halaman dan juga mempunyai atribut appBar, body, dan snackBar otomatis
    AppBar: widget kotak yang berisikan judul
    SnackBar: widget untuk menampilkan pesan di Bawah layer.
    Text: widget untuk menampilkan teks
    Padding: widget untuuk memberi jarak di sekeliling anaknya (Menurut saya pribadi implementasi ini aneh karena kita harus membalut widget dengan padding, bukannya memberi atribut padding pad awidget langsung)
    Column: Menyusun anak anaknya secara vertical, seperti div dengan atribut flex column.
    Row: Menyusun anak-anaknya secara horizontal, seperti div dnegan atribut flex row. 
    SizedBox: widget yang kosong, di kodenya dipake sebagai spasi 
    Center: widget yang mempunyai atribut MainAxisAlignment.center dan CrossAxisAlignment.center otomatis
    Container: widget yang serbaguna. (mungkin sama dengan div di HTML) 
    Card: widget yang berbentuk kotak dengan bayangan dan border radius 
    Icon: widget untuk menampilkan ikon
    GridView: widget yang berguna untuk menyimpan anak dengan layout grid 

3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini umumnya digunakan sebagai root widget pada aplikasi Flutter!
    Widget MaterialApp berfungsi untuk kerangka yang membungkus seluruh aplikasi dan menyediakan beberapa widget lain yang dibutuhkan widget lain di dalamnya, seperti Theme, Navigator, dan mempunyai atribut untuk title sebagai judul aplikasi dan halaman awal.
    Alasan menggunakan MaterialApp adalah karena widget ini digunakan sebagai parent sehingga data yang didefinisikan di sini akan diwariskan ke anak. Juga berperan sebagai root sehingga kita hanya perlu mengatur konfigurasi atau data di widget ini, lalu widget anak yang ikut menyesuaikan.

4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget! Kapan kita sebaiknya memilih StatelessWidget dan kapan harus menggunakan StatefulWidget?
    StatelessWidget adalah widget immutable yang tidak punya dan tidak mengingat kondisi/state-nya sehingga saat direload, widget akan dimuat ulang dengan keadaan baru, sedangkan StatefulWidget adalah widget immutable yang mengingat kondisi/state-nya sehingga saat reload terjadi mau secara manual atau karena event, widget akan berisikan keadaan sebelumnya. Sebaiknya, kita menggunakan StatelessWidget untuk widget yang statis dan tidak berubah, sedangkan StatefulWidget digunakan untuk widget dinamik yang memungkinkan perubahan 

5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di dalam metode build?
    BuildContext adalah sebuah class yang menjadi penanda widget di WidgetTree untuk mengakses data widget di atasnya dan juga menghindari pengiriman data yang berlapis saat proses construct.
    Penggunaanya:
    flutter memberikan context otomatis
    menggunakan [nama_atribut].of(context) untuk mengakses data di atasnya


6. Jelaskan konsep hot reload di Flutter dan apa perbedaannya dengan hot restart! Kapan kita tidak bisa hanya mengandalkan hot reload dan harus melakukan hot restart atau full restart?
    hot reload: fitur flutter yang digunakan untuk membangun ulang widget tree, tetapi state akan dipertahankan. Ia memberikan kode dart ke Dart VM yang sedang berjalan untuk rebuild widget tree.
    hot restart: fitur flutter yang digunakan untuk memuat ulang seluruh kode ke VM, menjalankan dari main() sebagai entry aplikasi. Karena semua kode diberikan ulang, seluruh statenya akan hilang.
    full restart: mengompilasi ulang seluruh aplikasi dari awal. State akan hilang.
    kita tidak cukup mengandalkan hot reload saja Ketika ada perubahan state awal atau menambahkan asset baru dan juga perubahan konfigurasi platform


## Tugas 8

1. Jelaskan perbedaan antara Navigator.push(), Navigator.pushReplacement(), dan Navigator.pop(). Metode apa yang digunakan untuk membuka formulir dari kartu aksi? Jelaskan juga bagaimana opsi Home di drawer membawa pengguna kembali ke halaman utama.
- Navigator.push() berguna untuk melakukan opearsi push pada page stack, ia menambahkan page ke stack dengan menimpa stack sebelumnya
- Navigator.pushReplacement() berguna untuk melakukan operasi push pada page stack, tetapi sebelumnya ia melakukan pop() pada page sekarang, jadi ia menambahkan page, tetapi page sekarang akan dibuang terlebih dahulu sehingga kita tidak bisa kembali ke halaman sebelumnya
- Navigator.pop() berguna untuk mengeluarkan halaman sekarang dari page stack sehingga seharusnya kita akan kembali ke page sebelumnya atau terkeluar dari aplikasi jika tidak ada halaman yang dibuka sebelumnya.
- Metode yang digunakan untuk membuka form dari kartu aksi adalah Navigator.push() sehingga kita bisa kembali ke home page jika menekan back
- Drawer menavigasi kita ke home page dengan metode Navigator.pushReplacement() sehingga kita tidak bisa kembali ke page sebelumnya. 


2. Bagaimana susunan Scaffold, AppBar, dan Drawer membantu menjaga struktur halaman tetap konsisten? Berikan satu contoh penggunaan warna tema portofolio di lebih dari satu halaman.

    Scaffold adalah sebuah widget yang digunakan untuk menjadi kerangka utama tiap halaman, hal ini dikarenakan ia mempunyai atribut wajib dari sebuah halaman seperti appBar, Drawer, main. appBar adalah widget yang digunakan sebagai penyimpan atribut dari sebuah page yang akan dipakai lagi di dalam page-nya, sementara Drawer adalah widget yang dijadikan sebagai fitur navigasi dari tiap halaman.

    Jadi hubungan dari ketiganya adalah Scaffold sebagai kerangka utama dari tiap halaman yang punya drawer sebagai navigasi antar halaman dan appBar sebagai semacam konfigurasi awal dari tiap halaman. 

    Contoh di projek ini, kita menggunakan warna indigo yang sudah kita konfigurasi sebelumnya di appBar, kita menggunakannya menjadi backgroundColor MyHomePage dan ProjectFormPage.

 
3. Mengapa tata letak tersebut dipilih untuk formulir? Jelaskan peran widget pengatur jarak dan widget penggulir ketika ruang layar terbatas.   

    Formulir menggunakan Column sebagai widget pengatur tata letak yang akan berisi anak berupa field formulir yang diurutkan secara vertikal.
    Column digunakan karena memang field ingin ditampilkan secara vertikal, bukan horizontal.

    Widget pengatur jarak yang diimplementasikan menggunakan widget Padding yang mempunyai atribut padding yang mengatur jarak antar field.
    Widget penggulir yang digunakan adalah widget SingleChildScrollView yang memungkinkan kita untuk menggulir layar jika tinggi page lebih besar daripada tinggi device.

4. Apa peran GlobalKey<FormState>, validator, dan validate() saat tombol Simpan ditekan? Berikan satu contoh nilai yang ditolak oleh validasi dan jelaskan mengapa memilih jenis input atau papan ketik saja belum cukup.

- GlobalKey<FormState> digunakan sebagai sebuah penghubung agar tombl bisa memberi perintah ke form untuk memvalidasi isinya. Tanpa key ini, tombol ngga bisa  mengakses form.
- validator adalah sebuah aturan yang dipunyai oleh tiap field, akan mengembalikan null ketika validasi sukses dan error ketika validasi gagal
- validate() adalah perintah yang dipanggil oleh tombol simpan saat ditekan 
- contoh nilai yang ditolak adalah deskripsi yang panjangnya kurang dari 10 karakter
- memilih jenis input dan widget saja tidak cukup karena ingin menghindari kemanan data yang mungkin terjadi seperti XSS dan SQLi





## AI Disclosure

### Tools yang Digunakan
- Claude AI model Sonnet 5.5

### Bagian yang Dibantu 

| Bagian | Bentuk bantuan |
|---|---|
| `main.dart` | Penjelasan struktur aplikasi (`MaterialApp`, `StatelessWidget`, alur `runApp`) |
| `menu.dart` (`MyHomePage`) | Penjelasan susunan widget halaman utama |
| `Soal Refleksi` | Penjelasan dan jawaban secara umum|


### Strategi Prompting
1. Saya mulai dengan menyatakan bahwa saya belum mengenal Flutter/Dart dan meminta penjelasan isi kode **dari dasar**.
2. Saya menempelkan potongan kode per file lalu meminta penjelasan **baris demi baris / widget demi widget**.
3. Saya menanyakan soal refleksi secara garis besar lalu menanyakan hal yang spesifik yang sekiranya perlu saya ketahui 


### Keterbatasan AI yang Saya Temui
- Penjelasan AI terkadang cenderung menganggap saya sudah paham dasar-dasar yang saya belum ketahui.

### Log Percakapan
[Link AI #1](https://claude.ai/share/2cbc306c-f5fb-4a42-a5c2-398d263172e4) --  https://claude.ai/share/2cbc306c-f5fb-4a42-a5c2-398d263172e4
