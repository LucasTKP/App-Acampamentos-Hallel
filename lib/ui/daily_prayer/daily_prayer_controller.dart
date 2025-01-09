import 'package:app_acampamentos_hallel/core/extensions/date_time_extension.dart';
import 'package:app_acampamentos_hallel/core/global_controllers/user_controller.dart';
import 'package:app_acampamentos_hallel/core/models/async_state.dart';
import 'package:app_acampamentos_hallel/core/models/prayer.dart';
import 'package:app_acampamentos_hallel/core/repositories/prayers_repository.dart';
import 'package:app_acampamentos_hallel/core/utils/identify_error.dart';
import 'package:app_acampamentos_hallel/ui/daily_prayer/daily_prayer_dto.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

abstract class DailyPrayerController extends ChangeNotifier {
  AsyncState state = AsyncState.initial;
  bool buttonSaveIsLoading = false;
  bool todayIsSelected = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();

  List<PrayerModel> prayersToday = [];
  List<PrayerModel> prayersYesterday = [];

  Future<bool> createPrayer();
  Future<bool> updatePrayer(PrayerModel prayer);
  Future<void> getDailyPrayers();

  void setState(AsyncState value);
  void setPrayersToday(List<PrayerModel> value);
  void setPrayersYesterday(List<PrayerModel> value);
  void setButtonSaveIsLoading(bool value);
  void setTodayIsSelected(bool value);
}

class DailyPrayerControllerImpl extends DailyPrayerController {
  final PrayersRepository repository;
  final UserController userController;
  final Function({required String message, required Color color}) onShowMessage;

  DailyPrayerControllerImpl({required this.repository, required this.userController, required this.onShowMessage}) {
    getDailyPrayers();
  }

  @override
  Future<bool> createPrayer() async {
    if (formKey.currentState?.validate() == false) return false;
    try {
      final dateNow = DateTime.now().zeroTime();
      final user = userController.userLogged;
      setButtonSaveIsLoading(true);
      await repository.createPrayer(
        DailyPrayerDto(
          text: textEditingController.text,
          createdAt: dateNow.toTimestamp(),
          userRequest: UserRequestPrayerModel(id: user.id, name: user.name, photoUrl: user.photoUrl),
        ),
      );
      await Future.delayed(const Duration(seconds: 1));

      textEditingController.clear();
      onShowMessage(message: 'Oração registrada com sucesso', color: Colors.green);
      getDailyPrayers();
      setButtonSaveIsLoading(false);

      return true;
    } catch (e) {
      developer.log('Error on createPrayer', error: e);
      onShowMessage(message: identifyError(error: e, message: 'Erro ao registrar pedido oração'), color: Colors.red);
      setButtonSaveIsLoading(false);

      return false;
    }
  }

  @override
  Future<bool> updatePrayer(PrayerModel prayer) async {
    if (formKey.currentState?.validate() == false) return false;
    try {
      setButtonSaveIsLoading(true);
      await repository.updatePrayer(textEditingController.text, prayer.id);
      await Future.delayed(const Duration(seconds: 1));

      textEditingController.clear();
      onShowMessage(message: 'Oração atualizada com sucesso', color: Colors.green);
      getDailyPrayers();
      setButtonSaveIsLoading(false);

      return true;
    } catch (e) {
      developer.log('Error on updatePrayer', error: e);
      onShowMessage(message: identifyError(error: e, message: 'Erro ao atualizar pedido oração'), color: Colors.red);
      setButtonSaveIsLoading(false);

      return false;
    }
  }

  @override
  Future<void> getDailyPrayers() async {
    try {
      setState(AsyncState.loading);
      final dateNow = DateTime.now().zeroTime();
      final dateYesterday = dateNow.subtract(const Duration(days: 1));
      final prayers = await repository.getDailyPrayer(dateNow.toTimestamp());
      final prayersYesterday = await repository.getDailyPrayer(dateYesterday.toTimestamp());
      await Future.delayed(const Duration(seconds: 1));
      setPrayersToday(prayers);
      setPrayersYesterday(prayersYesterday);
      setState(AsyncState.initial);
    } catch (e) {
      developer.log('Error on getDailyPrayers', error: e);
      onShowMessage(message: identifyError(error: e, message: 'Erro ao buscar orações'), color: Colors.red);
      setState(AsyncState.error);
    }
  }

  @override
  void setState(AsyncState value) {
    state = value;
    notifyListeners();
  }

  @override
  void setPrayersToday(List<PrayerModel> value) {
    prayersToday = value;
    notifyListeners();
  }

  @override
  void setButtonSaveIsLoading(bool value) {
    buttonSaveIsLoading = value;
    notifyListeners();
  }

  @override
  void setPrayersYesterday(List<PrayerModel> value) {
    prayersYesterday = value;
    notifyListeners();
  }

  @override
  void setTodayIsSelected(bool value) {
    todayIsSelected = value;
    notifyListeners();
  }
}
