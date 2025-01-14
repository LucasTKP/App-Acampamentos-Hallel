import 'package:cloud_firestore/cloud_firestore.dart';

abstract class PresencesService {
  Future<void> createPresence(Map<String, dynamic> presence);
  Future<QuerySnapshot<Map<String, dynamic>>> getPresencesByUser(String idUser, DateTime? maxDate);
}

class PresencesServiceImpl extends PresencesService {
  final FirebaseFirestore db;
  final Duration timeout;

  PresencesServiceImpl({required this.db, this.timeout = const Duration(seconds: 10)});

  @override
  Future<void> createPresence(Map<String, dynamic> presence) async {
    final docRef = db.collection('presences').doc();
    presence['id'] = docRef.id;
    return await docRef.set(presence).timeout(timeout);
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getPresencesByUser(String idUser, DateTime? maxDate) async {
    if (maxDate != null) {
      return await db.collection('presences').where("id_user", isEqualTo: idUser).orderBy('date', descending: true).where("date", isGreaterThanOrEqualTo: maxDate).get().timeout(timeout);
    }
    return await db.collection('presences').where("id_user", isEqualTo: idUser).orderBy('date', descending: true).limit(5).get().timeout(timeout);
  }
}
