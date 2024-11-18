import 'package:cloud_firestore/cloud_firestore.dart';

abstract class UserService {
  Future<DocumentSnapshot<Map<String, dynamic>>> getUser(String idUser);
  Future<void> updateUser(String idUser, Map<String, dynamic> data);
}

class UserServiceImpl extends UserService {
  final db = FirebaseFirestore.instance;

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getUser(String idUser) async {
    return await db.collection('users').doc(idUser).get();
  }

  @override
  Future<void> updateUser(String idUser, Map<String, dynamic> data) async {
    return await db.collection('users').doc(idUser).update(data);
  }
}
