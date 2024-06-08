
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class PayslipScreen extends StatefulWidget {
  // const PayslipScreen({super.key, required this.dashboardResponseModel});
  // final DashboardResponseModel dashboardResponseModel;

  @override
  State<PayslipScreen> createState() => _PayslipScreenState();
}

class _PayslipScreenState extends State<PayslipScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   Get.put(PayslipScreenController(widget.dashboardResponseModel));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
    // return WillPopScope(
    //   onWillPop: () async => await Get.delete<PayslipScreenController>(),
    //   child: Scaffold(
    //     appBar: AppBar(
    //       title: const Text("Payslip"),
    //       leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_outlined), onPressed: () => Get.back()),
    //     ),
    //     body: Column(
    //       children: [
    //         CustomConnectivityBanner(),
    //         PayslipScreenInformation(),
    //         PayslipScreenSelectDate()
    //       ],
    //     ),
    //   ),
    // );
  }
}
//
// class PayslipScreenInformation extends StatelessWidget {
//   PayslipScreenInformation({super.key});
//
//   final PayslipScreenController _controller = Get.find();
//
//   Widget _setData(BuildContext context, String s, bool isLoading, Widget child, {bool isWarning = false}) {
//     return CustomAnimatedSize(
//       widthFactor: 1,
//       alignment: Alignment.topCenter,
//       child: CustomCard(
//         isLoading: isLoading,
//         margin: EdgeInsets.all(defaultPadding / 2),
//         heading: Container(
//           color: !isWarning ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.error,
//           padding: EdgeInsets.symmetric(vertical: defaultPadding / 4),
//           alignment: Alignment.center,
//           child: Text(
//             s,
//             textAlign: TextAlign.center,
//             style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).canvasColor, fontWeight: FontWeight.bold),
//           ),
//         ),
//         child: child,
//       ),
//     );
//   }
//
//   Widget _steValue(BuildContext context, String heading, String? value, {bool isMain = false}) {
//     return DefaultTextStyle(
//       style: Theme.of(context).textTheme.labelSmall?.copyWith(color: isMain ? Theme.of(context).primaryColor : null, fontWeight: isMain ? FontWeight.bold : null) ?? const TextStyle(),
//       child: Row(
//         children: [
//           Expanded(child: Text(heading)),
//           Expanded(child: Text(value ?? "0", textAlign: TextAlign.end)),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(child: LayoutBuilder(
//       builder: (context, box) {
//         return RefreshIndicator(
//           onRefresh: () async => await _controller.getData(),
//           child: SingleChildScrollView(
//             child: Obx(
//               () => Container(
//                 constraints: BoxConstraints(minHeight: box.maxHeight + 0.01),
//                 child: Column(
//                   children: [
//                     _setData(
//                       context,
//                       "Total Addition",
//                       _controller.isLoading.value,
//                       Column(
//                         children: [
//                           _steValue(context, "Gross salary", _controller.response.value?.grossSalay),
//                           Divider(height: defaultPadding / 4),
//                           _steValue(context, "Basic Salary", _controller.response.value?.basicSalary),
//                           Divider(height: defaultPadding / 4),
//                           _steValue(context, "House Rent", _controller.response.value?.houseRent),
//                           Divider(height: defaultPadding / 4),
//                           _steValue(context, "Medical Allowance", _controller.response.value?.medicalAllowance),
//                           Divider(height: defaultPadding / 4),
//                           _steValue(context, "Food Allowance", _controller.response.value?.foodAllowance),
//                           Divider(height: defaultPadding / 4),
//                           _steValue(context, "Conveyance", _controller.response.value?.conveyance),
//                           Divider(height: defaultPadding / 4),
//                           _steValue(context, "Attendance Bonus", _controller.response.value?.attendanceBonus),
//                           Divider(height: defaultPadding / 4),
//                           _steValue(context, "Others Allowance", "----"),
//                           Divider(height: defaultPadding / 4),
//                           _steValue(context, "Total Payable", _controller.response.value?.totalPayable, isMain: true),
//                         ],
//                       ),
//                     ),
//
//                     _setData(
//                       context,
//                       "Total Deduction",
//                       isWarning: true,
//                       _controller.isLoading.value,
//                       Column(
//                         children: [
//                           _steValue(context, "Absent Deduction", _controller.response.value?.absentDeduction),
//                           Divider(height: defaultPadding / 4),
//                           _steValue(context, "Provident Fund", _controller.response.value?.providentFund),
//                           Divider(height: defaultPadding / 4),
//                           _steValue(context, "ADV", "----"),
//                           Divider(height: defaultPadding / 4),
//                           _steValue(context, "Stamp", _controller.response.value?.stamp),
//                           Divider(height: defaultPadding / 4),
//                           _steValue(context, "Others Deduct", _controller.response.value?.othersDeduct),
//                           Divider(height: defaultPadding / 4),
//                           _steValue(context, "Total Deduct", _controller.response.value?.totalDeduct),
//                           Divider(height: defaultPadding / 4),
//                           _steValue(context, "Net Salary", _controller.response.value?.netSalary),
//                           Divider(height: defaultPadding / 4),
//                           _steValue(context, "Net Salary Payable", _controller.response.value?.netSalaryPayable, isMain: true),
//                         ],
//                       ),
//                     ),
//                     // _setHeading(context, "Total Deduction", isWarning: true),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     ));
//   }
// }
//
// class PayslipScreenSelectDate extends StatelessWidget {
//   PayslipScreenSelectDate({super.key});
//
//   final PayslipScreenController _controller = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomElevatedButton(
//       expanded: true,
//       margin: EdgeInsets.only(
//         bottom: MediaQuery.of(context).padding.bottom + defaultPadding / 2,
//         top: defaultPadding / 2,
//         left: defaultPadding / 2,
//         right: defaultPadding / 2,
//       ),
//       onTap: () async {
//         if (_controller.dateList.isEmpty) await _controller.getData();
//         if (_controller.dateList.isEmpty) return false;
//         if (!context.mounted) return null;
//
//         PayslipDateModel? res = await showDialog<PayslipDateModel>(
//             context: context,
//             builder: (context) {
//               return CustomPopUpWindow(
//                 title: const Text("Select Date"),
//                 child: Column(
//                   children: [
//                     for (PayslipDateModel i in _controller.dateList)
//                       CustomElevatedButton(
//                         expanded: true,
//                         backgroundColor: _controller.selectedDate.value != null && _controller.selectedDate.value!.dateTime == i.dateTime ? null : Theme.of(context).primaryColor.withOpacity(0.5),
//                         margin: EdgeInsets.symmetric(vertical: defaultPadding / 8),
//                         onDone: (_) => Get.back<PayslipDateModel>(result: i),
//                         child: Text(i.dateTime!),
//                       )
//                   ],
//                 ),
//               );
//             });
//
//         if (res == null) return null;
//         if (_controller.selectedDate.value != null && res.dateTime == _controller.selectedDate.value?.dateTime) return null;
//
//         _controller.selectedDate.value = res;
//         await _controller.getInfo();
//
//         return null;
//       },
//       child: Obx(() => Text(_controller.selectedDate.value?.dateTime ?? "Select Date")),
//     );
//   }
// }
