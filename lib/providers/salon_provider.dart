import 'package:flutter/material.dart';
import '../models/spor_model.dart';

class SalonProvider with ChangeNotifier {
  // Tasarımdaki verilerin aynısı
  final List<Spor> _sporlar = [
    Spor(
      id: '1',
      baslik: 'Yoga ve Esneklik',
      altBaslik: 'Egzersizler',
      ikon: Icons.self_improvement,
    ),
    Spor(
      id: '2',
      baslik: 'Kuvvet & Egzersiz',
      altBaslik: 'Egzersizler',
      ikon: Icons.fitness_center,
    ),
    Spor(
      id: '3',
      baslik: 'Koşu ve Kardiyo',
      altBaslik: 'Egzersizler',
      ikon: Icons.directions_run,
    ),
    Spor(
      id: '4',
      baslik: 'Savunma Sporları',
      altBaslik: 'Egzersizler',
      ikon: Icons.sports_mma,
    ),
  ];

  List<Spor> get sporlar => _sporlar;

  // "Başla" butonuna basınca çalışacak fonksiyon
  void sporaBasla(String id) {
    // Burada ileride veritabanı işlemi yapılabilir
    print("$id id'li spora başlandı.");
    notifyListeners();
  }
}