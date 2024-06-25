import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components.dart';
import '../uiHelper.dart';
import '../widget/base_components/custom_elevated_button_widget.dart';
import '../widget/custom_text_field1.dart';

class Applicationlist extends StatefulWidget {
  const Applicationlist({super.key});

  @override
  State<Applicationlist> createState() => _ApplicationlistState();
}

class _ApplicationlistState extends State<Applicationlist> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchAllLeaveApplications() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('ABC Company')
          .doc('leave_application_document')
          .collection('applications')
          .get();
      List<QueryDocumentSnapshot> docs = querySnapshot.docs;
      return docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      print("Error fetching leave applications: $e");
      return [];
    }
  }
TextEditingController results=TextEditingController();

  Future<void> submitLeaveApplication(String emial,String date,String reason,String leave) async {




      Map<String, dynamic> data = {
        "email":emial,
        "Date": date,
        "Reason": reason,
        "Leave Type": leave,
        "result": results.text.toString(),
      };

      try {
        await _firestore.collection('ABC Company').doc('leave_application_document').collection('applications').doc(emial).set(data);
        print("Leave application submitted successfully.");
        UiHelper.CustomAlertDialog(context!, "success");
      } catch (e) {
        print("Error submitting leave application: $e");
      }




  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Application List"),
      ),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: fetchAllLeaveApplications(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No leave applications found.'));
            } else {
              List<Map<String, dynamic>> data = snapshot.data!;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> application = data[index];
                  return ListTile(
                    title: Text("email:"+application['email']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Leave type:"+application['Leave Type']),
                        Text('Date: ${application['Date']}'),
                        Text('Reason: ${application['Reason']}'),
                        Text('Result: ${application['result']}'),

                        CustomTextField1(
                          textEditingController: results,
                          keyboardType: TextInputType.none,
                          hintText: "Please type accepted or rejected",
                          svg: "lib/assets/icons/message_icon.svg",
                          //validator: (value) => !_controller.isEmail.value ? null : emailValidation(_controller.email),
                        ),

                        CustomElevatedButton(
                            expanded: false,
                            border: Border.all(
                                width: borderWidth2,
                                strokeAlign: BorderSide.strokeAlignOutside,
                                color: Theme.of(context).cardColor),
                            child: const Text("submit"),
                            onTap: () async{

                              await  submitLeaveApplication(application['email'],application['Date'],application['Reason'],application['Leave Type'],);

                            }),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ));
  }
}
