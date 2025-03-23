import 'package:flutter/material.dart';
import '../constants.dart';
import './monitor_data_page.dart';
import './export_data_page.dart';
import './consult_doctor_page.dart';
import '../services/sensor_service.dart';
import '../models/sensor_data.dart';
import './user_profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<SensorData> _sensorData = [];
  final _sensorService = SensorService();

  @override
  void initState() {
    super.initState();
    _loadSensorData();
  }

  Future<void> _loadSensorData() async {
    final data = await _sensorService.loadSensorData();
    setState(() {
      _sensorData.clear();
      _sensorData.addAll(data);
    });
  }

  List<Widget> get _pages => [
    const MonitorDataPage(),
    ExportDataPage(sensorData: _sensorData),
    const ConsultDoctorPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MitraLink'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.monitor_heart),
            label: 'Monitor',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_download),
            label: 'Export',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services),
            label: 'Consult',
          ),
        ],
        selectedItemColor: AppColors.primaryColor,
      ),
    );
  }
} 