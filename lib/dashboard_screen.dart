import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_series/app_screens/addEmployee.dart';
import 'package:firebase_series/app_screens/emplyeeListScreen.dart';
import 'package:firebase_series/app_screens/setLeaveType.dart';
import 'package:firebase_series/widget/base_components/custom_animated_size_widget.dart';
import 'package:firebase_series/widget/base_components/custom_elevated_button_widget.dart';
import 'package:firebase_series/widget/boxes/warning_message.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'app_screens/attendance_history_screen.dart';
import 'app_screens/attendance_screen.dart';
import 'app_screens/leave_application_screen.dart';
import 'app_screens/leave_approve_screen.dart';
import 'app_screens/payslip_screen.dart';
import 'components.dart';
import 'dashboard_menu_model.dart';

class DashBoardScreen extends StatefulWidget {
  DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> _fetchDocumentData() async {
    try {
      DocumentSnapshot documentSnapshot = await _firestore
          .collection('ABC Company')
          .doc('mshohan088@gmail.com')
          .get();
      return documentSnapshot.data() as Map<String, dynamic> ?? {};
    } catch (e) {
      print("Error fetching document: $e");
      return {};
    }
  }

  List<DashboardMenuModel> _parseMenuList(Map<String, dynamic> data) {
    List<dynamic>? menuList = data['menulist'] as List<dynamic>?;
    if (menuList == null || menuList.isEmpty) {
      return [];
    }

    return menuList.map((item) {
      var menuMap = item as Map<String, dynamic>;
      return DashboardMenuModel.fromJson(menuMap);
    }).toList();
  }

  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Firestore Document Data Display'),
  //     ),
  //     body: FutureBuilder<Map<String, dynamic>>(
  //       future: _fetchDocumentData(),
  //       builder: (context, snapshot) {
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return const Center(child: CircularProgressIndicator());
  //         } else if (snapshot.hasError) {
  //           return Center(child: Text('Error: ${snapshot.error}'));
  //         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
  //           return Center(child: Text('No Data Found'));
  //         } else {
  //           Map<String, dynamic> data = snapshot.data!;
  //           List<dynamic>? attendanceList = data['attendence'] as List<dynamic>?;
  //
  //           if (attendanceList == null || attendanceList.isEmpty) {
  //             return Center(child: Text('No attendance records found.'));
  //           }
  //
  //
  //           return ListView(
  //             padding: EdgeInsets.all(16.0),
  //             children: [
  //               Text('Name: ${data['Name']}', style: TextStyle(fontSize: 18)),
  //               Text('Role: ${data['Rule']}', style: TextStyle(fontSize: 18)),
  //               Text('Salary: ${data['Salary']}', style: TextStyle(fontSize: 18)),
  //               SizedBox(height: 20),
  //               Text('Attendance:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
  //               ...attendanceList.map((attendance) {
  //                 var attendanceMap = attendance as Map<String, dynamic>;
  //                 return Padding(
  //                   padding: const EdgeInsets.only(top: 10.0),
  //                   child: Text(
  //                     'Date: ${attendanceMap['date']}, Location: ${attendanceMap['location']}, Time: ${attendanceMap['time']}',
  //                     style: TextStyle(fontSize: 16),
  //                   ),
  //                 );
  //               }).toList(),
  //             ],
  //           );
  //         }
  //       },
  //     ),
  //   );
  // }
/*  final DashboardScreenController _controller = Get.put(DashboardScreenController());
  final DataController _dataController = Get.find();

  Widget? _image(BuildContext context, String? image64) {
    Widget? we;
    if (_controller.response.value == null && _controller.isLoading.value) {
      we = LinearProgressIndicator(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
      );
    } else {
      Uint8List? x = imageStringToByte(image64);
      if (x != null) we = Image.memory(x);
    }

    return we;
  }*/

