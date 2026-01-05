import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'providers/salon_provider.dart';
import 'screens/tab_ekrani.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print("Firebase henüz aktif değil, sorun yok.");
  }

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => SalonProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SALON App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF009688)),
        scaffoldBackgroundColor: const Color(0xFFF0F4F4),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          elevation: 2,
        ),
      ),
      home: TabEkrani(),
    );
  }
}
