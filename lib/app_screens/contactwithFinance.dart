import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components.dart';
import '../widget/base_components/custom_elevated_button_widget.dart';

class Contactwithfinance extends StatefulWidget {
  const Contactwithfinance({super.key});

  @override
  State<Contactwithfinance> createState() => _ContactwithfinanceState();
}

class _ContactwithfinanceState extends State<Contactwithfinance> {
  TextEditingController textc=TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> addRecord() async {
    try {
      DocumentReference docRef = _firestore.collection('ABC Company').doc("withfinance");
      DocumentSnapshot documentSnapshot = await docRef.get();
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>? ?? {};

      List<dynamic> textlist = data['textlist'] as List<dynamic>? ?? [];
      textlist.add({
        "text":textc.text,
      });

      await docRef.update({'textlist': textlist});
      print("New attendance record added successfully.");
      return true;
    } catch (e) {
      print("Error adding new attendance record: $e");
      return false;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact with finance"),
      ),
      body: Column(
        children: [

          SizedBox(height: 10.h,),

          Text("please type your information"),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green,width: 3),
              ),
              child: TextField(
                decoration:
                InputDecoration(labelText: 'Enter Ruels and Regulations,',),
                controller: textc,
                keyboardType: TextInputType.multiline,
                minLines: 5, // <-- SEE HERE
                maxLines: 10, // <-- SEE HERE
              ),
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

                await addRecord();

              }),
        ],
      ),
    );
  }
}
