import 'package:flutter/foundation.dart';

/// Representasi entitas data layanan yang diajukan oleh warga
@immutable
class ItemPengajuan {
  final String namaLayanan;
  final String dinas;
  final DateTime waktuPengajuan;
  final String status;

  const ItemPengajuan({
    required this.namaLayanan,
    required this.dinas,
    required this.waktuPengajuan,
    this.status = 'Menunggu Verifikasi',
  });
}

/// Model manajemen state untuk pengajuan permohonan layanan publik warga.
/// Meng-extend ChangeNotifier agar dapat menyiarkan pembaruan data ke widget tree.
class PengajuanModel extends ChangeNotifier {
  // Daftar internal pengajuan yang bersifat privat demi integritas enkapsulasi
  final List<ItemPengajuan> _daftarPengajuan = [];

  /// Getter daftar permohonan layanan yang aman dibaca UI
  List<ItemPengajuan> get daftarPengajuan => List.unmodifiable(_daftarPengajuan);

  /// Getter total pengajuan untuk badge dan indikator
  int get totalPengajuan => _daftarPengajuan.length;

  /// Menambahkan layanan baru ke dalam antrean pengajuan
  void tambahPengajuan({
    required String namaLayanan,
    required String dinas,
  }) {
    _daftarPengajuan.add(
      ItemPengajuan(
        namaLayanan: namaLayanan,
        dinas: dinas,
        waktuPengajuan: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  /// Menghapus pengajuan berdasarkan indeks jika diperlukan
  void hapusPengajuan(int index) {
    if (index >= 0 && index < _daftarPengajuan.length) {
      _daftarPengajuan.removeAt(index);
      notifyListeners();
    }
  }

  /// Mengosongkan daftar seluruh pengajuan
  void kosongkanPengajuan() {
    if (_daftarPengajuan.isEmpty) return;
    _daftarPengajuan.clear();
    notifyListeners();
  }
}
