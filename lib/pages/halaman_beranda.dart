import 'package:flutter/material.dart';

class HalamanBeranda extends StatelessWidget {
  const HalamanBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> pilarSmartCity = const [
      {
        'judul': 'Smart Governance',
        'subjudul': 'Birokrasi & Layanan Terpadu',
        'ikon': Icons.account_balance_rounded,
        'warna': Colors.blue,
      },
      {
        'judul': 'Smart Branding',
        'subjudul': 'Pariwisata & Citra Kota Nusantara',
        'ikon': Icons.campaign_rounded,
        'warna': Colors.purple,
      },
      {
        'judul': 'Smart Economy',
        'subjudul': 'Ekosistem UMKM & Transaksi Digital',
        'ikon': Icons.trending_up_rounded,
        'warna': Colors.green,
      },
      {
        'judul': 'Smart Living',
        'subjudul': 'Kualitas Hunian & Mobilitas Cerdas',
        'ikon': Icons.local_convenience_store_rounded,
        'warna': Colors.orange,
      },
      {
        'judul': 'Smart Society',
        'subjudul': 'Masyarakat Edukatif & Partisipatif',
        'ikon': Icons.groups_rounded,
        'warna': Colors.teal,
      },
      {
        'judul': 'Smart Environment',
        'subjudul': 'Kelestarian Energi Hijau & Hutan Tropis',
        'ikon': Icons.eco_rounded,
        'warna': Colors.lightGreen,
      },
    ];

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Banner Sambutan Smart City
        Container(
          padding: const EdgeInsets.all(18.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal.shade700, Colors.teal.shade900],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.teal.shade900.withValues(alpha: 0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.location_city_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nusantara Cerdas Mobile',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Pusat Pelayanan Terpadu Warga IKN',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              const Text(
                'Selamat datang! Akses seluruh layanan publik dan kelola laporan kota Anda dalam satu genggaman tangan.',
                style: TextStyle(color: Colors.white, fontSize: 13, height: 1.4),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Judul Bagian 6 Pilar Smart City
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: Text(
                'Enam Pilar Smart City',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '6 Pilar Aktif',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade800,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Grid 6 Pilar Smart City
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.35,
          ),
          itemCount: pilarSmartCity.length,
          itemBuilder: (context, index) {
            final pilar = pilarSmartCity[index];
            final Color color = pilar['warna'] as Color;

            return Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey.shade200),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: color.withValues(alpha: 0.15),
                      child: Icon(
                        pilar['ikon'] as IconData,
                        color: color,
                        size: 20,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      pilar['judul'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      pilar['subjudul'] as String,
                      style: const TextStyle(fontSize: 11, color: Colors.black54),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 20),

        // Tombol Pengujian Rute Galat (onUnknownRoute)
        OutlinedButton.icon(
          onPressed: () {
            Navigator.pushNamed(context, '/rute-palsu-uji-coba');
          },
          icon: const Icon(Icons.bug_report_outlined),
          label: const Text('Uji Penanganan Rute Tidak Dikenal (404)'),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.red.shade700,
            side: BorderSide(color: Colors.red.shade300),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ],
    );
  }
}
