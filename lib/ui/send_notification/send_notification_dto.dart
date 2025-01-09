class SendNotificationDto {
  final String title;
  final String description;

  SendNotificationDto({required this.title, required this.description});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
    };
  }
}
