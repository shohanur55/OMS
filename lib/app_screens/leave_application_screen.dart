
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:tuple/tuple.dart';
//
// import '../../widgets/base_components/custom_animated_size_widget.dart';

class LeaveApplicationScreen extends StatefulWidget {
  // const LeaveApplicationScreen({super.key, required this.dashboardResponseModel});
  // final DashboardResponseModel dashboardResponseModel;

  @override
  State<LeaveApplicationScreen> createState() => _LeaveApplicationScreenState();
}

class _LeaveApplicationScreenState extends State<LeaveApplicationScreen> {
  // late LeaveApplicationScreenController _controller;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _controller = Get.put(LeaveApplicationScreenController(widget.dashboardResponseModel));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
    // return WillPopScope(
    //   onWillPop: () async => await Get.delete<LeaveApplicationScreenController>(),
    //   child: Stack(
    //     children: [
    //       //! Background Color
    //       Positioned.fill(
    //         child: Column(
    //           children: [
    //             Container(height: MediaQuery.of(context).size.height / 2, color: Theme.of(context).primaryColor),
    //             Container(height: MediaQuery.of(context).size.height / 2, color: Theme.of(context).canvasColor),
    //           ],
    //         ),
    //       ),
    //
    //       //! Main
    //       Scaffold(
    //         backgroundColor: Colors.transparent,
    //         appBar: AppBar(
    //           title: const Text("Leave Application"),
    //           leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_outlined), onPressed: () => Get.back()),
    //         ),
    //         body: Column(
    //           children: [
    //             CustomConnectivityBanner(),
    //             Expanded(
    //               child: LayoutBuilder(
    //                 builder: (context, box) {
    //                   return RefreshIndicator(
    //                     onRefresh: () async => await _controller.getData(),
    //                     child: SingleChildScrollView(
    //                       child: Container(
    //                         color: Theme.of(context).canvasColor,
    //                         width: double.infinity,
    //                         constraints: BoxConstraints(minHeight: box.maxHeight + 0.01),
    //                         child: Column(
    //                           children: [
    //                             //!----------------------------------------------------------------------------- Applied Leave Info
    //                             CustomAnimatedSize(
    //                               widthFactor: 1,
    //                               alignment: Alignment.topRight,
    //                               child: Container(
    //                                 width: double.infinity,
    //                                 decoration: BoxDecoration(color: Theme.of(context).primaryColor),
    //                                 padding: EdgeInsets.symmetric(vertical: defaultPadding, horizontal: defaultPadding / 2),
    //                                 child: Column(
    //                                   crossAxisAlignment: CrossAxisAlignment.start,
    //                                   children: [
    //                                     LeaveApplicationScreenTotalCount(),
    //                                     SizedBox(height: defaultPadding / 2),
    //                                     LeaveApplicationScreenApplyLeave(),
    //                                   ],
    //                                 ),
    //                               ),
    //                             ),
    //                             LeaveApplicationScreenLeaveApplicationList(),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   );
    //                 },
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
//
// class LeaveApplicationScreenApplyLeave extends StatelessWidget {
//   LeaveApplicationScreenApplyLeave({super.key});
//
//   final LeaveApplicationScreenController _controller = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => CustomCard(
//         isLoading: _controller.responseLeaveInfo.value == null && _controller.isLoading.value,
//         child: CustomAnimatedSize(
//           widthFactor: 1,
//           alignment: Alignment.topCenter,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Apply for leave!",
//                 style: Theme.of(context).textTheme.titleSmall,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 // crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   //! ------------------------------------------------------------------------------ Select Date
//                   CustomElevatedButton(
//                     margin: EdgeInsets.only(top: defaultPadding / 2),
//                     child: Text(
//                       _controller.dtFrom.value == null ? "Select Date" : _controller.dateFormatter(_controller.dtFrom.value!),
//                       style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Theme.of(context).canvasColor),
//                     ),
//                     onTap: () async {
//                       final currentDate = DateTime.now();
//                       final firstDate = DateTime(currentDate.year, currentDate.month, 1);
//                       final lastDate = DateTime(currentDate.year + 1, currentDate.month, currentDate.day);
//                       DateTime? d = await showDatePicker(
//                         context: context,
//                         initialDate: _controller.dtFrom.value ?? currentDate,
//                         firstDate: firstDate,
//                         lastDate: lastDate,
//                       );
//                       if (d == null) return;
//
//                       _controller.dtFrom.value = d;
//                       _controller.isValid;
//
//                       return;
//                     },
//                   ),
//
//                   // Select Total date
//                   if (_controller.dtFrom.value != null)
//                     Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           "Total Days",
//                           style: Theme.of(context).textTheme.labelMedium,
//                         ),
//                         CustomIncrementButton(
//                           initialValue: _controller.totalDay.value,
//                           onChange: (value) {
//                             _controller.totalDay.value = value;
//                             _controller.isValid;
//                           },
//                         ),
//                         CustomAnimatedSize(
//                           child: _controller.totalDay.value <= 1 || _controller.toDate.value == null
//                               ? null
//                               : Text(
//                                   "Until\n${_controller.dateFormatter(_controller.toDate.value!)}",
//                                   textAlign: TextAlign.center,
//                                   style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Theme.of(context).colorScheme.error),
//                                 ),
//                         ),
//                       ],
//                     ),
//                 ],
//               ),
//               if (_controller.dtFrom.value != null) SizedBox(height: defaultPadding / 2),
//
//               if (_controller.dtFrom.value != null)
//                 CustomTextFormField(
//                     labelText: "Reason",
//                     floatingLabelBehavior: FloatingLabelBehavior.always,
//                     minLines: 1,
//                     maxLines: 5,
//                     onChanged: (value) {
//                       _controller.sendData.remark = value.trim();
//
//                       _controller.isValid;
//                     }),
//               if (_controller.dtFrom.value != null) SizedBox(height: defaultPadding / 2),
//
//               //! ------------------------------------------------------------------------------------
//               if (_controller.dtFrom.value != null)
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         CustomElevatedButton(
//                           onTap: () async {
//                             LeaveType? res = await showDialog<LeaveType>(
//                               context: context,
//                               builder: (context) {
//                                 return CustomPopUpWindow(
//                                   title: const Text("Select Leave Type"),
//                                   child: Column(
//                                     children: [
//                                       for (LeaveType i in _controller.responseLeaveInfo.value?.leaveTypesList ?? [])
//                                         CustomElevatedButton(
//                                           expanded: true,
//                                           margin: EdgeInsets.symmetric(vertical: defaultPadding / 8),
//                                           onDone: (_) => Get.back<LeaveType>(result: i),
//                                           child: Text(i.leaveTypeName!),
//                                         )
//                                     ],
//                                   ),
//                                 );
//                               },
//                             );
//                             if (res == null) return;
//
//                             _controller.sendData.lTypeId = res.leaveTypeId.toString();
//                             _controller.lvType.value = res.leaveTypeName ?? "";
//                             _controller.isValid;
//                             return;
//                           },
//                           child: Text(_controller.lvType.value.isEmpty ? "Leave Type" : _controller.lvType.value),
//                         ),
//                       ],
//                     ),
//                     //! ---------------------------------------------------------------------------- Apply Button
//                     Flexible(
//                       child: CustomElevatedButton(
//                         enable: _controller.isValidFinal().isEmpty,
//                         backgroundColor: _controller.isValidFinal().isEmpty ? null : Theme.of(context).primaryColor.withOpacity(0.5),
//                         onTap: () async => await _controller.submitLeaveApplication(),
//                         onDone: (isSuccess) async {
//                           // if (isSuccess != null && isSuccess) await _controller.getData();
//                           if (isSuccess != null && isSuccess) Get.back();
//                         },
//                         child: Text(_controller.isValidFinal().isEmpty ? "Submit" : _controller.isValidFinal(), textAlign: TextAlign.center),
//                       ),
//                     ),
//                   ],
//                 )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class LeaveApplicationScreenLeaveApplicationList extends StatelessWidget {
//   LeaveApplicationScreenLeaveApplicationList({super.key});
//
//   final LeaveApplicationScreenController _controller = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Column(
//         children: [
//           Container(
//             color: Theme.of(context).primaryColor,
//             alignment: Alignment.center,
//             padding: EdgeInsets.all(defaultPadding / 4),
//             child: Text(
//               "Applied Leave Applications",
//               textAlign: TextAlign.center,
//               style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).canvasColor),
//             ),
//           ),
//
//           // List
//           if (_controller.isLoading.value) const LinearProgressIndicator(),
//           if (_controller.responseAppliedApplications.isEmpty && !_controller.isLoading.value)
//             const WarningMessage()
//           else
//             for (AppliedLeaveApplicationModel i in _controller.responseAppliedApplications) CustomLeaveListTile(model: i),
//           SizedBox(height: MediaQuery.of(context).padding.bottom + defaultPadding)
//         ],
//       ),
//     );
//   }
// }
//
// class LeaveApplicationScreenTotalCount extends StatelessWidget {
//   LeaveApplicationScreenTotalCount({super.key});
//   final LeaveApplicationScreenController _controller = Get.find();
//   final RxBool isExpanded = false.obs;
//
//   Widget setInfo(BuildContext context, String type) {
//     TextStyle? ts = Theme.of(context).textTheme.labelSmall;
//
//     Row t(String heading, int? value) {
//       return Row(
//         children: [
//           Expanded(child: Text("$heading:", style: ts)),
//           Expanded(child: Text(value?.toStringWithLeadingZeros(2) ?? "N/A", textAlign: TextAlign.end, style: ts)),
//         ],
//       );
//     }
//
//     Tuple2<int, int>? val = _controller.countInfo(type);
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text("$type:", style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold)),
//         t("Total", val?.item1),
//         t("Enjoyed", val?.item2),
//         t("Available", (val?.item1 ?? 0) - (val?.item2 ?? 0)),
//         const Divider(),
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => CustomCard(
//         padding: EdgeInsets.zero,
//         isLoading: _controller.responseLeaveInfo.value == null && _controller.isLoading.value,
//         child: Column(
//           children: [
//             CustomElevatedButton(
//               width: double.infinity,
//               borderRadius: BorderRadius.zero,
//               onDone: (_) => isExpanded.value = !isExpanded.value,
//               contentPadding: EdgeInsets.all(defaultPadding / 2),
//               backgroundColor: Colors.transparent,
//               child: !isExpanded.value
//                   ? Row(
//                       children: [
//                         Expanded(
//                           child: Text(
//                             "Enjoyed CL: ${_controller.responseLeaveInfo.value?.enjoyedCL?.toStringWithLeadingZeros(2) ?? "N/A"}\nEnjoyed SL: ${_controller.responseLeaveInfo.value?.enjoyedSL?.toStringWithLeadingZeros(2) ?? "N/A"}\nEnjoyed EL: ${_controller.responseLeaveInfo.value?.enjoyedEL?.toStringWithLeadingZeros(2) ?? "N/A"}",
//                             style: Theme.of(context).textTheme.labelSmall,
//                           ),
//                         ),
//                         Expanded(
//                           child: Text(
//                             "Total CL: ${_controller.responseLeaveInfo.value?.totalCL?.toStringWithLeadingZeros(2) ?? "N/A"}\nTotal SL: ${_controller.responseLeaveInfo.value?.totalSL?.toStringWithLeadingZeros(2) ?? "N/A"}\nTotal EL: ${_controller.responseLeaveInfo.value?.totalEL?.toStringWithLeadingZeros(2) ?? "N/A"}",
//                             textAlign: TextAlign.end,
//                             style: Theme.of(context).textTheme.labelSmall,
//                           ),
//                         ),
//                       ],
//                     )
//                   : Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         setInfo(context, "CL"),
//                         setInfo(context, "SL"),
//                         setInfo(context, "EL"),
//                       ],
//                     ),
//             ),
//             Container(
//               width: double.infinity,
//               alignment: Alignment.center,
//               padding: EdgeInsets.all(defaultPadding / 8),
//               decoration: BoxDecoration(color: Theme.of(context).primaryColor),
//               child: Text(!isExpanded.value ? "more" : "less", style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).canvasColor)),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
