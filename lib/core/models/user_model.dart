import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String name;
  String email;
  bool madeCane;
  int? madeCaneYear;
  DateTime lastPresence;
  int totalPresence;
  String namePhoto;
  String photoUrl;
  bool isAdmin;
  String? deviceToken;
  Timestamp? dateOfBirth;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.madeCane,
    required this.madeCaneYear,
    required this.lastPresence,
    required this.totalPresence,
    required this.namePhoto,
    required this.photoUrl,
    required this.isAdmin,
    required this.deviceToken,
    required this.dateOfBirth,
  });

  factory UserModel.fromJSON(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      madeCane: json['madeCane'],
      madeCaneYear: json['madeCaneYear'],
      lastPresence: json['lastPresence'].toDate(),
      totalPresence: json['totalPresence'],
      namePhoto: json['namePhoto'],
      photoUrl: json['photoUrl'],
      isAdmin: json['isAdmin'] ?? false,
      deviceToken: json['deviceToken'],
      dateOfBirth: json['dateOfBirth'] ?? Timestamp(0, 0),
    );
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    bool? madeCane,
    int? madeCaneYear,
    DateTime? lastPresence,
    int? totalPresence,
    String? namePhoto,
    String? photoUrl,
    bool? isAdmin,
    String? deviceToken,
    Timestamp? dateOfBirth,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      madeCane: madeCane ?? this.madeCane,
      madeCaneYear: madeCaneYear ?? this.madeCaneYear,
      lastPresence: lastPresence ?? this.lastPresence,
      totalPresence: totalPresence ?? this.totalPresence,
      namePhoto: namePhoto ?? this.namePhoto,
      photoUrl: photoUrl ?? this.photoUrl,
      isAdmin: isAdmin ?? this.isAdmin,
      deviceToken: deviceToken ?? this.deviceToken,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, madeCane: $madeCane, madeCaneYear: $madeCaneYear, lastPresence: $lastPresence, totalPresence: $totalPresence, namePhoto: $namePhoto, photoUrl: $photoUrl, isAdmin: $isAdmin, deviceToken: $deviceToken, dateOfBirth: $dateOfBirth,)';
  }
}
