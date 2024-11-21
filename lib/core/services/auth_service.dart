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

  AuthServiceImpl({required this.auth});

  @override
  Future<UserCredential> registerUser(Map<String, dynamic> data) async {
    return await auth.createUserWithEmailAndPassword(
      email: data['email'],
      password: data['password'],
    );
  }

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

  @override
  User? getCurrentUser() {
    return auth.currentUser;
  }
}
