import 'package:cloud_firestore/cloud_firestore.dart';

class TodayBirthModel {
  final Timestamp date;
  final List<UserBirth> users;

  TodayBirthModel({
    required this.date,
    required this.users,
  });

  factory TodayBirthModel.fromJSON(Map<String, dynamic> json) {
    return TodayBirthModel(
      date: json['date'],
      users: json['users'] != null  ? (json['users'] as List<dynamic>).map((e) => UserBirth.fromJSON(e)).toList() : [],
    );
  }

  @override
  String toString() {
    return 'TodayBirthModel{date: $date, users: $users}';
  }
}

class UserBirth {
  final String id;
  final String name;
  final String photoUrl;
  final Timestamp dateOfBirth;

  UserBirth({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.dateOfBirth,
  });

  factory UserBirth.fromJSON(Map<String, dynamic> json) {
    return UserBirth(
      id: json['id'],
      name: json['name'],
      photoUrl: json['photoUrl'],
      dateOfBirth: json['dateOfBirth'],
    );
  }
}
