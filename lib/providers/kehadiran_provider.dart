import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:daftar_kehadiran/models/kehadiran.dart';

class AttendanceProvider with ChangeNotifier {
  List<Attendance> _students = [
    Attendance(name: 'Ali'),
    Attendance(name: 'Budi'),
    Attendance(name: 'Citra'),
    Attendance(name: 'alief'),
    Attendance(name: 'dika'),
    Attendance(name: 'farrel'),
    Attendance(name: 'wahyu')
  ];

  List<Map<String, dynamic>> _history = [];

  AttendanceProvider() {
    _loadInitialData();
  }

  List<Attendance> get students => _students;
  List<Map<String, dynamic>> get history => _history;

  Future<void> _loadInitialData() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Load students data
    final studentsJson = prefs.getString('students');
    if (studentsJson != null) {
      final List<dynamic> decodedStudents = json.decode(studentsJson);
      _students = decodedStudents.map((s) => 
        Attendance(
          name: s['name'], 
          isPresent: s['isPresent'] ?? false
        )
      ).toList();
    }

    // Load history data
    final historyJson = prefs.getString('history');
    if (historyJson != null) {
      final List<dynamic> decodedHistory = json.decode(historyJson);
      _history = List<Map<String, dynamic>>.from(decodedHistory);
    }

    notifyListeners();
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();

    // Save students data
    final studentsJson = json.encode(_students.map((s) => {
      'name': s.name,
      'isPresent': s.isPresent
    }).toList());
    await prefs.setString('students', studentsJson);

    // Save history data
    final historyJson = json.encode(_history);
    await prefs.setString('history', historyJson);
  }

  void toggleAttendance(int index) {
    _students[index].isPresent = !_students[index].isPresent;
    _saveData();
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
      'details': details,
    });

    // Reset status kehadiran
    _students = _students.map((s) => Attendance(name: s.name)).toList();
    
    // Simpan data
    _saveData();
    notifyListeners();
  }
}