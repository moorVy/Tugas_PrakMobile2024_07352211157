import 'package:flutter/material.dart';
import 'package:msio/admin/admin_profile.dart';
import 'package:msio/models/appointment_provider.dart';
import 'package:msio/screens/UserProvider.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'admin/admin_dashboard1.dart' as admin1_dashboard;
import 'models/appointment_detail_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppointmentProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Miso Dental Care',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        // Menangani rute dengan arguments
        if (settings.name == '/appointment-detail') {
          final args = settings.arguments as Map<String, String>?;

          if (args != null) {
            // Menambahkan default value untuk doctor jika null
            final doctor = args['doctor'] ?? 'Unknown Doctor';

            return MaterialPageRoute(
              builder: (context) => AppointmentDetailScreen(
                name: args['name']!,
                date: args['date']!,
                service: args['service']!,
                status: args['status']!,
                time: args['time']!,
                doctor: doctor, // Mengirimkan dokter
              ),
            );
          }
        }
        // Menangani rute yang tidak dikenal dengan memberikan fallback
        return MaterialPageRoute(builder: (context) => LoginScreen());
      },
      routes: {
        '/': (context) => LoginScreen(),
        '/admin-dashboard': (context) => admin1_dashboard.AdminDashboard1(), // Menggunakan alias
        '/admin-profile': (context) => AdminProfile(),
      },
    );
  }
}
