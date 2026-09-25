import 'package:flutter/material.dart';
import '../navigation/app_routes.dart';

class HalamanLayanan extends StatefulWidget {
  const HalamanLayanan({super.key});

  @override
  State<HalamanLayanan> createState() => _HalamanLayananState();
}

class _HalamanLayananState extends State<HalamanLayanan> {
  // Data Layanan per Kategori Bidang
  final List<Map<String, String>> _layananPerizinan = const [
    {
      'nama': 'Persetujuan Bangunan Gedung (PBG / IMB)',
      'dinas': 'Dinas Pekerjaan Umum & Penataan Ruang (PUPR)',
      'jam': 'Senin - Jumat, 08.00 - 15.00 WITA',
      'keterangan':
          'Layanan penerbitan izin mendirikan, merenovasi, atau mengubah fungsi bangunan di kawasan IKN.',
    },
    {
      'nama': 'Izin Usaha Mikro & Kecil (IUMK Digital)',
      'dinas': 'Dinas Koperasi, UKM, Perindustrian & Perdagangan',
      'jam': 'Senin - Jumat, 08.00 - 16.00 WITA',
      'keterangan':
          'Legalisasi izin operasional bagi pelaku UMKM di Nusantara Cerdas secara instan berbasis OSS.',
    },
    {
      'nama': 'Surat Izin Praktik Tenaga Kesehatan (SIP)',
      'dinas': 'Dinas Penanaman Modal & Pelayanan Terpadu Satu Pintu',
      'jam': 'Senin - Jumat, 08.30 - 15.00 WITA',
      'keterangan':
          'Penerbitan surat izin praktik bagi dokter, perawat, dan apoteker di fasilitas kesehatan kota.',
    },
  ];

  final List<Map<String, String>> _layananKesehatan = const [
    {
      'nama': 'Antrean Faskes & Puskesmas Digital',
      'dinas': 'Dinas Kesehatan Kota Nusantara',
      'jam': 'Setiap Hari, 07.30 - 14.00 WITA',
      'keterangan':
          'Reservasi antrean berobat online tanpa antre fisik untuk seluruh Puskesmas di Kawasan Inti.',
    },
    {
      'nama': 'Layanan Ambulans Tanggap Cepat 119',
      'dinas': 'UPTD Public Safety Center (PSC) 119',
      'jam': 'Operasional 24 Jam Non-Stop',
      'keterangan':
          'Pelayanan evakuasi medis darurat terpadu dengan integrasi pelacakan GPS armada tercepat.',
    },
    {
      'nama': 'Telemedisin & Konsultasi Dokter Spesialis',
      'dinas': 'RSUD Vertikal Ibu Kota Nusantara',
      'jam': 'Senin - Sabtu, 08.00 - 20.00 WITA',
      'keterangan':
          'Konsultasi kesehatan tatap muka secara virtual bersama dokter ahli dan pengantaran resep obat.',
    },
  ];

  final List<Map<String, String>> _layananTransportasi = const [
    {
      'nama': 'Tiket Bus Rapid Transit (BRT) Nusantara',
      'dinas': 'Dinas Perhubungan & Otorita IKN',
      'jam': 'Setiap Hari, 05.30 - 22.00 WITA',
      'keterangan':
          'Pemesanan tiket digital dan pelacakan posisi bus listrik ramah lingkungan koridor 1 - 5.',
    },
    {
      'nama': 'Uji Berkala Kelayakan Kendaraan (KIR)',
      'dinas': 'Dinas Perhubungan Kota Nusantara',
      'jam': 'Senin - Jumat, 08.00 - 14.30 WITA',
      'keterangan':
          'Pemeriksaan emisi dan kelaikan kendaraan angkutan barang serta umum berbasis otomatisasi.',
    },
    {
      'nama': 'Sewa Sepeda Listrik Terpadu (Smart Bike)',
      'dinas': 'PT Transportasi Cerdas Nusantara (BUMD)',
      'jam': 'Setiap Hari, 06.00 - 21.00 WITA',
      'keterangan':
          'Aktivasi peminjaman sepeda listrik mikro-mobilitas di stasiun docking halte kota terdekat.',
    },
  ];

  Future<void> _bukaRincian(Map<String, String> item) async {
    // Membuka rincian layanan menggunakan named route dan mengirimkan argumen dinamis
    final hasil = await Navigator.pushNamed(
      context,
      AppRoutes.rincianLayanan,
      arguments: item,
    );

    // Verifikasi widget mounted sebelum menampilkan SnackBar pemberitahuan hasil
    if (!mounted) return;

    if (hasil is String) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle_outline, color: Colors.white),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  hasil,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.teal.shade800,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Container(
            color: Theme.of(context).colorScheme.surface,
            child: const TabBar(
              labelColor: Colors.teal,
              indicatorColor: Colors.teal,
              tabs: [
                Tab(
                  icon: Icon(Icons.assignment_outlined),
                  text: 'Perizinan',
                ),
                Tab(
                  icon: Icon(Icons.local_hospital_outlined),
                  text: 'Kesehatan',
                ),
                Tab(
                  icon: Icon(Icons.directions_bus_outlined),
                  text: 'Transportasi',
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildDaftarLayanan(_layananPerizinan, Icons.description_outlined),
                _buildDaftarLayanan(_layananKesehatan, Icons.health_and_safety_outlined),
                _buildDaftarLayanan(_layananTransportasi, Icons.commute_outlined),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDaftarLayanan(
    List<Map<String, String>> list,
    IconData leadingIcon,
  ) {
    return ListView.separated(
      padding: const EdgeInsets.all(12.0),
      itemCount: list.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final item = list[index];
        return Card(
          elevation: 0.8,
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.teal.shade50,
              child: Icon(leadingIcon, color: Colors.teal.shade700),
            ),
            title: Text(
              item['nama']!,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 2),
                Text(
                  item['dinas']!,
                  style: TextStyle(fontSize: 12, color: Colors.teal.shade900),
                ),
                Text(
                  '🕒 ${item['jam']}',
                  style: const TextStyle(fontSize: 11, color: Colors.black54),
                ),
              ],
            ),
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
            onTap: () => _bukaRincian(item),
          ),
        );
      },
    );
  }
}
