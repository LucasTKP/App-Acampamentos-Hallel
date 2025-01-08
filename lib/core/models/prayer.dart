import 'package:cloud_firestore/cloud_firestore.dart';

class PrayerModel {
  final String id;
  final String text;
  final UserRequestPrayer userRequest;
  final Timestamp createdAt;

  PrayerModel({
    required this.id,
    required this.text,
    required this.userRequest,
    required this.createdAt,
  });

  factory PrayerModel.fromJSON(Map<String, dynamic> json) {
    return PrayerModel(
      id: json['id'],
      text: json['text'],
      userRequest: UserRequestPrayer.fromJSON(json['userRequest']),
      createdAt: json['createdAt'],
    );
  }
}

class UserRequestPrayer {
  final String id;
  final String name;
  final String photoUrl;

  UserRequestPrayer({
    required this.id,
    required this.name,
    required this.photoUrl,
  });

  factory UserRequestPrayer.fromJSON(Map<String, dynamic> json) {
    return UserRequestPrayer(
      id: json['id'],
      name: json['name'],
      photoUrl: json['photoUrl'],
    );
  }

  @override
  String toString() {
    return 'UserRequestPrayer{id: $id, name: $name, photoUrl: $photoUrl}';
  }
}
