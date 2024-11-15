class PresenceModel {
  String id;
  String idMeeting;
  String idUser;
  DateTime date;

  PresenceModel({required this.id, required this.idMeeting, required this.idUser, required this.date});

  factory PresenceModel.fromJson(Map<String, dynamic> json) {
    return PresenceModel(
      id: json['id'],
      idMeeting: json['idMeeting'],
      idUser: json['idUser'],
      date: DateTime.parse(json['date']),
    );
  }

  @override
  String toString() {
    return 'PresenceModel(id: $id, idMeeting: $idMeeting, idUser: $idUser, date: $date)';
  }
}
