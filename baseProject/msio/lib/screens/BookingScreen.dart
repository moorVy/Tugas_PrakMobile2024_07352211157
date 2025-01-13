import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/appointment_provider.dart';
import 'package:provider/provider.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime? _selectedDate;
  String? _selectedDoctor;
  String? _selectedService;
  String? _selectedTime; // Waktu yang dipilih
  CalendarFormat _currentFormat = CalendarFormat.week;

  // Status booking
  String _bookingStatus = 'Menunggu Persetujuan';

  void _confirmBooking(BuildContext context) {
    if (_selectedDate == null || _selectedDoctor == null || _selectedService == null || _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please complete all fields!')),
      );
      return;
    }

    // Simulasikan pengiriman data ke admin
    final bookingData = {
      'doctor': _selectedDoctor!,
      'service': _selectedService!,
      'date': _selectedDate!,
      'time': _selectedTime!,
      'status': _bookingStatus,
    };

    Provider.of<AppointmentProvider>(context, listen: false).addAppointment(bookingData);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Janji Temu Anda Terkirim dan Menunggu Persetujuan Admin!')),
    );

    Navigator.pop(context, bookingData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buat Janji Anda", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.brown[100],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pilih Dokter
            Text("Select Doctor", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            DropdownButtonFormField<String>(
              items: [
                DropdownMenuItem(child: Text('Dr. Amelia'), value: 'Dr. Amelia'),
                DropdownMenuItem(child: Text('Dr. Bayu'), value: 'Dr. Bayu'),
                DropdownMenuItem(child: Text('Dr. Clara'), value: 'Dr. Clara'),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedDoctor = value;
                });
              },
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),

            // Pilih Layanan
            Text("Select Service", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            DropdownButtonFormField<String>(
              items: [
                DropdownMenuItem(child: Text('Pembersihan Gigi'), value: 'Pembersihan Gigi'),
                DropdownMenuItem(child: Text('Pengobatan Gusi'), value: 'Pengobatan Gusi'),
                DropdownMenuItem(child: Text('Pemasangan Behel'), value: 'Pemasangan Behel'),
                DropdownMenuItem(child: Text('Pemasangan Mahkota'), value: 'mahkota'),
                DropdownMenuItem(child: Text('Penambalan'), value: 'tambal '),
                DropdownMenuItem(child: Text('Cabut Gigi'), value: 'cabut'),
                DropdownMenuItem(child: Text('Root Canal'), value: 'root'),
                DropdownMenuItem(child: Text('Veener'), value: 'veener'),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedService = value;
                });
              },
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),

            // Pilih Tanggal
            Text("Select Date", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            TableCalendar(
              firstDay: DateTime.now(),
              lastDay: DateTime.now().add(Duration(days: 365)),
              focusedDay: _selectedDate ?? DateTime.now(),
              calendarFormat: _currentFormat,
              onFormatChanged: (format) {
                setState(() {
                  _currentFormat = format;
                });
              },
              availableCalendarFormats: {
                CalendarFormat.month: 'Month',
                CalendarFormat.twoWeeks: '2 Weeks',
                CalendarFormat.week: 'Week',
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.brown[200],
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.brown,
                  shape: BoxShape.circle,
                ),
              ),
              selectedDayPredicate: (day) => isSameDay(day, _selectedDate),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDate = selectedDay;
                });
              },
            ),
            SizedBox(height: 20),

            // Pilih Waktu dengan GridView
            Text("Select Time", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Menampilkan 3 kolom per baris
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                List<String> times = ['16:00', '17:00', '18:00', '19:00', '20:00', '21:00'];
                String time = times[index];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTime = time;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _selectedTime == time ? Colors.brown : Colors.brown[100],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.brown),
                    ),
                    child: Center(
                      child: Text(
                        time,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _selectedTime == time ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 30),

            // Tombol Konfirmasi
            ElevatedButton(
              onPressed: () => _confirmBooking(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Center(
                child: Text("Confirm Booking", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
