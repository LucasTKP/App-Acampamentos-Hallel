import 'package:app_acampamentos_hallel/core/services/api_client.dart';
import 'package:dio/dio.dart';

abstract class DailyLiturgyService {
  Future<Response<dynamic>> getDailyLiturgy({required String day, required String month});
}

class DailyLiturgyServiceImpl extends DailyLiturgyService {
  final ApiService api;

  DailyLiturgyServiceImpl({required this.api});

  @override
  Future<Response<dynamic>> getDailyLiturgy({required String day, required String month}) async {
    return await api.client.get('/$day-$month');
  }
}
