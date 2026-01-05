import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/salon_provider.dart';
import 'egzersiz_detay.dart';
import 'ayarlar_sayfasi.dart';

class TabEkrani extends StatefulWidget {
  const TabEkrani({super.key});

  @override
  State<TabEkrani> createState() => _TabEkraniState();
}

class _TabEkraniState extends State<TabEkrani> {
  int _seciliSayfaIndex = 0;

  final List<Widget> _sayfalar = [
    const AnaSayfaIcerik(), // Burası artık Akıllı Asistanlı!
    const KesfetSayfasi(),
    const GelisimSayfasi(),
    const ProfilSayfasi(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Ana sayfadaysak başlığı gizle (Çünkü özel tasarım yaptık), diğerlerinde göster
        title: _seciliSayfaIndex == 0
            ? null
            : Text(
                _seciliSayfaIndex == 1
                    ? "KEŞFET"
                    : _seciliSayfaIndex == 2
                    ? "GELİŞİM"
                    : "PROFİL",
              ),
        // Ana sayfadaysak AppBar rengini transparan yap, diğerlerinde teal
        backgroundColor: _seciliSayfaIndex == 0
            ? const Color(0xFF009688)
            : null,
        elevation: _seciliSayfaIndex == 0 ? 0 : 4,
      ),
      body: _sayfalar[_seciliSayfaIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _seciliSayfaIndex,
        onTap: (index) {
          setState(() {
            _seciliSayfaIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF009688),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Ana Sayfa"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Keşfet"),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Gelişim",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
    );
  }
}

// ==========================================
// 1. ANA SAYFA (AKILLI ASİSTANLI HALİ)
// ==========================================
class AnaSayfaIcerik extends StatelessWidget {
  const AnaSayfaIcerik({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SalonProvider>(context);
    final liste = provider.egzersizler;

    // --- SAAT KONTROLÜ ---
    var saat = DateTime.now().hour;
    String mesaj = "";
    if (saat < 6) {
      mesaj = "İyi Geceler, Yiğit! 😴";
    } else if (saat < 12) {
      mesaj = "Günaydın, Yiğit! ☀️";
    } else if (saat < 18) {
      mesaj = "İyi Günler, Yiğit! 👋";
    } else {
      mesaj = "İyi Akşamlar, Yiğit! 🌙";
    }
    // ---------------------

    return Column(
      children: [
        // ÜST BİLGİ KUTUSU (HEADER)
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 25),
          decoration: const BoxDecoration(
            color: Color(0xFF009688), // AppBar ile bütünleşik dursun diye
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                mesaj,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "Bugün antrenman için harika bir zaman!",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ),

        // LİSTE KISMI
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: liste.length,
            itemBuilder: (context, index) {
              final egzersiz = liste[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              egzersiz.isim,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              egzersiz.altBaslik,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        Icon(egzersiz.ikon, size: 40, color: egzersiz.renk),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EgzersizDetaySayfasi(egzersiz: egzersiz),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF009688),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text("BAŞLA"),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ==========================================
// 2. KEŞFET SAYFASI
// ==========================================
class KesfetSayfasi extends StatelessWidget {
  const KesfetSayfasi({super.key});

  void _kategoriyeGit(BuildContext context, String aramaKelimesi) {
    final provider = Provider.of<SalonProvider>(context, listen: false);
    try {
      final bulunanEgzersiz = provider.egzersizler.firstWhere(
        (egzersiz) =>
            egzersiz.isim.toLowerCase().contains(aramaKelimesi.toLowerCase()),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EgzersizDetaySayfasi(egzersiz: bulunanEgzersiz),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("$aramaKelimesi kategorisi henüz eklenmedi.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Egzersiz veya eğitmen ara...",
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Popüler Kategoriler",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.5,
              children: [
                _buildKategoriKart(
                  context,
                  "Yoga",
                  "Yoga",
                  Colors.purple.shade100,
                  Icons.self_improvement,
                ),
                _buildKategoriKart(
                  context,
                  "Pilates",
                  "Pilates",
                  Colors.pink.shade100,
                  Icons.accessibility_new,
                ),
                _buildKategoriKart(
                  context,
                  "HIIT",
                  "HIIT",
                  Colors.orange.shade100,
                  Icons.timer,
                ),
                _buildKategoriKart(
                  context,
                  "Beslenme",
                  "Beslenme",
                  Colors.green.shade100,
                  Icons.restaurant,
                ),
                _buildKategoriKart(
                  context,
                  "Koşu",
                  "Kardiyo",
                  Colors.red.shade100,
                  Icons.directions_run,
                ),
                _buildKategoriKart(
                  context,
                  "Kuvvet",
                  "Güç",
                  Colors.blue.shade100,
                  Icons.fitness_center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKategoriKart(
    BuildContext context,
    String aramaKelimesi,
    String gorunenIsim,
    Color renk,
    IconData ikon,
  ) {
    return GestureDetector(
      onTap: () => _kategoriyeGit(context, aramaKelimesi),
      child: Container(
        decoration: BoxDecoration(
          color: renk,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(ikon, size: 40, color: Colors.black54),
            const SizedBox(height: 8),
            Text(
              gorunenIsim,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 3. GELİŞİM SAYFASI (YENİ VE HAREKETLİ!)
// ==========================================
class GelisimSayfasi extends StatefulWidget {
  const GelisimSayfasi({super.key});

  @override
  State<GelisimSayfasi> createState() => _GelisimSayfasiState();
}

class _GelisimSayfasiState extends State<GelisimSayfasi> {
  bool _haftalik = true; // false ise Aylık görünüm

  @override
  Widget build(BuildContext context) {
    // Seçime göre verileri değiştiriyoruz
    final antrenmanSayisi = _haftalik ? "12" : "48";
    final kalori = _haftalik ? "4.500" : "19.200";
    final saat = _haftalik ? "8.5" : "36.0";

    final progress1 = _haftalik ? 0.7 : 0.95;
    final progress2 = _haftalik ? 0.4 : 0.85;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // HAFTALIK - AYLIK SEÇİM KUTUSU
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              children: [
                _buildToggleOption("Haftalık", _haftalik),
                _buildToggleOption("Aylık", !_haftalik),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // BÜYÜK İSTATİSTİK KARTI
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF009688), Color(0xFF4DB6AC)],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.teal.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(antrenmanSayisi, "Antrenman"),
                _buildStatItem(kalori, "Kalori"),
                _buildStatItem(saat, "Saat"),
              ],
            ),
          ),

          const SizedBox(height: 25),

          // İLERLEME ÇUBUKLARI
          _buildProgressRow("Hedef Tamamlama", progress1, Colors.blue),
          _buildProgressRow("Kardiyo Dayanıklılığı", progress2, Colors.orange),
          _buildProgressRow("Esneklik Seviyesi", 0.9, Colors.purple),

          const SizedBox(height: 25),

          // SON AKTİVİTELER LİSTESİ
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Son Aktiviteler",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),

          _buildGecmisAktivite(
            "Bugün",
            "Yoga ve Esneklik",
            "20 dk",
            Icons.self_improvement,
            Colors.purple,
          ),
          _buildGecmisAktivite(
            "Dün",
            "Koşu ve Kardiyo",
            "35 dk",
            Icons.directions_run,
            Colors.red,
          ),
          _buildGecmisAktivite(
            "Pazartesi",
            "Kuvvet & Antrenman",
            "50 dk",
            Icons.fitness_center,
            Colors.orange,
          ),
        ],
      ),
    );
  }

  // Toggle Butonu Yardımcısı
  Widget _buildToggleOption(String text, bool isSelected) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _haftalik = text == "Haftalık"),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF009688) : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // İstatistik Yardımcısı
  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(label, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }

  // İlerleme Çubuğu Yardımcısı
  Widget _buildProgressRow(String baslik, double deger, Color renk) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(baslik), Text("%${(deger * 100).toInt()}")],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: deger,
            backgroundColor: Colors.grey.shade200,
            color: renk,
            minHeight: 10,
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }

  // Liste Elemanı Yardımcısı
  Widget _buildGecmisAktivite(
    String tarih,
    String baslik,
    String sure,
    IconData ikon,
    Color renk,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: renk.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(ikon, color: renk),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  baslik,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  tarih,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            sure,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 4. PROFİL SAYFASI
// ==========================================
class ProfilSayfasi extends StatelessWidget {
  const ProfilSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const CircleAvatar(
          radius: 50,
          backgroundColor: Color(0xFF009688),
          child: Icon(Icons.person, size: 60, color: Colors.white),
        ),
        const SizedBox(height: 10),
        const Text(
          "Yiğit Derin",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const Text("Gazi Üniversitesi", style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.amber.shade100,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            "PRO ÜYELİK",
            style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 30),
        Expanded(
          child: ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text("Hesap Ayarları"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AyarlarSayfasi(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.notifications),
                title: const Text("Bildirimler"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Bildirimleriniz güncel.")),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.privacy_tip),
                title: const Text("Gizlilik"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Gizlilik politikası son sürüm."),
                    ),
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text(
                  "Çıkış Yap",
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Çıkış Yap"),
                        content: const Text(
                          "Uygulamadan çıkmak istediğine emin misin?",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("İptal"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Çıkış yapıldı!")),
                              );
                            },
                            child: const Text(
                              "Evet, Çık",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
