
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_series/controller/storageController.dart';
import 'package:firebase_series/widget/base_components/custom_elevated_button_widget.dart';
import 'package:firebase_series/widget/custom_text_field1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../components.dart';
import '../widget/others/custom_list_tile.dart';

class EmployeeAttendence extends StatefulWidget {


  @override
  State<EmployeeAttendence> createState() => _AttendanceHistoryScreenState();
}

class _AttendanceHistoryScreenState extends State<EmployeeAttendence> {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StorageController store=Get.put(StorageController());
TextEditingController emailcon=TextEditingController();
  Future<Map<String, dynamic>> _fetchDocumentData() async {
    try {
      DocumentSnapshot documentSnapshot = await _firestore
          .collection('ABC Company')
          .doc(emailcon.text)
          .get();
      return documentSnapshot.data() as Map<String, dynamic> ?? {};
    } catch (e) {
      print("Error fetching document: $e");
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendence History"),
        centerTitle: true,
      ),
      body: Column(
          children: [
            SizedBox(
              height: 10.sp,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Please type employee email for see his/her attendence",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30,top: 14,right: 30,bottom: 5),
              child: CustomTextField1(
                textEditingController: emailcon,
                keyboardType: TextInputType.emailAddress,
                hintText: "Enter employee email",
              ),
            ),
        
            Padding(
              padding: const EdgeInsets.only(left:200),
              child: CustomElevatedButton(
                  expanded: false,
                  border: Border.all(
                      width: borderWidth2,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: Theme.of(context).cardColor),
                  child: const Text("Search"),
                  onTap: () async{
        
                    _fetchDocumentData();
                    setState(() {
        
                    });
        
                  }),
            ),
            SizedBox(
              height: 10.sp,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              color: Theme.of(context).primaryColor,
              child: const Row(
                children: [
                  CustomListTile(text: "Punch Date", isHeading: true),
                  CustomListTile(text: "Punch Time", isHeading: true),
                  CustomListTile(text: "Location", isHeading: true),
                ],
              ),
            ),
            Expanded(
        
              child:  FutureBuilder<Map<String, dynamic>>(
                future: _fetchDocumentData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No Data Found'));
                  } else {
                    Map<String, dynamic> data = snapshot.data!;
                    List<dynamic>? attendanceList = data['attendence'] as List<dynamic>?;
        
                    if (attendanceList == null || attendanceList.isEmpty) {
                      return Center(child: Text('No attendance records found.'));
                    }
        
        
                    return ListView(
                      padding: EdgeInsets.all(16.0),
                      children: [
        
                        ...attendanceList.map((attendance) {
                          var attendanceMap = attendance as Map<String, dynamic>;
                          return  Container(
                            padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                            color: Theme.of(context).primaryColor,
                            child:  Row(
                              children: [
                                CustomListTile(text:"${attendanceMap['date']} " , isHeading: true),
                                CustomListTile(text: "${attendanceMap['time']}" , isHeading: true),
                                CustomListTile(text: "${attendanceMap['location']}" , isHeading: true),
        
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    );
                  }
                },
              ),
            )
        
        
          ],
        ),

    );

  }
}
