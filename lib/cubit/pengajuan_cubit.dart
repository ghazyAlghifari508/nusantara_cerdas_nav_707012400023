import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/pengajuan_item.dart';

class PengajuanState {
  final List<PengajuanItem> items;

  const PengajuanState(this.items);

  int get totalPengajuan => items.length;
}

class PengajuanCubit extends Cubit<PengajuanState> {
  PengajuanCubit() : super(const PengajuanState([]));

  void tambahPengajuan({
    required String namaLayanan,
    required String dinas,
  }) {
    final daftarBaru = List<PengajuanItem>.from(state.items)
      ..add(
        PengajuanItem(
          namaLayanan: namaLayanan,
          dinas: dinas,
          waktuPengajuan: DateTime.now(),
        ),
      );
    emit(PengajuanState(daftarBaru));
  }

  void hapusPengajuan(int indeks) {
    if (indeks < 0 || indeks >= state.items.length) return;
    final daftarBaru = List<PengajuanItem>.from(state.items)..removeAt(indeks);
    emit(PengajuanState(daftarBaru));
  }

  void kosongkan() {
    emit(const PengajuanState([]));
  }

  int get totalPengajuan => state.totalPengajuan;
}
