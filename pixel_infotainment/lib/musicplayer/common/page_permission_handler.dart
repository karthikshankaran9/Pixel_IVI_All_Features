import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  late PermissionStatus status;

  void requirePermission() async {
    status = await Permission.manageExternalStorage.status;

    if (status.isDenied) {
      status = await Permission.manageExternalStorage.request();
    }
    if (status.isGranted) {
      print("Storage permission granted");
    } else {
      print("Storage permission denied");
    }

    // if (status.isDenied) {
    //   status = await Permission.audio.status;
    //   if (status.isDenied) {
    //     status = await Permission.audio.request();
    //   }
    // }
  }

  Future<bool> isPermissionAllowed() async {
    if (status.isGranted) {
      print("Storage permission granted");
      return true;
    } else {
      print("Storage permission denied");
      return false;
    }
  }
}
