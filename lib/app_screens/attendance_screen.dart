import 'dart:io';


import 'package:get/get.dart';
import 'package:flutter/material.dart';


class AttendanceScreen extends StatefulWidget {
 // const AttendanceScreen({super.key, required this.dashboardResponseModel});
  //final DashboardResponseModel dashboardResponseModel;

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  // late AttendanceScreenController _controller;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _controller = Get.put(AttendanceScreenController(widget.dashboardResponseModel));
  // }
  //
  // Widget attendanceButtons() {
  //   if (_controller.type.isEmpty) {
  //     if (_controller.isLoading.value) {
  //       return Container(
  //         clipBehavior: Clip.antiAlias,
  //         height: defaultPadding,
  //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(defaultPadding / 4)),
  //         child: LinearProgressIndicator(
  //           color: Theme.of(context).primaryColor.withOpacity(0.5),
  //         ),
  //       );
  //     } else {
  //       return const WarningMessage(message: "No attendance submission type found.");
  //     }
  //   }
  //
  //   final Map<String, Widget> map = {
  //     "Quick": AttendanceScreenQuickAttendance(),
  //     "Scan": AttendanceScreenScan(),
  //     "Picture": AttendanceScreenPicture(),
  //   };
  //
  //   return map[_controller.type] ?? Column(children: map.values.toList());
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
    // return WillPopScope(
    //   onWillPop: () async => await Get.delete<AttendanceScreenController>(),
    //   child: Scaffold(
    //     appBar: AppBar(
    //       title: const Text("Attendance"),
    //       leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_outlined), onPressed: () => Get.back()),
    //     ),
    //     body: Column(
    //       children: [
    //         CustomConnectivityBanner(),
    //         Expanded(
    //           child: LayoutBuilder(
    //             builder: (context, box) {
    //               return Stack(
    //                 children: [
    //                   RefreshIndicator(
    //                     onRefresh: () async => await _controller.getData(),
    //                     child: SingleChildScrollView(
    //                       child: Container(
    //                         constraints: BoxConstraints(minHeight: box.maxHeight + 0.01),
    //                         padding: EdgeInsets.all(defaultPadding),
    //                         child: Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             //! -------------------------------------------------------------------------------- Manus
    //                             AttendanceScreenLocation(),
    //
    //                             CustomAnimatedSize(
    //                               widthFactor: 1,
    //                               child: Obx(() => attendanceButtons()),
    //                             ),
    //
    //                             SizedBox(height: defaultBoxHeight * 2 + MediaQuery.of(context).padding.bottom)
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //
    //                   //! -------------------------------------------------------------------------------- Submit button
    //                   Positioned(
    //                     bottom: MediaQuery.of(context).padding.bottom,
    //                     left: 0,
    //                     right: 0,
    //                     child: Obx(() => _controller.buttonText.isEmpty || _controller.isLoading.value
    //                         ? const SizedBox()
    //                         : Container(
    //                             color: Theme.of(context).canvasColor,
    //                             child: CustomElevatedButton(
    //                               margin: EdgeInsets.symmetric(vertical: defaultPadding / 2, horizontal: defaultPadding),
    //                               enable: _controller.isValidate.value,
    //                               backgroundColor: _controller.isValidate.value ? null : Theme.of(context).primaryColor.withOpacity(0.5),
    //                               onTap: () async => await _controller.submitData(),
    //                               // onDone: (isSuccess) {
    //                               //   if (isSuccess == null) return;
    //                               //   if (isSuccess) Get.back();
    //                               // },
    //                               child: Text(_controller.buttonText.value),
    //                             ),
    //                           )),
    //                   ),
    //                 ],
    //               );
    //             },
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}

//! Location
// class AttendanceScreenLocation extends StatelessWidget {
//   AttendanceScreenLocation({super.key});
//   final AttendanceScreenController _controller = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           CustomElevatedButton(
//             margin: EdgeInsets.only(bottom: defaultPadding / 2),
//             onTap: () async => await _controller.getLocation(),
//             child: _controller.gettingLocation.value
//                 ? Padding(padding: EdgeInsets.symmetric(horizontal: defaultBoxHeight), child: CustomCircularProgressBar(color: Theme.of(context).canvasColor))
//                 : Row(
//                     children: [
//                       Icon(Icons.location_on, color: Theme.of(context).canvasColor),
//                       SizedBox(width: defaultPadding / 2),
//                       const Expanded(child: Text("Find your location")),
//                     ],
//                   ),
//           ),
//           if (_controller.locationString.isNotEmpty)
//             CustomAnimatedSize(
//               alignment: Alignment.topCenter,
//               widthFactor: 1,
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Location:", style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
//                     Text(_controller.locationString.value, style: Theme.of(context).textTheme.labelLarge),
//                     const Divider(),
//                   ],
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

