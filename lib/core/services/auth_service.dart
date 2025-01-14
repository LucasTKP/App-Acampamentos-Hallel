import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
  Future<UserCredential> registerUser(Map<String, dynamic> data);
  Future<UserCredential> signInWithEmailAndPassword({required String email, required String password});
  Future<void> signOut();
  Future<void> forgotPassword({required String email});
  User? getCurrentUser();
}

class AuthServiceImpl extends AuthService {
  final FirebaseAuth auth;
  final Duration timeout;
  AuthServiceImpl({required this.auth, this.timeout = const Duration(seconds: 10)});

  @override
  Future<UserCredential> registerUser(Map<String, dynamic> data) async {
    return await auth
        .createUserWithEmailAndPassword(
          email: data['email'],
          password: data['password'],
        )
        .timeout(timeout);
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword({required String email, required String password}) async {
    return await auth
        .signInWithEmailAndPassword(
          email: email,
          password: password,
        )
        .timeout(timeout);
  }

  @override
  Future<void> signOut() async {
    return await auth.signOut().timeout(timeout);
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    await auth.sendPasswordResetEmail(email: email).timeout(timeout);
  }

  @override
  User? getCurrentUser() {
    return auth.currentUser;
  }
}
