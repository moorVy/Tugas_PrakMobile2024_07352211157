import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
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
                // Header
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Icon(
                        Icons.lock_open,
                        size: 80,
                        color: Colors.brown[800],
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Recover Your Password",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown[800],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Enter your email to reset your password",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.brown[600],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),

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
                SizedBox(height: 30),

                // Send Recovery Button
                ElevatedButton(
                  onPressed: () {
                    // Logika pemulihan password (contoh: kirim email pemulihan)
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            "Password recovery link has been sent to your email."),
                      ),
                    );
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
                    "Send Recovery Email",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                ),
                SizedBox(height: 5),

                // Back to Login Button
                Container(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Back to Login",
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
