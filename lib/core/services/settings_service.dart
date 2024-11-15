import 'package:cloud_firestore/cloud_firestore.dart';

abstract class SettingsService {
  Future<Map<String, dynamic>> getSettings();
  
}

class SettingsServiceImpl extends SettingsService {
  final FirebaseFirestore db;

  SettingsServiceImpl({required this.db});

  @override
  Future<Map<String, dynamic>> getSettings() async {
    final snapshot = await db.collection('settings').limit(1).get();
    return snapshot.docs.first.data();
  }
}
