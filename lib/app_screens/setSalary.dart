import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components.dart';
import '../uiHelper.dart';
import '../widget/base_components/custom_elevated_button_widget.dart';
import '../widget/custom_text_field1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SalaryController extends GetxController {
  TextEditingController emailc = TextEditingController();
  TextEditingController gross = TextEditingController();
  TextEditingController basic = TextEditingController();
  TextEditingController house = TextEditingController();
  TextEditingController medical = TextEditingController();
  TextEditingController food = TextEditingController();
  TextEditingController conve = TextEditingController();
  TextEditingController attendence = TextEditingController();
  TextEditingController others = TextEditingController();

  TextEditingController absent = TextEditingController();
  TextEditingController providentf = TextEditingController();
  TextEditingController adv = TextEditingController();
  TextEditingController stamp = TextEditingController();
  TextEditingController otherdeduct = TextEditingController();
  TextEditingController tax = TextEditingController();

  TextEditingController totaldeduct = TextEditingController();

  TextEditingController netSalary = TextEditingController();
  TextEditingController netpayable = TextEditingController();

  Map<String, dynamic> gatherValues() {
    double parseStringToDouble(String value) {
      return double.tryParse(value) ?? 0.0; // Returns 0.0 if parsing fails
    }

    double grossValue = parseStringToDouble(gross.text);
    double basicValue = parseStringToDouble(basic.text);
    double housev = parseStringToDouble(house.text);
    double medicalv = parseStringToDouble(medical.text);
    double foodv = parseStringToDouble(food.text);
    double convev = parseStringToDouble(conve.text);
    double attendencev = parseStringToDouble(attendence.text);
    double othersv = parseStringToDouble(others.text);

    double absentv = parseStringToDouble(absent.text);
    double providentfv = parseStringToDouble(providentf.text);
    double advv = parseStringToDouble(adv.text);
    double stampv = parseStringToDouble(stamp.text);
    double taxv = parseStringToDouble(tax.text);
    double otherdeductv = parseStringToDouble(otherdeduct.text);

    double totalp = grossValue +
        basicValue +
        housev +
        foodv +
        convev +
        medicalv +
        attendencev +
        othersv;

    print("total payable");
    print(totalp);
    double taxp=(taxv / basicValue) * 100;
    print(taxp);
    double totald=absentv+providentfv+advv+stampv+taxp+otherdeductv;
double netp=totalp-totald;

    return {
      'gross': double.tryParse(gross.text) ?? 0,
      'basic': double.tryParse(basic.text) ?? 0,
      'house': double.tryParse(house.text) ?? 0,
      'medical': double.tryParse(medical.text) ?? 0,
      'food': double.tryParse(food.text) ?? 0,
      'conve': double.tryParse(conve.text) ?? 0,
      'attendence': int.tryParse(attendence.text) ?? 0,
      'others': double.tryParse(others.text) ?? 0,

       'totalp': totalp,

      'absent': int.tryParse(absent.text) ?? 0,
      'providentf': double.tryParse(providentf.text) ?? 0,
      'adv': double.tryParse(adv.text) ?? 0,
      'stamp': double.tryParse(stamp.text) ?? 0,
      'tax':taxp,
      'otherdeduct': double.tryParse(otherdeduct.text) ?? 0,
      'totaldeduct': totald,
      'netpayable': netp,
    };
  }
}

Future<void> saveSalaryDataToFirebase(
    BuildContext context, String email, Map<String, dynamic> salaryData) async {
  if (email == "") {
    UiHelper.CustomAlertDialog(context, "Please fill up all requirement");
  } else {
    try {
      await FirebaseFirestore.instance
          .collection('ABC Company')
          .doc(email)
          .update({
        'salarylist': salaryData,
      });
      UiHelper.CustomAlertDialog(context, "Save successful");
      print('Salary data saved successfully!');
    } catch (e) {
      print('Error saving salary data: $e');
    }
  }
}

class Setsalary extends StatefulWidget {
  const Setsalary({super.key});

