import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/pengajuan_model.dart';

/// Halaman Rincian Layanan Publik Nusantara Cerdas
/// Menerapkan pengelolaan State Lokal melalui setState() untuk status tombol sedang mengirim,
/// serta memperbarui State Aplikasi PengajuanModel melalui Provider sebelum kembali.
class HalamanRincianLayanan extends StatefulWidget {
  final String namaLayanan;
  final String dinas;
  final String jamOperasional;
  final String keterangan;

  const HalamanRincianLayanan({
    super.key,
    required this.namaLayanan,
    required this.dinas,
    required this.jamOperasional,
    required this.keterangan,
  });

  @override
  State<HalamanRincianLayanan> createState() => _HalamanRincianLayananState();
}

class _HalamanRincianLayananState extends State<HalamanRincianLayanan> {
  // State lokal untuk menandai proses pengiriman formulir permohonan
  bool _sedangMengirim = false;

  Future<void> _prosesPengajuan() async {
    if (_sedangMengirim) return;

    // 1. Memperbarui state lokal agar UI menampilkan indikator loading
    setState(() {
      _sedangMengirim = true;
    });

    // Simulasi jeda transmisi jaringan ke server dinas terkait
    await Future.delayed(const Duration(milliseconds: 1200));

    // Proteksi build context mounted sebelum melanjutkan manipulasi state / navigasi
    if (!mounted) return;

    // 2. Memasukkan berkas permohonan ke dalam state aplikasi PengajuanModel
    context.read<PengajuanModel>().tambahPengajuan(
          namaLayanan: widget.namaLayanan,
          dinas: widget.dinas,
        );

    // 3. Mengembalikan state lokal ke kondisi semula
    setState(() {
      _sedangMengirim = false;
    });

    // 4. Menutup halaman rincian sekaligus mengirimkan nilai balik konfirmasi ke halaman pemanggil (Modul II)
    Navigator.pop(
      context,
      'Permohonan "${widget.namaLayanan}" berhasil diajukan ke ${widget.dinas}.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rincian Layanan'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.teal.shade50,
                          radius: 28,
                          child: Icon(
                            Icons.business_center,
                            color: Colors.teal.shade700,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.namaLayanan,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.dinas,
                                style: TextStyle(
                                  color: Colors.teal.shade800,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 32),
                    _buildInfoRow(
                      Icons.access_time_filled_outlined,
                      'Jam Operasional',
                      widget.jamOperasional,
                    ),
                    const SizedBox(height: 12),
                    _buildInfoRow(
                      Icons.info_outline,
                      'Deskripsi Layanan',
                      widget.keterangan,
                    ),
                    const SizedBox(height: 12),
                    _buildInfoRow(
                      Icons.verified_user_outlined,
                      'Syarat Pengajuan',
                      'e-KTP Nusantara, Kartu Keluarga, dan Berkas Pendukung.',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Tombol Ajukan Permohonan dengan indikator proses pengiriman (State Lokal setState)
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _sedangMengirim ? null : _prosesPengajuan,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade700,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.teal.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _sedangMengirim
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.2,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 12),
                          Text(
                            'Memproses Pengajuan...',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ],
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.send_rounded, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            'Ajukan Permohonan',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton(
                onPressed: _sedangMengirim ? null : () => Navigator.pop(context),
                child: const Text('Kembali ke Daftar Layanan'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.black54),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                content,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
