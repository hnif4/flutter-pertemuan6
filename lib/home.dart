import 'package:flutter/material.dart';
import 'welcome.dart'; // Import WelcomeScreen untuk navigasi

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SMKN 4 KOTA BOGOR'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Selamat Datang!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Kami siap membantu Anda menemukan informasi terkini tentang SMKN 4 Kota Bogor.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            Expanded(
              child: ListView(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WelcomeScreen(initialIndex: 1), // Arahkan ke tab Informasi
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85, // Sesuaikan lebar
                      margin: EdgeInsets.only(bottom: 8), // Kurangi jarak antar card
                      child: Card(
                        color: Color.fromARGB(255, 189, 196, 204),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.info, size: 40),
                              SizedBox(width: 16),
                              Text(
                                'Informasi',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WelcomeScreen(initialIndex: 2), // Arahkan ke tab Agenda
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85, // Sesuaikan lebar
                      margin: EdgeInsets.only(bottom: 8), // Kurangi jarak antar card
                      child: Card(
                        color: Color.fromARGB(255, 189, 196, 204),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.calendar_today, size: 40),
                              SizedBox(width: 16),
                              Text(
                                'Agenda',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WelcomeScreen(initialIndex: 3), // Arahkan ke tab Galeri
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85, // Sesuaikan lebar
                      margin: EdgeInsets.only(bottom: 8), // Kurangi jarak antar card
                      child: Card(
                        color: Color.fromARGB(255, 189, 196, 204),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.photo, size: 40),
                              SizedBox(width: 16),
                              Text(
                                'Galeri',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
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
