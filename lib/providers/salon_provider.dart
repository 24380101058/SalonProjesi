import 'package:flutter/material.dart';

class Egzersiz {
  final String isim;
  final String altBaslik;
  final IconData ikon;
  final Color renk;
  final String aciklama;
  final List<String> adimlar;
  final int sureDakika;

  Egzersiz({
    required this.isim,
    required this.altBaslik,
    required this.ikon,
    required this.renk,
    required this.aciklama,
    required this.adimlar,
    required this.sureDakika,
  });
}

class SalonProvider with ChangeNotifier {
  final List<Egzersiz> _egzersizler = [
    // --- MEVCUT OLANLAR ---
    Egzersiz(
      isim: "Yoga ve Esneklik",
      altBaslik: "Zihin ve beden dengesi",
      ikon: Icons.self_improvement,
      renk: Colors.purple,
      sureDakika: 20,
      aciklama:
          "Güne başlarken veya gün sonunda rahatlamak için ideal bir akış.",
      adimlar: [
        "Matını ser.",
        "Bağdaş kur ve nefes al.",
        "Kedi-İnek pozu yap.",
        "Çocuk pozunda dinlen.",
      ],
    ),
    Egzersiz(
      isim: "Kuvvet & Antrenman",
      altBaslik: "Kas kütleni arttır",
      ikon: Icons.fitness_center,
      renk: Colors.orange,
      sureDakika: 45,
      aciklama: "Tüm vücudu çalıştıran temel kuvvet hareketleri.",
      adimlar: [
        "Isınma koşusu.",
        "3x12 Şınav.",
        "3x15 Squat.",
        "Plank beklemesi.",
      ],
    ),
    Egzersiz(
      isim: "Koşu ve Kardiyo",
      altBaslik: "Dayanıklılık egzersizleri",
      ikon: Icons.directions_run,
      renk: Colors.red,
      sureDakika: 30,
      aciklama: "Kalp ritmini hızlandır ve yağ yakımını başlat.",
      adimlar: ["5 dk yürüyüş.", "10 dk hafif koşu.", "2 dk depar.", "Soğuma."],
    ),
    Egzersiz(
      isim: "Savunma Sporları",
      altBaslik: "Teknik ve güç",
      ikon: Icons.sports_mma,
      renk: Colors.blue,
      sureDakika: 40,
      aciklama: "Temel savunma teknikleri.",
      adimlar: [
        "Gardını al.",
        "Gölge boksu yap.",
        "Kum torbası çalış.",
        "İp atla.",
      ],
    ),

    // --- YENİ EKLENENLER (KEŞFET İÇİN) ---
    Egzersiz(
      isim: "Pilates Başlangıç",
      altBaslik: "Omurga sağlığı",
      ikon: Icons.accessibility_new,
      renk: Colors.pink,
      sureDakika: 25,
      aciklama: "Vücut duruşunu düzeltmek ve sıkılaşmak için temel pilates.",
      adimlar: [
        "Sırt üstü yat.",
        "Köprü kurma hareketi (10 tekrar).",
        "Yüzme hareketi.",
        "Yana bacak açma.",
      ],
    ),
    Egzersiz(
      isim: "HIIT Kardiyo",
      altBaslik: "Hızlı yağ yakımı",
      ikon: Icons.timer,
      renk: Colors.amber, // Orange ile karışmasın diye amber yaptık
      sureDakika: 15,
      aciklama: "Kısa sürede yüksek kalori yaktıran yoğun antrenman.",
      adimlar: [
        "30 sn Jumping Jack.",
        "10 sn dinlen.",
        "30 sn Burpee.",
        "10 sn dinlen.",
        "30 sn Dağ Tırmanışı.",
      ],
    ),
    Egzersiz(
      isim: "Sağlıklı Beslenme",
      altBaslik: "Diyet programı",
      ikon: Icons.restaurant,
      renk: Colors.green,
      sureDakika: 5,
      aciklama: "Bugünkü öğün planın ve dikkat etmen gerekenler.",
      adimlar: [
        "Sabah: 2 Yumurta, Lor peyniri.",
        "Öğle: Izgara tavuk, bol salata.",
        "Ara: 1 elma, 5 badem.",
        "Akşam: Sebze yemeği, yoğurt.",
        "En az 2.5 litre su iç!",
      ],
    ),
  ];

  List<Egzersiz> get egzersizler => _egzersizler;
}
