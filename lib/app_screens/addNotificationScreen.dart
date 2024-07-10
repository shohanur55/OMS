import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_series/controller/dataController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../components.dart';
import '../widget/base_components/custom_elevated_button_widget.dart';

class Addnotificationscreen extends StatefulWidget {
  const Addnotificationscreen({super.key});

  @override
  State<Addnotificationscreen> createState() => _AddnotificationscreenState();
}

class _AddnotificationscreenState extends State<Addnotificationscreen> {
DataController _controller=Get.put(DataController());

  String department = 'Select Department';
  setDepartment(int index) {
    department = dept.departments[index];

  }

TextEditingController desc=TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<void> sendData() async {
    try {
      DocumentReference docRef = _firestore.collection('ABC Company').doc(department);

      await _firestore.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(docRef);

        if (!snapshot.exists) {
          // If the document does not exist, create it with an initial list
          transaction.set(docRef, {
            'task_list': [
              {
                'datetime':DateFormat.yMMMd().format(DateTime.now()).toString(),
                'description': desc.text,

              }
            ]
          });
        } else {
          // If the document exists, update the list
          List<dynamic> userList = snapshot['task_list'] ?? [];
          userList.add({
            'datetime':DateFormat.yMMMd().format(DateTime.now()).toString(),
            'description': desc.text,

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Notification"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: [
            SizedBox(
              height: 15.sp,
            ),
            Text(
              "Department",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 50,
              child: GestureDetector(
                  onTapDown: (tapDetails) {
                    showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(tapDetails.globalPosition.dx, tapDetails.globalPosition.dy + 20, 0, 0),
                        items: List.generate(
                            dept.departments.length,
                                (index) => PopupMenuItem(
                              onTap: () {
                                setDepartment(index);
                                setState(() {

                                });
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            dept.departments[index],
                                            style: const TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              value: dept.departments[index],
                            )));
                  },
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(color: Colors.green, borderRadius: const BorderRadius.all(Radius.circular(10)), boxShadow: [
                              BoxShadow(
                                spreadRadius: 1,
                                color: Colors.green,
                                blurRadius: 2,
                              )
                            ]),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        department,
                                        style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                                      ),
                                      IconButton(
                                          onPressed: null,
                                          icon: Icon(
                                            Icons.keyboard_arrow_down,
                                            color:Colors.white,
                                          ))
                                    ],
                                  )),
                            ),
                          ))
                    ],
                  )),
            ),

            SizedBox(
              height: 5.sp,
            ),
            Text(
              "Notification message",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green,width: 3),
              ),
              child: TextField(
                decoration:
                InputDecoration(labelText: 'Please type Notification message,',),
                controller: desc,
                keyboardType: TextInputType.multiline,
                minLines: 5, // <-- SEE HERE
                maxLines: 10, // <-- SEE HERE
              ),
            ),

            SizedBox(
              height: 15.sp,
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
