import 'package:flutter/material.dart';
import 'dart:convert'; // For decoding JSON data
import 'package:http/http.dart' as http;

class AgendaScreen extends StatefulWidget {
  @override
  _AgendaScreenState createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  List<dynamic> agendaData = [];

  @override
  void initState() {
    super.initState();
    fetchAgendaData();
  }

  // Function to fetch data from the API
  Future<void> fetchAgendaData() async {
    final response = await http.get(Uri.parse('https://ujikom2024pplg.smkn4bogor.sch.id/0078728255/agenda.php'));

    if (response.statusCode == 200) {
      setState(() {
        agendaData = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load agenda');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agenda'),
        backgroundColor: const Color.fromARGB(255, 221, 215, 215), // navbar warna
      ),
      body: Container(
       color: Color.fromARGB(255, 107, 168, 247), // Latar belakang biru
        child: agendaData.isEmpty
            ? Center(child: CircularProgressIndicator()) // Loading indicator while fetching data
            : ListView.builder(
                itemCount: agendaData.length,
                itemBuilder: (context, index) {
                  final item = agendaData[index];
                  return Card(
                    margin: EdgeInsets.all(8.0),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['judul_agenda'], // Title from the JSON
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87, // Warna teks judul
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            item['isi_agenda'], // Content from the JSON
                            style: TextStyle(fontSize: 16, color: Colors.black54),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Tanggal: ${item['tgl_agenda']}', // Date from the JSON
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
