import 'package:flutter/material.dart';

class HalamanRiwayatLaporan extends StatelessWidget {
  const HalamanRiwayatLaporan({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> daftarLaporan = const [
      {
        'judul': 'Perbaikan Lampu Jalan PJU',
        'lokasi': 'Jl. Titik Nol Nusantara No. 12',
        'status': 'Selesai',
        'tanggal': '20 September 2026',
      },
      {
        'judul': 'Pembersihan Saluran Air Drainase',
        'lokasi': 'Kawasan Hunian ASN 3',
        'status': 'Diproses',
        'tanggal': '22 September 2026',
      },
      {
        'judul': 'Permohonan Bibit Pohon Penghijauan',
        'lokasi': 'Taman Kota Sepaku',
        'status': 'Diverifikasi',
        'tanggal': '24 September 2026',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Laporan Warga'),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: daftarLaporan.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final laporan = daftarLaporan[index];
          final isSelesai = laporan['status'] == 'Selesai';

          return Card(
            elevation: 1.5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading: CircleAvatar(
                backgroundColor:
                    isSelesai ? Colors.teal.shade50 : Colors.amber.shade50,
                child: Icon(
                  isSelesai ? Icons.check_circle : Icons.hourglass_top,
                  color:
                      isSelesai ? Colors.teal.shade700 : Colors.amber.shade800,
                ),
              ),
              title: Text(
                laporan['judul']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text('Lokasi: ${laporan['lokasi']}'),
                  const SizedBox(height: 2),
                  Text(
                    'Tanggal: ${laporan['tanggal']}',
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
              trailing: Chip(
                label: Text(
                  laporan['status']!,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color:
                        isSelesai
                            ? Colors.teal.shade900
                            : Colors.amber.shade900,
                  ),
                ),
                backgroundColor:
                    isSelesai ? Colors.teal.shade100 : Colors.amber.shade100,
                padding: EdgeInsets.zero,
              ),
            ),
          );
        },
      ),
      // FloatingActionButton menempel pada cekungan BottomAppBar
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Formulir tambah laporan baru dibuka.'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        backgroundColor: Colors.teal.shade700,
        foregroundColor: Colors.white,
        tooltip: 'Tambah Laporan Baru',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // BottomAppBar sebagai wadah aksi halaman aktif
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.search),
              tooltip: 'Cari Laporan',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Fitur Pencarian Laporan.')),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.filter_list),
              tooltip: 'Filter Status',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Filter status laporan.')),
                );
              },
            ),
            const SizedBox(width: 48), // Ruang cekungan untuk tombol melayang
            IconButton(
              icon: const Icon(Icons.sort),
              tooltip: 'Urutkan Tanggal',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Mengurutkan data laporan.')),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.file_download_outlined),
              tooltip: 'Unduh Rekap',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Mengunduh rekap laporan PDF.')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
