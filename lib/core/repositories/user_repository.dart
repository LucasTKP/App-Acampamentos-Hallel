import 'dart:io';

import 'package:app_acampamentos_hallel/core/models/today_birth_model.dart';
import 'package:app_acampamentos_hallel/core/models/user_model.dart';
import 'package:app_acampamentos_hallel/core/services/user.service.dart';
import 'package:app_acampamentos_hallel/ui/register/register_user_dto.dart';
import 'package:app_acampamentos_hallel/ui/send_notification/send_notification_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';

abstract class UserRepository {
  Future<void> registerUser(RegisteUserDto user);
  Future<UserModel> getUser(String idUser);
  Future<void> updateUser({required String idUser, required Map<String, dynamic> data});
  Future<List<UserModel>> getUsers();
  Future<String> uploadFile({required File file, required String storagePath});
  Future<void> deleteFile(String storagePath);
  Future<TodayBirthModel> getTodayBirth();
  Future<Response<dynamic>> sendNotification(SendNotificationDto data);
}

class UserRepositoryImpl extends UserRepository {
  final UserService userService;

  UserRepositoryImpl({required this.userService});

  @override
  Future<void> registerUser(RegisteUserDto user) async {
    return await userService.registerUser(user.toJson());
  }

  @override
  Future<UserModel> getUser(String idUser) async {
    final response = await userService.getUser(idUser);
    return UserModel.fromJSON(response.data()!);
  }

  @override
  Future<void> updateUser({required String idUser, required Map<String, dynamic> data}) async {
    return await userService.updateUser(idUser, data);
  }

  @override
  Future<List<UserModel>> getUsers() async {
    final response = await userService.getUsers();
    return response.docs.map((e) => UserModel.fromJSON(e.data())).toList();
  }

  @override
  Future<String> uploadFile({required File file, required String storagePath}) async {
    final response = await userService.uploadFile(file: file, storagePath: storagePath);
    return await response.ref.getDownloadURL();
  }

  @override
  Future<void> deleteFile(String storagePath) async {
    return await userService.deleteFile(storagePath);
  }

  @override
  Future<TodayBirthModel> getTodayBirth() async {
    final dateNow = DateTime.now();
    final response = await userService.getTodayBirth();
    final data = response.data();
    if (data == null) {
      return TodayBirthModel(date: Timestamp.fromDate(dateNow), users: []);
    }
    return TodayBirthModel.fromJSON(data);
  }

  @override
  Future<Response<dynamic>> sendNotification(SendNotificationDto data) async {
    return await userService.sendNotification(data.toJson());
  }
}
