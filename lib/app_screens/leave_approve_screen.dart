
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeaveApproveScreen extends StatefulWidget {
  // const LeaveApproveScreen({super.key, required this.dashboardResponseModel, this.isFinalLeave = false});
 // final DashboardResponseModel dashboardResponseModel;
 //  final bool isFinalLeave;

  @override
  State<LeaveApproveScreen> createState() => _LeaveApproveScreenState();
}

class _LeaveApproveScreenState extends State<LeaveApproveScreen> {
 // late final LeaveApproveScreenController _controller;
 //  @override
 //  void initState() {
 //    super.initState();
 //    _controller = Get.put(LeaveApproveScreenController(dashboardResponseModel: widget.dashboardResponseModel, isFinalLeave: widget.isFinalLeave));
 //  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
    // return WillPopScope(
    //   onWillPop: () async => await Get.delete<LeaveApproveScreenController>(),
    //   child: Scaffold(
    //     appBar: AppBar(
    //       title: Text(!_controller.isFinalLeave ? "Leave Approve" : "Final Leave Approve"),
    //       leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_outlined), onPressed: () => Get.back()),
    //     ),
    //     body: Obx(
    //       () => Column(
    //         children: [
    //           CustomConnectivityBanner(),
    //           if (_controller.isLoading.value) const LinearProgressIndicator(),
    //           Expanded(
    //             child: LayoutBuilder(
    //               builder: (context, box) => RefreshIndicator(
    //                 onRefresh: () async => await _controller.getData(),
    //                 child: SingleChildScrollView(
    //                   child: Container(
    //                     width: double.infinity,
    //                     constraints: BoxConstraints(minHeight: box.maxHeight + 0.01),
    //                     child: LeaveApproveScreenList(),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}

// class LeaveApproveScreenList extends StatelessWidget {
//   LeaveApproveScreenList({super.key});
//
//   final LeaveApproveScreenController _controller = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Column(
//         children: [
//           SizedBox(height: defaultPadding / 4),
//           if (_controller.response.isEmpty && !_controller.isLoading.value)
//             const WarningMessage()
//           else
//             for (AppliedLeaveApplicationModel i in _controller.response)
//               CustomLeaveListTile(
//                 key: ValueKey(i.leaveId.toString()),
//                 model: i,
//                 onTapAccept: () async => await _controller.onChange(leaveId: i.leaveId.toString(), isApproved: true),
//                 onDoneAccept: (isAccept) async {
//                   if (isAccept != null && isAccept) _controller.response.remove(i);
//                 },
//                 onTapReject: () async => await _controller.onChange(leaveId: i.leaveId.toString(), isApproved: false),
//                 onDoneReject: (isAccept) async {
//                   if (isAccept != null && isAccept) _controller.response.remove(i);
//                 },
//               ),
//           SizedBox(height: MediaQuery.of(context).padding.bottom + defaultPadding)
//         ],
//       ),
//     );
//   }
// }
