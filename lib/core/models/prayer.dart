import 'package:cloud_firestore/cloud_firestore.dart';

class PrayerModel {
  final String id;
  final String text;
  final UserRequestPrayer userRequest;
  final Timestamp createdAt;
  final List<UserPrayer> reactions;

  PrayerModel({
    required this.id,
    required this.text,
    required this.userRequest,
    required this.createdAt,
    required this.reactions,
  });

  factory PrayerModel.fromJSON(Map<String, dynamic> json) {
    return PrayerModel(
      id: json['id'],
      text: json['text'],
      userRequest: UserRequestPrayer.fromJSON(json['userRequest']),
      createdAt: json['createdAt'],
      reactions: json['reactions'] != null ? (json['reactions'] as Map<String, dynamic>).values.map((e) => UserPrayer.fromJSON(e)).toList() : [],
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

class UserPrayer {
  final String userId;
  final String name;
  final String photo;
  final Timestamp createdAt;

  UserPrayer({
    required this.userId,
    required this.name,
    required this.photo,
    required this.createdAt,
  });

  factory UserPrayer.fromJSON(Map<String, dynamic> json) {
    return UserPrayer(
      userId: json['userId'],
      name: json['name'],
      photo: json['photo'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'photo': photo,
      'createdAt': createdAt,
    };
  }

  @override
  String toString() {
    return 'ReactionPrayer{userId: $userId, name: $name, photo: $photo, createdAt: $createdAt}';
  }
}
