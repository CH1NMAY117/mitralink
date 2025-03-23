import '../models/sensor_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SensorService {
  static const String _storageKey = 'sensor_data';
  
  Future<List<SensorData>> loadSensorData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString(_storageKey);
    if (jsonString == null) return [];
    
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => SensorData(
      username: json['username'],
      timestamp: DateTime.parse(json['timestamp']),
      bloodPressureSystolic: json['systolic'],
      bloodPressureDiastolic: json['diastolic'],
      pulseOximeter: json['spo2'],
      temperature: json['temperature'],
    )).toList();
  }
  
  Future<void> saveSensorData(List<SensorData> data) async {
    final prefs = await SharedPreferences.getInstance();
    final String jsonString = json.encode(
      data.map((d) => d.toMap()).toList(),
    );
    await prefs.setString(_storageKey, jsonString);
  }
} 