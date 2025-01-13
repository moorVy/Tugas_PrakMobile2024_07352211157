import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/appointment_provider.dart';

class AdminAppointmentDetailScreen extends StatelessWidget {
  final String dname;
  final dynamic date;
  final String service;
  final String status;
  final String time;
  final String patientName;
  final int appointmentIndex;

  AdminAppointmentDetailScreen({
    required this.dname,
    required this.date,
    required this.service,
    required this.status,
    required this.time,
    required this.patientName,
    required this.appointmentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Appointment Details',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.brown[100],
        elevation: 10,
        shadowColor: Colors.black26,
      ),
      body: Center(  // Center widget to ensure content is centered vertically and horizontally
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centering column content
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Card for Appointment Details and Action Buttons
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.brown[100]!, Colors.brown[300]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(blurRadius: 15, color: Colors.black12, offset: Offset(0, 5))],
                ),
                width: double.infinity, // Full width for the card
                margin: EdgeInsets.symmetric(vertical: 20), // Center card vertically
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Doctor Name
                    Row(
                      children: [
                        Icon(Icons.person_3, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Doctor: $dname',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    // Patient Name
                    Row(
                      children: [
                        Icon(Icons.person, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Patient: $patientName',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    // Date
                    Row(
                      children: [
                        Icon(Icons.calendar_today, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Date: $date',
                          style: TextStyle(fontSize: 18, color: Colors.white70),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    // Time
                    Row(
                      children: [
                        Icon(Icons.access_time, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Time: $time',
                          style: TextStyle(fontSize: 18, color: Colors.white70),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    // Service
                    Row(
                      children: [
                        Icon(Icons.medical_services, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Service: $service',
                          style: TextStyle(fontSize: 18, color: Colors.white70),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    // Action Buttons: Approve and Reject
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Approve Appointment Button
                        ElevatedButton(
                          onPressed: () {
                            // Memperbarui status janji temu menjadi "Disetujui"
                            Provider.of<AppointmentProvider>(context, listen: false)
                                .approveAppointment(appointmentIndex);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Appointment approved!')),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[400],
                            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 10,
                          ),
                          child: Text(
                            "Approve",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
                          ),
                        ),

                        // Reject Appointment Button
                        ElevatedButton(
                          onPressed: () {
                            // Memperbarui status janji temu menjadi "Ditolak"
                            Provider.of<AppointmentProvider>(context, listen: false)
                                .rejectAppointment(appointmentIndex);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Appointment rejected!')),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[400],
                            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 10,
                          ),
                          child: Text(
                            "Reject",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Status Section
              Consumer<AppointmentProvider>(builder: (context, provider, child) {
                return Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.brown[50],
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(blurRadius: 8, color: Colors.black12, offset: Offset(0, 5))],
                  ),
                  child: Text(
                    'Status: ${provider.appointments[appointmentIndex]['status']}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: provider.appointments[appointmentIndex]['status'] == 'Disetujui'
                          ? Colors.green
                          : provider.appointments[appointmentIndex]['status'] == 'Pending'
                              ? Colors.orange
                              : Colors.red,
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
