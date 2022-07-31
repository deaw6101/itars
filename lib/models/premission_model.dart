import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PremissionModel {
  final String name;
  final String role;
  PremissionModel({
    required this.name,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'role': role,
    };
  }

  factory PremissionModel.fromMap(Map<String, dynamic> map) {
    return PremissionModel(
      name: (map['name'] ?? '') as String,
      role: (map['role'] ?? '')  as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PremissionModel.fromJson(String source) => PremissionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
