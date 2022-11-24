# PBP - E05

## Anggota

* Alvin Xavier Rakha Wardhana - 2106750300
* Aulia Satrio Wijoyo - 2106752123
* Idham Vadri - 2106752174
* Rebeka Alma - 2106653060
* Stenly Yosua Saputra - 2106704244
* Zacky Muchlas Dharmawan - 2106702296

## Deskripsi Aplikasi

* Deskripsi Aplikasi
  * Nama: ARTi
  * Fungsi Aplikasi
    * Membantu masyarakat yang mengalami kesulitan sebagai bentuk dari empati dan memberikan rasa suka cita     sekaligus perwujudan bentuk kasih sayang kepada sesama.  Bantuan diberikan dalam bentuk uang  yang terkumpul dari layanan donasi. Selain itu, memberi ruang untuk setiap orang berekspresi melalui karya-karyanya. Manfaat berdonasi juga sangat banyak, tidak hanya bagi orang yang menerima tetapi juga bagi orang yang melakukannya.
  * Peran/Aktor Aplikasi
    * Admin: Memiliki akses khusus yang dapat melakukan hal di luar role pengguna seperti menghapus postingan yang dianggap tidak sesuai/mengandung unsur sara atau pornografi.

    * Guest User: User yang mengakses website tanpa melakukan login.  Guest user memiliki akses yang terbatas, contohnya tidak bisa posting karya.

    * Login User: User yang mengakses website dengan melakukan login. Login user memiliki akses yang lebih luas, seperti dapat posting karya.

## Daftar fitur yang diimpelemntasikan

* Login: Untuk user melakukan login dalam home jika sudah memiliki akun. (sudah register)

* Register: Untuk user melakukan pendaftaran akun (register) agar dapat login. Dalam register juga ada fitur spesial yaitu memberikan filter kategori pilihan yang user suka untuk muncul di galeri mereka.

* Home: Menampilkan tampilan utama homepage website dengan berbagai fitur yang ada.

* Post Karya: Untuk user meng-upload karya-karya mereka yang nantinya dapat diperjualbelikan untuk donasi.

* Pembelian karya: Untuk membeli karya-karya yang dipilih dan nantinya akan ada pemberitahuan yang menandakan bahwa karya yang dipilih sudah soldout.

* Profile user: Untuk menampilkan biodata akun, jumlah total donasi, karya user, dan sebagainya.

* Galeri: Untuk menampilkan explore yang berisi karya-karya yang relate dengan kategori yang sesuai dengan apa yang kita suka dimana informasi kategori tersebut sudah didapat saat melakukan register.

* Leaderboard: Menampilkan 10 pengguna dengan donasi dan jumlah like terbanyak.

* Update: Menampilkan progress atau history dari kegiatan donasi yang sudah terkumpul beserta dengan foto-fotonya.

## Alur pengintegrasian dengan web service untuk terhubung dengan aplikasi web yang sudah dibuat saat Proyek Tengah Semester

* Membuat semua model yang sesuai daengan data-data yang telah ada pada project tengah semester seperti karya, user, coment, dll.
* Menambahkan view di project django sebelumnya untuk mendapatkan seluruh data dalam bentuk JSON (serialize JSON)
* Mengambil data JSON tersebut menggunakan method http.get
* Mengubah data tersebut menjadi objek dari suatu model
* Memasukkan seluruh data tersebut ke dalam struktur data list
* Mengkonversikan data tersebut menjadi objek Future
* Tampilkan seluruh data dengan menggunakan widget FutureBuilder
