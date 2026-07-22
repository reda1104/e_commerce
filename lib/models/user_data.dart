// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserData {
  final String id;
  final String name;
  final String email;
  final String createdAt;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'createdAt': createdAt,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      createdAt: map['createdAt'] as String,
    );
  }
}
