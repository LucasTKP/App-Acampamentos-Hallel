import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

String identifyError({required dynamic error, required String message}) {
  String messageError = message;
  if (error is FirebaseException) {
    if (error.code == 'invalid-credential') {
      messageError = 'Credencial inválida.';
    } else if (error.code == 'operation-not-allowed') {
      messageError = 'Operação não permitida.';
    } else if (error.code == 'user-disabled') {
      messageError = 'Usuário desabilitado.';
    } else if (error.code == 'user-not-found') {
      messageError = 'Usuário não encontrado.';
    } else if (error.code == 'wrong-password') {
      messageError = 'Senha incorreta.';
    } else if (error.code == 'email-already-in-use') {
      messageError = 'E-mail já em uso.';
    } else if (error.code == 'invalid-email') {
      messageError = 'E-mail inválido.';
    } else if (error.code == 'weak-password') {
      messageError = 'Senha fraca.';
    } else if (error.code == 'too-many-requests') {
      messageError = 'Muitas tentativas. Tente novamente mais tarde.';
    } else if (error.code == 'network-request-failed') {
      messageError = 'Falha na conexão. Verifique sua conexão com a internet.';
    }
  }
  if(error is TypeError) {
    messageError = 'Erro de tipo.';
  }

  return messageError;
}
