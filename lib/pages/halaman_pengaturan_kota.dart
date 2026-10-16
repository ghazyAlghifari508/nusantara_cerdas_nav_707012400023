import 'package:flutter/material.dart';

class HalamanPengaturanKota extends StatefulWidget {
  const HalamanPengaturanKota({super.key});

  @override
  State<HalamanPengaturanKota> createState() => _HalamanPengaturanKotaState();
}

class _HalamanPengaturanKotaState extends State<HalamanPengaturanKota> {
  bool _notifikasiDarurat = true;
  bool _sensorKualitasUdara = true;
  bool _modeHematEnergi = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan Kota'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Preferensi Notifikasi & Sensor',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Peringatan Dini Cuaca & Bencana'),
                  subtitle: const Text('Pemberitahuan darurat dari BPBD IKN'),
                  value: _notifikasiDarurat,
                  activeTrackColor: Colors.teal,
                  onChanged: (val) => setState(() => _notifikasiDarurat = val),
                ),
                const Divider(height: 1),
                SwitchListTile(
                  title: const Text('Sensor Kualitas Udara Real-Time'),
                  subtitle: const Text('Pantau indeks ISPU kawasan sekitar'),
                  value: _sensorKualitasUdara,
                  activeTrackColor: Colors.teal,
                  onChanged: (val) =>
                      setState(() => _sensorKualitasUdara = val),
                ),
                const Divider(height: 1),
                SwitchListTile(
                  title: const Text('Mode Hemat Energi Smart Streetlight'),
                  subtitle: const Text('Optimasi data penerangan berbasis AI'),
                  value: _modeHematEnergi,
                  activeTrackColor: Colors.teal,
                  onChanged: (val) => setState(() => _modeHematEnergi = val),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Informasi Wilayah',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              children: [
                ListTile(
                  leading: Icon(Icons.location_city_outlined),
                  title: Text('Kawasan Inti Pusat Pemerintahan (KIPP)'),
                  subtitle: Text('Wilayah Operasional Layanan Terpadu'),
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.language_outlined),
                  title: Text('Bahasa Sistem'),
                  subtitle: Text('Bahasa Indonesia (Default)'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
