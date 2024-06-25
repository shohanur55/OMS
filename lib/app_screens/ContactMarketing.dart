import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_series/app_screens/replyMarketing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Contactmarketing extends StatefulWidget {
  const Contactmarketing({super.key});

  @override
  State<Contactmarketing> createState() => _ContactmarketingState();
}

class _ContactmarketingState extends State<Contactmarketing> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> _fetchDocumentData() async {
    try {
      DocumentSnapshot documentSnapshot =
          await _firestore.collection('ABC Company').doc('withHr').get();
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
        title: Text("Marketing Department message"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Get.to(()=>Replymarketing());
          }, icon: Icon(Icons.message_rounded)),
        ],

      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<Map<String, dynamic>>(
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
                  List<dynamic>? userList = data['textlist'] as List<dynamic>?;

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
                              '${attendanceMap['subject']}',
                              style: TextStyle(
                                  fontSize: 16.sp, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ' ${attendanceMap['datetime']}',
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  ' ${attendanceMap['text']}',
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold),
                                ),
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
