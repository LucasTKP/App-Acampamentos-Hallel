import 'package:cloud_firestore/cloud_firestore.dart';

abstract class MeetingsService {
  Future<QuerySnapshot<Map<String, dynamic>>> getMeetings(String? lastDocumentId);
}

class MeetingsServiceImpl extends MeetingsService {
  final FirebaseFirestore db;
  final Duration timeout;
  MeetingsServiceImpl({required this.db, this.timeout = const Duration(seconds: 10)});
  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getMeetings(String? lastDocumentId) async {
    Query<Map<String, dynamic>> query = db.collection('meetings').orderBy('date', descending: true).limit(5);

    // Se o lastDocumentId não for nulo, usamos ele para pegar a referência do documento
    if (lastDocumentId != null) {
      DocumentSnapshot lastDocument = await db.collection('meetings').doc(lastDocumentId).get();
      query = query.startAfterDocument(lastDocument); // Usa o documento obtido
    }

    return await query.get().timeout(timeout);
  }
}
