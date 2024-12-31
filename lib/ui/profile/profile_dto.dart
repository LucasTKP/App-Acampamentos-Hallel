import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateUserDto {
  String name;
  bool madeCane;
  int? madeCaneYear;
  Timestamp dateOfBirth;

  UpdateUserDto({
    required this.name,
    required this.madeCane,
    this.madeCaneYear,
    required this.dateOfBirth,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'madeCane': madeCane,
      'madeCaneYear': madeCaneYear,
      'dateOfBirth': dateOfBirth,
    };
  }
}
