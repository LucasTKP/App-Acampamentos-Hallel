import 'dart:io';

import 'package:app_acampamentos_hallel/core/models/user_model.dart';
import 'package:app_acampamentos_hallel/core/services/user.service.dart';
import 'package:app_acampamentos_hallel/ui/register/register_user_dto.dart';

abstract class UserRepository {
  Future<void> registerUser(RegisteUserDto user);
  Future<UserModel> getUser(String idUser);
  Future<void> updateUser({required String idUser, required Map<String, dynamic> data});
  Future<List<UserModel>> getUsers();
  Future<String> uploadFile({required File file, required String storagePath});
  Future<void> deleteFile(String storagePath);
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
}
