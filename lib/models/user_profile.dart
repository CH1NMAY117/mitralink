class UserProfile {
  String username;
  String? age;
  String? gender;
  double? height; // in cm
  double? weight; // in kg
  String? bloodGroup;
  String? eyeSight;
  bool? isDiabetic;
  Map<String, dynamic> otherParameters;

  UserProfile({
    required this.username,
    this.age,
    this.gender,
    this.height,
    this.weight,
    this.bloodGroup,
    this.eyeSight,
    this.isDiabetic,
    Map<String, dynamic>? otherParameters,
  }) : otherParameters = otherParameters ?? {};

  double? get bmi {
    if (height != null && weight != null) {
      return weight! / ((height! / 100) * (height! / 100));
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'age': age,
      'gender': gender,
      'height': height,
      'weight': weight,
      'bloodGroup': bloodGroup,
      'eyeSight': eyeSight,
      'isDiabetic': isDiabetic,
      'otherParameters': otherParameters,
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      username: json['username'] ?? '',
      age: json['age'],
      gender: json['gender'],
      height: json['height']?.toDouble(),
      weight: json['weight']?.toDouble(),
      bloodGroup: json['bloodGroup'],
      eyeSight: json['eyeSight'],
      isDiabetic: json['isDiabetic'],
      otherParameters: json['otherParameters'] ?? {},
    );
  }
} 