class UserModel {
  String id;
  String name;
  String email;
  bool madeCane;
  int madeCaneYear;
  DateTime lastPresence;
  int totalPresence;
  String namePhoto;
  String photoUrl;
  bool isAdmin;

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
  });

  factory UserModel.fromJSON(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      madeCane: json['madeCane'],
      madeCaneYear: json['madeCaneYear'],
      lastPresence: DateTime.parse(json['lastPresence']),
      totalPresence: json['totalPresence'],
      namePhoto: json['namePhoto'],
      photoUrl: json['photoUrl'],
      isAdmin: json['isAdmin'],
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, madeCane: $madeCane, madeCaneYear: $madeCaneYear, lastPresence: $lastPresence, totalPresence: $totalPresence, namePhoto: $namePhoto, photoUrl: $photoUrl, isAdmin: $isAdmin)';
  }
}
