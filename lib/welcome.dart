import 'package:flutter/material.dart';
import 'home.dart';
import 'info.dart';
import 'agenda.dart';
import 'galery.dart';
import 'login.dart'; // Import LoginScreen untuk logout

class WelcomeScreen extends StatefulWidget {
  final int initialIndex;

  WelcomeScreen({this.initialIndex = 0});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  final List<Widget> _pages = [
    HomeScreen(),
    InfoScreen(),
    AgendaScreen(),
    GaleryScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Fungsi untuk logout dan kembali ke halaman Login
  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex != 0) {
          setState(() {
            _selectedIndex = 0; // Kembali ke tab Home jika bukan di Home
          });
          return false; // Tidak keluar dari aplikasi
        } else {
          return true; // Jika sudah di Home, keluar dari aplikasi
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: _selectedIndex == 0
              ? null // Tidak ada tombol back di halaman Home
              : IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 0; // Kembali ke Home
                    });
                  },
                ),
          title: Text(
            'Student App',
            style: TextStyle(
              color: Color.fromRGBO(246, 246, 248, 1),
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 107, 168, 247),
          elevation: 4,
          shadowColor: Colors.black.withOpacity(0.5),
          actions: _selectedIndex == 0
              ? [
                  IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: _logout,
                    tooltip: 'Logout',
                  ),
                ]
              : null, // Hanya tampilkan tombol logout di Home
        ),
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'Info',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Agenda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.photo),
              label: 'Galeri',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Color.fromARGB(255, 24, 23, 23),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
