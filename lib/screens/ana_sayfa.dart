import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/salon_provider.dart';
import '../widgets/spor_karti.dart';

class AnaSayfa extends StatelessWidget {
  const AnaSayfa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Provider'dan verileri çekiyoruz
    final sporlar = context.watch<SalonProvider>().sporlar;

    return Scaffold(
      backgroundColor: Colors.white, // Arka plan
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: Color(0xFF00C9B7), // Logo rengi
                shape: BoxShape.circle,
              ),
              child: const Text("S", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 10),
            const Text(
              'SALON',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.grey, size: 30),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: sporlar.length,
        itemBuilder: (context, index) {
          return SporKarti(spor: sporlar[index]);
        },
      ),
    );
  }
}