import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/favorit_model.dart';
import '../models/pengajuan_model.dart';
import '../navigation/app_routes.dart';

class HalamanWarga extends StatelessWidget {
  const HalamanWarga({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Kartu Identitas Digital Warga (Smart Citizen Card)
        Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: Colors.teal.shade800,
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
                            'NIM: 707012400023 | D4SIKC 48-03',
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
        const SizedBox(height: 20),

        // Bagian Ringkasan Pengajuan Permohonan (Reaktif dengan Provider)
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          runSpacing: 4,
          children: [
            const Text(
              'Aktivitas & Permohonan',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Consumer<PengajuanModel>(
              builder: (context, pengajuan, child) {
                return Text(
                  '${pengajuan.totalPengajuan} Berkas Diajukan',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade700,
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 12),
        Consumer<PengajuanModel>(
          builder: (context, pengajuan, child) {
            final total = pengajuan.totalPengajuan;
            return Row(
              children: [
                _buildStatCard(total.toString(), 'Permohonan', Colors.teal),
                const SizedBox(width: 8),
                _buildStatCard('3', 'Pengaduan', Colors.blue),
                const SizedBox(width: 8),
                _buildStatCard(total > 0 ? 'Aktif' : 'Nihil', 'Status Izin', Colors.amber),
              ],
            );
          },
        ),
        const SizedBox(height: 24),

        // ================================================================
        // BAGIAN WAJIB MODUL 3: DAFTAR LAYANAN FAVORIT DENGAN CONSUMER
        // Menampilkan daftar layanan favorit secara reaktif lintas kategori
        // ================================================================
        Row(
          children: [
            Icon(Icons.star_rounded, color: Colors.amber.shade700),
            const SizedBox(width: 8),
            const Expanded(
              child: Text(
                'Layanan Favorit Warga',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Consumer<FavoritModel>(
          builder: (context, favorit, child) {
            if (favorit.daftarFavorit.isEmpty) {
              return Card(
                elevation: 0.5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey.shade300),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
                  child: Column(
                    children: [
                      Icon(Icons.star_border_rounded, size: 48, color: Colors.grey.shade400),
                      const SizedBox(height: 10),
                      const Text(
                        'Belum Ada Layanan Favorit',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Tandai ikon bintang pada Katalog Layanan untuk menyematkan layanan favorit di sini.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              );
            }

            return Column(
              children: favorit.daftarFavorit.map((namaLayanan) {
                return Card(
                  elevation: 1,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.amber.shade50,
                      child: Icon(Icons.star_rounded, color: Colors.amber.shade700),
                    ),
                    title: Text(
                      namaLayanan,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    subtitle: const Text(
                      'Tersimpan sebagai akses cepat',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent),
                      tooltip: 'Hapus dari Favorit',
                      onPressed: () {
                        context.read<FavoritModel>().batalTandai(namaLayanan);
                      },
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
        const SizedBox(height: 24),

        // DAFTAR PERMOHONAN AKTIF (REAKTIF DARI PENGAJUAN MODEL)
        Consumer<PengajuanModel>(
          builder: (context, pengajuan, child) {
            if (pengajuan.daftarPengajuan.isEmpty) {
              return const SizedBox.shrink();
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.pending_actions_rounded, color: Colors.teal.shade700),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Daftar Pengajuan Terkini',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: pengajuan.daftarPengajuan.length,
                  itemBuilder: (context, index) {
                    final item = pengajuan.daftarPengajuan[index];
                    return Card(
                      elevation: 1,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.teal.shade50,
                          child: Icon(Icons.check_circle_outline, color: Colors.teal.shade700),
                        ),
                        title: Text(
                          item.namaLayanan,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        subtitle: Text(
                          '${item.dinas}\nStatus: ${item.status}',
                          style: const TextStyle(fontSize: 12),
                        ),
                        isThreeLine: true,
                        trailing: IconButton(
                          icon: const Icon(Icons.close_rounded, size: 20),
                          tooltip: 'Batalkan Pengajuan',
                          onPressed: () {
                            context.read<PengajuanModel>().hapusPengajuan(index);
                          },
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
              ],
            );
          },
        ),

        // Tombol menuju Halaman Penuh Riwayat Laporan (dengan BottomAppBar + FAB)
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.teal.shade50,
              child: Icon(Icons.history_rounded, color: Colors.teal.shade700),
            ),
            title: const Text(
              'Riwayat & Form Laporan',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text('Buka halaman penuh dengan aksi BottomAppBar'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.riwayatLaporan);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String count, String label, MaterialColor color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          color: color.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.shade200),
        ),
        child: Column(
          children: [
            Text(
              count,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color.shade900,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(fontSize: 11, color: color.shade900),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
