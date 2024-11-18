import 'package:app_acampamentos_hallel/core/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<UserCredential> signInWithEmailAndPassword({required String email, required String password});
  Future<void> signOut();
  Future<void> forgotPassword({required String email});
  User? getCurrentUser();
}

class AuthRepositoryImpl extends AuthRepository {
  final AuthService authService;

  AuthRepositoryImpl({required this.authService});

  @override
  Future<UserCredential> signInWithEmailAndPassword({required String email, required String password}) async {
    return await authService.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> signOut() async {
    await authService.signOut();
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    await authService.forgotPassword(email: email);
  }

  @override
  User? getCurrentUser() {
    return authService.getCurrentUser();
  }
}