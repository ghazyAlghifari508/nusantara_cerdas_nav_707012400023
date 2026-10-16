# Nusantara Cerdas Mobile - Aplikasi Layanan Warga Smart City
**Tugas Praktikum Modul 2 - Soal 1 (PPBL - Pemrograman Perangkat Bergerak Lanjut)**

[![Flutter Analyze](https://img.shields.io/badge/Flutter%20Analyze-0%20Issues-brightgreen.svg)]()
[![Flutter Test](https://img.shields.io/badge/Flutter%20Test-Passed-brightgreen.svg)]()
[![Design System](https://img.shields.io/badge/Material%20Design-3-blue.svg)]()

---

## 👤 Identitas Pengembang
* **Nama Lengkap:** Ghazy Nabil Alghfari
* **NIM:** 707012400023
* **Kelas:** D4SIKC (48-03)
* **Program Studi:** D4 Sistem Informasi Kota Cerdas (D4SIKC)
* **Fakultas:** Fakultas Ilmu Terapan (FIT)
* **Institusi:** Universitas Telkom
* **Akun GitHub:** [ghazyAlghifari508](https://github.com/ghazyAlghifari508)

---

## 📌 Deskripsi Proyek
**Nusantara Cerdas Mobile** adalah purwarupa aplikasi layanan warga cerdas terpadu berbasis Flutter yang mengimplementasikan arsitektur navigasi komprehensif Material Design 3. Aplikasi ini dirancang untuk menjawab studi kasus *Smart Governance*, *Smart Living*, dan *Smart Mobility* pada Ibu Kota Nusantara (IKN) dengan standar penulisan kode modern, modular, dan bebas *lint warning*.

---

## 🚀 Fitur & Komponen Navigasi Utama

1. **3 Destinasi Utama (`NavigationBar` Material 3):**
   * **Beranda:** Menampilkan ringkasan pilar kota cerdas (*Smart Governance*, *Smart Economy*, *Smart Living*, *Smart Mobility*, *Smart Environment*, *Smart People*), status sensor IoT real-time, dan pengumuman kedaruratan.
   * **Layanan Publik:** Menggunakan tab navigasi horizontal untuk mengelompokkan layanan publik.
   * **Profil & Warga:** Memuat Kartu Warga Cerdas (identitas mahasiswa), statistik laporan pengaduan, dan riwayat laporan warga.

2. **Perlindungan Tombol Kembali (`PopScope`):**
   * Jika pengguna menekan tombol *back* fisik/gesture Android di luar tab Beranda (index $\ne 0$), aplikasi secara otomatis mengembalikan fokus pengguna ke tab Beranda terlebih dahulu.
   * Jika pengguna berada di tab Beranda, penekanan tombol *back* memunculkan dialog konfirmasi keluar aplikasi.

3. **Menu Samping Komprehensif (`NavigationDrawer`):**
   * Dilengkapi `UserAccountsDrawerHeader` dengan identitas resmi mahasiswa (NIM & Prodi).
   * Sinkronisasi dua arah dengan `NavigationBar` (Beranda, Layanan, Warga).
   * Menu pendukung: **Pengaturan Kota**, **Tentang Aplikasi**, dan **Keluar Aplikasi** (dengan `Navigator.pop(context)` sebelum navigasi untuk mencegah penumpukan drawer di *back stack*).

4. **Kategorisasi Layanan Bertingkat (`DefaultTabController` + `TabBar` + `TabBarView`):**
   * 3 Tab Bidang: **Perizinan & Regulasi**, **Kesehatan Terpadu**, dan **Transportasi Cerdas**.
   * Tiap tab menyediakan $\ge 3$ kartu layanan terverifikasi dengan informasi durasi, dinas pengampu, dan status operasional.

5. **Navigasi Berparameter & Pengembalian Data Asinkron (`Named Routes`):**
   * Pemilihan layanan memanggil rute `/rincian-layanan` dengan argumen kuat (`RincianLayananArguments`).
   * Tombol *"Ajukan Permohonan Sekarang"* mengembalikan data hasil konfirmasi (`Navigator.pop(context, result)`), yang kemudian diproses asinkron oleh pemanggil untuk memunculkan `SnackBar` pemberitahuan resmi.

6. **Dermaga Aksi Bawah (`BottomAppBar` + `FloatingActionButton` centerDocked):**
   * Diterapkan pada rute halaman penuh `HalamanRiwayatLaporan`.
   * Memiliki lekukan melingkar (*circular notch*) `CircularNotchedRectangle()` dengan FAB *"Buat Pengaduan Baru"* di posisi tengah bawah.

7. **Desain Adaptif Multi-Platform (`MediaQuery`):**
   * Menggunakan *breakpoint* dinamis $600\text{ px}$.
   * **Layar Ponsel (< 600 px):** Menampilkan `NavigationBar` di bagian bawah layar.
   * **Layar Tablet / Mode Lanskap ($\ge 600\text{ px}$):** Otomatis beralih ke `NavigationRail` di sebelah kiri layar dengan label teks lengkap.

8. **Penanganan Rute Tidak Dikenal (`onUnknownRoute`):**
   * Mengarahkan tautan/rute yang tidak terdaftar ke halaman ramah pengguna (*Error 404 - Rute Tidak Dikenal*) dengan tombol kembali ke Beranda.

---

## 📁 Struktur Berkas Proyek

```text
nusantara_cerdas_nav_707012400023/
├── lib/
│   ├── main.dart                          # Titik masuk utama & konfigurasi tema/rute
│   ├── navigation/
│   │   ├── app_routes.dart                # Konstanta rute, route generator, dan onUnknownRoute
│   │   └── kerangka_navigasi.dart         # Scaffold utama adaptif (NavigationBar & NavigationRail + PopScope + Drawer)
│   └── pages/
│       ├── halaman_beranda.dart           # Dashboard 6 pilar smart city & widget sensor
│       ├── halaman_layanan.dart           # Tab navigation (Perizinan, Kesehatan, Transportasi)
│       ├── halaman_rincian_layanan.dart   # Detail layanan dengan argument model & pop result
│       ├── halaman_warga.dart             # Kartu identitas warga, statistik, & launcher riwayat
│       ├── halaman_riwayat_laporan.dart   # BottomAppBar dengan FloatingActionButton centerDocked
│       ├── halaman_pengaturan_kota.dart   # Preferensi sensor IoT & notifikasi
│       └── halaman_tentang_aplikasi.dart  # Informasi aplikasi & profil mahasiswa
├── test/
│   └── widget_test.dart                   # Unit & Widget testing navigasi komprehensif
├── screenshots/                           # Dokumentasi visual lengkap pengujian aplikasi
└── pubspec.yaml                           # Metadata dan dependensi Flutter
```

---

## 📸 Dokumentasi Screenshot Pengujian

| No | Tampilan Antarmuka | Deskripsi Fitur | Berkas Screenshot |
|:--:|:-------------------|:----------------|:------------------|
| 1 | **Beranda Smart City** | Dashboard 6 pilar kota cerdas, status sensor, dan kartu identitas | `01_beranda_smart_city.png` |
| 2 | **Layanan - Perizinan** | Tab 1 katalog perizinan & administrasi IKN | `02_layanan_perizinan.png` |
| 3 | **Layanan - Kesehatan** | Tab 2 telemedisin, faskes, dan gawat darurat | `03_layanan_kesehatan.png` |
| 4 | **Layanan - Transportasi**| Tab 3 Autonomous Rapid Transit & Electric Mobility | `04_layanan_transportasi.png` |
| 5 | **Rincian Layanan** | Halaman detail menerima objek argumen via *Named Route* | `05_rincian_layanan.png` |
| 6 | **Pemberitahuan SnackBar** | Hasil *pop return* dari form rincian memicu SnackBar | `06_pemberitahuan_snackbar.png` |
| 7 | **Profil & Laporan Warga** | Kartu Warga Cerdas (NIM 707012400023) & ringkasan aduan | `07_warga_profil.png` |
| 8 | **Riwayat Laporan** | Implementasi `BottomAppBar` & FAB *centerDocked* | `08_riwayat_laporan_bottom_app_bar.png` |
| 9 | **Navigation Drawer** | Menu samping dengan `UserAccountsDrawerHeader` | `09_drawer_terbuka.png` |
| 10 | **Pengaturan Kota** | Konfigurasi preferensi sensor dan notifikasi warga | `10_pengaturan_kota.png` |
| 11 | **Tentang Aplikasi** | Kartu profil mahasiswa pengembang dan spesifikasi sistem | `11_tentang_aplikasi.png` |
| 12 | **Rute 404 (Unknown)** | Penanganan fallback rute tidak terdaftar (`onUnknownRoute`) | `12_rute_tidak_dikenal_404.png` |
| 13 | **Adaptif Lanskap** | Transformasi antarmuka ke `NavigationRail` ($\ge 600\text{ px}$) | `13_layar_lebar_navigation_rail.png` |

---

## 🧪 Verifikasi & Pengujian Kode

Proyek ini telah melalui pengujian menyeluruh dan memenuhi kriteria **Zero Warning & Zero Error**:

```bash
# 1. Pengecekan Linting dan Analisis Kode Statis
flutter analyze
# Output: No issues found! (ran in 1.4s)

# 2. Eksekusi Automated Widget Test
flutter test
# Output: 00:02 +1: All tests passed!
```

---

## 💻 Cara Menjalankan Proyek

1. **Pastikan Flutter SDK (versi $\ge 3.29.0$) terpasang pada komputer:**
   ```bash
   flutter doctor
   ```
2. **Kloning repositori:**
   ```bash
   git clone https://github.com/ghazyAlghifari508/nusantara_cerdas_nav_707012400023.git
   ```
3. **Masuk ke direktori proyek:**
   ```bash
   cd nusantara_cerdas_nav_707012400023
   ```
4. **Unduh dependensi:**
   ```bash
   flutter pub get
   ```
5. **Jalankan aplikasi pada emulator atau perangkat fisik Android:**
   ```bash
   flutter run
   ```
