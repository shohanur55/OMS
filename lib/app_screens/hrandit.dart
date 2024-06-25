import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Hrandit extends StatefulWidget {
  const Hrandit({super.key});

  @override
  State<Hrandit> createState() => _HranditState();
}

class _HranditState extends State<Hrandit> {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<List<dynamic>> fetchTextList() async {
    try {
      DocumentSnapshot documentSnapshot = await _firestore.collection('ABC Company').doc("withIt").get();
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>? ?? {};
      return data['textlist'] as List<dynamic>? ?? [];
    } catch (e) {
      print("Error fetching text list: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HR and IT "),
      ),
      body:  FutureBuilder<List<dynamic>>(
        future: fetchTextList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No records found.'));
          } else {
            List<dynamic> textlist = snapshot.data!;
            return ListView.builder(
              itemCount: textlist.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> textItem = textlist[index] as Map<String, dynamic>;
                int i=index+1;
                return ListTile(
                  title: Text(textItem['text'] ?? 'No Text'),
                  leading: Text(i.toString()),
                );
              },
            );
          }
        },
      ),


    );
  }
}
