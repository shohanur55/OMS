import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components.dart';
import '../widget/others/custom_list_tile.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> _fetchDocumentData() async {
    try {
      DocumentSnapshot documentSnapshot = await _firestore
          .collection('ABC Company')
          .doc("user_info")
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
        title: Text("Employee List"),
        centerTitle: true,
      ),
body:   Column(
  children: [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
        color: Theme.of(context).primaryColor,
        child: const Row(
          children: [
            CustomListTile(text: "Email", isHeading: true),
            CustomListTile(text: "Password", isHeading: true),

          ],
        ),
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
            List<dynamic>? userList = data['user_list'] as List<dynamic>?;

            if (userList == null || userList.isEmpty) {
              return Center(child: Text('No records found.'));
            }


            return ListView(
              padding: EdgeInsets.all(16.0),
              children: [

                ...userList.map((attendance) {
                  var attendanceMap = attendance as Map<String, dynamic>;
                  return  Container(
                    padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                    color: Theme.of(context).primaryColor,
                    child:  Row(
                      children: [
                        CustomListTile(text:"${attendanceMap['email']} " , isHeading: true),
                        CustomListTile(text: "${attendanceMap['password']}" , isHeading: true),


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
