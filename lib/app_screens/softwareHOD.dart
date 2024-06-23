
import 'package:firebase_series/app_screens/givenTask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Softwarehod extends StatefulWidget {
  const Softwarehod({super.key});

  @override
  State<Softwarehod> createState() => _SoftwarehodState();
}

class _SoftwarehodState extends State<Softwarehod> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee response list"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
Get.to(()=>Giventask());
          }, icon: Icon(Icons.add, size: 30.sp)),
        ],
      ),
    );
  }
}