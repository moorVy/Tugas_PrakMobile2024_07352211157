import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Untuk format tanggal

class AppointmentDetailScreen extends StatelessWidget {
  final String name;
  final String date;
  final String service;
  final String status;
  final String time;
  final String doctor; // Menambahkan parameter dokter

  AppointmentDetailScreen({
    required this.name,
    required this.date,
    required this.service,
    required this.status,
    required this.time,
    required this.doctor, // Menambahkan parameter dokter
  });

  @override
  Widget build(BuildContext context) {
    // Convert date string to DateTime
    final dateTime = DateTime.tryParse(date);
    final formattedDate = dateTime != null
        ? DateFormat("dd MMMM yyyy").format(dateTime)
        : date; // If the date is invalid, use the raw date string

    // Adding time formatting
    final formattedTime = time.isNotEmpty ? time : "Unknown Time";

    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Details'),
        backgroundColor: Colors.brown[200], // Lighter brown for app bar
        elevation: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Header with a larger title
            Text(
              'Appointment Details',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
                color: Colors.brown[800], // Dark brown for title
              ),
            ),
            SizedBox(height: 25),
            
            // Card containing appointment details
            Card(
              elevation: 12,
              shadowColor: Colors.brown.withOpacity(0.1), // Soft shadow
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildDetailRow(Icons.person, 'Patient Name:', name),
                    _buildDetailRow(Icons.calendar_today, 'Date:', formattedDate),
                    _buildDetailRow(Icons.access_time, 'Time:', formattedTime), // Show time
                    _buildDetailRow(Icons.medical_services, 'Service:', service),
                    _buildDetailRow(Icons.check_circle, 'Status:', status),
                    _buildDetailRow(Icons.person, 'Doctor:', doctor), // Menambahkan baris untuk nama dokter
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            
            // Additional footer or action buttons could go here
          ],
        ),
      ),
    );
  }

  // Helper function to create consistent detail rows
  Widget _buildDetailRow(IconData icon, String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.brown[600], // Using brown for icons
            size: 24,
          ),
          SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.brown[700], // Darker brown for title text
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              content,
              style: TextStyle(
                fontSize: 16,
                color: Colors.brown[800], // Darker brown for content text
              ),
            ),
          ),
        ],
      ),
    );
  }
}
