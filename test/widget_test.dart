import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:nusantara_cerdas_nav_707012400023/main.dart';
import 'package:nusantara_cerdas_nav_707012400023/models/favorit_model.dart';
import 'package:nusantara_cerdas_nav_707012400023/models/pengajuan_model.dart';

void main() {
  testWidgets('Pengujian alur navigasi dan manajemen state Nusantara Cerdas Mobile', (
    WidgetTester tester,
  ) async {
    // Atur ukuran layar ke rasio ponsel (lebar < 600 px untuk menguji NavigationBar)
    tester.view.physicalSize = const Size(1080, 2280);
    tester.view.devicePixelRatio = 2.75;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    // Bangun widget aplikasi dengan MultiProvider
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => FavoritModel()),
          ChangeNotifierProvider(create: (_) => PengajuanModel()),
        ],
        child: const AplikasiNusantaraCerdas(),
      ),
    );
    await tester.pumpAndSettle();

    // 1. Verifikasi berada di halaman Beranda
    expect(find.text('Beranda Smart City'), findsOneWidget);
    expect(find.text('Enam Pilar Smart City'), findsOneWidget);

    // 2. Ketuk menu navigasi Layanan pada NavigationBar
    await tester.tap(find.byIcon(Icons.grid_view_outlined));
    await tester.pumpAndSettle();

    // Verifikasi berada di halaman Layanan
    expect(find.text('Katalog Layanan Publik'), findsOneWidget);
    expect(find.text('Perizinan'), findsOneWidget);

    // 3. Uji interaksi tombol favorit (state management FavoritModel)
    final tombolFavorit = find.byTooltip('Tandai favorit').first;
    expect(tombolFavorit, findsOneWidget);
    await tester.tap(tombolFavorit);
    await tester.pumpAndSettle();

    // 4. Buka menu Warga untuk memverifikasi reaktivitas Consumer<FavoritModel>
    await tester.tap(find.byIcon(Icons.person_outline));
    await tester.pumpAndSettle();

    // Verifikasi halaman Warga memuat identitas dan layanan favorit yang baru ditandai
    expect(find.text('Profil & Laporan Warga'), findsOneWidget);
    expect(find.text('Ghazy Nabil Alghfari'), findsOneWidget);
    expect(find.text('Layanan Favorit Warga'), findsOneWidget);
    expect(find.text('Persetujuan Bangunan Gedung (PBG / IMB)'), findsOneWidget);
  });
}
