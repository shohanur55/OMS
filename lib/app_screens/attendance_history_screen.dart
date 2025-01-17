
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_series/controller/storageController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../components.dart';
import '../widget/others/custom_list_tile.dart';

class AttendanceHistoryScreen extends StatefulWidget {


  @override
  State<AttendanceHistoryScreen> createState() => _AttendanceHistoryScreenState();
}

class _AttendanceHistoryScreenState extends State<AttendanceHistoryScreen> {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StorageController store=Get.put(StorageController());

  Future<Map<String, dynamic>> _fetchDocumentData() async {
    try {
      DocumentSnapshot documentSnapshot = await _firestore
          .collection('ABC Company')
          .doc(store.userEmail.value)
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
      body:Column(
        children: [
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
