import 'package:flutter/material.dart';
import 'dart:convert'; // Untuk decoding data JSON
import 'package:http/http.dart' as http;

class GaleryScreen extends StatefulWidget {
  @override
  _GaleryScreenState createState() => _GaleryScreenState();
}

class _GaleryScreenState extends State<GaleryScreen> {
  List<dynamic> galeryData = [];

  @override
  void initState() {
    super.initState();
    fetchGaleryData();
  }

  // Fungsi untuk mengambil data dari API
  Future<void> fetchGaleryData() async {
    final response = await http.get(Uri.parse('https://ujikom2024pplg.smkn4bogor.sch.id/0078728255/galery.php'));

    if (response.statusCode == 200) {
      setState(() {
        galeryData = json.decode(response.body);
      });
    } else {
      throw Exception('Gagal mengambil data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Galery'),
        backgroundColor: Color.fromARGB(255, 221, 215, 215), // Mengubah navbar menjadi hitam
      ),
      body: Container(
        color: Color.fromARGB(255, 143, 178, 223), // Latar belakang biru
        padding: const EdgeInsets.all(8.0),
        child: galeryData.isEmpty
            ? Center(child: CircularProgressIndicator()) // Menampilkan loading saat data belum diambil
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Menentukan jumlah kolom dalam grid
                  crossAxisSpacing: 10, // Jarak horizontal antara item
                  mainAxisSpacing: 10, // Jarak vertikal antara item
                  childAspectRatio: 0.8, // Menentukan rasio tinggi-lebar item grid
                ),
                itemCount: galeryData.length,
                itemBuilder: (context, index) {
                  final item = galeryData[index];
                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Image.network(
                            item['isi_galery'], // Menggunakan key 'isi_galery' untuk gambar
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            item['judul_galery'], // Menggunakan key 'judul_galery' untuk judul
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
