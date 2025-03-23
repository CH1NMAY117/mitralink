import 'package:flutter/material.dart';
import 'package:wifi_iot/wifi_iot.dart';
import '../constants.dart';

class MonitorDataPage extends StatefulWidget {
  const MonitorDataPage({super.key});

  @override
  State<MonitorDataPage> createState() => _MonitorDataPageState();
}

class _MonitorDataPageState extends State<MonitorDataPage> {
  bool _isMonitoring = false;

  Future<void> _startMonitoring() async {
    try {
      bool? isEnabled = await WiFiForIoTPlugin.isEnabled();
      if (!isEnabled) {
        await WiFiForIoTPlugin.setEnabled(true);
      }
      // Add Arduino connection logic here
      setState(() {
        _isMonitoring = true;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
            icon: Icon(_isMonitoring ? Icons.stop : Icons.play_arrow),
            label: Text(_isMonitoring ? 'Stop Monitoring' : 'Start Monitoring'),
            onPressed: _isMonitoring ? null : _startMonitoring,
          ),
        ],
      ),
    );
  }
} 