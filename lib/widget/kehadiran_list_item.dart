import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:daftar_kehadiran/providers/kehadiran_provider.dart';
import 'package:daftar_kehadiran/models/kehadiran.dart';

class AttendanceListItem extends StatelessWidget {
  final Attendance student;
  final int index;

  const AttendanceListItem({Key? key, required this.student, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AttendanceProvider>(context);

    return ListTile(
      title: Text(student.name),
      leading: Checkbox(
        value: student.isPresent,
        onChanged: (value) {
          provider.toggleAttendance(index);
        },
      ),
    );
  }
}
