import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritCubit extends Cubit<Set<String>> {
  FavoritCubit() : super(const <String>{});

  void tandai(String namaLayanan) {
    final salinanBaru = Set<String>.from(state)..add(namaLayanan);
    emit(salinanBaru);
  }

  void batalTandai(String namaLayanan) {
    final salinanBaru = Set<String>.from(state)..remove(namaLayanan);
    emit(salinanBaru);
  }

  void toggleFavorit(String namaLayanan) {
    if (state.contains(namaLayanan)) {
      batalTandai(namaLayanan);
    } else {
      tandai(namaLayanan);
    }
  }

  bool isFavorit(String namaLayanan) => state.contains(namaLayanan);
}
