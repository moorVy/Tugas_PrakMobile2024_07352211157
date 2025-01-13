import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _namaPasien = '';
  String _waktuBo = '';
  String _tanggalBo = '';

  String get namaPasien => _namaPasien;
  dynamic get waktuBo => _waktuBo;
  dynamic get tanggalBo => _tanggalBo;

  void buatJanji(String nama, dynamic jam, dynamic tgl){
    _namaPasien = nama;
    _waktuBo = jam;
    _tanggalBo = tgl;
    notifyListeners();
  }

  final List<Map<String, String>> _users = [
    {'username': 'rafli ardhana', 'email': 'rafli@example.com', 'password': '1', 'type': 'User'},
    {'username': 'rafli1', 'email': 'rafli1@example.com', 'password': 'a1', 'type': 'Admin'},
  ]; // Data pengguna awal

  User? _currentUser; // Track current logged-in user

  // Getter to return current user (or 'Guest' if not logged in)
  User get currentUser {
    return _currentUser ?? User(username: 'Guest', email: '', isLoggedIn: false);
  }

  // Getter for all users
  List<Map<String, String>> get users => _users;

  // Add new user
  void addUser(String username, String email, String password) {
    _users.add({
      'username': username,
      'email': email,
      'password': password,
      'type': 'user',
    });
    notifyListeners();
  }

  // Validate login and set the current user
  bool validateLogin(String username, String password) {
    for (var user in _users) {
      if (user['username'] == username && user['password'] == password) {
        // Set the current user after successful login
        _currentUser = User(username: username, email: user['email']!, isLoggedIn: true);
        notifyListeners(); // Notify listeners of the change
        return true;
      }
    }
    return false;
  }

  // Get the user type based on username
  String getUserType(String username) {
    for (var user in _users) {
      if (user['username'] == username) {
        return user['type'] ?? 'User';
      }
    }
    return 'User'; // Default return if user not found
  }

  // Log out the current user
  void logOut() {
    _currentUser = null;
    notifyListeners(); // Notify listeners that the user logged out
  }
}

class User {
  final String username;
  final String email;
  final bool isLoggedIn;

  User({
    required this.username,
    required this.email,
    required this.isLoggedIn,
  });
}
