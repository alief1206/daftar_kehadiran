import 'package:flutter/material.dart';
import 'package:daftar_kehadiran/models/kehadiran.dart';

class AttendanceProvider with ChangeNotifier {
  List<Attendance> _students = [
    Attendance(name: 'Ali', ),
    Attendance(name: 'Budi'),
    Attendance(name: 'Citra'),
    Attendance(name: 'alief'),
    Attendance(name: 'dika'),
    Attendance(name: 'farrel'),
    Attendance(name: 'wahyu')
  ];

  List<Map<String, dynamic>> _history = [];

  List<Attendance> get students => _students;
  List<Map<String, dynamic>> get history => _history;

  void toggleAttendance(int index) {
    _students[index].isPresent = !_students[index].isPresent;
    notifyListeners();
  }

  void saveAttendance() {
    final now = DateTime.now();
    final presentCount = _students.where((s) => s.isPresent).length;

    // Menyimpan detail siapa saja yang hadir dan tidak hadir
    final details = _students.map((s) {
      return {
        'name': s.name,
        'isPresent': s.isPresent,
      };
    }).toList();

    _history.insert(0, {
      'date': '${now.day}-${now.month}-${now.year}',
      'present': presentCount,
      'absent': _students.length - presentCount,
      'details': details, // Tambahkan detail kehadiran
    });

    // Reset status kehadiran
    _students = _students.map((s) => Attendance(name: s.name)).toList();
    notifyListeners();
  }
}