  void goNextPage(int id) {
    print("DashboardScreenController: Showing page for menuId: $id");

    Map<int, Widget> map = {
      1337: AttendanceScreen(),
      1338: LeaveApplicationScreen(),
      1341: PayslipScreen(),
      1342: AttendanceHistoryScreen(),
      1339: LeaveApproveScreen(),
      1340:EmployeeListScreen(),
      1343:AddEmployeeScreen(),
      1344:AttendanceHistoryScreen(),//have to change
      1345:PayslipScreen(),//have to change
      1346:SetLeaveType(),
    };

    if (map[id] == null) {
      print("message: This feature will be added soon");
      return;
    }

    Get.to(() => map[id]!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          //! ---------------------------------------------------------------------------------------- Title
          title: FittedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Dashboard",
                    style: Theme.of(context).appBarTheme.titleTextStyle),
                Text("Version: $appVersion",
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context)
                            .appBarTheme
                            .titleTextStyle
                            ?.color
                            ?.withOpacity(0.8))),
              ],
            ),
          ),

          //! ---------------------------------------------------------------------------------------- Actions
          actions: [
            IconButton(
                onPressed: () {
                  //   if (_controller.response.value == null) {
                  //     showToast(message: "Please Wait");
                  //     return;
                  //   }
                  // Get.to(() => NotificationScreen(dashboardResponseModel: _controller.response.value!));
                },
                icon: const Icon(Icons.notifications)),
            //IconButton(onPressed: _controller.onPressDrawerButton, icon: const Icon(Icons.more_vert_rounded))
          ],
        ),
        body: FutureBuilder<Map<String, dynamic>>(
            future: _fetchDocumentData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No Data Found'));
              } else {
                Map<String, dynamic> data = snapshot.data!;
                List<DashboardMenuModel> menuList = _parseMenuList(data);

                if (menuList.isEmpty) {
                  return Center(child: Text('No menu records found.'));
                }

                return ListView(

                  children: [
                    //CustomConnectivityBanner(),

                    //! -------------------------------------------------------------------------------------- UserInfo
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: defaultPadding / 2,
                          vertical: defaultPadding),
                      child: Row(
                        children: [
                          // Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(DateFormat.yMMMd().format(DateTime.now()),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                            color:
                                                Theme.of(context).canvasColor)),

                                SizedBox(height: defaultPadding / 2),

                                // Name
                                CustomAnimatedSize(
                                  widthFactor: 1,
                                  alignment: Alignment.topCenter,
                                  child: data['Name'] == null
                                      ? null
                                      : Text(data['Name'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge
                                              ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .canvasColor)),
                                ),

                                const Divider(),
                                // Designation
                                CustomAnimatedSize(
                                  widthFactor: 1,
                                  alignment: Alignment.topCenter,
                                  child: data['Designation'] == null
                                      ? null
                                      : Text.rich(
                                          TextSpan(
                                            text: "Designation: ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium
                                                ?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context)
                                                        .canvasColor),
                                            children: [
                                              TextSpan(
                                                text: data['Name'],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Theme.of(context)
                                                            .canvasColor),
                                              )
                                            ],
                                          ),
                                        ),
                                ),

                                // Company
                                Text.rich(
                                  TextSpan(
                                    text: "Company: ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).canvasColor),
                                    children: [
                                      TextSpan(
                                        text: "ABC Company",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.normal,
                                                color: Theme.of(context)
                                                    .canvasColor),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),


                        ],
                      ),
                    ),

                    //! -------------------------------------------------------------------------------------- Menus
                    Expanded(
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            color: Theme.of(context).canvasColor,
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(defaultPadding))),
                        child:
                            //Positioned(child: Obx(() => !_controller.isLoading.value ? const SizedBox() : const LinearProgressIndicator())),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultPadding / 2),
                              child: SingleChildScrollView(
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 16.0),
                                  width: double.infinity,
                                  child: Wrap(
                                    alignment: WrapAlignment.center,
                                    children: [
                                      if (menuList.isEmpty)
                                        const WarningMessage(
                                            message: "Something went wrong.\nTry again later."),
                                      for (DashboardMenuModel i in menuList ?? [])
                                        CustomElevatedButton(
                                          backgroundColor: Colors.transparent,
                                          contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                                          constraints: BoxConstraints(maxWidth: 120),
                                          child: Column(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Theme.of(context).primaryColor,
                                                    borderRadius: BorderRadius.circular(1000)),
                                                margin: EdgeInsets.all(8.0),
                                                padding: EdgeInsets.all(16.0),
                                                width: 64,
                                                height: 64,
                                                child: Image.asset(i.image,),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                                child: Text(i.menuName ?? "",
                                                    style: Theme.of(context).textTheme.labelLarge,
                                                    textAlign: TextAlign.center),
                                              ),
                                            ],
                                          ),
                                          onDone: (_) => goNextPage(i.menuId ?? 0),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                      ),
                    ),
                  ],
                );
              }
            }));
  }
}
