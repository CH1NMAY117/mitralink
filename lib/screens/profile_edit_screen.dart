import 'package:flutter/material.dart';
import '../constants.dart';
import '../models/user_profile.dart';

class ProfileEditScreen extends StatefulWidget {
  final UserProfile profile;
  final Function(UserProfile) onSave;

  const ProfileEditScreen({
    super.key,
    required this.profile,
    required this.onSave,
  });

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  late UserProfile _profile;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _profile = widget.profile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveProfile,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _profile.age,
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _profile.age = value,
              ),
              DropdownButtonFormField<String>(
                value: _profile.gender,
                decoration: const InputDecoration(labelText: 'Gender'),
                items: ['Male', 'Female', 'Other']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) => setState(() => _profile.gender = value),
              ),
              TextFormField(
                initialValue: _profile.height?.toString(),
                decoration: const InputDecoration(
                  labelText: 'Height (cm)',
                  suffixText: 'cm',
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) => _profile.height = double.tryParse(value ?? ''),
              ),
              TextFormField(
                initialValue: _profile.weight?.toString(),
                decoration: const InputDecoration(
                  labelText: 'Weight (kg)',
                  suffixText: 'kg',
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) => _profile.weight = double.tryParse(value ?? ''),
              ),
              if (_profile.bmi != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'BMI: ${_profile.bmi!.toStringAsFixed(1)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              DropdownButtonFormField<String>(
                value: _profile.bloodGroup,
                decoration: const InputDecoration(labelText: 'Blood Group'),
                items: ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) => setState(() => _profile.bloodGroup = value),
              ),
              TextFormField(
                initialValue: _profile.eyeSight,
                decoration: const InputDecoration(labelText: 'Eye Sight'),
                onSaved: (value) => _profile.eyeSight = value,
              ),
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

  void _saveProfile() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      widget.onSave(_profile);
      Navigator.pop(context);
    }
  }
} 