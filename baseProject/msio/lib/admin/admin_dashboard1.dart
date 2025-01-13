import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msio/screens/UserProvider.dart';
import 'package:provider/provider.dart';
import '../models/appointment_provider.dart';
import 'admin_profile.dart';
import 'adminAppointment.dart';

class AdminDashboard1 extends StatefulWidget {
  @override
  _AdminDashboard1State createState() => _AdminDashboard1State();
}

class _AdminDashboard1State extends State<AdminDashboard1> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    AdminAppointmentPage(),
    AdminProfile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 30),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white, // Darker shade for more elegance
      ),
    );
  }
}

class AdminAppointmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final namaPasien = Provider.of<UserProvider>(context).namaPasien;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Appointments',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.brown[100], // Tetap warna tema yang sama
        elevation: 4, // Memberikan sedikit bayangan agar lebih jelas
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<AppointmentProvider>(
          builder: (context, provider, child) {
            if (provider.appointments.isEmpty) {
              return Center(
                child: Text(
                  'No appointments available.',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              );
            }

            return ListView.builder(
              itemCount: provider.appointments.length,
              itemBuilder: (context, index) {
                final appointment = provider.appointments[index];

                // Format date and time
                final dynamic date = appointment['date'];
                final formattedDate = (date is DateTime)
                    ? DateFormat("dd MMMM yyyy").format(date)
                    : DateTime.tryParse(date.toString()) != null
                        ? DateFormat("dd MMMM yyyy").format(DateTime.parse(date.toString()))
                        : 'Unknown Date';

                final String time = appointment['time'] ?? 'Unknown Time';
                final formattedTime = time.isNotEmpty ? time : "Unknown Time";
                final String patientName = namaPasien;
                final String doctor = appointment['doctor'] ?? 'Unknown';
                final String service = appointment['service'] ?? 'N/A';
                final String status = appointment['status'] ?? 'Pending';

                // Menambahkan warna berbeda untuk status
                Color? statusColor;
                if (status == 'Disetujui') {
                  statusColor = Colors.green[400]; // Lebih soft dari sebelumnya
                } else if (status == 'Menunggu Persetujuan') {
                  statusColor = Colors.orange[400]; // Warna yang lebih lembut
                } else {
                  statusColor = Colors.red[400]; // Soft red
                }

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminAppointmentDetailScreen(
                          dname: doctor,
                          date: formattedDate,
                          service: service,
                          status: status,
                          time: formattedTime,
                          patientName: patientName,
                          appointmentIndex: index,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0), // Sudut sedikit lebih bulat
                    ),
                    elevation: 5,
                    shadowColor: Colors.grey[400], // Bayangan yang lebih soft
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.0),
                        color: Colors.white, // Latar belakang putih untuk kontras
                        border: Border.all(
                          color: Colors.grey[200]!, // Border lebih ringan dan lebih halus
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.calendar_today, color: Colors.brown[300]), // Ikon tetap sama
                              SizedBox(width: 8),
                              Text(
                                formattedDate,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.access_time, color: Colors.grey[600]),
                              SizedBox(width: 8),
                              Text(
                                formattedTime,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.person, color: Colors.brown[300]),
                              SizedBox(width: 8),
                              Text(
                                'Doctor: $doctor',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          Divider(height: 20, color: Colors.grey[400]),
                          Text(
                            'Patient: $patientName',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Service: $service',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 6),
                          Row(
                            children: [
                              Text(
                                'Status: ',
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                status,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: statusColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