  @override
  State<Setsalary> createState() => _SetsalaryState();
}

class _SetsalaryState extends State<Setsalary> {
  final SalaryController salaryController = Get.put(SalaryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Set Employee Salary"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: ListView(
              children: [
                Text(
                  "Employee Email ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                CustomTextField1(
                  textEditingController: salaryController.emailc,
                  keyboardType: TextInputType.emailAddress,
                  hintText: "Enter Employee Email",
                ),
                Text(
                  "Gross Salary ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                CustomTextField1(
                  textEditingController: salaryController.gross,
                  keyboardType: TextInputType.number,
                  hintText: "Enter Gross salary",
                ),
                Text(
                  "Basic Salary ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                CustomTextField1(
                  textEditingController: salaryController.basic,
                  keyboardType: TextInputType.number,
                  hintText: "Enter Basic Salary",
                ),
                Text(
                  "House Rent ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                CustomTextField1(
                  textEditingController: salaryController.house,
                  keyboardType: TextInputType.number,
                  hintText: "Enter House Rent",
                ),
                Text(
                  "Medical Allowance ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                CustomTextField1(
                  textEditingController: salaryController.medical,
                  keyboardType: TextInputType.number,
                  hintText: "Enter Medical Allowance",
                ),
                Text(
                  "Food Allowance",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                CustomTextField1(
                  textEditingController: salaryController.food,
                  keyboardType: TextInputType.number,
                  hintText: "Enter Food Allowance",
                ),
                Text(
                  "Conveyance",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                CustomTextField1(
                  textEditingController: salaryController.conve,
                  keyboardType: TextInputType.number,
                  hintText: "Enter Conveyance",
                ),
                Text(
                  "Attendance Bonus ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                CustomTextField1(
                  textEditingController: salaryController.attendence,
                  keyboardType: TextInputType.number,
                  hintText: "Enter Attendance Bonus",
                ),
                Text(
                  "Others Allowance ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                CustomTextField1(
                  textEditingController: salaryController.others,
                  keyboardType: TextInputType.number,
                  hintText: "Enter Others Allowance",
                ),

                SizedBox(
                  height: 20,
                ),

                Text(
                  "Deduction ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.red),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Absent Deduction ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                CustomTextField1(
                  textEditingController: salaryController.absent,
                  keyboardType: TextInputType.number,
                  hintText: "Enter Absent Deduction",
                ),
                Text(
                  "Provident Fund ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                CustomTextField1(
                  textEditingController: salaryController.providentf,
                  keyboardType: TextInputType.number,
                  hintText: "Enter Provident Fund",
                ),
                Text(
                  "ADV ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                CustomTextField1(
                  textEditingController: salaryController.adv,
                  keyboardType: TextInputType.number,
                  hintText: "Enter ADV",
                ),
                Text(
                  "Stamp ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                CustomTextField1(
                  textEditingController: salaryController.stamp,
                  keyboardType: TextInputType.number,
                  hintText: "Enter Stamp",
                ),
                Text(
                  "Enter percentage of Tax ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                CustomTextField1(
                  textEditingController: salaryController.tax,
                  keyboardType: TextInputType.number,
                  hintText: "Enter percentage(integer) value",
                ),
                Text(
                  "Others Deduct ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                CustomTextField1(
                  textEditingController: salaryController.otherdeduct,
                  keyboardType: TextInputType.number,
                  hintText: "Enter Others Deduct",
                ),


                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 200),
                  child: CustomElevatedButton(
                      expanded: false,
                      border: Border.all(
                          width: borderWidth2,
                          strokeAlign: BorderSide.strokeAlignOutside,
                          color: Theme.of(context).cardColor),
                      child: const Text("Save Salary"),
                      onTap: () async {
                        Map<String, dynamic> salaryData =
                            salaryController.gatherValues();
                        await saveSalaryDataToFirebase(
                            context, salaryController.emailc.text, salaryData);
                      }),
                ),
              ],
            ),
          ),
        ));
  }
}
