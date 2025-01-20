import 'package:flutter/material.dart';

class BuatJadwalPage extends StatelessWidget {
  const BuatJadwalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Buat Jadwal Perkuliahan',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Form untuk membuat jadwal bisa ditambahkan di sini
            Text('Form untuk membuat jadwal perkuliahan di sini'),
          ],
        ),
      ),
    );
  }
}
