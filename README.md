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






