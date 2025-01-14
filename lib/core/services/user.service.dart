import 'dart:io';

import 'package:app_acampamentos_hallel/core/services/api_client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class UserService {
  Future<void> registerUser(Map<String, dynamic> data);
  Future<DocumentSnapshot<Map<String, dynamic>>> getUser(String idUser);
  Future<void> updateUser(String idUser, Map<String, dynamic> data);
  Future<QuerySnapshot<Map<String, dynamic>>> getUsers();
  Future<TaskSnapshot> uploadFile({required File file, required String storagePath});
  Future<void> deleteFile(String storagePath);
  Future<DocumentSnapshot<Map<String, dynamic>>> getTodayBirth();
  Future<Response<dynamic>> sendNotification(Map<String, dynamic> data);
}

class UserServiceImpl extends UserService {
  final FirebaseFirestore db;
  final FirebaseStorage storage;
  final ApiService api;
  final Duration timeout;
  UserServiceImpl({
    required this.api,
    required this.db,
    required this.storage,
    this.timeout = const Duration(seconds: 10),
  });

  @override
  Future<void> registerUser(Map<String, dynamic> data) async {
    return await db.collection('users').doc(data['id']).set(data).timeout(timeout);
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getUser(String idUser) async {
    return await db.collection('users').doc(idUser).get().timeout(timeout);
  }

  @override
  Future<void> updateUser(String idUser, Map<String, dynamic> data) async {
    return await db.collection('users').doc(idUser).update(data).timeout(timeout);
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getUsers() async {
    return await db.collection('users').get().timeout(timeout);
  }

  @override
  Future<TaskSnapshot> uploadFile({required File file, required String storagePath}) async {
    final storageReference = storage.ref(storagePath);
    final uploadTask = storageReference.putFile(file);
    final taskSnapshot = await uploadTask;
    return taskSnapshot;
  }

  @override
  Future<void> deleteFile(String storagePath) async {
    return await storage.ref(storagePath).delete();
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getTodayBirth() async {
    //dentro da coleção today quero o documento usersBirth
    return await db.collection('today').doc('usersBirth').get().timeout(timeout);
  }

  @override
  Future<Response<dynamic>> sendNotification(Map<String, dynamic> data) async {
    return await api.client.post(
      'https://canaa-backend-30b0337f14fb.herokuapp.com/api/sendNotification',
      options: Options(
        headers: {"x-custom-header": "TerraPrometida"},
      ),
      data: data,
    );
  }
}
