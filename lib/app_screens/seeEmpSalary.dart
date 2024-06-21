import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_series/controller/storageController.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../Firebase_part/firebase_func.dart';
import '../components.dart';
import '../widget/base_components/custom_animated_size_widget.dart';
import '../widget/base_components/custom_elevated_button_widget.dart';
import '../widget/boxes/custom_card.dart';
import '../widget/boxes/custom_connectivity_banner.dart';
import '../widget/custom_text_field1.dart';
class Seeempsalary extends StatefulWidget {
  const Seeempsalary({super.key});

  @override
  State<Seeempsalary> createState() => _SeeempsalaryState();
}
//  class getdata(){
//   static getsalary(String email){
//     FirebaseFirestore.instance.collection('ABC Company').doc(email)).snapshots(),
//   }
// }


class _SeeempsalaryState extends State<Seeempsalary> {
  TextEditingController emailController = TextEditingController();
  String currentEmail = '';

  void _searchEmail() {
    setState(() {
      currentEmail = emailController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payslip"),
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_outlined), onPressed: () => Get.back()),
      ),
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Please type employee email for see his/her salary",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30,top: 14,right: 30,bottom: 5),
            child: CustomTextField1(
              textEditingController: emailController,
              keyboardType: TextInputType.emailAddress,
              hintText: "Enter employee email",
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left:200),
            child: CustomElevatedButton(
                expanded: false,
                border: Border.all(
                    width: borderWidth2,
                    strokeAlign: BorderSide.strokeAlignOutside,
                    color: Theme.of(context).cardColor),
                child: const Text("Search"),
                onTap:(){
                  _searchEmail();
                }, ),
          ),
          CustomConnectivityBanner(),
          if (currentEmail.isNotEmpty)
            PayslipScreenInformation(emailcon: currentEmail),
        ],
      ),

    );
  }
}

class PayslipScreenInformation extends StatelessWidget {
 final String emailcon;
  PayslipScreenInformation({super.key,required this.emailcon});



  Widget _setData(BuildContext context, String s, bool isLoading, Widget child, {bool isWarning = false}) {
    return CustomAnimatedSize(
      widthFactor: 1,
      alignment: Alignment.topCenter,
      child: CustomCard(
        isLoading: isLoading,
        margin: EdgeInsets.all(defaultPadding / 2),
        heading: Container(
          color: !isWarning ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.error,
          padding: EdgeInsets.symmetric(vertical: defaultPadding / 4),
          alignment: Alignment.center,
          child: Text(
            s,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).canvasColor, fontWeight: FontWeight.bold),
          ),
        ),
        child: child,
      ),
    );
  }

  Widget _steValue(BuildContext context, String heading, dynamic? value, {bool isMain = false}) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.labelSmall?.copyWith(color: isMain ? Theme.of(context).primaryColor : null, fontWeight: isMain ? FontWeight.bold : null) ?? const TextStyle(),
      child: Row(
        children: [
          Expanded(child: Text(heading)),
          Expanded(child: Text(value.toString() ?? "0", textAlign: TextAlign.end)),
        ],
      ),
    );
  }
  StorageController store=Get.put(StorageController());
  @override
  Widget build(BuildContext context) {
    return Expanded(child: LayoutBuilder(
      builder: (context, box) {
        return StreamBuilder<DocumentSnapshot?>(
            stream: FirebaseFirestore.instance.collection('ABC Company').doc(emailcon).snapshots(),
            builder: (context, snapshot) {

              if (!snapshot.hasData || !snapshot.data!.exists) {
                return Center(child: Text('Document does not exist'));
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              // Check if the document exists
              if (!snapshot.hasData || !snapshot.data!.exists) {
                return Center(child: Text('Document does not exist'));
              }

              // Access the specific fields from the document
              var data = snapshot.data!.data() as Map<String, dynamic>;

              return SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(minHeight: box.maxHeight + 0.01),
                  child: Column(
                    children: [
                      _setData(
                        context,
                        "Total Addition",
                        false,
                        Column(
                          children: [
                            _steValue(context, "Gross salary",
                                data['salarylist']['gross'] ?? "0.0"),
                            Divider(height: defaultPadding / 4),
                            _steValue(context, "Basic Salary",
                                data['salarylist']['basic'] ?? "0.0"),
                            Divider(height: defaultPadding / 4),
                            _steValue(context, "House Rent",
                                data['salarylist']['house'] ?? "0.0"),
                            Divider(height: defaultPadding / 4),
                            _steValue(context, "Medical Allowance",
                                data['salarylist']['medical'] ?? "0.0"),
                            Divider(height: defaultPadding / 4),
                            _steValue(context, "Food Allowance",
                                data['salarylist']['food'] ?? "0.0"),
                            Divider(height: defaultPadding / 4),
                            _steValue(context, "Conveyance",
                                data['salarylist']['conve'] ?? "0.0"),
                            Divider(height: defaultPadding / 4),
                            _steValue(context, "Attendance Bonus",
                                data['salarylist']['attendence'] ?? "0.0"),
                            Divider(height: defaultPadding / 4),
                            _steValue(context, "Others Allowance",
                                data['salarylist']['others'] ?? "0.0"),
                            Divider(height: defaultPadding / 4),
                            _steValue(context, "Total Payable",
                                data['salarylist']['totalp'] ?? "0.0",
                                isMain: true),
                          ],
                        ),
                      ),

                      _setData(
                        context,
                        "Total Deduction",
                        isWarning: true,
                        false,
                        Column(
                          children: [
                            _steValue(context, "Absent Deduction",
                                data['salarylist']['absent'] ?? "0.0"),
                            Divider(height: defaultPadding / 4),
                            _steValue(context, "Provident Fund",
                                data['salarylist']['providentf'] ?? "0.0"),
                            Divider(height: defaultPadding / 4),
                            _steValue(
                                context, "ADV", data['salarylist']['adv'] ?? "0.0"),
                            Divider(height: defaultPadding / 4),
                            _steValue(context, "Stamp",
                                data['salarylist']['stamp'] ?? "0.0"),
                            Divider(height: defaultPadding / 4),
                            _steValue(context, "Others Deduct",
                                data['salarylist']['otherdeduct'] ?? "0.0"),
                            Divider(height: defaultPadding / 4),
                            _steValue(context, "Total Deduct",
                                data['salarylist']['totaldeduct'] ?? "0.0"),
                            Divider(height: defaultPadding / 4),
                            _steValue(context, "Net Salary",
                                data['salarylist']['netSalary'] ?? "0.0"),
                            Divider(height: defaultPadding / 4),
                            _steValue(context, "Net Salary Payable",
                                data['salarylist']['netpayable'] ??"0.0",
                                isMain: true),
                          ],
                        ),
                      ),
                      // _setHeading(context, "Total Deduction", isWarning: true),
                    ],
                  ),
                ),

              );} );
      },
    ));
  }
}
