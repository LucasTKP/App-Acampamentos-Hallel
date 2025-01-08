import 'package:cloud_firestore/cloud_firestore.dart';

abstract class PrayersService {
  Future<void > createPrayer(Map<String, dynamic> prayer);
  Future<void> updatePrayer(Map<String, dynamic> prayer, String id);
  Future<QuerySnapshot<Map<String, dynamic>>> getDailyPrayer(Timestamp date);
}

class PrayersServiceImpl implements PrayersService {
  final FirebaseFirestore db;

  PrayersServiceImpl({required this.db});

  @override
  Future<void> createPrayer(Map<String, dynamic> prayer) async {
    final docRef = db.collection('prayers').doc();
    prayer['id'] = docRef.id;
    return await docRef.set(prayer);
  }

  @override
  Future<void> updatePrayer(Map<String, dynamic> prayer, String id) async {
    await db.collection('prayers').doc(id).update(prayer);
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getDailyPrayer(Timestamp date) async {
    return await db.collection('prayers').where('createdAt', isEqualTo: date).get();
  }
}
