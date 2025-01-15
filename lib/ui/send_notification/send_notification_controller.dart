import 'package:acamps_canaa/core/repositories/user_repository.dart';
import 'package:acamps_canaa/core/utils/identify_error.dart';
import 'package:acamps_canaa/ui/send_notification/send_notification_dto.dart';
import 'package:flutter/material.dart';

abstract class SendNotificationController extends ChangeNotifier {
  bool buttonIsLoading = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future<void> sendNotification();

  void setButtonIsLoading(bool value);
}

class SendNotificationControllerImpl extends SendNotificationController {
  final UserRepositoryImpl userRepository;
  final Function({required String message, required Color color}) onShowMessage;

  SendNotificationControllerImpl({required this.userRepository, required this.onShowMessage});

  @override
  Future<void> sendNotification() async {
    if (!formKey.currentState!.validate()) return;
    try {
      setButtonIsLoading(true);
      final data = SendNotificationDto(title: titleController.text, description: descriptionController.text);
      final response = await userRepository.sendNotification(data);
      if(response.statusCode != 200) throw Exception('Erro ao enviar notificação');
      onShowMessage(message: 'Notificação enviada com sucesso', color: Colors.green);
      titleController.clear();
      descriptionController.clear();
    } catch (e) {
      onShowMessage(message: identifyError(error: e, message: 'Erro ao enviar notificação'), color: Colors.red);
    } finally {
      setButtonIsLoading(false);
    }
  }

  @override
  void setButtonIsLoading(bool value) {
    buttonIsLoading = value;
    notifyListeners();
  }
}
