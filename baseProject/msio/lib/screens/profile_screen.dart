import 'package:flutter/material.dart';
import 'login_screen.dart'; // Import halaman login

class ProfileScreen extends StatefulWidget {
  final String userName; // Variabel untuk menyimpan nama pengguna

  // Konstruktor untuk menerima nama pengguna dari halaman login
  ProfileScreen({required this.userName});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Controller untuk setiap informasi yang dapat diedit
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  // Initial values for profile
  String email = "rafli@gmail.com";
  String phone = "+62198371";
  String address = "kayu merah";

  @override
  void initState() {
    super.initState();
    // Set initial values for controllers
    emailController.text = email;
    phoneController.text = phone;
    addressController.text = address;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        backgroundColor: Colors.brown[100],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile section with photo and name centered
              Container(
                padding: const EdgeInsets.only(top: 30, bottom: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.brown[200]!, Colors.brown[100]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
                  children: [
                    // Center the profile photo in the container
                    Center(
                      child: CircleAvatar(
                        radius: 70,
                        backgroundImage: AssetImage('assets/images/dokter.jpg'),
                        backgroundColor: Colors.grey[300],
                      ),
                    ),
                    SizedBox(height: 15),
                    // Display username in the center below the photo
                    Center(
                      child: Text(
                        widget.userName,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown[800],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    // Optional description (optional)
                    Center(
                      child: Text(
                        'Active user',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.brown[500],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),

              // Form for editing user information
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildDetailRow(Icons.email, "Email", emailController),
                      Divider(),
                      _buildDetailRow(Icons.phone, "Phone", phoneController),
                      Divider(),
                      _buildDetailRow(Icons.location_on, "Address", addressController),
                      Divider(),
                      _buildStaticDetailRow(Icons.date_range, "Joined", "January 2023"),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40), // Adjusted space between form and buttons

              // Positioned buttons with consistent size and space
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch, // Make buttons full-width
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        // Update the profile with the edited values
                        email = emailController.text;
                        phone = phoneController.text;
                        address = addressController.text;
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Profile updated successfully!')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown[800],
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    icon: Icon(Icons.save, color: Colors.white),
                    label: Text(
                      "Save Changes",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20), // Space between Save Changes and Logout button
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown[800],
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    icon: Icon(Icons.logout, color: Colors.white),
                    label: Text(
                      "Logout",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to create consistent detail rows with text fields
  Widget _buildDetailRow(IconData icon, String title, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.brown[600], // Icon color
            size: 24,
          ),
          SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: title,
                labelStyle: TextStyle(color: Colors.brown[600]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.brown[400]!),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper function for static text fields (e.g., for 'Joined' field)
  Widget _buildStaticDetailRow(IconData icon, String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.brown[600], // Icon color
            size: 24,
          ),
          SizedBox(width: 12),
          Text(
            "$title: $content",
            style: TextStyle(
              fontSize: 16,
              color: Colors.brown[800],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
