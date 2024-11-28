import 'package:cloud_firestore/cloud_firestore.dart';

abstract class UserService {
  Future<void> registerUser(Map<String, dynamic> data);
  Future<DocumentSnapshot<Map<String, dynamic>>> getUser(String idUser);
  Future<void> updateUser(String idUser, Map<String, dynamic> data);
  Future<QuerySnapshot<Map<String, dynamic>>> getUsers();
}

class UserServiceImpl extends UserService {
  final db = FirebaseFirestore.instance;

  @override
  Future<void> registerUser(Map<String, dynamic> data) async {
    return await db.collection('users').doc(data['id']).set(data);
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getUser(String idUser) async {
    return await db.collection('users').doc(idUser).get();
  }

  @override
  Future<void> updateUser(String idUser, Map<String, dynamic> data) async {
    return await db.collection('users').doc(idUser).update(data);
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getUsers() async {
    return await db.collection('users').get();
  }
}
