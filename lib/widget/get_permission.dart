//! ---------------------------------------------------------------------------------------------- All permission handling will be here

import 'package:firebase_series/widget/snackbar.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> askPermission(Permission permission) async {
  bool res = false;

  try {
    res = await permission.request() == PermissionStatus.granted;
  } catch (e) {
    print("AskPermission: ${permission.value}: Error: $e");
  }

  showToast(message: res ? "Granted" : "Denied");
  return res;
}
