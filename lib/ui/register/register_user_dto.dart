import 'package:cloud_firestore/cloud_firestore.dart';

class RegisteUserDto {
  String id;
  String name;
  String email;
  bool madeCane;
  int? madeCaneYear;
  String namePhoto;
  String photoUrl;
  int totalPresence;
  DateTime lastPresence;
  Timestamp dateOfBirth;
  bool isAdmin;

  RegisteUserDto({
    required this.id,
    required this.name,
    required this.email,
    required this.madeCane,
    this.madeCaneYear,
    required this.namePhoto,
    required this.photoUrl,
    required this.totalPresence,
    required this.lastPresence,
    required this.dateOfBirth,
    this.isAdmin = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'madeCane': madeCane,
      'madeCaneYear': madeCaneYear,
      'namePhoto': namePhoto,
      'photoUrl': photoUrl,
      'totalPresence': totalPresence,
      'lastPresence': lastPresence,
      'dateOfBirth': dateOfBirth,
      'isAdmin': isAdmin,
    };
  }
}

class RegisterAuthUserDTO {
  String email;
  String password;

  RegisterAuthUserDTO({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
