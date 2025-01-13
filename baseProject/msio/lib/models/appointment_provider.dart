import 'package:flutter/material.dart';

class AppointmentProvider with ChangeNotifier {
  List<Map<String, dynamic>> _appointments = [];

  List<Map<String, dynamic>> get appointments => _appointments;

  get pendingAppointments => _appointments.where((appointment) => appointment['status'] == 'Pending').toList();

  // Menambahkan janji temu baru
  void addAppointment(Map<String, dynamic> newAppointment) {
    _appointments.add(newAppointment);
    notifyListeners(); // Mengupdate UI ketika ada perubahan data
  }

  // Menyetujui janji temu
  void approveAppointment(int index) {
    // Mengubah status janji temu menjadi 'Disetujui'
    _appointments[index]['status'] = 'Disetujui';
    notifyListeners(); // Mengupdate UI ketika status berubah

    // Mengirim notifikasi kepada pasien bahwa janji temu telah disetujui
    sendApprovalNotification(_appointments[index]);

    // Opsional: Menampilkan snackbar untuk admin
    print('Appointment approved: ${_appointments[index]}');
  }

  // Menolak janji temu
  void rejectAppointment(int index) {
    // Mengubah status janji temu menjadi 'Ditolak'
    _appointments[index]['status'] = 'Ditolak';
    notifyListeners(); // Mengupdate UI ketika status berubah

    // Mengirim notifikasi kepada pasien bahwa janji temu telah ditolak
    sendRejectionNotification(_appointments[index]);

    // Opsional: Menampilkan snackbar untuk admin
    print('Appointment rejected: ${_appointments[index]}');
  }

  // Mengirim notifikasi saat janji temu disetujui
  void sendApprovalNotification(Map<String, dynamic> appointment) {
    // Logika untuk mengirim notifikasi ke pasien
    // Misalnya, menggunakan Firebase Cloud Messaging atau notifikasi lokal
    print("Notifikasi: Appointment with ${appointment['doctor']} has been approved!");
    // Anda bisa menambahkan kode untuk mengirim email, notifikasi, atau lainnya.
  }

  // Mengirim notifikasi saat janji temu ditolak
  void sendRejectionNotification(Map<String, dynamic> appointment) {
    // Logika untuk mengirim notifikasi ke pasien
    print("Notifikasi: Appointment with ${appointment['doctor']} has been rejected.");
    // Anda bisa menambahkan kode untuk mengirim email, notifikasi, atau lainnya.
  }
}
