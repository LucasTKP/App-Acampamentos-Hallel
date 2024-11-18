import 'package:permission_handler/permission_handler.dart';

abstract class PermissionHandler {
  Future<PermissionStatus> checkPermissionStatus(Permission permission);
  Future<PermissionStatus> requestPermission(Permission permission);
  Future<bool> openAppSettings();
}

class PermissionHandlerImpl implements PermissionHandler {
  @override
  Future<PermissionStatus> checkPermissionStatus(Permission permission) {
    return permission.status;
  }

  @override
  Future<PermissionStatus> requestPermission(Permission permission) {
    return permission.request();
  }

  @override
  Future<bool> openAppSettings() {
    return openAppSettings();
  }
}
