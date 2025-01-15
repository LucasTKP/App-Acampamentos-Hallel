import 'package:acamps_canaa/core/models/liturgy_model.dart';
import 'package:acamps_canaa/core/services/liturgy_service.dart';

abstract class LiturgyRepository {
  Future<LiturgyModel> getLiturgyByDate({required DateTime date});
}

class LiturgyRepositoryImpl extends LiturgyRepository {
  final LiturgyService service;

  LiturgyRepositoryImpl({required this.service});

  @override
  Future<LiturgyModel> getLiturgyByDate({required DateTime date}) async {
    final day = date.day.toString();
    final month = date.month.toString();
    final year = date.year.toString();
    final response = await service.getLiturgyByDate(day: day, month: month, year: year);
    return LiturgyModel.fromJson(response.data);
  }
}
