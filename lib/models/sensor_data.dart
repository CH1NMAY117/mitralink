class SensorData {
  final String username;
  final DateTime timestamp;
  final double bloodPressureSystolic;
  final double bloodPressureDiastolic;
  final double pulseOximeter;
  final double temperature;

  SensorData({
    required this.username,
    required this.timestamp,
    required this.bloodPressureSystolic,
    required this.bloodPressureDiastolic,
    required this.pulseOximeter,
    required this.temperature,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'timestamp': timestamp.toIso8601String(),
      'systolic': bloodPressureSystolic,
      'diastolic': bloodPressureDiastolic,
      'spo2': pulseOximeter,
      'temperature': temperature,
    };
  }
} 