import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'schedule_screen.dart';
import 'profile_screen.dart';
import 'BookingScreen.dart';
import 'DoctorDetailScreen.dart';

class HomeScreen extends StatefulWidget {
  final String userName;

  HomeScreen({required this.userName});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();

  List<Widget> _buildScreens() {
    return [
      HomePage(userName: widget.userName, scrollController: _scrollController),
      ScheduleScreen(),
      ProfileScreen(userName: widget.userName),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildScreens()[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Schedule'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
floatingActionButton: _selectedIndex == 1 // FAB hanya muncul di halaman Schedule
          ? FloatingActionButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookingScreen()),
              ),
              backgroundColor: Colors.brown[100],
              child: Icon(Icons.edit_calendar_outlined, size: 28),
              tooltip: 'Book Now',
            )
          : null, // FAB tidak ditampilkan di halaman lain
    );
  }
}

class HomePage extends StatefulWidget {
  final String userName;
  final ScrollController scrollController;

  HomePage({required this.userName, required this.scrollController});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> services = [
    {'title': 'Pembersihan Gigi', 'description': 'Membersihkan gigi secara menyeluruh.', 'image': 'assets/images/cleaning.jpg'},
    {'title': 'Pengobatan Penyakit Gusi', 'description': 'Mengatasi masalah gusi Anda.', 'image': 'assets/images/gusi.jpg'},
    {'title': 'Perawatan Gigi Berlubang', 'description': 'Mengobati gigi berlubang agar tetap sehat.', 'image': 'assets/images/berlubang.jpg'},
    {'title': 'Penempelan Mahkota', 'description': 'Menempelkan mahkota.', 'image': 'assets/images/mahkota.jpg'},
    {'title': 'Pemasangan Behel', 'description': 'Memperbaiki susunan gigi Anda.', 'image': 'assets/images/nbehel.jpg'},
    {'title': 'Root Canal', 'description': 'Menyelamatkan gigi rusak dan terinfeksi gigi Anda.', 'image': 'assets/images/root.JPG'},
    {'title': 'Veener', 'description': 'Memperbaiki permukaan gigi Anda.', 'image': 'assets/images/veener.JPG'},
    {'title': 'Penambalan Gigi', 'description': 'Menambal gigi Anda.', 'image': 'assets/images/tambal.JPG'},
    {'title': 'Cabut Gigi', 'description': 'Mengeluarkan gigi rusak Anda.', 'image': 'assets/images/cabut.JPG'},
  ];

  final List<Map<String, String>> doctors = [
    {'name': 'Amelia', 'specialty': 'Spesialis Ortodonti', 'photo': 'assets/images/dokter.jpg'},
    {'name': 'Bayu', 'specialty': 'Spesialis Periodonti', 'photo': 'assets/images/dokter.jpg'},
    {'name': 'Clara', 'specialty': 'Spesialis Prostodonti', 'photo': 'assets/images/dokter.jpg'},
  ];

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Miso Dental Care",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.brown[100],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.brown[100]!, Colors.brown[300]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello, ${widget.userName}",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Welcome to Miso Dental Care! Your trusted dental clinic for premium care.",
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Services Section
            Text(
              "Our Services",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              height: 250, // Adjusted height for better view
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
                    itemCount: services.length,
                    itemBuilder: (context, index) {
                      final service = services[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0), // Adjusted margin for spacing between cards
                        child: Container(
                          width: double.infinity, // Ensuring the container uses full width
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Gambar dengan lebar penuh
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                                  child: Image.asset(
                                    service['image'],
                                    height: 160,
                                    width: double.infinity, // Ensure image uses full width
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    service['title'],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    service['description'],
                                    style: TextStyle(fontSize: 14, color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    top: 250,
                    bottom: 0, // Adjusted bottom space for page indicator
                    left: 0,
                    right: 0,
                    child: Center(
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: services.length,
                        effect: WormEffect(
                          dotWidth: 10.0,
                          dotHeight: 10.0,
                          spacing: 10.0,
                          dotColor: Colors.grey.withOpacity(0.6),
                          activeDotColor: Colors.brown,
                        ),
                      ),
                    ),
                  ),
                  // Left Arrow Button
                  Positioned(
                    left: 5,
                    top: 100,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios,size: 30, color: Colors.brown[900]),
                      onPressed: () {
                        _pageController.previousPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                    ),
                  ),
                  // Right Arrow Button
                  Positioned(
                    right: 10,
                    top: 100,
                    child: IconButton(
                      icon: Icon(Icons.arrow_forward_ios,size: 30, color: Colors.brown[900]),
                      onPressed: () {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Doctors Section
            SizedBox(height: 20),
            Text(
              "Our Doctors",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                final doctor = doctors[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(doctor['photo']!),
                    ),
                    title: Text(doctor['name']!),
                    subtitle: Text(doctor['specialty']!),
                    trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DoctorDetailScreen(doctor: doctor),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text("More", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                "© 2024 Miso Dental Care. All Rights Reserved.",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
