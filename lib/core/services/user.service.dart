import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class UserService {
  Future<void> registerUser(Map<String, dynamic> data);
  Future<DocumentSnapshot<Map<String, dynamic>>> getUser(String idUser);
  Future<void> updateUser(String idUser, Map<String, dynamic> data);
  Future<QuerySnapshot<Map<String, dynamic>>> getUsers();
  Future<TaskSnapshot> uploadFile({required File file, required String storagePath});
  Future<void> deleteFile(String storagePath);
}

class UserServiceImpl extends UserService {
  final db = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;

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

  @override
  Future<TaskSnapshot> uploadFile({required File file, required String storagePath}) async {
    final storageReference = FirebaseStorage.instance.ref(storagePath);
    final uploadTask = storageReference.putFile(file);
    final taskSnapshot = await uploadTask;
    return taskSnapshot;
  }

  @override
  Future<void> deleteFile(String storagePath) async {
    return await FirebaseStorage.instance.ref(storagePath).delete();
  }
}
