import 'package:bazi_app_frontend/models/bazichart_model.dart';

class UserModel {
  final String name;
  final String email;
  final String birthDate;
  final int gender;
  final BaziChart baziChart;

  UserModel({
    required this.name,
    required this.email,
    required this.birthDate,
    required this.gender,
    required this.baziChart,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      birthDate: json['birth_date'],
      gender: json['gender'],
      baziChart: BaziChart.fromJson(json['four_pillars']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'birthDate': birthDate,
      'gender': gender,
      'baziChart': baziChart.toJson(),
    };
  }
}
