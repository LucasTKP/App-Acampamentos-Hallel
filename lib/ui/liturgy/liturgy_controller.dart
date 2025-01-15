import 'package:acamps_canaa/core/models/async_state.dart';
import 'package:acamps_canaa/core/models/liturgy_model.dart';
import 'package:acamps_canaa/core/models/type_liturgy_enum.dart';
import 'package:acamps_canaa/core/repositories/liturgy_repository.dart';
import 'package:acamps_canaa/core/utils/identify_error.dart';
import 'package:acamps_canaa/core/utils/theme_colors.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

abstract class LiturgyController extends ChangeNotifier {
  AsyncState asyncState = AsyncState.initial;
  DateTime dateSelected = DateTime.now();
  LiturgyModel? liturgy;
  TypeLiturgy liturgySelected = TypeLiturgy.primary;
  final PageController pageController = PageController();

  Future<void> getLiturgy();
  Color textButtonColor(TypeLiturgy typeLiturgy);
  Color backgroundButtonColor(TypeLiturgy typeLiturgy);
  Color getColorLiturgy();

  void setAsyncState(AsyncState asyncState);
  void setDateSelected(DateTime date);
  void setLiturgy(LiturgyModel liturgy);
  void setLiturgySelected(TypeLiturgy liturgySelected);
}

class LiturgyControllerImpl extends LiturgyController {
  final LiturgyRepository liturgyRepository;
  final Function({required String message, required Color color}) onShowMessage;

  LiturgyControllerImpl({required this.liturgyRepository, required this.onShowMessage}) {
    getLiturgy();
  }

  @override
  Future<void> getLiturgy() async {
    setAsyncState(AsyncState.loading);
    try {
      final response = await liturgyRepository.getLiturgyByDate(date: dateSelected);
      setLiturgy(response);
      setAsyncState(AsyncState.initial);
    } catch (e) {
      developer.log('Error: $e');
      onShowMessage(message: identifyError(error: e, message: 'Erro ao buscar liturgia'), color: Colors.red);
      setAsyncState(AsyncState.error);
    }
  }

  @override
  Color textButtonColor(TypeLiturgy typeLiturgy) {
    return liturgySelected == typeLiturgy ? Colors.white : ThemeColors.primaryColor;
  }

  @override
  Color backgroundButtonColor(TypeLiturgy typeLiturgy) {
    return liturgySelected == typeLiturgy ? ThemeColors.primaryColor : Colors.transparent;
  }

  @override
  Color getColorLiturgy() {
    switch (liturgy?.color) {
      case 'Verde':
        return Colors.green;
      case 'Vermelho':
        return Colors.red;
      case 'Roxo':
        return Colors.purple;
      case 'Rosa':
        return Colors.pink;
      case 'Branco':
        return Colors.white;
      default:
        return Colors.white;
    }
  }

  @override
  void setDateSelected(DateTime date) {
    dateSelected = date;
    notifyListeners();
    pageController.jumpToPage(0);
    getLiturgy();
  }

  @override
  void setAsyncState(AsyncState asyncState) {
    this.asyncState = asyncState;
    notifyListeners();
  }

  @override
  void setLiturgy(LiturgyModel liturgy) {
    this.liturgy = liturgy;
    notifyListeners();
  }

  @override
  void setLiturgySelected(TypeLiturgy liturgySelected) {
    this.liturgySelected = liturgySelected;
    notifyListeners();
  }
}
