class PresenceDto {
  final DateTime date;
  final String idMeeeting;
  final String idUser;

  PresenceDto({
    required this.date,
    required this.idMeeeting,
    required this.idUser,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'id_meeting': idMeeeting,
      'id_user': idUser,
    };
  }

  
}
