import 'dart:io';
import 'package:app_acampamentos_hallel/core/global_controllers/user_controller.dart';
import 'package:app_acampamentos_hallel/core/models/async_state.dart';
import 'package:app_acampamentos_hallel/core/models/dropdown.dart';
import 'package:app_acampamentos_hallel/core/repositories/user_repository.dart';
import 'package:app_acampamentos_hallel/core/utils/identify_error.dart';
import 'package:app_acampamentos_hallel/core/utils/internal_errors.dart';
import 'package:app_acampamentos_hallel/core/utils/theme_colors.dart';
import 'package:app_acampamentos_hallel/ui/profile/profile_dto.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:developer' as developer;
import 'package:image_picker/image_picker.dart';

abstract class ProfileController extends ChangeNotifier {
  AsyncState asyncState = AsyncState.initial;
  List<DropdownModel> itemsDropdownOne = [DropdownModel(value: 'true', label: 'Sim'), DropdownModel(value: 'false', label: 'Não')];
  List<DropdownModel> itemsDropdownTwo = List.generate(18, (index) => DropdownModel(value: '${2024 - index}', label: '${2024 - index}')).toList();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isEdit = false;

  String urlImage = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  late DropdownModel madeCamping;
  late DropdownModel madeCaneYear;
  TextEditingController totalPresenceController = TextEditingController();

  void init();
  Future<void> updateImage();
  Future<void> updateProfile();

  void setIsEdit(bool value);
  void setMadeCamping(DropdownModel value);
  void setMadeCaneYear(DropdownModel value);
  void setAsyncState(AsyncState value);
  void setUrlImage(String value);
}

class ProfileControllerImpl extends ProfileController {
  final UserController userController;
  final UserRepository userRepository;
  final Function({required String message, required Color color}) onShowMessage;

  ProfileControllerImpl({required this.userController, required this.userRepository, required this.onShowMessage}) {
    init();
  }

  @override
  void init() {
    setUrlImage(userController.userLogged.photoUrl);
    nameController.text = userController.userLogged.name;
    emailController.text = userController.userLogged.email;
    dateOfBirthController.text = userController.userLogged.dateOfBirth ?? '';
    madeCamping = itemsDropdownOne.where((element) => element.value == userController.userLogged.madeCane.toString()).first;
    madeCaneYear = itemsDropdownTwo.first;
    totalPresenceController.text = userController.userLogged.totalPresence.toString();
  }

  @override
  Future<void> updateImage() async {
    try {
      final pickedFile = await onSelectImage();

      if (pickedFile != null) {
        setAsyncState(AsyncState.loading);

        await verifyFile(pickedFile);
        final idUser = userController.userLogged.id;
        final nameImage = pickedFile.path.split('/').last;
        final storagePathUpload = 'imageProfile/$idUser/$nameImage';
        final storagePathDelete = 'imageProfile/$idUser/${userController.userLogged.namePhoto}';

        final response = await userRepository.uploadFile(file: pickedFile, storagePath: storagePathUpload);

        await userRepository.updateUser(idUser: idUser, data: {'photoUrl': response, 'namePhoto': nameImage});

        userController.setUser(userController.userLogged.copyWith(photoUrl: response, namePhoto: nameImage));

        setUrlImage(response);

        await userRepository.deleteFile(storagePathDelete);

        onShowMessage(message: 'Imagem atualizada com sucesso', color: Colors.green);
      }
    } catch (e) {
      developer.log(e.toString());
      onShowMessage(message: identifyError(error: e, message: "Não foi possivél atualizar a imagem."), color: Colors.red);
    } finally {
      setAsyncState(AsyncState.initial);
    }
  }

  Future<File?> onSelectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final fileCropped = await cropImage(pickedFile);
      if (fileCropped != null) {
        return fileCropped;
      }
    }
    return null;
  }

  Future<void> verifyFile(File file) async {
    final fileSize = await file.length();
    const maxFileSize = 10 * 1024 * 1024;

    if (fileSize > maxFileSize) {
      throw InternalErrors(message: 'A imagem deve ter no máximo 10MB');
    }
  }

  Future<File?> cropImage(XFile image) async {
    final imageCropped = await ImageCropper().cropImage(
      sourcePath: image.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Selecionar Área',
          hideBottomControls: true,
          toolbarColor: ThemeColors.primaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
          ],
        ),
        IOSUiSettings(
          title: 'Selecionar Área',
          aspectRatioLockEnabled: true,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
          ],
        ),
      ],
    );
    if (imageCropped != null) {
      final croppedFile = File(imageCropped.path);
      return croppedFile;
    }
    return null;
  }

  @override
  Future<void> updateProfile() async {
    if (formKey.currentState!.validate() == false) return;
    try {
      setAsyncState(AsyncState.loading);
      final updateUser = UpdateUserDto(
        name: nameController.text,
        madeCane: madeCamping.value == 'true',
        madeCaneYear: madeCamping.value == 'true' ? int.parse(madeCaneYear.value) : null,
        dateOfBirth: dateOfBirthController.text,
      );
      await userRepository.updateUser(idUser: userController.userLogged.id, data: updateUser.toJson());
      onShowMessage(message: 'Perfil atualizado com sucesso', color: Colors.green);
      userController.setUser(
        userController.userLogged.copyWith(
          name: nameController.text,
          madeCane: madeCamping.value == 'true',
          madeCaneYear: int.parse(madeCaneYear.value),
          dateOfBirth: dateOfBirthController.text,
        ),
      );
      setIsEdit(false);
    } catch (e) {
      onShowMessage(message: identifyError(error: e, message: 'Erro ao atualizar perfil'), color: Colors.red);
      developer.log(e.toString());
    } finally {
      setAsyncState(AsyncState.initial);
    }
  }

  @override
  void setIsEdit(bool value) {
    isEdit = value;
    notifyListeners();
  }

  @override
  void setMadeCamping(DropdownModel value) {
    madeCamping = value;
    notifyListeners();
  }

  @override
  void setMadeCaneYear(DropdownModel value) {
    madeCaneYear = value;
    notifyListeners();
  }

  @override
  void setAsyncState(AsyncState value) {
    asyncState = value;
    notifyListeners();
  }

  @override
  void setUrlImage(String value) {
    urlImage = value;
    notifyListeners();
  }
}
