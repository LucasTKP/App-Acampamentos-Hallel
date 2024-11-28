class MeetingModel {
  String id;
  String theme;
  String description;
  String password;
  DateTime date;
  bool isVisible;
  bool isOpen;

  MeetingModel({
    required this.id,
    required this.theme,
    required this.description,
    required this.password,
    required this.date,
    required this.isVisible,
    required this.isOpen,
  });

  factory MeetingModel.fromJson(Map<String, dynamic> json) {
    return MeetingModel(
      id: json['id'],
      theme: json['theme'],
      description: json['description'],
      password: json['password'],
      date:json['date'].toDate(),
      isVisible: json['isVisible'],
      isOpen: json['isOpen'],
    );
  }

  @override
  String toString() {
    return 'MeetingModel(id: $id, theme: $theme, description: $description, password: $password, date: $date, isVisible: $isVisible, isOpen: $isOpen)';
  }
}