import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageController extends GetxController {

 final box = GetStorage();

 RxString userEmail = ''.obs;

 @override
 void onInit() {
  super.onInit();
  // Retrieve saved email from GetStorage
  userEmail.value = box.read('save_email') ?? '';
 }

 void saveEmail(String email) {
  // Save email to GetStorage
  box.write('save_email', email);
  // Update userEmail
  userEmail.value = email;
 }

}
