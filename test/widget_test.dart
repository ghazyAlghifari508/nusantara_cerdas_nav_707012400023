import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nusantara_cerdas_nav_707012400023/cubit/favorit_cubit.dart';
import 'package:nusantara_cerdas_nav_707012400023/cubit/pengajuan_cubit.dart';
import 'package:nusantara_cerdas_nav_707012400023/main.dart';

void main() {
  test('FavoritCubit unit test - tandai dan batalTandai', () {
    final cubit = FavoritCubit();
    expect(cubit.state.isEmpty, true);

    cubit.tandai('PBG');
    expect(cubit.state.contains('PBG'), true);
    expect(cubit.state.length, 1);

    cubit.batalTandai('PBG');
    expect(cubit.state.contains('PBG'), false);
    expect(cubit.state.isEmpty, true);
  });

  test('PengajuanCubit unit test - tambah, total, dan kosongkan', () {
    final cubit = PengajuanCubit();
    expect(cubit.state.totalPengajuan, 0);

    cubit.tambahPengajuan(namaLayanan: 'PBG', dinas: 'PUPR');
    expect(cubit.state.totalPengajuan, 1);
    expect(cubit.state.items.first.namaLayanan, 'PBG');

    cubit.tambahPengajuan(namaLayanan: 'Telemedisin', dinas: 'Dinkes');
    expect(cubit.state.totalPengajuan, 2);

    cubit.hapusPengajuan(0);
    expect(cubit.state.totalPengajuan, 1);
    expect(cubit.state.items.first.namaLayanan, 'Telemedisin');

    cubit.kosongkan();
    expect(cubit.state.totalPengajuan, 0);
  });

  testWidgets('Pengujian alur navigasi & state management Nusantara Cerdas Mobile', (
    WidgetTester tester,
  ) async {
    // Ukuran layar mobile (< 600 px)
    tester.view.physicalSize = const Size(1080, 2280);
    tester.view.devicePixelRatio = 2.75;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<FavoritCubit>(create: (_) => FavoritCubit()),
          BlocProvider<PengajuanCubit>(create: (_) => PengajuanCubit()),
        ],
        child: const AplikasiNusantaraCerdas(),
      ),
    );
    await tester.pumpAndSettle();

    // Verifikasi berada di halaman Beranda
    expect(find.text('Beranda Smart City'), findsOneWidget);

    // Pindah ke Layanan
    await tester.tap(find.byIcon(Icons.grid_view_outlined));
    await tester.pumpAndSettle();
    expect(find.text('Katalog Layanan Publik'), findsOneWidget);

    // Tandai layanan pertama sebagai favorit
    final starButtons = find.byTooltip('Tandai favorit');
    expect(starButtons, findsWidgets);
    await tester.tap(starButtons.first);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    // Pindah ke Warga
    await tester.tap(find.byIcon(Icons.person_outline));
    await tester.pumpAndSettle();

    // Verifikasi identitas dan layanan favorit tampil di Warga
    expect(find.text('Profil & Laporan Warga'), findsOneWidget);
    expect(find.text('Ghazy Nabil Alghfari'), findsOneWidget);
    expect(find.text('1 Tersimpan'), findsOneWidget);
  });
}
