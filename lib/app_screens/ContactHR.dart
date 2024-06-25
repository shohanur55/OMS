import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_series/app_screens/marketAndHr.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../components.dart';
import '../widget/base_components/custom_elevated_button_widget.dart';
import '../widget/custom_text_field1.dart';

class Contacthr extends StatefulWidget {
  const Contacthr({super.key});

  @override
  State<Contacthr> createState() => _ContacthrState();
}

class _ContacthrState extends State<Contacthr> {


  TextEditingController subc=TextEditingController();
  TextEditingController textc=TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> addRecord() async {
    try {
      DocumentReference docRef = _firestore.collection('ABC Company').doc("withHr");
      DocumentSnapshot documentSnapshot = await docRef.get();
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>? ?? {};

      List<dynamic> textlist = data['textlist'] as List<dynamic>? ?? [];
      textlist.add({
        'datetime':DateFormat.yMMMd().format(DateTime.now()).toString(),
        'subject':subc.text,
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
        title: Text("Contact with HR"),
        actions: [
          IconButton(onPressed: (){
Get.to(()=>Marketandhr());
          }, icon: Icon(Icons.message_rounded)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5.sp,
            ),


            Text(
              "Subject name",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            CustomTextField1(
              textEditingController: subc,
              keyboardType: TextInputType.text,
              hintText: "Enter Subject",
              svg: "lib/assets/icons/message_icon.svg",
              //validator: (value) => !_controller.isEmail.value ? null : emailValidation(_controller.email),
            ),
            SizedBox(height: 10.h,),

            Text("please type your information",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green,width: 3),
                ),
                child: TextField(
                  decoration:
                  InputDecoration(labelText: 'Enter your Description message',),
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
      ),
    );
  }
}
