import 'package:acamps_canaa/core/extensions/string_extension.dart';
import 'package:acamps_canaa/core/global_controllers/user_controller.dart';
import 'package:acamps_canaa/core/models/async_state.dart';
import 'package:acamps_canaa/core/models/meeting_model.dart';
import 'package:acamps_canaa/core/models/presence_model.dart';
import 'package:acamps_canaa/core/models/status_presence_meeting.dart';
import 'package:acamps_canaa/core/repositories/meetings_repository.dart';
import 'package:acamps_canaa/core/repositories/presences_repository.dart';
import 'package:acamps_canaa/core/repositories/user_repository.dart';
import 'package:acamps_canaa/core/utils/identify_error.dart';
import 'package:acamps_canaa/ui/meetings/presence_dto.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

abstract class MeetingsController extends ChangeNotifier {
  AsyncState asyncState = AsyncState.initial;
  bool buttonGetMeetingsPaginationIsLoading = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool buttonCheckPresenceIsLoading = false;
  List<MeetingModel> meetingsOpen = [];
  List<MeetingModel> meetingsClosed = [];
  List<PresenceModel> presences = [];
  TextEditingController passwordController = TextEditingController();

  Future<void> init();
  Future<void> loadingMoreMeetings();
  Future<void> getMeetings();
  Future<void> getMeetingsPagination();
  Future<void> getPresences();
  Future<void> getPresencesPagination();
  Future<bool> checkPresence(MeetingModel meeting);
  Future<void> createPresence(String idMeeting, DateTime dateMeeting);
  Future<void> updatePresenceUser(DateTime dateMeeting);
  bool verifyPassword(String passwordMeeting);
  StatusPresenceMeeting getStatusPresenceMeeting(MeetingModel meeting);

  void setMeetingsOpen(List<MeetingModel> value);
  void setMeetingsClosed(List<MeetingModel> value);
  void setPresences(List<PresenceModel> value);
  void setButtonCheckPresenceIsLoading(bool value);
  void setAsyncState(AsyncState state);
  void setButtonGetMeetingsPaginationIsLoading(bool value);
}

class MeetingsControllerImpl extends MeetingsController {
  final MeetingsRepositoryImpl meetingsRepository;
  final PresencesRepositoryImpl presenceRepository;
  final UserRepository userRepository;
  final UserControllerImpl userController;
  final Function({required String message, required Color color}) onShowMessage;

  MeetingsControllerImpl({
    required this.meetingsRepository,
    required this.presenceRepository,
    required this.userRepository,
    required this.userController,
    required this.onShowMessage,
  }) {
    init();
  }

  @override
  Future<void> init() async {
    setAsyncState(AsyncState.loading);
    await Future.wait([
      getPresences(),
      getMeetings(),
    ]);
    setAsyncState(AsyncState.initial);
  }

  @override
  Future<void> loadingMoreMeetings() async {
    if (buttonGetMeetingsPaginationIsLoading) {
      return;
    }
    setButtonGetMeetingsPaginationIsLoading(true);
    await getMeetingsPagination();
    await getPresencesPagination();
    setButtonGetMeetingsPaginationIsLoading(false);
  }

  @override
  Future<void> getMeetings() async {
    try {
      final meetings = await meetingsRepository.getMeetings(null);
      setMeetingsOpen(meetings.where((element) => element.isOpen).toList());
      setMeetingsClosed(meetings.where((element) => !element.isOpen).toList());
    } catch (e) {
      onShowMessage(message: 'Erro ao buscar reuniões', color: Colors.red);
      developer.log(e.toString());
    }
  }

  @override
  Future<void> getMeetingsPagination() async {
    String? lastDocumentId;
    if (meetingsClosed.isNotEmpty) {
      lastDocumentId = meetingsClosed.last.id;
    }
    try {
      final meetings = await meetingsRepository.getMeetings(lastDocumentId);
      setMeetingsOpen(meetingsOpen..addAll(meetings.where((element) => element.isOpen).toList()));
      setMeetingsClosed(meetingsClosed..addAll(meetings.where((element) => !element.isOpen).toList()));
    } catch (e) {
      onShowMessage(message: 'Erro ao buscar reuniões', color: Colors.red);
      developer.log(e.toString());
    }
  }

