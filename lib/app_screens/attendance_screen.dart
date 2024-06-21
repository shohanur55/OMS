import 'dart:io';


import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../components.dart';
import '../controller/Screen_controller/AttendanceScreenController.dart';
import '../model/dashboard_response_model.dart';
import '../widget/base_components/custom_animated_size_widget.dart';
import '../widget/base_components/custom_elevated_button_widget.dart';
import '../widget/boxes/custom_connectivity_banner.dart';
import '../widget/boxes/warning_message.dart';
import '../widget/others/custom_circular_progress_bar.dart';


class AttendanceScreen extends StatefulWidget {
  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final AttendanceScreenController _controller = Get.put(AttendanceScreenController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.delete<AttendanceScreenController>();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Attendance"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
            onPressed: () => Get.back(),
          ),
        ),
        body: Column(
          children: [
            CustomConnectivityBanner(),
            Expanded(
              child: LayoutBuilder(
                builder: (context, box) {
                  return Stack(
                    children: [
                      RefreshIndicator(
                        onRefresh: _controller.getData,
                        child: SingleChildScrollView(
                          child: Container(
                            constraints: BoxConstraints(minHeight: box.maxHeight + 0.01),
                            padding: EdgeInsets.all(defaultPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AttendanceScreenLocation(),
                               CustomAnimatedSize(
                                  widthFactor: 1,
                                  child: AttendanceScreenQuickAttendance(),
                                ),
                                SizedBox(height: defaultBoxHeight * 2 + MediaQuery.of(context).padding.bottom),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Obx(() {
                        if (_controller.buttonText.isEmpty || _controller.isLoading.value) {
                          return SizedBox();
                        }
                        return Positioned(
                          bottom: MediaQuery.of(context).padding.bottom,
                          left: 0,
                          right: 0,
                          child: Container(
                            color: Theme.of(context).canvasColor,
                            child: CustomElevatedButton(
                              margin: EdgeInsets.symmetric(vertical: defaultPadding / 2, horizontal: defaultPadding),
                              enable: _controller.isValidate.value,
                              backgroundColor: _controller.isValidate.value
                                  ? null
                                  : Theme.of(context).primaryColor.withOpacity(0.5),
                              onTap: _controller.submitData,
                              child: Text(_controller.buttonText.value),
                            ),
                          ),
                        );
                      }),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


//! Location
class AttendanceScreenLocation extends StatelessWidget {
  final AttendanceScreenController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomElevatedButton(
          margin: EdgeInsets.only(bottom: defaultPadding / 2),
          onTap: _controller.getLocation,
          child: _controller.gettingLocation.value
              ? Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultBoxHeight),
            child: CustomCircularProgressBar(color: Theme.of(context).canvasColor),
          )
              : Row(
            children: [
              Icon(Icons.location_on, color: Theme.of(context).canvasColor),
              SizedBox(width: defaultPadding / 2),
              const Expanded(child: Text("Find your location")),
            ],
          ),
        ),
        if (_controller.locationString.isNotEmpty)
          CustomAnimatedSize(
            alignment: Alignment.topCenter,
            widthFactor: 1,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Location:",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                  ),
                  Text(_controller.locationString.value, style: Theme.of(context).textTheme.labelLarge),
                  const Divider(),
                ],
              ),
            ),
          ),
      ],
    ));
  }
}


//! Button
class AttendanceScreenButton extends StatelessWidget {
  const AttendanceScreenButton({super.key, required this.description, required this.imageUrl, required this.shortText, required this.onTap, this.isActive = false, this.onDone});
  final String description;
  final String imageUrl;
  final String shortText;
  final Function onTap;
  final bool isActive;
  final dynamic Function(bool?)? onDone;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      iconColor: Theme.of(context).shadowColor,
      backgroundColor: isActive ? Theme.of(context).primaryColor.withOpacity(0.1) : Colors.transparent,
      margin: EdgeInsets.symmetric(vertical: defaultPadding / 4),
      expanded: true,
      onTap: () async => onTap(),
      onDone: onDone,
      child: Row(
        children: [
          Expanded(
            child: Text(
              description,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          SizedBox(width: defaultPadding / 2),
          SizedBox(
            width: defaultBoxHeight,
            child: Column(
              children: [
                Image.asset(imageUrl, width: defaultBoxHeight, height: defaultBoxHeight, fit: BoxFit.contain),
                Text(shortText, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodySmall)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//! Quick Submit
class AttendanceScreenQuickAttendance extends StatelessWidget {
  final AttendanceScreenController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return AttendanceScreenButton(
      shortText: 'Quick',
      description: 'Quickly Submit attendance With your current location ',
      imageUrl: 'lib/assets/icons/quick_attendance.png',
      onTap: _controller.submitData,
    );
  }
}

