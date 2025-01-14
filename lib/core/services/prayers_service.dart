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
  final Duration timeout;

  PrayersServiceImpl({required this.db, this.timeout = const Duration(seconds: 10)});

  @override
  Future<void> createPrayer(Map<String, dynamic> prayer) async {
    final docRef = db.collection('prayers').doc();
    prayer['id'] = docRef.id;
    return await docRef.set(prayer).timeout(timeout);
  }

  @override
  Future<void> updatePrayer(Map<String, dynamic> prayer, String id) async {
    await db.collection('prayers').doc(id).update(prayer).timeout(timeout);
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getDailyPrayer(Timestamp date) async {
    return await db.collection('prayers').where('createdAt', isEqualTo: date).get().timeout(timeout);
  }

  @override
  Future<void> addReaction({required Map<String, dynamic> data, required String prayerId, required String userId}) async {
    final prayerRef = FirebaseFirestore.instance.collection('prayers').doc(prayerId);
    return await prayerRef.update({
      'reactions.$userId': data,
    }).timeout(const Duration(seconds: 2));
  }

  @override
  Future<void> removeReaction(String userId, String prayerId) async {
    final prayerRef = FirebaseFirestore.instance.collection('prayers').doc(prayerId);
    return await prayerRef.update({
      'reactions.$userId': FieldValue.delete(),
    }).timeout(const Duration(seconds: 2));
  }
}
