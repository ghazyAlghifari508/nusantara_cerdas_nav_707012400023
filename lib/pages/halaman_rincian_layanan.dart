import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/pengajuan_cubit.dart';

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
  bool _sedangMengirim = false;

  Future<void> _ajukanPermohonan() async {
    setState(() {
      _sedangMengirim = true;
    });

    // Simulasi pengiriman data ke server balai kota
    await Future.delayed(const Duration(milliseconds: 1200));

    if (!mounted) return;

    // Catat ke PengajuanCubit
    context.read<PengajuanCubit>().tambahPengajuan(
          namaLayanan: widget.namaLayanan,
          dinas: widget.dinas,
        );

    setState(() {
      _sedangMengirim = false;
    });

    // Menutup halaman sekaligus mengembalikan pesan pengajuan seperti Modul II
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
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: _sedangMengirim ? null : _ajukanPermohonan,
                icon: _sedangMengirim
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.send_rounded),
                label: Text(
                  _sedangMengirim ? 'Sedang Mengirim...' : 'Ajukan Permohonan',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade700,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.teal.shade300,
                  disabledForegroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
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
