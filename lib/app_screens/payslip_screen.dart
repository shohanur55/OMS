
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_series/controller/storageController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components.dart';
import '../widget/base_components/custom_animated_size_widget.dart';
import '../widget/boxes/custom_card.dart';
import '../widget/boxes/custom_connectivity_banner.dart';



class PayslipScreen extends StatefulWidget {


  @override
  State<PayslipScreen> createState() => _PayslipScreenState();
}

class _PayslipScreenState extends State<PayslipScreen> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text("Payslip"),
          leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_outlined), onPressed: () => Get.back()),
        ),
        body: Column(
          children: [
            CustomConnectivityBanner(),
            PayslipScreenInformation(),
           // PayslipScreenSelectDate()
          ],
        ),

    );
  }
}

class PayslipScreenInformation extends StatelessWidget {
  PayslipScreenInformation({super.key});



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
        return StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection('ABC Company').doc(store.userEmail.value).snapshots(),
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


