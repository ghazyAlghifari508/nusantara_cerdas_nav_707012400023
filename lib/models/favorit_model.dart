import 'package:flutter/foundation.dart';

/// Model manajemen state untuk daftar layanan favorit warga.
/// Meng-extend ChangeNotifier agar dapat memberi tahu listener (widget pembaca)
/// saat data favorit ditambah atau dihapus.
class FavoritModel extends ChangeNotifier {
  // Set privat untuk menyimpan nama-nama layanan favorit secara unik
  final Set<String> _layananFavorit = {};

  /// Getter daftar nama layanan favorit yang tidak dapat dimodifikasi sembarangan dari luar
  List<String> get daftarFavorit => List.unmodifiable(_layananFavorit);

  /// Getter total layanan yang sedang difavoritkan
  int get totalFavorit => _layananFavorit.length;

  /// Memeriksa apakah suatu layanan telah ditandai sebagai favorit
  bool isFavorit(String namaLayanan) {
    return _layananFavorit.contains(namaLayanan);
  }

  /// Menandai layanan sebagai favorit dan memberitahu widget pendengar
  void tandai(String namaLayanan) {
    if (_layananFavorit.add(namaLayanan)) {
      notifyListeners();
    }
  }

  /// Membatalkan tanda favorit pada layanan dan memberitahu widget pendengar
  void batalTandai(String namaLayanan) {
    if (_layananFavorit.remove(namaLayanan)) {
      notifyListeners();
    }
  }

  /// Toggle tanda favorit untuk kemudahan interaksi UI
  void toggleFavorit(String namaLayanan) {
    if (isFavorit(namaLayanan)) {
      batalTandai(namaLayanan);
    } else {
      tandai(namaLayanan);
    }
  }
}
