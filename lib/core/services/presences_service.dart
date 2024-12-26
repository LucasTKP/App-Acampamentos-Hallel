import 'package:cloud_firestore/cloud_firestore.dart';

abstract class PresencesService {
  Future<DocumentReference<Map<String, dynamic>>> createPresence(Map<String, dynamic> presence);
  Future<QuerySnapshot<Map<String, dynamic>>> getPresencesByUser(String idUser);
}

class PresencesServiceImpl extends PresencesService {
  final FirebaseFirestore db;
  PresencesServiceImpl({required this.db});

  @override
  Future<DocumentReference<Map<String, dynamic>>> createPresence(Map<String, dynamic> presence) async {
    final docRef = db.collection('presences').doc();
    presence['id'] = docRef.id;
    return await db.collection('presences').add(presence);
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getPresencesByUser(String idUser) async {
    return await db.collection('presences').where("id_user", isEqualTo: idUser).get();
  }
}
