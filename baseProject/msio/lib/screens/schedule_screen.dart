import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // Untuk format tanggal
import '../models/appointment_detail_screen.dart';
import '../models/appointment_provider.dart';
import 'UserProvider.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final List<Map<String, String>> appointments1 = [
    {
      'name': 'John Doe',
      'date': '2025-01-10',
      'time': '21:00',
      'status': 'Menunggu Persetujuan',
      'service': 'Pembersihan Gigi',
      'doctor': 'Dr. Amelia',
    },
    {
      'name': 'Jane Smith',
      'date': '2025-01-01',
      'time': '19:00',
      'status': 'Disetujui',
      'service': 'Pengobatan Gusi',
      'doctor': 'Dr. Bayu',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final appointments = Provider.of<AppointmentProvider>(context).appointments;
    final currentUser = Provider.of<UserProvider>(context).currentUser;
    final allAppointments = [...appointments1, ...appointments];

    return Scaffold(
      appBar: AppBar(
        title: Text("Schedule"),
        centerTitle: true,
        backgroundColor: Colors.brown[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              'Upcoming Appointments',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: allAppointments.length,
                itemBuilder: (context, index) {
                  final appointment = allAppointments[index];
                  final name = appointment['name'] ?? currentUser.username;
                  final service = appointment['service'] ?? 'Unknown';
                  final status = appointment['status'] ?? 'Unknown';
                  final date = appointment['date']; // could be String or DateTime
                  final time = appointment['time'] ?? 'Unknown';
                  final doctor = appointment['doctor'] ?? 'Unknown';
              
                  // Ensure the date is a String and in the correct format before parsing
                  DateTime? dateTime;

                  if (date is String) {
                    try {
                      // If the date is a String, parse it
                      dateTime = DateTime.parse(date);
                    } catch (e) {
                      print('Error parsing date: $e');
                      dateTime = DateTime.now(); // Fallback to the current date if parsing fails
                    }
                  } else if (date is DateTime) {
                    // If it's already a DateTime, use it directly
                    dateTime = date;
                  }

                  final formattedDate = dateTime != null ? DateFormat("dd MMMM yyyy").format(dateTime) : 'Unknown';

                  Color statusColor;
                  if (status == 'Disetujui') {
                    statusColor = Colors.green;
                  } else if (status == 'Menunggu Persetujuan') {
                    statusColor = Colors.orange;
                  } else {
                    statusColor = Colors.red;
                  }

                  var appointmentData = {
                    'name': name, 
                    'date': formattedDate, 
                    'time': time
                  };

                  // Menyimpan data janji temu ke provider
                  Provider.of<UserProvider>(context, listen: false).buatJanji(
                    appointmentData['name'] ?? 'No Name',
                    appointmentData['date'] ?? 'No Date',
                    appointmentData['time'] ?? 'No Time',
                  );

                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.calendar_today, color: Colors.brown),
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
                              Icon(Icons.access_time, color: Colors.grey),
                              SizedBox(width: 8),
                              Text(
                                time,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.person, color: Colors.blue),
                              SizedBox(width: 8),
                              Text(
                                'Doctor: $doctor',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                          Divider(height: 20, color: Colors.grey[400]),
                          Text(
                            name,
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
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton.icon(
                              icon: Icon(Icons.info, color: Colors.brown),
                              label: Text('Details'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AppointmentDetailScreen(
                                      name: name,
                                      date: formattedDate,
                                      service: service,
                                      status: status,
                                      time: time,
                                      doctor: doctor,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}