  @override
  Future<void> getPresences() async {
    try {
      final presences = await presenceRepository.getPresencesByUser(userController.userLogged.id, null);
      setPresences(presences);
    } catch (e) {
      onShowMessage(message: identifyError(error: e, message: 'Erro ao buscar presenças'), color: Colors.red);
      developer.log(e.toString());
    }
  }

  @override
  Future<void> getPresencesPagination() async {
    try {
      final lastDateMeeting = meetingsClosed.last.date;
      final presences = await presenceRepository.getPresencesByUser(userController.userLogged.id, lastDateMeeting);
      setPresences(presences);
    } catch (e) {
      onShowMessage(message: identifyError(error: e, message: 'Erro ao buscar presenças'), color: Colors.red);
      developer.log(e.toString());
    }
  }

  @override
  Future<bool> checkPresence(MeetingModel meeting) async {
    if (formKey.currentState?.validate() == false) {
      return false;
    }
    try {
      setButtonCheckPresenceIsLoading(true);
      await createPresence(meeting.id, meeting.date);
      await updatePresenceUser(meeting.date);
      userController.setUser(
        userController.userLogged.copyWith(
          lastPresence: meeting.date,
          totalPresence: userController.userLogged.totalPresence + 1,
        ),
      );
      onShowMessage(message: 'Presença confirmada', color: Colors.green);
      passwordController.clear();
      init();
      return true;
    } catch (e) {
      onShowMessage(message: identifyError(error: e, message: 'Erro ao confirmar presença'), color: Colors.red);
      developer.log(e.toString());
      return false;
    } finally {
      setButtonCheckPresenceIsLoading(false);
    }
  }

  @override
  Future<void> createPresence(String idMeeting, DateTime dateMeeting) async {
    final presence = PresenceDto(
      date: dateMeeting,
      idMeeeting: idMeeting,
      idUser: userController.userLogged.id,
    );
    await presenceRepository.createPresence(presence);
  }

  @override
  Future<void> updatePresenceUser(DateTime dateMeeting) async {
    await userRepository.updateUser(
      idUser: userController.userLogged.id,
      data: {
        'lastPresence': dateMeeting,
        "totalPresence": userController.userLogged.totalPresence + 1,
      },
    );
  }

  @override
  StatusPresenceMeeting getStatusPresenceMeeting(MeetingModel meeting) {
    final PresenceModel? presence = presences.any((element) => element.idMeeting == meeting.id) ? presences.firstWhere((element) => element.idMeeting == meeting.id) : null;
    if (meeting.isOpen == false) {
      if (presence == null) {
        return StatusPresenceMeeting.closed;
      }
    }

    if (presence == null) {
      return StatusPresenceMeeting.open;
    }

    return StatusPresenceMeeting.checked;
  }

  @override
  bool verifyPassword(String passwordMeeting) {
    final normalizedPassword = passwordMeeting.trim().toLowerCase().removeDiacritics();
    final normalizedInput = passwordController.text.trim().toLowerCase().removeDiacritics();
    return normalizedPassword == normalizedInput;
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
  void setPresences(List<PresenceModel> value) {
    presences = value;
    notifyListeners();
  }

  @override
  void setButtonCheckPresenceIsLoading(bool value) {
    buttonCheckPresenceIsLoading = value;
    notifyListeners();
  }

  @override
  void setAsyncState(AsyncState state) {
    asyncState = state;
    notifyListeners();
  }

  @override
  void setButtonGetMeetingsPaginationIsLoading(bool value) {
    buttonGetMeetingsPaginationIsLoading = value;
    notifyListeners();
  }
}
