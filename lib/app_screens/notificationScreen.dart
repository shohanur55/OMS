import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_series/controller/dataController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class notificationScreen extends StatefulWidget {
  const notificationScreen({super.key});

  @override
  State<notificationScreen> createState() => _notificationScreenState();
}

class _notificationScreenState extends State<notificationScreen> {

DataController _controller=Get.put(DataController());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> _fetchDocumentData() async {
    try {
      DocumentSnapshot documentSnapshot = await _firestore
          .collection('ABC Company')
          .doc(_controller.departments)
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
  title: Text("Notification"),
  centerTitle: true,
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
                              '${attendanceMap['datetime']}',style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold),),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ' ${attendanceMap['description']}',style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold),),


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
