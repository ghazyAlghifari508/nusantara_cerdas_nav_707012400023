import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/pengajuan_cubit.dart';
import '../cubit/theme_cubit.dart';
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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

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
          elevation: 2,
          actions: [
            BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, themeMode) {
                final isDarkMode = themeMode == ThemeMode.dark;
                return IconButton(
                  icon: Icon(
                    isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                  ),
                  tooltip: isDarkMode ? 'Ganti ke Mode Terang' : 'Ganti ke Mode Gelap',
                  onPressed: () => context.read<ThemeCubit>().toggle(),
                );
              },
            ),
          ],
        ),
        drawer: _buatDrawer(isDark),
        // Tata letak adaptif: NavigationRail untuk layar lebar, NavigationBar untuk layar sempit
        body: layarLebar ? _tataLetakLebar(isDark) : _halaman[_indeksTerpilih],
        bottomNavigationBar: layarLebar ? null : _buatBilahBawah(isDark),
      ),
    );
  }

  // Helper widget untuk ikon badge profil warga
  Widget _buildWargaIconWithBadge({required bool isSelected, required bool isDark}) {
    final theme = Theme.of(context);
    return BlocSelector<PengajuanCubit, PengajuanState, int>(
      selector: (state) => state.totalPengajuan,
      builder: (context, total) {
        return Badge(
          isLabelVisible: total > 0,
          label: Text('$total'),
          backgroundColor: Colors.red.shade700,
          child: Icon(
            isSelected ? Icons.person : Icons.person_outline,
            color: isSelected ? theme.colorScheme.primary : null,
          ),
        );
      },
    );
  }

  // NavigationBar Material 3 untuk layar sempit (< 600 px)
  Widget _buatBilahBawah(bool isDark) {
    final theme = Theme.of(context);
    return NavigationBar(
      selectedIndex: _indeksTerpilih,
      onDestinationSelected: _pilihTujuan,
      destinations: [
        NavigationDestination(
          icon: const Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home, color: theme.colorScheme.primary),
          label: 'Beranda',
        ),
        NavigationDestination(
          icon: const Icon(Icons.grid_view_outlined),
          selectedIcon: Icon(Icons.grid_view, color: theme.colorScheme.primary),
          label: 'Layanan',
        ),
        NavigationDestination(
          icon: _buildWargaIconWithBadge(isSelected: false, isDark: isDark),
          selectedIcon: _buildWargaIconWithBadge(isSelected: true, isDark: isDark),
          label: 'Warga',
        ),
      ],
    );
  }

  // Tata letak layar lebar (>= 600 px), NavigationRail di kiri + isi di kanan
  Widget _tataLetakLebar(bool isDark) {
    final theme = Theme.of(context);
    return Row(
      children: [
        NavigationRail(
          selectedIndex: _indeksTerpilih,
          onDestinationSelected: _pilihTujuan,
          extended: true,
          leading: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: CircleAvatar(
              backgroundColor: theme.colorScheme.primary,
              radius: 24,
              child: Icon(
                Icons.location_city_rounded,
                color: theme.colorScheme.onPrimary,
                size: 26,
              ),
            ),
          ),
          destinations: [
            NavigationRailDestination(
              icon: const Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home, color: theme.colorScheme.primary),
              label: const Text('Beranda Smart City'),
            ),
            NavigationRailDestination(
              icon: const Icon(Icons.grid_view_outlined),
              selectedIcon: Icon(Icons.grid_view, color: theme.colorScheme.primary),
              label: const Text('Katalog Layanan'),
            ),
            NavigationRailDestination(
              icon: _buildWargaIconWithBadge(isSelected: false, isDark: isDark),
              selectedIcon: _buildWargaIconWithBadge(isSelected: true, isDark: isDark),
              label: const Text('Profil Warga'),
            ),
          ],
        ),
        const VerticalDivider(thickness: 1, width: 1),
        Expanded(child: _halaman[_indeksTerpilih]),
      ],
    );
  }

  // NavigationDrawer untuk panel samping
  Widget _buatDrawer(bool isDark) {
    final theme = Theme.of(context);
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
              colors: isDark
                  ? [const Color(0xFF1E3835), const Color(0xFF122220)]
                  : [Colors.teal.shade700, Colors.teal.shade900],
            ),
          ),
          accountName: const Text(
            'Ghazy Nabil Alghfari',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          accountEmail: const Text('NIM: 707012400023 | D4SIKC 48-03'),
          currentAccountPicture: CircleAvatar(
            backgroundColor: isDark ? const Color(0xFF162523) : Colors.white,
            child: Icon(
              Icons.person,
              size: 40,
              color: isDark ? const Color(0xFF80CBC4) : Colors.teal,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 12, 16, 8),
          child: Text(
            'Layanan Utama',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        NavigationDrawerDestination(
          icon: const Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home, color: theme.colorScheme.primary),
          label: const Text('Beranda'),
        ),
        NavigationDrawerDestination(
          icon: const Icon(Icons.grid_view_outlined),
          selectedIcon: Icon(Icons.grid_view, color: theme.colorScheme.primary),
          label: const Text('Layanan Publik'),
        ),
        NavigationDrawerDestination(
          icon: _buildWargaIconWithBadge(isSelected: false, isDark: isDark),
          selectedIcon: _buildWargaIconWithBadge(isSelected: true, isDark: isDark),
          label: const Text('Profil & Laporan Warga'),
        ),
        const Divider(indent: 28, endIndent: 28),
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 8, 16, 4),
          child: Text(
            'Menu Pendukung',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 28),
          leading: const Icon(Icons.location_city_outlined),
          title: const Text('Pengaturan Kota'),
          onTap: () {
            Navigator.pop(context); // Tutup drawer dahulu sebelum pushNamed
            Navigator.pushNamed(context, AppRoutes.pengaturanKota);
          },
        ),
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 28),
          leading: const Icon(Icons.info_outline),
          title: const Text('Tentang Aplikasi'),
          onTap: () {
            Navigator.pop(context); // Tutup drawer dahulu sebelum pushNamed
            Navigator.pushNamed(context, AppRoutes.tentangAplikasi);
          },
        ),
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 28),
          leading: const Icon(Icons.logout_rounded, color: Colors.red),
          title: const Text('Keluar', style: TextStyle(color: Colors.red)),
          onTap: () {
            Navigator.pop(context); // Tutup drawer dahulu
            _tampilkanDialogKeluar();
          },
        ),
      ],
    );
  }
}
