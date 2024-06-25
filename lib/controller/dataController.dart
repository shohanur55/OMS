import 'dart:ffi';

import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:connection_notifier/connection_notifier.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../dashboard_menu_model.dart';
class DataController extends GetxController{
  final RxBool isConnected = true.obs;
String departments="";

  Future<void> initApp() async {
    await _networkConnectivity();
    populateMenu();

  }
  Future<void> _networkConnectivity() async {
    await ConnectionNotifierTools.initialize();
    isConnected.value = ConnectionNotifierTools.isConnected;

    ConnectionNotifierTools.onStatusChange.listen((event) async {
      isConnected.value = event;

    });
  }

  Future<String> getAddressFromCoordinates(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        return "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";
      }
    } catch (e) {
      print("Error occurred while getting address: $e");
    }
    return "Unknown location";
  }
  RxList<DashboardMenuModel> menu=<DashboardMenuModel>[].obs;
  Rx<List<dynamic>> selectedOptionslist=Rx<List<dynamic>>([]);
 // Rx<List<dynamic>> options=Rx<List<dynamic>>([]);
    List<MultiSelectItem>options=[];


 void populateMenu() {
  options=menu.map((menu){
  return MultiSelectItem(menu, menu.menuName??"unknown");
  }).toList();
update();
  print("shohan...................................................");
  print(options);
 for(dynamic i in menu.value){
   print(i.menuId);
   print(i.menuName);
   print("sh\n");
 }
  }

}