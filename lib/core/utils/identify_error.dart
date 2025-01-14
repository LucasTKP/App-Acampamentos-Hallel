import 'dart:async';
import 'dart:io';

import 'package:app_acampamentos_hallel/core/utils/internal_errors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';

String identifyError({required dynamic error, required String message}) {
  String messageError = message;
  if (error is FirebaseException) {
    if (error.code == 'invalid-credential') {
      return messageError = 'Credencial inválida.';
    } else if (error.code == 'operation-not-allowed') {
      return messageError = 'Operação não permitida.';
    } else if (error.code == 'user-disabled') {
      return messageError = 'Usuário desabilitado.';
    } else if (error.code == 'user-not-found') {
      return messageError = 'Usuário não encontrado.';
    } else if (error.code == 'wrong-password') {
      return messageError = 'Senha incorreta.';
    } else if (error.code == 'email-already-in-use') {
      return messageError = 'E-mail já em uso.';
    } else if (error.code == 'invalid-email') {
      return messageError = 'E-mail inválido.';
    } else if (error.code == 'weak-password') {
      return messageError = 'Senha fraca.';
    } else if (error.code == 'too-many-requests') {
      return messageError = 'Muitas tentativas. Tente novamente mais tarde.';
    } else if (error.code == 'network-request-failed') {
      return messageError = 'Falha na conexão. Verifique sua conexão com a internet.';
    }
  }
  if (error is TypeError) {
    return messageError = 'Erro de tipo.';
  }

  if (error is InternalErrors) {
    return messageError = error.message;
  }

  if (error is DioException && error.error is SocketException) {
    return messageError = 'Sem internet, por favor reconecte';
  }

  if (error is TimeoutException) {
    return messageError = 'Tempo esgotado. Verifique sua conexão com a internet.';
  }


  return messageError;
}
