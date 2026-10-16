import 'package:flutter/foundation.dart';

@immutable
class PengajuanItem {
  final String namaLayanan;
  final String dinas;
  final DateTime waktuPengajuan;

  const PengajuanItem({
    required this.namaLayanan,
    required this.dinas,
    required this.waktuPengajuan,
  });
}
