import 'package:flutter/material.dart';
import 'dart:convert'; // For decoding JSON data
import 'package:http/http.dart' as http;

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  List<dynamic> infoData = [];

  @override
  void initState() {
    super.initState();
    fetchInfoData();
  }

  // Function to fetch data from the API
  Future<void> fetchInfoData() async {
    final response = await http.get(Uri.parse('https://ujikom2024pplg.smkn4bogor.sch.id/0078728255/informasi.php'));

    if (response.statusCode == 200) {
      setState(() {
        infoData = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load information');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( 
          'Informasi',
          style: TextStyle(color: Colors.black87), // Warna teks judul
        ),
        backgroundColor: const Color.fromARGB(255, 221, 215, 215), // Warna latar belakang AppBar
      ),
      body: Container(
        color: Color.fromARGB(255, 107, 168, 247), // Latar belakang biru
        child: infoData.isEmpty
            ? Center(child: CircularProgressIndicator()) // Loading indicator while fetching data
            : ListView.builder(
                itemCount: infoData.length,
                itemBuilder: (context, index) {
                  final item = infoData[index];
                  
                  // Get preview of 'isi_info' (first 50 characters)
                  String preview = item['isi_info'].length > 50 
                    ? item['isi_info'].substring(0, 50) + '...' 
                    : item['isi_info'];

                  return GestureDetector(
                    onTap: () {
                      // Navigate to detail screen when tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InfoDetailScreen(
                            judul: item['judul_info'],
                            isi: item['isi_info'],
                            tanggal: item['tgl_post_info'],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      margin: EdgeInsets.all(8.0),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['judul_info'], // Title from the JSON
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87, // Warna teks judul
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              preview, // Preview content (first 50 characters)
                              style: TextStyle(fontSize: 16, color: Colors.black54),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Tanggal: ${item['tgl_post_info']}', // Date from the JSON
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

// Detail screen to show full information
class InfoDetailScreen extends StatelessWidget {
  final String judul;
  final String isi;
  final String tanggal;

  InfoDetailScreen({required this.judul, required this.isi, required this.tanggal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informasi'),
        backgroundColor: Color.fromARGB(255, 107, 168, 247), // Warna latar belakang AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              judul,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Tanggal: $tanggal',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16),
            Text(
              isi,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
