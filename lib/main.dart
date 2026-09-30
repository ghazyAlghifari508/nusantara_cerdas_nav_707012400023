import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/favorit_model.dart';
import 'models/pengajuan_model.dart';
import 'navigation/app_routes.dart';

/// Titik masuk utama aplikasi Nusantara Cerdas Mobile
void main() {
  runApp(const AplikasiNusantaraCerdas());
}

/// Root widget aplikasi Nusantara Cerdas
/// Memasang FavoritModel dan PengajuanModel melalui MultiProvider di akar aplikasi,
/// persis di atas MaterialApp sehingga seluruh widget turunan dan modal route
/// dapat mengakses state aplikasi tanpa risiko ProviderNotFoundException.
class AplikasiNusantaraCerdas extends StatelessWidget {
  const AplikasiNusantaraCerdas({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritModel()),
        ChangeNotifierProvider(create: (_) => PengajuanModel()),
      ],
      child: MaterialApp(
        title: 'Nusantara Cerdas Mobile',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: Colors.teal,
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFFF8F9FA),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.teal.shade700,
            foregroundColor: Colors.white,
            elevation: 2,
          ),
        ),
        initialRoute: AppRoutes.beranda,
        routes: AppRoutes.daftarRoute(),
        onGenerateRoute: AppRoutes.bentukRoute,
        onUnknownRoute: AppRoutes.routeTidakDikenal,
      ),
    );
  }
}
