import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../components.dart';
import '../widget/base_components/custom_elevated_button_widget.dart';
import '../widget/custom_text_field1.dart';

class Giveresponse extends StatefulWidget {
  const Giveresponse({super.key});

  @override
  State<Giveresponse> createState() => _GiveresponseState();
}

class _GiveresponseState extends State<Giveresponse> {

  TextEditingController namec=TextEditingController();
  TextEditingController topicn=TextEditingController();
  TextEditingController topicd=TextEditingController();
  TextEditingController status=TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<void> sendData() async {
    try {
      DocumentReference docRef = _firestore.collection('ABC Company').doc('give_response');

      await _firestore.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(docRef);

        if (!snapshot.exists) {
          // If the document does not exist, create it with an initial list
          transaction.set(docRef, {
            'task_list': [
              {
                'datetime':DateFormat.yMMMd().format(DateTime.now()).toString(),
                'name': namec.text,
                'task_name':topicn.text,
                'task_description':topicd.text,
                'status':status.text,
              }
            ]
          });
        } else {
          // If the document exists, update the list
          List<dynamic> userList = snapshot['task_list'] ?? [];
          userList.add({
            'datetime':DateFormat.yMMMd().format(DateTime.now()).toString(),
            'name': namec.text,
            'task_name':topicn.text,
            'task_description':topicd.text,
            'status':status.text,

          });

          transaction.update(docRef, {'task_list': userList});
        }
      });

      print('User added successfully');
    } catch (e) {
      print('Error adding user: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Give Task"),
        centerTitle: true,

      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: [
            Text(
              "From",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),

            CustomTextField1(
              textEditingController: namec,
              keyboardType: TextInputType.emailAddress,
              hintText: "Enter Your name",
              svg: "lib/assets/icons/message_icon.svg",
              //validator: (value) => !_controller.isEmail.value ? null : emailValidation(_controller.email),
            ),
            SizedBox(
              height: 5.sp,
            ),


            Text(
              "Topic name",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            CustomTextField1(
              textEditingController: topicn,
              keyboardType: TextInputType.text,
              hintText: "Enter Task Name",
              svg: "lib/assets/icons/message_icon.svg",
              //validator: (value) => !_controller.isEmail.value ? null : emailValidation(_controller.email),
            ),
            Text(
              "Topic Description",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green,width: 3),
              ),
              child: TextField(
                decoration:
                InputDecoration(labelText: 'Enter Task Description',),
                controller: topicd,
                keyboardType: TextInputType.multiline,
                minLines: 5, // <-- SEE HERE
                maxLines: 10, // <-- SEE HERE
              ),
            ),
            Text(
              "Task Status",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            CustomTextField1(
              textEditingController: status,
              keyboardType: TextInputType.text,
              hintText: "Enter Task Status (pending/Completed)",
              svg: "lib/assets/icons/message_icon.svg",
              //validator: (value) => !_controller.isEmail.value ? null : emailValidation(_controller.email),
            ),
            SizedBox(
              height: 10.sp,
            ),
            CustomElevatedButton(
                expanded: false,
                border: Border.all(
                    width: borderWidth2,
                    strokeAlign: BorderSide.strokeAlignOutside,
                    color: Theme.of(context).cardColor),
                child: const Text("Send"),
                onTap: () async{
                  await sendData();


                }),
          ],
        ),
      ),
    );
  }
}