//! Button
// class AttendanceScreenButton extends StatelessWidget {
//   const AttendanceScreenButton({super.key, required this.description, required this.imageUrl, required this.shortText, required this.onTap, this.isActive = false, this.onDone});
//   final String description;
//   final String imageUrl;
//   final String shortText;
//   final Function onTap;
//   final bool isActive;
//   final dynamic Function(bool?)? onDone;
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomElevatedButton(
//       iconColor: Theme.of(context).shadowColor,
//       backgroundColor: isActive ? Theme.of(context).primaryColor.withOpacity(0.1) : Colors.transparent,
//       margin: EdgeInsets.symmetric(vertical: defaultPadding / 4),
//       expanded: true,
//       onTap: () async => onTap(),
//       onDone: onDone,
//       child: Row(
//         children: [
//           Expanded(
//             child: Text(
//               description,
//               style: Theme.of(context).textTheme.labelLarge,
//             ),
//           ),
//           SizedBox(width: defaultPadding / 2),
//           SizedBox(
//             width: defaultBoxHeight,
//             child: Column(
//               children: [
//                 Image.asset(imageUrl, width: defaultBoxHeight, height: defaultBoxHeight, fit: BoxFit.contain),
//                 Text(shortText, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodySmall)
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//! Scan
// class AttendanceScreenScan extends StatelessWidget {
//   AttendanceScreenScan({super.key});
//   final AttendanceScreenController _controller = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => AttendanceScreenButton(
//         isActive: _controller.isScan.value != null && _controller.isScan.value!,
//         description: "Effortlessly mark your attendance by simply scanning a QR code",
//         imageUrl: "lib/assets/icons/scan_attendance_image.png",
//         shortText: "Scan",
//         onTap: () async {
//           _controller.onTapButton(true);
//
//           // if (_controller.isScan.value == null) return;
//           if (_controller.latitude == null && _controller.longitude == null) {
//             showToast(message: "Please wait");
//             return;
//           }
//           PostBarcodeModel? barcode = await Get.to<PostBarcodeModel>(() => CustomQRCodeScanner(latitude: _controller.latitude!, longitude: _controller.longitude!));
//           if (barcode == null) return;
//           _controller.barcode = barcode;
//
//           _controller.checkValidation();
//           await _controller.submitData();
//         },
//       ),
//     );
//   }
// }

//! Picture
// class AttendanceScreenPicture extends StatelessWidget {
//   AttendanceScreenPicture({super.key});
//   final AttendanceScreenController _controller = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Obx(
//           () => AttendanceScreenButton(
//             isActive: _controller.isScan.value != null && !_controller.isScan.value!,
//             description: "Capture your attendance with taking front and back images of yourself along with your current location",
//             imageUrl: "lib/assets/icons/take_attendance_image.png",
//             shortText: "Picture",
//             onTap: () {
//               _controller.onTapButton(false);
//             },
//           ),
//         ),
//         Obx(
//           () => CustomAnimatedSize(
//             alignment: Alignment.topCenter,
//             widthFactor: 1,
//             child: _controller.isScan.value == null || _controller.isScan.value!
//                 ? null
//                 : Row(
//                     children: [
//                       AttendanceScreenTakeImage(
//                         text: "Front Image",
//                         imagePath: _controller.frontImage.value?.path,
//                         onTap: () async => await _controller.getImage(),
//                       ),
//                       SizedBox(width: defaultPadding / 2),
//                       AttendanceScreenTakeImage(
//                         text: "Back Image",
//                         imagePath: _controller.backImage.value?.path,
//                         onTap: () async => await _controller.getImage(isBack: true),
//                       ),
//                     ],
//                   ),
//           ),
//         )
//       ],
//     );
//   }
// }

// class AttendanceScreenTakeImage extends StatelessWidget {
//   const AttendanceScreenTakeImage({super.key, required this.text, this.onTap, this.imagePath});
//   final String text;
//   final Future<void> Function()? onTap;
//   final String? imagePath;
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Column(
//         children: [
//           AspectRatio(
//             aspectRatio: 1,
//             child: Padding(
//               padding: EdgeInsets.only(bottom: defaultPadding / 8),
//               child: Material(
//                 borderRadius: BorderRadius.circular(defaultPadding / 2),
//                 color: Theme.of(context).primaryColor.withOpacity(0.1),
//                 clipBehavior: Clip.antiAlias,
//                 child: InkWell(
//                   onTap: onTap,
//                   child: Container(
//                     child: imagePath == null ? null : Image.file(File(imagePath!), fit: BoxFit.cover),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Text(
//             text,
//             style: Theme.of(context).textTheme.titleSmall,
//           ),
//         ],
//       ),
//     );
//   }
// }

//! Quick Submit
// class AttendanceScreenQuickAttendance extends StatelessWidget {
//   AttendanceScreenQuickAttendance({super.key});
//
//   final AttendanceScreenController _controller = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     return AttendanceScreenButton(
//       shortText: 'Quick',
//       description: 'Submit attendance instantly without scanning or capturing',
//       imageUrl: 'lib/assets/icons/quick_attendance.png',
//       onTap: () async {
//         _controller.isScan.value = null;
//         return await _controller.submitData();
//       },
//       // onDone: (isSuccess) {
//       //   if (isSuccess != null && isSuccess) Get.back();
//       // },
//     );
//   }
// }
