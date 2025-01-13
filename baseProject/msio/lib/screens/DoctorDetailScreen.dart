import 'package:flutter/material.dart';

class DoctorDetailScreen extends StatelessWidget {
  final Map<String, String> doctor;

  DoctorDetailScreen({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          doctor['name']!,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown[900]),
        ),
        centerTitle: true,
        backgroundColor: Colors.brown[100],
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.brown[900]),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor's photo with a gradient border
            Center(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.brown[100]!, Colors.brown[300]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: EdgeInsets.all(4),
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage(doctor['photo']!),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Doctor's name and specialty
            Center(
              child: Column(
                children: [
                  Text(
                    doctor['name']!,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[900],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    doctor['specialty']!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.brown[600],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Section: Education & Background
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.school, color: Colors.brown[800]),
                        SizedBox(width: 8),
                        Text(
                          "Education & Background",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown[800],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Dr. ${doctor['name']} has completed their studies at XYZ University. They specialize in ${doctor['specialty']} and have over 10 years of experience in the field.",
                      style: TextStyle(fontSize: 16, color: Colors.brown[700]),
                    ),
                  ],
                ),
              ),
            ),

            // Section: Additional Information
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.brown[800]),
                        SizedBox(width: 8),
                        Text(
                          "Additional Information",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown[800],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Dr. ${doctor['name']} is passionate about helping patients achieve optimal oral health. They frequently attend international conferences to stay updated with the latest advancements in dentistry.",
                      style: TextStyle(fontSize: 16, color: Colors.brown[700]),
                    ),
                  ],
                ),
              ),
            ),

            // Contact Section
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Contact",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown[800],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Email: dr.${doctor['name']!.toLowerCase().replaceAll(' ', '')}@misodental.com",
                          style: TextStyle(fontSize: 16, color: Colors.brown[700]),
                        ),
                        Text(
                          "Phone: +62 123-456-7890",
                          style: TextStyle(fontSize: 16, color: Colors.brown[700]),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Placeholder for call functionality
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Call",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
