import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/dataController.dart';
import '../controller/storageController.dart';

class RulesR extends StatefulWidget {
  const RulesR({super.key});

  @override
  State<RulesR> createState() => _RulesRState();
}

class _RulesRState extends State<RulesR> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DataController _controller = Get.put(DataController());
  StorageController store=Get.put(StorageController());

  Future<Map<String, dynamic>> _fetchDocumentData() async {
    try {
      DocumentSnapshot documentSnapshot = await _firestore
          .collection('ABC Company')
          .doc(store.userEmail.value)
          .get();
      return documentSnapshot.data() as Map<String, dynamic> ?? {};
    } catch (e) {
      print("Error fetching document: $e");
      return {};
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rules and Regulation"),
        centerTitle: true,
      ),
      body:FutureBuilder<Map<String, dynamic>>(
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
      return ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(data['Rules']),
          ),

        ],
      );
    }
    })
    );
  }
}
