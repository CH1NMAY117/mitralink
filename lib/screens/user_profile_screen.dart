import 'package:flutter/material.dart';
import '../constants.dart';
import '../models/user_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late UserProfile _profile;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final String? profileJson = prefs.getString('user_profile');
    
    if (profileJson != null) {
      final Map<String, dynamic> profileMap = json.decode(profileJson);
      setState(() {
        _profile = UserProfile(
          username: profileMap['username'] ?? '',
          age: profileMap['age'],
          gender: profileMap['gender'],
          height: profileMap['height']?.toDouble(),
          weight: profileMap['weight']?.toDouble(),
          bloodGroup: profileMap['bloodGroup'],
          eyeSight: profileMap['eyeSight'],
          isDiabetic: profileMap['isDiabetic'],
        );
      });
    } else {
      setState(() {
        _profile = UserProfile(username: '');
      });
    }
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_profile', json.encode({
        'username': _profile.username,
        'age': _profile.age,
        'gender': _profile.gender,
        'height': _profile.height,
        'weight': _profile.weight,
        'bloodGroup': _profile.bloodGroup,
        'eyeSight': _profile.eyeSight,
        'isDiabetic': _profile.isDiabetic,
      }));

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile saved successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveProfile,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                initialValue: _profile.username,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  icon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter username';
                  }
                  return null;
                },
                onSaved: (value) => _profile.username = value ?? '',
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _profile.age,
                decoration: const InputDecoration(
                  labelText: 'Age',
                  icon: Icon(Icons.calendar_today),
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) => _profile.age = value,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _profile.gender,
                decoration: const InputDecoration(
                  labelText: 'Gender',
                  icon: Icon(Icons.people),
                ),
                items: ['Male', 'Female', 'Other']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) => setState(() => _profile.gender = value),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: _profile.height?.toString(),
                      decoration: const InputDecoration(
                        labelText: 'Height (cm)',
                        icon: Icon(Icons.height),
                      ),
                      keyboardType: TextInputType.number,
                      onSaved: (value) => _profile.height = double.tryParse(value ?? ''),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      initialValue: _profile.weight?.toString(),
                      decoration: const InputDecoration(
                        labelText: 'Weight (kg)',
                        icon: Icon(Icons.line_weight),
                      ),
                      keyboardType: TextInputType.number,
                      onSaved: (value) => _profile.weight = double.tryParse(value ?? ''),
                    ),
                  ),
                ],
              ),
              if (_profile.height != null && _profile.weight != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'BMI: ${_profile.bmi?.toStringAsFixed(1)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _profile.bloodGroup,
                decoration: const InputDecoration(
                  labelText: 'Blood Group',
                  icon: Icon(Icons.bloodtype),
                ),
                items: ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) => setState(() => _profile.bloodGroup = value),
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _profile.eyeSight,
                decoration: const InputDecoration(
                  labelText: 'Eye Sight',
                  icon: Icon(Icons.remove_red_eye),
                ),
                onSaved: (value) => _profile.eyeSight = value,
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Diabetic'),
                value: _profile.isDiabetic ?? false,
                onChanged: (value) => setState(() => _profile.isDiabetic = value),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 