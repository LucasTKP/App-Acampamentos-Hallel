import 'package:permission_handler/permission_handler.dart';

abstract class PermissionHandler {
  Future<PermissionStatus> checkPermissionStatus(Permission permission);
  Future<PermissionStatus> requestPermission(Permission permission);
  Future<bool> openSettings();
}

class PermissionHandlerImpl implements PermissionHandler {
  @override
  Future<PermissionStatus> checkPermissionStatus(Permission permission) async {
    return await permission.status;
  }

  @override
  Future<PermissionStatus> requestPermission(Permission permission) async {
    return await permission.request();
  }

  @override
  Future<bool> openSettings() {
    return openAppSettings();
  }
}
