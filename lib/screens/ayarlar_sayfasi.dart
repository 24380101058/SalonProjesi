import 'package:flutter/material.dart';

class AyarlarSayfasi extends StatefulWidget {
  const AyarlarSayfasi({super.key});

  @override
  State<AyarlarSayfasi> createState() => _AyarlarSayfasiState();
}

class _AyarlarSayfasiState extends State<AyarlarSayfasi> {
  bool _bildirimlerAcik = true;
  bool _karanlikMod = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F4),
      appBar: AppBar(
        title: const Text("Hesap Ayarları"),
        backgroundColor: const Color(0xFF009688),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Kişisel Bilgiler",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 10),

            // İSİM ALANI
            _buildTextField("Ad Soyad", "Yiğit Derin"),
            const SizedBox(height: 15),

            // E-POSTA ALANI
            _buildTextField("E-Posta", "yigit@gazi.edu.tr"),
            const SizedBox(height: 15),

            // TELEFON ALANI
            _buildTextField("Telefon", "+90 555 123 45 67"),

            const SizedBox(height: 30),
            const Text(
              "Uygulama Tercihleri",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 10),

            // AYARLAR KUTUSU
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
              ),
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text("Bildirimleri Al"),
                    subtitle: const Text("Kampanyalar ve hatırlatıcılar"),
                    value: _bildirimlerAcik,
                    activeColor: Colors.teal,
                    onChanged: (val) {
                      setState(() {
                        _bildirimlerAcik = val;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            val
                                ? "Bildirimler Açıldı"
                                : "Bildirimler Kapatıldı",
                          ),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    title: const Text("Karanlık Mod"),
                    subtitle: const Text("Göz yormayan tema"),
                    value: _karanlikMod,
                    activeColor: Colors.teal,
                    onChanged: (val) {
                      setState(() {
                        _karanlikMod = val;
                      });
                      // Gerçekte temayı değiştirmese bile kullanıcıya tepki veriyoruz
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Tema ayarı kaydedildi (Demo)"),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // KAYDET BUTONU
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Yalandan bir yükleniyor efekti verelim
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Row(
                        children: [
                          CircularProgressIndicator(color: Colors.white),
                          SizedBox(width: 20),
                          Text("Değişiklikler Kaydediliyor..."),
                        ],
                      ),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF009688),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "KAYDET",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Text Kutusu Tasarımı (Helper Widget)
  Widget _buildTextField(String label, String placeholder) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [const BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          hintText: placeholder,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          prefixIcon: const Icon(Icons.edit, color: Colors.grey),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }
}
