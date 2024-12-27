import 'package:app_acampamentos_hallel/core/services/api_client.dart';
import 'package:dio/dio.dart';

abstract class LiturgyService {
  Future<Response<dynamic>> getLiturgyByDate({required String day, required String month, required String year});
}

class LiturgyServiceImpl extends LiturgyService {
  final ApiService api;

  LiturgyServiceImpl({required this.api});

  @override
  Future<Response<dynamic>> getLiturgyByDate({required String day, required String month, required String year}) async {
    return await api.client.get('/?dia=$day&month=$month&ano=$year');
  }
}
