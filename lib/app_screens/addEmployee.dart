import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_series/app_screens/createAccount.dart';
import 'package:firebase_series/controller/dataController.dart';
import 'package:firebase_series/dashboard_menu_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../components.dart';
import '../uiHelper.dart';
import '../widget/base_components/custom_elevated_button_widget.dart';
import '../widget/custom_text_field1.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  DataController _controller = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.populateMenu();
  }

  TextEditingController emailc = TextEditingController();
  TextEditingController namec = TextEditingController();
  TextEditingController departmentc = TextEditingController();
  TextEditingController designationc = TextEditingController();
  TextEditingController salaryc = TextEditingController();
  TextEditingController rulec = TextEditingController();



  final FirebaseFirestore _firestore = FirebaseFirestore.instance;



  Future<void> saveData() async {
    if (emailc.text=="" || namec.text == "" || departmentc.text == "" || designationc.text == "" ||
        salaryc.text == "" || rulec.text == "" || _controller.selectedOptionslist.value.isEmpty) {

      UiHelper.CustomAlertDialog(context, "Please fill up all requirement");

    } else {
      try {
        await updateMenuListInFirebase();
        UiHelper.CustomAlertDialog(context!, "Save successful");
        print("Data saved successfully!");
      } catch (e) {
        UiHelper.CustomAlertDialog(context, e.toString());
        print("Error saving data: $e");
      }
    }
  }

  Future<void> updateMenuListInFirebase() async {
    List<DashboardMenuModel> menu = _controller.menu.toList();
    // Create the new menulist from selected options
    List<Map<String, dynamic>> newMenuList = createMenuListFromSelectedOptions(
        _controller.selectedOptionslist.value.cast<int>(),
        menu
    );

    // Create the data map to update
    Map<String, dynamic> data = {
      'menulist': newMenuList,
      'Name': namec.text,
      'Department': departmentc.text,
      'Designation': designationc.text,
      'Salary': salaryc.text,
      'Rules': rulec.text,
    };

    try {
      await _firestore.collection('ABC Company').doc(emailc.text).set(data);
    } catch (e) {
      print("Error updating document: $e");
    }
  }

  List<Map<String, dynamic>> createMenuListFromSelectedOptions(List<int> selectedOptions, List<DashboardMenuModel> menu) {
    return selectedOptions.map((menuId) {
      DashboardMenuModel? menuItem = menu.firstWhere((item) => item.menuId == menuId, orElse: () => DashboardMenuModel(menuId: menuId, menuName: "Unknown"));
      return menuItem.toJson();
    }).toList();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Or Update Employee"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: ListView(
            children: [
              Text(
                "Do you have account?",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              Text("Please create a account for new person"),
              SizedBox(height: 10.h),
              Center(
                child: CustomElevatedButton(
                    expanded: false,
                    border: Border.all(
                        width: borderWidth2,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color: Theme.of(context).cardColor),
                    child: const Text("Create Account"),
                    onTap: () {
                      print("my......................................................................      data"+_controller.selectedOptionslist.toString());
                      Get.to(() => Createaccount());
                    }),
              ),
              SizedBox(height: 15.h),
              Container(
                height: 2,
                color: Colors.grey,
              ),
              SizedBox(
                height: 5.sp,
              ),
              Text(
                "Please fill up all requirement",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              SizedBox(
                height: 5.sp,
              ),
              Text(
                "Email",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              CustomTextField1(
                textEditingController: emailc,
                keyboardType: TextInputType.emailAddress,
                hintText: "Enter employee email",
                svg: "lib/assets/icons/message_icon.svg",
                //validator: (value) => !_controller.isEmail.value ? null : emailValidation(_controller.email),
              ),
              SizedBox(
                height: 5.sp,
              ),
              Text(
                "Name",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              CustomTextField1(
                textEditingController: namec,
                keyboardType: TextInputType.emailAddress,
                hintText: "Enter employee name",
                svg: "lib/assets/icons/message_icon.svg",
                //validator: (value) => !_controller.isEmail.value ? null : emailValidation(_controller.email),
              ),
              SizedBox(
                height: 5.sp,
              ),
              Text(
                "Department",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              CustomTextField1(
                textEditingController: departmentc,
                keyboardType: TextInputType.text,
                hintText: "Enter employee department",
                svg: "lib/assets/icons/message_icon.svg",
                //validator: (value) => !_controller.isEmail.value ? null : emailValidation(_controller.email),
              ),
              SizedBox(
                height: 5.sp,
              ),
              Text(
                "Designation",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              CustomTextField1(
                textEditingController: designationc,
                keyboardType: TextInputType.text,
                hintText: "Enter employee designation",
                svg: "lib/assets/icons/message_icon.svg",
                //validator: (value) => !_controller.isEmail.value ? null : emailValidation(_controller.email),
              ),
              SizedBox(
                height: 5.sp,
              ),
              Text(
                "Salary",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              CustomTextField1(
                textEditingController: salaryc,
                keyboardType: TextInputType.number,
                hintText: "Enter employee Salary",
                svg: "lib/assets/icons/message_icon.svg",
                //validator: (value) => !_controller.isEmail.value ? null : emailValidation(_controller.email),
              ),
              SizedBox(
                height: 5.sp,
              ),
              Text(
                "Rules and regulations",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green,width: 3),
                ),
                child: TextField(
                  decoration:
                      InputDecoration(labelText: 'Enter Ruels and Regulations,',),
                  controller: rulec,
                  keyboardType: TextInputType.multiline,
                  minLines: 5, // <-- SEE HERE
                  maxLines: 10, // <-- SEE HERE
                ),
              ),
              SizedBox(
                height: 5.sp,
              ),
              Text(
                "Select page for this employee",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),

              MultiSelectDialogField(
                items: _controller.options,
                title: Text("Select page for emeployee"),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        const BorderRadius.all(Radius.circular(3)),
                    border: Border.all(
                      color: Colors.green,
                      width: 2,
                    )),
                buttonIcon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.blue,
                ),
                onConfirm: (results){
                  _controller.selectedOptionslist.value=[];
                  for(var i=0; i< results.length;i++){
                    DashboardMenuModel data=results[i] as DashboardMenuModel;
                    _controller.selectedOptionslist.value.add(data.menuId);
                  }
                },
              ),
              SizedBox(
                height: 10.sp,
              ),
              CustomElevatedButton(
                  expanded: false,
                  border: Border.all(
                      width: borderWidth2,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: Theme.of(context).cardColor),
                  child: const Text("Save Account"),
                  onTap: () async{
                   await saveData();


                  }),
            ],
          ),
        ));
  }
}
