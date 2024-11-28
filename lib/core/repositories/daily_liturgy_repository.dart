import 'dart:developer';

import 'package:app_acampamentos_hallel/core/services/daily_liturgy_service.dart';
import 'package:dio/dio.dart';

abstract class DailyLiturgyRepository {
  Future<Response<dynamic>> getDailyLiturgy({required String day, required String month});
}

class DailyLiturgyRepositoryImpl extends DailyLiturgyRepository {
  final DailyLiturgyService service;

  DailyLiturgyRepositoryImpl({required this.service});

  @override
  Future<Response<dynamic>> getDailyLiturgy({required String day, required String month}) async {
    final response = await service.getDailyLiturgy(day: day, month: month);
    log(response.data.toString());
    return response;
  }
}
