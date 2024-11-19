import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:daftar_kehadiran/providers/kehadiran_provider.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final history = Provider.of<AttendanceProvider>(context).history;

    return Scaffold(
      appBar: AppBar(title: Text('Riwayat Kehadiran')),
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (ctx, index) {
          final record = history[index];
          return ExpansionTile(
            title: Text(record['date']),
            subtitle: Text(
              'Hadir: ${record['present']}, Tidak Hadir: ${record['absent']}',
            ),
            children: [
              ...record['details'].map<Widget>((detail) {
                return ListTile(
                  title: Text(detail['name']),
                  trailing: Text(
                    detail['isPresent'] ? 'Hadir' : 'Tidak Hadir',
                    style: TextStyle(
                      color: detail['isPresent'] ? Colors.green : Colors.red,
                    ),
                  ),
                );
              }).toList(),
            ],
          );
        },
      ),
    );
  }
}
