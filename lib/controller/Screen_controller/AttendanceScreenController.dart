import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_series/controller/dataController.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../model/post_attendance_model.dart';
import '../../widget/current_location_data.dart';
import '../../widget/get_permission.dart';
import '../../widget/snackbar.dart';
import '../storageController.dart';

class AttendanceScreenController extends GetxController {
  DataController _controller=Get.put(DataController());
  StorageController store = Get.put(StorageController());
  var postData = PostAttendanceModel().obs;
  var buttonText = ''.obs;
  var isLoading = false.obs;
  var isValidate = false.obs;
  var locationString = ''.obs;
  var gettingLocation = false.obs;
  var isScan = RxnBool();
  var type = "".obs;

  @override
  void onInit() {
    super.onInit();
    getData();
    getLocation();
  }

  Future<void> getData() async {
    if (isLoading.value) return;

    isLoading.value = true;
    String res = await store.userEmail.toString();
    res = res.replaceAll("\"", "").trim();
    type.value = res.isEmpty ? "" : res;
    isLoading.value = false;
  }
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
      locationString.value = "Location service not enabled";
      showToast(message: "Location service not enabled");
      return false;
    }

    gettingLocation.value = true;

    Position currentLocation = await Geolocator.getCurrentPosition();
    latitude = currentLocation.latitude;
    longitude = currentLocation.longitude;
    locationString.value =await _controller.getAddressFromCoordinates(latitude!,longitude!);
    postData.value = postData.value.copyWith(latitude: latitude.toString(), longitude: longitude.toString());



    String ln = await getLocationData(latitude: latitude, longitude: longitude);
    if (ln.isNotEmpty) {
      postData.value.locationName = ln;
     // locationString.value = postData.value.locationName;
    }

    gettingLocation.value = false;
    checkValidation();
    return null;
  }

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

  void removeData() {
    postData.value = postData.value.copyWith(
      picFront: null,
      picBack: null,
    );
    checkValidation();
  }

  void onTapButton(bool b) {
    isScan.value = b;
    removeData();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> _fetchDocumentData() async {
    try {
      DocumentSnapshot documentSnapshot = await _firestore
          .collection('ABC Company')
          .doc(store.userEmail.value)
          .get();
      return documentSnapshot.data() as Map<String, dynamic>? ?? {};
    } catch (e) {
      print("Error fetching document: $e");
      return {};
    }
  }

  Future<bool> _addNewAttendanceRecord(String date, String time, String location) async {
    try {
      DocumentReference docRef = _firestore.collection('ABC Company').doc(store.userEmail.value);
      DocumentSnapshot documentSnapshot = await docRef.get();
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>? ?? {};

      List<dynamic> attendanceList = data['attendence'] as List<dynamic>? ?? [];
      attendanceList.add({
        'date': date,
        'time': time,
        'location': location,
      });

      await docRef.update({'attendence': attendanceList});
      print("New attendance record added successfully.");
      return true;
    } catch (e) {
      print("Error adding new attendance record: $e");
      return false;
    }
  }
  Future<bool?> submitData() async {
    if (isLoading.value) return false;
String time=DateFormat('hh:mm a').format(DateTime.now());
String dates=DateFormat.yMMMd().format(DateTime.now());
    isLoading.value = true;
    bool res =await _addNewAttendanceRecord(dates,time,locationString.value); // Submit logic
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
