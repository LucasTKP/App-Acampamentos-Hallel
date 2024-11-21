import 'package:app_acampamentos_hallel/core/models/user_model.dart';
import 'package:app_acampamentos_hallel/core/services/user.service.dart';
import 'package:app_acampamentos_hallel/ui/register/register_user_dto.dart';

abstract class UserRepository {
  Future<void> registerUser(RegisteUserDto user);
  Future<UserModel> getUser(String idUser);
  Future<void> updateUser(String idUser, Map<String, dynamic> data);
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
  Future<void> updateUser(String idUser, Map<String, dynamic> data) async {
    return await userService.updateUser(idUser, data);
  }
}
