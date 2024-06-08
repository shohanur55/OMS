
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class AttendanceScreenController extends GetxController {




  RxnBool isScan = RxnBool();
  RxString type = "".obs;
  RxBool isLoading = false.obs;

  Future<void> getData() async {
    if (isLoading.value) return;

    isLoading.value = true;



    // res = "Scan";



    isLoading.value = false;
  }

  //! ---------------------------------------------------------------------------------------------- Location
  RxString locationString = "".obs;
  RxBool gettingLocation = false.obs;
  double? latitude;
  double? longitude;

  Future<bool?> getLocation() async {
    if (gettingLocation.value) return null;

    locationString.value = "";

    if (!await askPermission(Permission.location)) {
      locationString.value = "No permission";
      return false;
    }

    if (!await Geolocator.isLocationServiceEnabled()) {
      locationString.value = "Location service not enable";
      showToast(message: "Location service not enable");
      return false;
    }

    gettingLocation.value = true;

    // Getting location
    Position currentLocation = await Geolocator.getCurrentPosition();

    latitude = currentLocation.latitude;
    longitude = currentLocation.longitude;

    locationString.value = "Latitude: $latitude\nLongitude: $longitude";

    postData.value = postData.value.copyWith(latitude: latitude.toString(), longitude: longitude.toString());

    String ln = await getLocationData(latitude: latitude, longitude: longitude);
    if (ln.isNotEmpty) {
      postData.value.locationName = ln;
      locationString.value = postData.value.locationName;
    }

    gettingLocation.value = false;
    checkValidation();
    return null;
  }

  //! ---------------------------------------------------------------------------------------------- For Validation
  RxString buttonText = "".obs;
  RxBool isValidate = false.obs;

  void checkValidation() {
    if (isScan.value == null) {
      isValidate.value = false;
      buttonText.value = "";
      return;
    }

    if (latitude == null || longitude == null) {
      isValidate.value = false;
      buttonText.value = "Provide Location Information";
      return;
    }

    // Scan
    if (isScan.value!) {
      if (barcode == null) {
        isValidate.value = false;
        buttonText.value = "Scan valid Barcode";
        return;
      }

      double d = getLocationDistance(startLatitude: latitude!, startLongitude: longitude!, endLatitude: barcode!.latitude, endLongitude: barcode!.longitude);
      if (d > 200) {
        isValidate.value = false;
        buttonText.value = "Your current location is not matched";
        return;
      }
    }

    postData.value = postData.value.copyWith(
      latitude: latitude.toString(),
      longitude: longitude.toString(),
      picFront: postData.value.picFront,
      picBack: postData.value.picBack,
    );

    String st = postData.value.isValidate(isScan.value!);
    if (st.isNotEmpty) {
      isValidate.value = false;
      buttonText.value = st;
      return;
    }

    isValidate.value = true;
    buttonText.value = "Submit";
  }

  //! ---------------------------------------------------------------------------------------------- Scan
  PostBarcodeModel? barcode;

  //! ---------------------------------------------------------------------------------------------- Image Picture
  final Rx<XFile?> frontImage = Rxn();
  final Rx<XFile?> backImage = Rxn();

  Future<bool> getImage({bool isBack = false}) async {
    XFile? f = await getCameraImage(isBack ? CameraDevice.rear : CameraDevice.front);
    if (f == null) return false;
    String? s = await imageXFileToString(f.path);
    if (s == null) return false;

    if (!isBack) {
      postData.value = postData.value.copyWith(
        picFront: s,
        picBack: postData.value.picBack,
      );
      frontImage.value = f;
    } else {
      postData.value = postData.value.copyWith(
        picFront: postData.value.picFront,
        picBack: s,
      );
      backImage.value = f;
    }

    checkValidation();
    return true;
  }

  removeData() {
    barcode = null;
    frontImage.value = null;
    backImage.value = null;
    postData.value = postData.value.copyWith(
      picFront: null,
      picBack: null,
    );
    checkValidation();
  }

  onTapButton(bool b) {
    isScan.value = b;

    removeData();
  }

  Future<bool?> submitData() async {
    if (isLoading.value) return false;
    // if (isScan.value == null) return false;
    if (postData.value.isValidate(isScan.value).isNotEmpty) return false;

    isLoading.value = true;
    bool res = await _controller.submitAttendance(postAttendanceModel: postData.value);
    if (res == false) return res;

    await showSnackBar(
      title: "Success",
      message: "Attendance was submitted successfully at time ${DateFormat('hh:mm a').format(DateTime.now())}",
    );

    isLoading.value = false;

    Get.back();

    return null;
  }
}
