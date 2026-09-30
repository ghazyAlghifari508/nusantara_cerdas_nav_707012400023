import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/pengajuan_model.dart';
import '../pages/halaman_beranda.dart';
import '../pages/halaman_layanan.dart';
import '../pages/halaman_warga.dart';
import 'app_routes.dart';

class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key});

  @override
  State<KerangkaNavigasi> createState() => _KerangkaNavigasiState();
}

class _KerangkaNavigasiState extends State<KerangkaNavigasi> {
  int _indeksTerpilih = 0;

  // Daftar tiga layanan/halaman utama aplikasi
  final List<Widget> _halaman = const [
    HalamanBeranda(),
    HalamanLayanan(),
    HalamanWarga(),
  ];

  final List<String> _judul = const [
    'Beranda Smart City',
    'Katalog Layanan Publik',
    'Profil & Laporan Warga',
  ];

  void _pilihTujuan(int indeks) {
    setState(() {
      _indeksTerpilih = indeks;
    });
  }

  // Dialog konfirmasi sebelum keluar dari aplikasi
  Future<void> _tampilkanDialogKeluar() async {
    final konfirmasi = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Konfirmasi Keluar'),
        content: const Text(
          'Apakah Anda yakin ingin keluar dari aplikasi Nusantara Cerdas Mobile?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade700,
              foregroundColor: Colors.white,
            ),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );

    if (konfirmasi == true) {
      SystemNavigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Membaca lebar layar untuk menentukan tata letak adaptif (ambang 600 px)
    final double lebarLayar = MediaQuery.of(context).size.width;
    final bool layarLebar = lebarLayar >= 600;

    return PopScope(
      canPop: _indeksTerpilih == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        // Jika tidak di Beranda, kembali ke Beranda daripada menutup aplikasi tiba-tiba
        if (_indeksTerpilih != 0) {
          setState(() {
            _indeksTerpilih = 0;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_judul[_indeksTerpilih]),
          centerTitle: true,
          backgroundColor: Colors.teal.shade700,
          foregroundColor: Colors.white,
          elevation: 2,
        ),
        drawer: _buatDrawer(),
        // Tata letak adaptif: NavigationRail untuk layar lebar, NavigationBar untuk layar sempit
        body: layarLebar ? _tataLetakLebar() : _halaman[_indeksTerpilih],
        bottomNavigationBar: layarLebar ? null : _buatBilahBawah(),
      ),
    );
  }

  // NavigationBar Material 3 untuk layar sempit (< 600 px)
  Widget _buatBilahBawah() {
    return NavigationBar(
      selectedIndex: _indeksTerpilih,
      onDestinationSelected: _pilihTujuan,
      indicatorColor: Colors.teal.shade100,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home, color: Colors.teal),
          label: 'Beranda',
        ),
        NavigationDestination(
          icon: Icon(Icons.grid_view_outlined),
          selectedIcon: Icon(Icons.grid_view, color: Colors.teal),
          label: 'Layanan',
        ),
        // Destination Warga dengan BadgeIkonWarga terisolasi menggunakan context.select
        NavigationDestination(
          icon: BadgeIkonWarga(isSelected: false),
          selectedIcon: BadgeIkonWarga(isSelected: true),
          label: 'Warga',
        ),
      ],
    );
  }

  // Tata letak layar lebar (>= 600 px), NavigationRail di kiri + isi di kanan
  Widget _tataLetakLebar() {
    return Row(
      children: [
        NavigationRail(
          selectedIndex: _indeksTerpilih,
          onDestinationSelected: _pilihTujuan,
          extended: true,
          backgroundColor: Colors.teal.shade50.withValues(alpha: 0.5),
          indicatorColor: Colors.teal.shade200,
          leading: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: CircleAvatar(
              backgroundColor: Colors.teal.shade700,
              radius: 24,
              child: const Icon(
                Icons.location_city_rounded,
                color: Colors.white,
                size: 26,
              ),
            ),
          ),
          destinations: const [
            NavigationRailDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home, color: Colors.teal),
              label: Text('Beranda Smart City'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.grid_view_outlined),
              selectedIcon: Icon(Icons.grid_view, color: Colors.teal),
              label: Text('Katalog Layanan'),
            ),
            // Destination Warga dengan Badge reaktif
            NavigationRailDestination(
              icon: BadgeIkonWarga(isSelected: false),
              selectedIcon: BadgeIkonWarga(isSelected: true),
              label: Text('Profil Warga'),
            ),
          ],
        ),
        const VerticalDivider(thickness: 1, width: 1),
        Expanded(child: _halaman[_indeksTerpilih]),
      ],
    );
  }

  // NavigationDrawer untuk panel samping
  Widget _buatDrawer() {
    return NavigationDrawer(
      selectedIndex: _indeksTerpilih,
      onDestinationSelected: (indeks) {
        _pilihTujuan(indeks);
        Navigator.pop(context); // Tutup drawer terlebih dahulu
      },
      children: [
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal.shade700, Colors.teal.shade900],
            ),
          ),
          accountName: const Text(
            'Ghazy Nabil Alghfari',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          accountEmail: const Text('NIM: 707012400023 | D4SIKC 48-03'),
          currentAccountPicture: const CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 44, color: Colors.teal),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 12, 16, 8),
          child: Text(
            'Layanan Utama',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home, color: Colors.teal),
          label: Text('Beranda'),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.grid_view_outlined),
          selectedIcon: Icon(Icons.grid_view, color: Colors.teal),
          label: Text('Layanan Publik'),
        ),
        const NavigationDrawerDestination(
          icon: BadgeIkonWarga(isSelected: false),
          selectedIcon: BadgeIkonWarga(isSelected: true),
          label: Text('Profil & Laporan Warga'),
        ),
        const Divider(indent: 28, endIndent: 28),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 8, 16, 4),
          child: Text(
            'Menu Pendukung',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        ),
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 28),
          leading: const Icon(Icons.location_city_outlined),
          title: const Text('Pengaturan Kota'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, AppRoutes.pengaturanKota);
          },
        ),
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 28),
          leading: const Icon(Icons.info_outline),
          title: const Text('Tentang Aplikasi'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, AppRoutes.tentangAplikasi);
          },
        ),
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 28),
          leading: const Icon(Icons.logout_rounded, color: Colors.red),
          title: const Text('Keluar', style: TextStyle(color: Colors.red)),
          onTap: () {
            Navigator.pop(context);
            _tampilkanDialogKeluar();
          },
        ),
      ],
    );
  }
}

/// Widget khusus Badge Ikon Warga
/// Memanfaatkan `context.select<PengajuanModel, int>` agar pembaruan total pengajuan
/// HANYA me-rebuild widget badge kecil ini, tanpa me-rebuild NavigationBar atau NavigationRail.
class BadgeIkonWarga extends StatelessWidget {
  final bool isSelected;
  const BadgeIkonWarga({super.key, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    // Membaca hanya totalPengajuan dari PengajuanModel
    final totalPengajuan = context.select<PengajuanModel, int>(
      (model) => model.totalPengajuan,
    );

    return Badge(
      isLabelVisible: totalPengajuan > 0,
      label: Text(
        '$totalPengajuan',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
      ),
      backgroundColor: Colors.deepOrange,
      child: Icon(
        isSelected ? Icons.person : Icons.person_outline,
        color: isSelected ? Colors.teal : null,
      ),
    );
  }
}
