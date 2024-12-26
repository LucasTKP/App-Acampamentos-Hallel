class PresenceModel {
  String id;
  String idMeeting;
  String idUser;
  DateTime date;

  PresenceModel({required this.id, required this.idMeeting, required this.idUser, required this.date});

  factory PresenceModel.fromJson(Map<String, dynamic> json) {
    return PresenceModel(
      id: json['id'],
      idMeeting: json['id_meeting'],
      idUser: json['id_user'],
      date: json['date'].toDate(),
    );
  }

  @override
  String toString() {
    return 'PresenceModel(id: $id, idMeeting: $idMeeting, idUser: $idUser, date: $date)';
  }
}
