import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Task extends StatefulWidget {
  const Task({super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
appBar: AppBar(
  title: Text("Task"),
  centerTitle: true,
  actions: [
   IconButton(onPressed: (){

   }, icon: Icon(Icons.add,size:30.sp)),
  ],
),
    );
  }
}
