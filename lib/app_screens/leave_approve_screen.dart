
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_series/controller/storageController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class LeaveApproveScreen extends StatefulWidget {


  @override
  State<LeaveApproveScreen> createState() => _LeaveApproveScreenState();
}

class _LeaveApproveScreenState extends State<LeaveApproveScreen> {

StorageController store=Get.put(StorageController());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> fetchLeaveApplication(String email) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('ABC Company').doc('leave_application_document').collection('applications').doc(email).get();
      return doc.data() as Map<String, dynamic>?;
    } catch (e) {
      print("Error fetching leave application: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("See application status"),
      ),
      body: Column(
        children: [


          SizedBox(height: 20),
          FutureBuilder<Map<String, dynamic>?>(
            future: fetchLeaveApplication(store.userEmail.toString()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data == null) {
                return Text('No leave application found.');
              } else {
                Map<String, dynamic> data = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Date: ${data['Date']}'),
                    Text('Reason: ${data['Reason']}'),
                    Text('Leave Type: ${data['Leave Type']}'),
                    Text('Result: ${data['result']}'),
                  ],
                );
              }
            },
          ),
        ],
      ),


    );
  }
}