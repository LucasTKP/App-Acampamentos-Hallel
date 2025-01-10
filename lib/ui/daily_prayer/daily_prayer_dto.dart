import 'package:cloud_firestore/cloud_firestore.dart';

class DailyPrayerDto {
  final String text;
  final UserRequestPrayerModel userRequest;
  final Timestamp createdAt;

  DailyPrayerDto({
    required this.text,
    required this.userRequest,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'userRequest': userRequest.toJson(),
      'createdAt': createdAt,
    };
  }

  @override
  String toString() {
    return 'DailyPrayerDto{text: $text, userRequest: $userRequest, createdAt: $createdAt}';
  }
}

class UserRequestPrayerModel {
  final String id;
  final String name;
  final String photoUrl;

  UserRequestPrayerModel({
    required this.id,
    required this.name,
    required this.photoUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'photoUrl': photoUrl,
    };
  }

  @override
  String toString() {
    return 'UserRequestPrayer{id: $id, name: $name, photoUrl: $photoUrl}';
  }
}

class ReactionPrayerDto {
  final String userId;
  final String name;
  final String photo;
  final Timestamp createdAt;

  ReactionPrayerDto({
    required this.userId,
    required this.name,
    required this.photo,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'createdAt': createdAt,
      'photo': photo,
    };
  }

  @override
  String toString() {
    return 'ReactionPrayerDto{userId: $userId, name: $name, photoUrl: $photo, createdAt: $createdAt}';
  }
}
