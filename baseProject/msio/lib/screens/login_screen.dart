import 'package:flutter/material.dart';
import 'package:msio/screens/UserProvider.dart';
import 'package:provider/provider.dart'; // Import Provider
import 'home_screen.dart';
import '../admin/admin_dashboard1.dart';
import 'forgot_password.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
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
                      // Ganti dengan logo gambar
                      Image.asset(
                        'assets/images/LOGO2.PNG',
                        color: Colors.brown[900], // Pastikan logo Anda ada di folder assets/images
                        height: 120, // Sesuaikan ukuran logo
                        width: 120,  // Sesuaikan ukuran logo
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Miso Dental Care",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown[800],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Welcome Back!",
                        style: TextStyle(
                          fontSize: 18,
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
                SizedBox(height: 1),

                // Forgot Password Button
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                      );
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.brown[800],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),

                // Login Button
                ElevatedButton(
                  onPressed: () {
                    final username = usernameController.text.trim();
                    final password = passwordController.text.trim();

                    if (username.isEmpty || password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please fill in all fields!')),
                      );
                      return;
                    }

                    // Menggunakan UserProvider untuk validasi login
                    final userProvider = Provider.of<UserProvider>(context, listen: false);

                    if (userProvider.validateLogin(username, password)) {
                      final userType = userProvider.getUserType(username);

                      // Navigasi berdasarkan tipe akun
                      if (userType == 'Admin') {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => AdminDashboard1()),
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen(userName: username)),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Invalid username or password!')),
                      );
                    }
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
                    "Login",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                ),
                SizedBox(height: 5),

                // Register Button
                Container(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterScreen()),
                      );
                    },
                    child: Text(
                      "Don't have an account? Register here",
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
