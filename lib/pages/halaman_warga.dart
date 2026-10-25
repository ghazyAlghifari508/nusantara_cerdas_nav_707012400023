import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/favorit_cubit.dart';
import '../cubit/pengajuan_cubit.dart';
import '../cubit/theme_cubit.dart';
import '../navigation/app_routes.dart';

class HalamanWarga extends StatelessWidget {
  const HalamanWarga({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Kartu Identitas Digital Warga (Smart Citizen Card)
        Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: isDark ? const Color(0xFF1E3835) : Colors.teal.shade800,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'KARTU WARGA CERDAS',
                      style: TextStyle(
                        color: Colors.white70,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Icon(Icons.contactless_rounded, color: Colors.teal.shade200),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, size: 40, color: Colors.teal.shade800),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ghazy Nabil Alghfari',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'NIK: 3273012400023001',
                            style: TextStyle(color: Colors.white70, fontSize: 13),
                          ),
                          Text(
                            'NIM: 707012400023 | D4SIKC',
                            style: TextStyle(color: Colors.white70, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'STATUS: WARGA AKTIF KOTA NUSANTARA',
                    style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Sakelar (Switch) Mode Gelap (Sesuai Poin 12 Modul 6)
        Card(
          elevation: 1.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, currentMode) {
              final isDarkModeActive = currentMode == ThemeMode.dark;
              return SwitchListTile(
                value: isDarkModeActive,
                onChanged: (val) {
                  context.read<ThemeCubit>().setDarkMode(val);
                },
                secondary: CircleAvatar(
                  backgroundColor: isDarkModeActive
                      ? Colors.teal.shade900
                      : Colors.teal.shade50,
                  child: Icon(
                    isDarkModeActive
                        ? Icons.dark_mode_rounded
                        : Icons.light_mode_rounded,
                    color: isDarkModeActive
                        ? Colors.amber.shade300
                        : Colors.teal.shade700,
                  ),
                ),
                title: const Text(
                  'Mode Tampilan Gelap (Dark Mode)',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                subtitle: Text(
                  isDarkModeActive
                      ? 'Mode malam aktif: palet warna gelap hemat daya'
                      : 'Mode terang aktif: tema resmi Nusantara Cerdas',
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),

        // Bagian Layanan Favorit Reaktif (BlocBuilder<FavoritCubit, Set<String>>)
        Row(
          children: [
            const Expanded(
              child: Text(
                'Layanan Favorit Warga',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            BlocBuilder<FavoritCubit, Set<String>>(
              builder: (context, favorit) {
                return Text(
                  '${favorit.length} Tersimpan',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isDark ? theme.colorScheme.primary : Colors.teal.shade700,
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        BlocBuilder<FavoritCubit, Set<String>>(
          builder: (context, favorit) {
            if (favorit.isEmpty) {
              return Card(
                elevation: 0.5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                  child: Column(
                    children: [
                      Icon(Icons.star_outline_rounded,
                          size: 40,
                          color: isDark ? Colors.grey.shade600 : Colors.grey.shade400),
                      const SizedBox(height: 8),
                      const Text(
                        'Belum Ada Layanan Favorit',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Tandai layanan pada menu Layanan dengan ikon bintang agar mudah diakses kembali dari sini.',
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }

            return Column(
              children: favorit.map((namaLayanan) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  elevation: 0.8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: isDark ? Colors.amber.shade900.withValues(alpha: 0.4) : Colors.amber.shade50,
                      child: Icon(Icons.star_rounded, color: Colors.amber.shade700),
                    ),
                    title: Text(
                      namaLayanan,
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Tersimpan sebagai layanan prioritas warga',
                      style: TextStyle(fontSize: 11, color: theme.colorScheme.onSurfaceVariant),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.close_rounded, size: 20, color: Colors.red),
                      tooltip: 'Hapus dari favorit',
                      onPressed: () {
                        context.read<FavoritCubit>().batalTandai(namaLayanan);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Layanan "$namaLayanan" dihapus dari favorit'),
                            duration: const Duration(seconds: 1),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
        const SizedBox(height: 20),

        // Bagian Berkas Permohonan Diajukan (BlocBuilder<PengajuanCubit, PengajuanState>)
        Row(
          children: [
            const Expanded(
              child: Text(
                'Berkas Permohonan Diajukan',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            BlocBuilder<PengajuanCubit, PengajuanState>(
              builder: (context, state) {
                return Text(
                  '${state.totalPengajuan} Berkas',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isDark ? theme.colorScheme.primary : Colors.teal.shade700,
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        BlocBuilder<PengajuanCubit, PengajuanState>(
          builder: (context, state) {
            if (state.items.isEmpty) {
              return Card(
                elevation: 0.5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                  child: Column(
                    children: [
                      Icon(Icons.inventory_2_outlined,
                          size: 40,
                          color: isDark ? Colors.grey.shade600 : Colors.grey.shade400),
                      const SizedBox(height: 8),
                      const Text(
                        'Keranjang Pengajuan Masih Kosong',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Ajukan permohonan melalui rincian layanan untuk mengajukan berkas ke dinas terkait.',
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }

            return Column(
              children: [
                ...state.items.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final item = entry.value;
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    elevation: 0.8,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: isDark ? Colors.teal.shade900 : Colors.teal.shade50,
                        child: Text(
                          '#${idx + 1}',
                          style: TextStyle(
                            color: isDark ? Colors.teal.shade200 : Colors.teal.shade800,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        item.namaLayanan,
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Tujuan: ${item.dinas}',
                        style: TextStyle(fontSize: 11, color: theme.colorScheme.onSurfaceVariant),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline, size: 20, color: Colors.red),
                        tooltip: 'Batalkan berkas ini',
                        onPressed: () {
                          context.read<PengajuanCubit>().hapusPengajuan(idx);
                        },
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 6),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () => context.read<PengajuanCubit>().kosongkan(),
                    icon: const Icon(Icons.delete_sweep_outlined, size: 18),
                    label: const Text('Kosongkan Semua Berkas'),
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 20),

        // Ringkasan Aktivitas & Laporan
        const Text(
          'Ringkasan Laporan Pengaduan',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildStatCard('3', 'Total Laporan', Colors.teal, isDark),
            const SizedBox(width: 12),
            _buildStatCard('2', 'Selesai', Colors.green, isDark),
            const SizedBox(width: 12),
            _buildStatCard('1', 'Diproses', Colors.amber, isDark),
          ],
        ),
        const SizedBox(height: 24),

        // Tombol menuju Halaman Penuh Riwayat Laporan
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: isDark ? Colors.teal.shade900 : Colors.teal.shade50,
              child: Icon(Icons.history_rounded, color: isDark ? Colors.teal.shade200 : Colors.teal.shade700),
            ),
            title: const Text(
              'Riwayat & Form Laporan',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Buka halaman penuh dengan aksi BottomAppBar',
              style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.riwayatLaporan);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String count, String label, MaterialColor color, bool isDark) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? color.shade900.withValues(alpha: 0.3) : color.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark ? color.shade700.withValues(alpha: 0.5) : color.shade200,
          ),
        ),
        child: Column(
          children: [
            Text(
              count,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: isDark ? color.shade200 : color.shade900,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: isDark ? color.shade200 : color.shade900,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
