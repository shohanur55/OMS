
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_series/app_screens/givenTask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Softwarehod extends StatefulWidget {
  const Softwarehod({super.key});

  @override
  State<Softwarehod> createState() => _SoftwarehodState();
}

class _SoftwarehodState extends State<Softwarehod> {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> _fetchDocumentData() async {
    try {
      DocumentSnapshot documentSnapshot = await _firestore
          .collection('ABC Company')
          .doc("give_response")
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
        title: Text("Employee response list"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
Get.to(()=>Giventask());
          }, icon: Icon(Icons.add, size: 30.sp)),
        ],
      ),

      body:   Column(
        children: [

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
                  List<dynamic>? userList = data['task_list'] as List<dynamic>?;

                  if (userList == null || userList.isEmpty) {
                    return Center(child: Text('No records found.'));
                  }


                  return ListView(
                    padding: EdgeInsets.all(16.0),
                    children: [

                      ...userList.map((attendance) {
                        var attendanceMap = attendance as Map<String, dynamic>;
                        return Card(
                          child: ListTile(
                            tileColor: Theme.of(context).cardColor,
                            title: Text(
                              'Response From:${attendanceMap['name']}',style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold),),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Submission Date: ${attendanceMap['datetime']}',style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold),),
                                Text(
                                  'Task Name: ${attendanceMap['task_name']}',style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold),),
                                Text(
                                  'Task Description: ${attendanceMap['task_description']}',style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold),),
                                Text(
                                  'Task status: ${attendanceMap['status']}',style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold),),


                              ],
                            ),
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