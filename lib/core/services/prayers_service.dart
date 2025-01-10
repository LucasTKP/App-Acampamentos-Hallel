import 'package:cloud_firestore/cloud_firestore.dart';

abstract class PrayersService {
  Future<void> createPrayer(Map<String, dynamic> prayer);
  Future<void> updatePrayer(Map<String, dynamic> prayer, String id);
  Future<QuerySnapshot<Map<String, dynamic>>> getDailyPrayer(Timestamp date);
  Future<void> addReaction({required Map<String, dynamic> data, required String prayerId, required String userId});
  Future<void> removeReaction(String userId, String prayerId);
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

  @override
  Future<void> addReaction({required Map<String, dynamic> data, required String prayerId, required String userId}) async {
    final prayerRef = FirebaseFirestore.instance.collection('prayers').doc(prayerId);
    return await prayerRef.update({
      'reactions.$userId': data,
    });
  }

  @override
  Future<void> removeReaction(String userId, String prayerId) async {
    final prayerRef = FirebaseFirestore.instance.collection('prayers').doc(prayerId);
    return await prayerRef.update({
      'reactions.$userId': FieldValue.delete(),
    });
  }
}
