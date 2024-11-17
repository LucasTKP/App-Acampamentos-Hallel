import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
  Future<UserCredential> signInWithEmailAndPassword({required String email, required String password});
  Future<void> signOut();
  Future<void> forgotPassword({required String email});
}

class AuthServiceImpl extends AuthService {
  final FirebaseAuth auth;

  AuthServiceImpl({required this.auth});

  @override
  Future<UserCredential> signInWithEmailAndPassword({required String email, required String password}) async {
    return await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signOut() async {
    await auth.signOut();
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    await auth.sendPasswordResetEmail(email: email);
  }
}
