import 'package:cloud_firestore/cloud_firestore.dart';

abstract class SettingsService {
  Future<Map<String, dynamic>> getSettings();
  
}

class SettingsServiceImpl extends SettingsService {
  final FirebaseFirestore db;
  final Duration timeout;
  SettingsServiceImpl({required this.db, this.timeout = const Duration(seconds: 10)});

  @override
  Future<Map<String, dynamic>> getSettings() async {
    final snapshot = await db.collection('settings').limit(1).get().timeout(timeout);
    return snapshot.docs.first.data();
  }
}
