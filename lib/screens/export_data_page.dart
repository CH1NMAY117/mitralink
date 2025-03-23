import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../models/sensor_data.dart';
import '../constants.dart';

class ExportDataPage extends StatefulWidget {
  final List<SensorData> sensorData;
  const ExportDataPage({super.key, required this.sensorData});

  @override
  State<ExportDataPage> createState() => _ExportDataPageState();
}

class _ExportDataPageState extends State<ExportDataPage> {
  Future<void> _exportToExcel() async {
    final excel = Excel.createExcel();
    final sheet = excel['Sensor Data'];

    // Add headers
    sheet.appendRow([
      'Username',
      'Date',
      'Time',
      'Blood Pressure (Systolic)',
      'Blood Pressure (Diastolic)',
      'SpO2',
      'Temperature'
    ]);

    // Add data rows
    for (var data in widget.sensorData) {
      sheet.appendRow([
        data.username,
        '${data.timestamp.day}/${data.timestamp.month}/${data.timestamp.year}',
        '${data.timestamp.hour}:${data.timestamp.minute}',
        data.bloodPressureSystolic,
        data.bloodPressureDiastolic,
        data.pulseOximeter,
        data.temperature,
      ]);
    }

    // Save file
    final directory = await getExternalStorageDirectory();
    final file = File('${directory?.path}/sensor_data.xlsx');
    await file.writeAsBytes(excel.encode()!);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Data exported to ${file.path}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.sensorData.length,
              itemBuilder: (context, index) {
                final data = widget.sensorData[index];
                return ListTile(
                  title: Text('${data.timestamp}'),
                  subtitle: Text(
                    'BP: ${data.bloodPressureSystolic}/${data.bloodPressureDiastolic} '
                    'SpO2: ${data.pulseOximeter}% '
                    'Temp: ${data.temperature}°C',
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.file_download),
              label: const Text('Export to Excel'),
              onPressed: _exportToExcel,
            ),
          ),
        ],
      ),
    );
  }
} 