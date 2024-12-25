import 'package:app_acampamentos_hallel/core/models/async_state.dart';
import 'package:app_acampamentos_hallel/core/models/meeting_model.dart';
import 'package:app_acampamentos_hallel/core/repositories/meetings_repository.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

abstract class MeetingsController extends ChangeNotifier {
  AsyncState asyncState = AsyncState.initial;
  List<MeetingModel> meetingsOpen = [];
  List<MeetingModel> meetingsClosed = [];

  Future<void> getMeetings();

  void setMeetingsOpen(List<MeetingModel> value);
  void setMeetingsClosed(List<MeetingModel> value);
  void setAsyncState(AsyncState state);
}

class MeetingsControllerImpl extends MeetingsController {
  final MeetingsRepository meetingsRepository;
  final Function({required String message, required Color color}) onShowMessage;

  MeetingsControllerImpl({required this.meetingsRepository, required this.onShowMessage}) {
    getMeetings();
  }

  @override
  Future<void> getMeetings() async {
    try {
      setAsyncState(AsyncState.loading);
      final meetings = await meetingsRepository.getMeetings();
      setMeetingsOpen(meetings.where((element) => element.isOpen).toList());
      setMeetingsClosed(meetings.where((element) => !element.isOpen).toList());
    } catch (e) {
      onShowMessage(message: 'Erro ao buscar reuniões', color: Colors.red);
      developer.log(e.toString());
    } finally {
      setAsyncState(AsyncState.initial);
    }
  }

  @override
  void setMeetingsOpen(List<MeetingModel> value) {
    meetingsOpen = value;
    notifyListeners();
  }

  @override
  void setMeetingsClosed(List<MeetingModel> value) {
    meetingsClosed = value;
    notifyListeners();
  }

  @override
  void setAsyncState(AsyncState value) {
    asyncState = value;
    notifyListeners();
  }
}
