import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nusantara_cerdas_nav_707012400023/main.dart';

void main() {
  testWidgets('Pengujian alur navigasi Nusantara Cerdas Mobile', (
    WidgetTester tester,
  ) async {
    // Atur ukuran layar ke rasio ponsel (lebar < 600 px untuk menguji NavigationBar)
    tester.view.physicalSize = const Size(1080, 2280);
    tester.view.devicePixelRatio = 2.75; // Lebar logis = 1080 / 2.75 = ~392 px (< 600)
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    // Bangun widget aplikasi
    await tester.pumpWidget(const AplikasiNusantaraCerdas());
    await tester.pumpAndSettle();

    // Verifikasi berada di halaman Beranda
    expect(find.text('Beranda Smart City'), findsOneWidget);
    expect(find.text('Enam Pilar Smart City'), findsOneWidget);

    // Ketuk menu navigasi Layanan pada NavigationBar
    await tester.tap(find.byIcon(Icons.grid_view_outlined));
    await tester.pumpAndSettle();

    // Verifikasi berada di halaman Layanan dengan TabBar
    expect(find.text('Katalog Layanan Publik'), findsOneWidget);
    expect(find.text('Perizinan'), findsOneWidget);
    expect(find.text('Kesehatan'), findsOneWidget);
    expect(find.text('Transportasi'), findsOneWidget);

    // Ketuk menu navigasi Warga pada NavigationBar
    await tester.tap(find.byIcon(Icons.person_outline));
    await tester.pumpAndSettle();

    // Verifikasi berada di halaman Warga dengan identitas mahasiswa
    expect(find.text('Profil & Laporan Warga'), findsOneWidget);
    expect(find.text('Ghazy Nabil Alghfari'), findsOneWidget);
    expect(find.text('Riwayat & Form Laporan'), findsOneWidget);
  });
}
