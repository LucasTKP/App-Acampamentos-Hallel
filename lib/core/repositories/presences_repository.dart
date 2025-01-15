import 'package:acamps_canaa/core/models/presence_model.dart';
import 'package:acamps_canaa/core/services/presences_service.dart';
import 'package:acamps_canaa/ui/meetings/presence_dto.dart';

abstract class PresencesRepository {
  Future<void> createPresence(PresenceDto presence);
  Future<List<PresenceModel>> getPresencesByUser(String idUser, DateTime? maxDate);
}

class PresencesRepositoryImpl extends PresencesRepository {
  final PresencesService service;

  PresencesRepositoryImpl({required this.service});

  @override
  Future<void> createPresence(PresenceDto presence) async {
    await service.createPresence(presence.toJson());
  }

  @override
  Future<List<PresenceModel>> getPresencesByUser(String idUser, DateTime? maxDate) async {
    final presences = await service.getPresencesByUser(idUser, maxDate);
    final a = presences.docs.map((e) => PresenceModel.fromJson(e.data())).toList();
    return a;
  }
}
