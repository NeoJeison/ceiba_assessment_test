import 'package:ceiba_assessment_test/features/list_users/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({required super.id, required super.name, required super.email, required super.phone});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone
    };
  }
}