# Laravel Project - Perpustakaan

Ini adalah aplikasi berbasis Laravel yang dirancang untuk mempermudah administrator dalam mengelola data perpustakaan. Proyek ini menyediakan fitur-fitur yang berguna untuk mengelola data data penting seperti, buku fisik dan digital(E-Book), admin, member, transaksi peminjaman, history peminjaman dan laporan dalam bentuk statistik diagram. 

## Fitur Aplikasi

- **Autentikasi Pengguna:** Pengguna(admin) dapat login, dan mengelola akun mereka.
- **Manajemen Data:** Menyediakan fitur untuk menambah, mengedit, dan menghapus data dalam aplikasi.
- **Dashboard Interaktif:** Tampilan yang bersih dan mudah digunakan untuk mengakses semua fitur penting.
- **Notifikasi Real-Time:** Memberikan notifikasi kepada pengguna saat terjadi perubahan atau pembaruan.
- **Keamanan:** Menggunakan enkripsi dan perlindungan terhadap serangan umum seperti CSRF dan XSS.

## Prasyarat

Sebelum melanjutkan ke instalasi, pastikan Anda memiliki perangkat lunak berikut:

- PHP >= 8.0
- Composer
- MySQL atau database lain yang kompatibel dengan Laravel
- Web server seperti Apache atau Nginx

## Langkah-langkah Instalasi

Ikuti langkah-langkah berikut untuk menginstal dan menjalankan aplikasi Laravel ini di lingkungan pengembangan lokal Anda:

### 1. Clone Repository

Pertama, clone repository ini ke dalam direktori lokal Anda:

```bash
git clone https://github.com/username/repository-name.git
cd repository-name
```

### 2. Install Dependensi

Setelah berhasil meng-clone proyek, install semua dependensi dengan Composer:

```bash
composer install
```

### 3. Konfigurasi File .env

Salin file `.env.example` menjadi `env`

```bash
cp .env.example .env
```

Setelah itu, sesuaikan konfigurasi database dan pengaturan lainnya di file `.env` sesuai dengan kebutuhan anda.

### 4. Generate Key Laravel

Jalankan perintah untuk menghasilkan key aplikasi:

```bash
php artisan key:generate
```

### 5. Import Database 

Unduh file SQL database dari link berikut :

[Unduh Database SQL](ttps://example.com/dokumen.pdf)

Import file SQL ke dalam database MySQL anda menggunakan phpMyAdmin.

### 6. Migrasi dan seed Database

Jika anda perlu menjalankan migrasi dan seeding data ke database, jalankan perintah berikut:

```bash
php artisan migrate --seed
```

### 7. Jalankan Server Pengembangan

Untuk menjalankan aplikasi pada server pengembangan lokal, jalankan perintah berikut:

```bash
php artisan serve
```

Aplikasi akan berjalan di `http://127.0.0.1:8000`

## Teknologi yang Digunakan

- **Laravel 11.x**
- **PHP 8.3**
- **MySQL**
- **Filament**
- **Filament-Shield**

## Kontribusi

Jika anda tertarik untuk berkontribusi pada proyek ini, silahkan ikuti langkah langkah berikut:

1. Fork repositori ini.
2. Buat cabang baru `branch` untuk fitur yang ingin anda kerjakan.
3. Kirim pull request dengan penjelasan tentang perubahan yang dilakukan.
