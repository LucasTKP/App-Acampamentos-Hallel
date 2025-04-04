import 'dart:io';
import 'package:acamps_canaa/core/extensions/string_extension.dart';
import 'package:acamps_canaa/core/extensions/time_stamp_extension.dart';
import 'package:acamps_canaa/core/global_controllers/user_controller.dart';
import 'package:acamps_canaa/core/models/async_state.dart';
import 'package:acamps_canaa/core/models/dropdown.dart';
import 'package:acamps_canaa/core/repositories/auth_repository.dart';
import 'package:acamps_canaa/core/repositories/user_repository.dart';
import 'package:acamps_canaa/core/utils/identify_error.dart';
import 'package:acamps_canaa/core/utils/internal_errors.dart';
import 'package:acamps_canaa/core/utils/theme_colors.dart';
import 'package:acamps_canaa/ui/profile/profile_dto.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:developer' as developer;
import 'package:image_picker/image_picker.dart';

abstract class ProfileController extends ChangeNotifier {
  AsyncState asyncState = AsyncState.initial;
  List<DropdownModel> itemsDropdownOne = [DropdownModel(value: 'true', label: 'Sim'), DropdownModel(value: 'false', label: 'Não')];
  List<DropdownModel> itemsDropdownTwo = List.generate(18, (index) => DropdownModel(value: '${DateTime.now().year - index}', label: '${DateTime.now().year - index}')).toList();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isEdit = false;

  String urlImage = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController cellPhone = TextEditingController();
  late DropdownModel madeCamping;
  late DropdownModel madeCaneYear;
  TextEditingController totalPresenceController = TextEditingController();

  void init();
  Future<void> updateImage();
  Future<void> updateProfile();
  Future<bool> signOut();

  void setIsEdit(bool value);
  void setMadeCamping(DropdownModel value);
  void setMadeCaneYear(DropdownModel value);
  void setAsyncState(AsyncState value);
  void setUrlImage(String value);
}

class ProfileControllerImpl extends ProfileController {
  final AuthRepository authRepository;
  final UserController userController;
  final UserRepository userRepository;
  final Function({required String message, required Color color}) onShowMessage;

  ProfileControllerImpl({required this.userController, required this.userRepository, required this.onShowMessage, required this.authRepository}) {
    init();
  }

  @override
  void init() {
    setUrlImage(userController.userLogged.photoUrl);
    nameController.text = userController.userLogged.name;
    emailController.text = userController.userLogged.email;
    dateOfBirthController.text = userController.userLogged.dateOfBirth?.toDDMMYYYY() ?? '';
    cellPhone.text = userController.userLogged.cellPhone ?? '';
    madeCamping = itemsDropdownOne.where((element) => element.value == userController.userLogged.madeCane.toString()).first;
    madeCaneYear = itemsDropdownTwo.firstWhere(
      (element) => element.value == userController.userLogged.madeCaneYear.toString(),
      orElse: () => itemsDropdownTwo.first,
    );
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

        setUrlImage(response);
        if (userController.userLogged.namePhoto != "jesus.jpg") {
          await userRepository.deleteFile(storagePathDelete);
        }

        userController.setUser(userController.userLogged.copyWith(photoUrl: response, namePhoto: nameImage));

        onShowMessage(message: 'Imagem atualizada com sucesso', color: Colors.green);
      }
    } catch (e) {
      developer.log(e.toString());
      onShowMessage(message: identifyError(error: e, message: "Não foi possível atualizar a imagem."), color: Colors.red);
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
      compressQuality: 50,
      maxWidth: 500,
      maxHeight: 500,

      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Selecionar Área',
          // hideBottomControls: true,
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
        dateOfBirth: dateOfBirthController.text.toTimestamp(),
        cellPhone: cellPhone.text,
      );
      await userRepository.updateUser(idUser: userController.userLogged.id, data: updateUser.toJson());
      onShowMessage(message: 'Perfil atualizado com sucesso', color: Colors.green);
      userController.setUser(
        userController.userLogged.copyWith(
          name: nameController.text,
          madeCane: madeCamping.value == 'true',
          madeCaneYear: int.parse(madeCaneYear.value),
          dateOfBirth: dateOfBirthController.text.toTimestamp(),
          cellPhone: cellPhone.text,
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
  Future<bool> signOut() async {
    try {
      await authRepository.signOut();
      return true;
    } catch (e) {
      onShowMessage(message: identifyError(error: e, message: 'Não foi possível sair da sua conta'), color: Colors.red);
      developer.log(e.toString());
      return false;
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
