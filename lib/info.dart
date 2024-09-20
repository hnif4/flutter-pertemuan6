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
                  return Card(
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
                            item['isi_info'], // Content from the JSON
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
                  );
                },
              ),
      ),
    );
  }
}
 