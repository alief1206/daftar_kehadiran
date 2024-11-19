import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:daftar_kehadiran/providers/kehadiran_provider.dart';
import 'package:daftar_kehadiran/widget/kehadiran_list_item.dart';

class RecordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AttendanceProvider>(context);
    final students = provider.students;

    return Scaffold(
      appBar: AppBar(title: Text('Presensi Siswa')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (ctx, index) => AttendanceListItem(
                student: students[index],
                index: index,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: students.isEmpty ? null : provider.saveAttendance,
            child: Text('Simpan Kehadiran'),
          ),
        ],
      ),
    );
  }
}
