import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components.dart';
import '../widget/base_components/custom_elevated_button_widget.dart';
import '../widget/custom_text_field1.dart';

class SetLeaveType extends StatefulWidget {
  const SetLeaveType({super.key});

  @override
  State<SetLeaveType> createState() => _SetLeaveTypeState();
}

class _SetLeaveTypeState extends State<SetLeaveType> {
  TextEditingController annual=TextEditingController();
  TextEditingController sick=TextEditingController();
  TextEditingController maternity=TextEditingController();
  TextEditingController paternity=TextEditingController();
  TextEditingController family=TextEditingController();
  TextEditingController study=TextEditingController();
  TextEditingController marriage=TextEditingController();
  TextEditingController bereavement=TextEditingController();
  TextEditingController casual=TextEditingController();
  TextEditingController unpaid=TextEditingController();
  TextEditingController earn=TextEditingController();
  TextEditingController sabbatical=TextEditingController();
  TextEditingController separation=TextEditingController();


  Future<void> updateMenuListInFirebase() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    // Create the data map to update
    Map<String, dynamic> data = {
      "Annual Leave":annual.text??"0",

      "Sick Leave":sick.text??"0",
      "Maternity Leave":maternity.text??"0",
      "Paternity Leave":paternity.text??"0",
      "Family Leave":family.text??"0",
      "Study Leave":study.text??"0",
      "Marriage Leave":marriage.text??"0",
      "Bereavement Leave":bereavement.text??"0",
      "Casual Leave":casual.text??"0",
      "Unpaid Leave":unpaid.text??"0",
      "earned leave":earn.text??"0",
      "Sabbatical Leave" :sabbatical.text??"0",
      "Separation Leave":separation.text??"0",
    };

    try {
      await _firestore.collection('ABC Company').doc("leave_number").set(data);
      print("done");
    } catch (e) {
      print("Error updating document: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Set leave number"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: ListView(
          children: [
            SizedBox(
              height: 5.sp,
            ),
            Text(
              "Annual Leave",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            CustomTextField1(
              textEditingController: annual,
              keyboardType: TextInputType.text,
              hintText: "Enter annual leave number",

            ),   SizedBox(
              height: 5.sp,
            ),
            Text(
              "Sick Leave",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),  CustomTextField1(
              textEditingController: sick,
              keyboardType: TextInputType.text,
              hintText: "Enter  leave number",

            ),   SizedBox(
              height: 5.sp,
            ),
             SizedBox(
              height: 5.sp,
            ),
            Text(
              "Maternity Leave",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),  CustomTextField1(
              textEditingController: maternity,
              keyboardType: TextInputType.text,
              hintText: "Enter  leave number",

            ),   SizedBox(
              height: 5.sp,
            ),
            Text(
              "Paternity Leave",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),  CustomTextField1(
              textEditingController: paternity,
              keyboardType: TextInputType.text,
              hintText:"Enter  leave number",

            ),   SizedBox(
              height: 5.sp,
            ),
            Text(
              "Family Leave",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),  CustomTextField1(
              textEditingController: family,
              keyboardType: TextInputType.text,
              hintText: "Enter  leave number",

            ),    SizedBox(
              height: 5.sp,
            ),
            Text(
              "Study Leave",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ), CustomTextField1(
              textEditingController: study,
              keyboardType: TextInputType.text,
              hintText: "Enter  leave number",

            ),   SizedBox(
              height: 5.sp,
            ),
            Text(
              "Marriage Leave",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),  CustomTextField1(
              textEditingController: marriage,
              keyboardType: TextInputType.text,
              hintText: "Enter  leave number",

            ),  SizedBox(
              height: 5.sp,
            ),
            Text(
              "Bereavement Leave",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            CustomTextField1(
              textEditingController: bereavement,
              keyboardType: TextInputType.text,
              hintText: "Enter  leave number",

            ),  SizedBox(
              height: 5.sp,
            ),
            Text(
              "Casual Leave",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),   CustomTextField1(
              textEditingController: casual,
              keyboardType: TextInputType.text,
              hintText:"Enter  leave number",

            ),   SizedBox(
              height: 5.sp,
            ),
            Text(
              "Unpaid Leave",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),  CustomTextField1(
              textEditingController: unpaid,
              keyboardType: TextInputType.text,
              hintText:"Enter  leave number",

            ),    SizedBox(
              height: 5.sp,
            ),
            Text(
              "earned leave",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ), CustomTextField1(
              textEditingController: earn,
              keyboardType: TextInputType.text,
              hintText: "Enter  leave number",

            ),  SizedBox(
              height: 5.sp,
            ),
            Text(
              "Sabbatical Leave",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),   CustomTextField1(
              textEditingController: sabbatical,
              keyboardType: TextInputType.text,
              hintText: "Enter  leave number",

            ),   SizedBox(
              height: 5.sp,
            ),
            Text(
              "Separation Leave",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),  CustomTextField1(
              textEditingController: separation,
              keyboardType: TextInputType.text,
              hintText: "Enter  leave number",

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
                child: const Text("Save "),
                onTap: () async{

                  await updateMenuListInFirebase();

                }),
          ],
        ),
      ),
    );
  }
}

