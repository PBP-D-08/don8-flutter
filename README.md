# Proyek Akhir Semester - Don8

- **Adyatma Wijaksara Aryaputra Nugraha Yudha** - 2106750805
- **Eduardus Tjitrahardja** - 2106653602
- **Fajar Rivaldi Ibnusina** - 2106707050
- **Jonathan Adriel** - 2106750692
- **Mariana Salma Saraswati** - 2106702516
- **Wedens Elma Malau** - 2106751165
  
🔗 Tautan aplikasi Heroku: [don8-proyek-ts.up.railway.app](don8-proyek-ts.up.railway.app)

🔗 Tautan apk: TBA

## Cerita aplikasi yang diajukan serta manfaatnya
**Don8** merupakan sebuah platform donasi online yang menghubungkan donatur dengan organisasi, dimana organisasi dapat mendaftarkan kegiatan penggalangan dana. Platform donasi memberikan peluang bagi organisasi non-profit untuk menggalang dana dan masyarakat umum untuk melakukan donasi.

## Daftar modul yang akan diimplementasikan dan kontrak kinerja
1. **Homepage** 🏠  ➡️ Edu
   
   Halaman utama akan menampilkan seluruh donasi yang dibuka, serta entry point untuk halaman profile pengguna (donatur/lembaga donasi), halaman submit donasi (untuk donatur) atau halaman create new donation (untuk lembaga)

2. **Detail kegiatan penggalangan dana** 🔍  ➡️ Jonathan
   
   Dari jenis donasi yang dipilih di halaman utama, pengguna akan diarahkan ke halaman detail donasi. Halaman ini menampilkan nama organisasi yang membuka donasi, deskripsi atau tujuan penggunaan dana, judul donasi, waktu batas pengumpulan dana, jumlah dana yang telah dikumpulkan,  jumlah dana yang ingin dikumpulkan, dan terakhir kali melakukan donasi (reset setiap kali logout)
   
3. **Halaman submit donasi** 📩  ➡️ Jonathan

   Halaman untuk melakukan pembayaran donasi

4. **Page create new donation** 🆕  ➡️ Salma
   
   Modal yang berisi form untuk membuat jenis donasi baru bagi organisasi

5. **Profile donatur dan lembaga donasi** 👤 
   - Halaman profile dari orang yang mendonasikan.  ➡️ Wedens
     - Menampilkan detail akun (username, saldo, dan total donasi yang telah diberikan) dan form untuk Top Up saldo 
     - Menampilkan history (sudah pernah donasi ke mana saja) 📆
   - Halaman profile lembaga yang menerima donasi.  ➡️ Adyatama
     - Menampilkan detail akun, rincian penerimaan donasi, total uang yang terkumpul 💵
     - Menampilkan form withdraw (jika sedang membuka profile milik sendiri)

6. **Support message** 💌  ➡️ Fajar

   Halaman support message berisikan pesan-pesan dukungan yang diberikan untuk donasi yang ada. Pesan-pesan yang telah disubmit juga dapat diberikan like.

7. **Saved Donations** ⭐  ➡️ Edu
   
   Fitur untuk donatur untuk menyimpan donasi-donasi yang mereka ingin simpan yang ditampilkan di sebuah halaman khusus. 

8. **Register dan Login untuk 2 jenis akun** 📝  ➡️ Edu
   
   Halaman register digunakan untuk menginput detail akun pengguna yang ingin mendaftarkan akunnya sebagai donatur ataupun organisasi. Halaman login.

   - **Role atau peran pengguna beserta deskripsinya (karena bisa saja lebih dari satu jenis pengguna yang mengakses aplikasi)**
      - **Role pertama**: Donatur 👥 (memberikan donasi (punya saldo)) 
        - Ketika donatur melakukan registrasi, donatur akan diminta untuk mengisi username, password, dan memilih role "Pengguna".
        - Donatur dapat melakukan top up jika saldo yang dimilikinya sekarang tidak mencukupi untuk melakukan suatu donasi. Uang yang donatur gunakan untuk melakukan top up bersifat fiksi sehingga donatur memiliki uang yang tak hingga
        - Donatur dapat memilih penggalangan dana mana yang ingin diberikan donasi dan melakukan pembayaran untuk transaksi donasi
      - **Role kedua**: Organisasi 🏢 (menggalang donasi (punya saldo khusus setiap penggalangan dana, saldo total seluruh penggalangan dana)) 
        - Organisasi dapat mendaftarkan kegiatan penggalangan dana pada website dan aplikasi kami.
        - Uang yang donatur berikan kepada kegiatan tertentu akan terkumpul dan akan langsung diterima oleh organisasi tersebut untuk disalurkan kepada orang terkait. Jumlah uang yang terkumpul untuk masing-masing kegiatan akan ditampilkan juga, beserta target uang yang ingin dikumpulkan, pada halaman website dan aplikasi kami.
        - Kegiatan penggalangan dana memiliki expired date yang ditentukan oleh organisasi yang membukanya di mana jika sudah terlewat maka tidak bisa melakukan donasi lagi pada kegiatan tersebut.
        - Organisasi akan mempunyai saldo juga untuk menampung uang yang berasal dari donatur. Organisasi dapat melakukan withdraw jika suatu saat ingin digunakan untuk diberikan kepada orang yang dituju dan sedang membutuhkan.

9. **Leaderboard** 🥇  ➡️ Salma

   Halaman yang menampilkan donasi dengan akumulasi dana terbanyak dengan informasi rank dan nama donasi.

## Alur pengintegrasian dengan web service untuk terhubung dengan aplikasi web yang sudah dibuat saat Proyek Tengah Semester
Agar kita bisa mengakses dan melakukan data delivery dengan Flutter melalui endpoint website yang sudah dibuat sebelumnya, kami menambahkan middleware di proyek Django. Kami akan memanfaatkan endpoint API yang telah kami buat di proyek tengah semester. Endpoint tersebut me-return data dalam bentuk JSON yang dapat kami olah dan baca di Flutter. Kami akan menggunakan fungsi-fungsi dari HTTP package yang disediakan oleh Flutter untuk melakukan HTTP request seperti GET dan POST yang menembak ke url API proyek tengah semester. GET digunakan untuk mengambil data dari web untuk diolah di widget, sedangkan POST digunakan untuk mengirim data ke database Django.

## Deployment Aplikasi
TBA
