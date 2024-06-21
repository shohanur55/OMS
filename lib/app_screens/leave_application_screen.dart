
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_series/controller/storageController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../components.dart';
import '../uiHelper.dart';
import '../widget/base_components/custom_elevated_button_widget.dart';
import '../widget/custom_text_field1.dart';
import '../widget/others/custom_list_tile.dart';


class LeaveApplicationScreen extends StatefulWidget {


  @override
  State<LeaveApplicationScreen> createState() => _LeaveApplicationScreenState();
}

class _LeaveApplicationScreenState extends State<LeaveApplicationScreen> {
StorageController store=Get.put(StorageController());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic> leaveData = {};

  @override
  void initState() {
    super.initState();
    fetchLeaveData();
  }

  Future<void> fetchLeaveData() async {
    try {
      DocumentSnapshot doc = await _firestore.collection('ABC Company').doc('leave_number').get();
      setState(() {
        leaveData = doc.data() as Map<String, dynamic>;
      });
    } catch (e) {
      print("Error fetching document: $e");
    }
  }

TextEditingController datec=TextEditingController();
  TextEditingController reasonc=TextEditingController();
  TextEditingController leavec=TextEditingController();


  Future<void> submitLeaveApplication() async {
    if ((datec.text == "") || (reasonc.text == "")|| (leavec.text=="")) {
      UiHelper.CustomAlertDialog(context!, "Please fill up all requirement");
    }

    else{
      Map<String, dynamic> data = {
        "email":store.userEmail.toString(),
        "Date": datec.text,
        "Reason": reasonc.text,
        "Leave Type": leavec.text,
        "result": "pending",
      };

      try {
        await _firestore.collection('ABC Company').doc('leave_application_document').collection('applications').doc(store.userEmail.toString()).set(data);
        print("Leave application submitted successfully.");
        UiHelper.CustomAlertDialog(context!, "success");
      } catch (e) {
        print("Error submitting leave application: $e");
      }


    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Leave Application"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: leaveData.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: leaveData.length,
              itemBuilder: (context, index) {
                String key = leaveData.keys.elementAt(index);
                String value = leaveData[key].toString();
                return  Container(
                  padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                  color: Theme.of(context).primaryColor,
                  child:  Row(
                    children: [
                      Container(
                          width: 100.w,
                          child: Text(key,style: TextStyle(color: Colors.white),)),
                      Text("=",style: TextStyle(color: Colors.white),),
                      SizedBox(width: 10.w,),
                      Text(value==""?"0":value,style: TextStyle(color: Colors.white),),
            
            
                    ],
                  ),
                );
              },
            ),
          ),
          Text(
            "Please type your leave date",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CustomTextField1(
              textEditingController: datec,
              keyboardType: TextInputType.emailAddress,
              hintText: "Ender Date",

            ),
          ), Text(
            "Please type your reason",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CustomTextField1(
              textEditingController: reasonc,
              keyboardType: TextInputType.emailAddress,
              hintText: "Ender your reason",

            ),
          ),  Text(
            "Please type your leave type",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ), Padding(
            padding: const EdgeInsets.all(12.0),
            child: CustomTextField1(
              textEditingController: leavec,
              keyboardType: TextInputType.emailAddress,
              hintText: "Ender leave type",

            ),
          ),
          CustomElevatedButton(
              expanded: false,
              border: Border.all(
                  width: borderWidth2,
                  strokeAlign: BorderSide.strokeAlignOutside,
                  color: Theme.of(context).cardColor),
              child: const Text("submit"),
              onTap: () async{

             await  submitLeaveApplication();

              }),
          SizedBox(height: 20.h,),
        ],

      ),
    );
  }
}