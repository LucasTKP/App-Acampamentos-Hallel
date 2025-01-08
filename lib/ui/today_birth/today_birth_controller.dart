import 'package:app_acampamentos_hallel/core/models/async_state.dart';
import 'package:app_acampamentos_hallel/core/models/today_birth_model.dart';
import 'package:app_acampamentos_hallel/core/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

abstract class TodayBirthController extends ChangeNotifier {
  AsyncState state = AsyncState.error;
  TodayBirthModel? todayBirth;
  int curretPage = 0;

  late PageController pageTodayBirthController;

  Future<void> getUsersBirthday();
  String getName(String name);
  int getAge(DateTime birthDate);

  void setState(AsyncState value);
  void setTodayBirth(TodayBirthModel value);
  void setCurrentPage(int value);
}

class TodayBirthControllerImpl extends TodayBirthController {
  final UserRepositoryImpl userRepository;
  final Function({required String message, required Color color}) onShowMessage;

  TodayBirthControllerImpl({required this.userRepository, required this.onShowMessage}) {
    pageTodayBirthController = PageController(viewportFraction: 1, initialPage: curretPage);
    pageTodayBirthController.addListener(() {
      setCurrentPage(pageTodayBirthController.page?.round() ?? 0);
    });
    getUsersBirthday();
  }

  @override
  void dispose() {
    pageTodayBirthController.dispose();
    super.dispose();
  }

  @override
  Future<void> getUsersBirthday() async {
    try {
      setState(AsyncState.loading);
      final response = await userRepository.getTodayBirth();
      setTodayBirth(response);
      await Future.delayed(const Duration(seconds: 2));
      setState(AsyncState.initial);
    } catch (e) {
      developer.log('Buscar aniversariantes:', error: e);
      setState(AsyncState.error);
      onShowMessage(message: 'Erro ao buscar aniversariantes', color: Colors.red);
    }
  }

  @override
  String getName(String name) {
    final names = name.split(' ');
    final firstName = names.first;
    final secondName = names.length > 1 ? names[1] : '';
    return '$firstName $secondName'.trim();
  }

  @override
  int getAge(DateTime birthDate) {
    final now = DateTime(2025, 11, 11);
    final age = now.year - birthDate.year;
    final currentMonth = now.month;
    final birthMonth = birthDate.month;
    final currentDay = now.day;
    final birthDay = birthDate.day;

    if (birthMonth > currentMonth) {
      return age - 1;
    } else if (currentMonth == birthMonth) {
      if (birthDay > currentDay) {
        return age - 1;
      }
    }
    return age;
  }

  @override
  void setState(AsyncState value) {
    state = value;
    notifyListeners();
  }

  @override
  void setTodayBirth(TodayBirthModel value) {
    todayBirth = value;
    notifyListeners();
  }

  @override
  void setCurrentPage(int value) {
    curretPage = value;
    notifyListeners();
  }
}
