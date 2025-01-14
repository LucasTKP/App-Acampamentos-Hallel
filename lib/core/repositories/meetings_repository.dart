import 'package:app_acampamentos_hallel/core/models/meeting_model.dart';
import 'package:app_acampamentos_hallel/core/services/meetings_service.dart';

abstract class MeetingsRepository {
  Future<List<MeetingModel>> getMeetings(String? lastDocumentId);
}

class MeetingsRepositoryImpl extends MeetingsRepository {
  final MeetingsService service;
  MeetingsRepositoryImpl({required this.service});

  @override
  Future<List<MeetingModel>> getMeetings(String? lastDocumentId) async {
    final meetings = await service.getMeetings(lastDocumentId);
    return meetings.docs.map((e) => MeetingModel.fromJson(e.data())).toList();
  }
}
