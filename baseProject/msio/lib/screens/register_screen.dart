import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider
import 'package:msio/screens/UserProvider.dart'; // Import UserProvider

class RegisterScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        centerTitle: true,
        backgroundColor: Colors.brown[100],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Icon(
                        Icons.person_add_alt_1,
                        size: 80,
                        color: Colors.brown[800],
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Create Your Account",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown[800],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Enter your details to create a new account",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.brown[600],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                
                // Input Username
                TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(color: Colors.brown[800]),
                    filled: true,
                    fillColor: Colors.brown[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.person, color: Colors.brown[600]),
                  ),
                ),
                SizedBox(height: 20),
                
                // Input Email
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.brown[800]),
                    filled: true,
                    fillColor: Colors.brown[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.email, color: Colors.brown[600]),
                  ),
                ),
                SizedBox(height: 20),
                
                // Input Password
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.brown[800]),
                    filled: true,
                    fillColor: Colors.brown[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.lock, color: Colors.brown[600]),
                  ),
                ),
                SizedBox(height: 30),
                
                // Register Button
                ElevatedButton(
                  onPressed: () {
                    final username = usernameController.text.trim();
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();

                    if (username.isEmpty || email.isEmpty || password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please fill all fields!')),
                      );
                      return;
                    }

                    // Menambahkan username baru ke UserProvider dengan email dan password
                    Provider.of<UserProvider>(context, listen: false).addUser(username, email, password);

                    // Navigasi kembali setelah registrasi
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Registration Successful!')),
                    );

                    Navigator.pop(context); // Kembali ke halaman login
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown[800],
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                  ),
                  child: Text(
                    "Register",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                ),
                SizedBox(height: 5),
                
                // Button to go back to login screen
                Container(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Kembali ke login screen
                    },
                    child: Text(
                      "Already have an account? Login here",
                      style: TextStyle(fontSize: 16, color: Colors.brown[800]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
