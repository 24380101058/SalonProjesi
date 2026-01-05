import 'package:flutter/material.dart';
import 'dart:async'; // Sayaç için gerekli
import '../providers/salon_provider.dart';

class EgzersizDetaySayfasi extends StatefulWidget {
  final Egzersiz egzersiz;

  const EgzersizDetaySayfasi({super.key, required this.egzersiz});

  @override
  State<EgzersizDetaySayfasi> createState() => _EgzersizDetaySayfasiState();
}

class _EgzersizDetaySayfasiState extends State<EgzersizDetaySayfasi> {
  int _saniye = 0;
  Timer? _timer;
  bool _basladiMi = false;

  // Sayacı Başlat/Durdur Fonksiyonu
  void _zamanlayiciyiYonet() {
    if (_basladiMi) {
      _timer?.cancel();
    } else {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _saniye++;
        });
      });
    }
    setState(() {
      _basladiMi = !_basladiMi;
    });
  }

  // Saniyeyi Dakika:Saniye formatına çevirir (Örn: 02:15)
  String _sureFormatla(int saniye) {
    int dk = saniye ~/ 60;
    int sn = saniye % 60;
    return "${dk.toString().padLeft(2, '0')}:${sn.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    _timer?.cancel(); // Sayfadan çıkınca sayacı öldür
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.egzersiz.isim),
        backgroundColor: widget.egzersiz.renk,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Üst Görsel Alanı (İkon)
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: widget.egzersiz.renk.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Center(
                child: Icon(
                  widget.egzersiz.ikon,
                  size: 100,
                  color: widget.egzersiz.renk,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Başlık ve Açıklama
                  Text(
                    "Antrenman Detayları",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.egzersiz.aciklama,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // SAYAÇ KUTUSU (En havalı kısım)
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "GEÇEN SÜRE",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              _sureFormatla(_saniye),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ],
                        ),
                        FloatingActionButton(
                          onPressed: _zamanlayiciyiYonet,
                          backgroundColor: _basladiMi
                              ? Colors.red
                              : Colors.green,
                          child: Icon(
                            _basladiMi ? Icons.pause : Icons.play_arrow,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),
                  Text(
                    "Yapılacaklar Listesi",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 10),

                  // ADIMLAR LİSTESİ (Checkbox'lı)
                  ...widget.egzersiz.adimlar
                      .map(
                        (adim) => CheckboxListTile(
                          value: false,
                          title: Text(adim),
                          activeColor: widget.egzersiz.renk,
                          onChanged:
                              (
                                val,
                              ) {}, // Şimdilik sadece görsel, tıklanabilir ama kaydetmez
                        ),
                      )
                      .toList(),

                  const SizedBox(height: 30),

                  // Bitir Butonu
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Geri dön
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Tebrikler! Antrenmanı tamamladın."),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.egzersiz.renk,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "ANTRENMANI BİTİR",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
