import 'package:app_acampamentos_hallel/core/models/prayer.dart';
import 'package:app_acampamentos_hallel/core/services/prayers_service.dart';
import 'package:app_acampamentos_hallel/ui/daily_prayer/daily_prayer_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class PrayersRepository {
  Future<void> createPrayer(DailyPrayerDto prayer);
  Future<void> updatePrayer(String text, String id);
  Future<List<PrayerModel>> getDailyPrayer(Timestamp date);
  Future<void> addReaction(ReactionPrayerDto reaction, String prayerId);
  Future<void> removeReaction({required String userId, required String prayerId});
}

class PrayersRepositoryImpl implements PrayersRepository {
  final PrayersService service;

  PrayersRepositoryImpl({required this.service});

  @override
  Future<void> createPrayer(DailyPrayerDto prayer) async {
    await service.createPrayer(prayer.toJson());
  }

  @override
  Future<void> updatePrayer(String text, String id) async {
    await service.updatePrayer({'text': text}, id);
  }

  @override
  Future<List<PrayerModel>> getDailyPrayer(Timestamp date) async {
    final response = await service.getDailyPrayer(date);
    return response.docs.map((e) => PrayerModel.fromJSON(e.data())).toList();
  }

  @override
  Future<void> addReaction(ReactionPrayerDto reaction, String prayerId) async {
    await service.addReaction(
      data: reaction.toJson(),
      prayerId: prayerId,
      userId: reaction.userId,
    );
  }

  @override
  Future<void> removeReaction({required String userId, required String prayerId}) async {
    await service.removeReaction(
      userId,
      prayerId,
    );
  }
}
