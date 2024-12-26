import 'package:cloud_firestore/cloud_firestore.dart';

abstract class MeetingsService {
  Future<QuerySnapshot<Map<String, dynamic>>> getMeetings();
}

class MeetingsServiceImpl extends MeetingsService {
  final FirebaseFirestore db;

  MeetingsServiceImpl({required this.db});

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getMeetings() async {
    return await db.collection('meetings').orderBy('date', descending: true).get();
  }
}
