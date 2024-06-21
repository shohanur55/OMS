import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_series/app_screens/addEmployee.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Firebase_part/firebase_func.dart';
import '../components.dart';
import '../widget/base_components/custom_elevated_button_widget.dart';
import '../widget/custom_text_field1.dart';
class Createaccount extends StatefulWidget {
  const Createaccount({super.key});

  @override
  State<Createaccount> createState() => _CreateaccountState();
}

class _CreateaccountState extends State<Createaccount> {
  final _formKey = GlobalKey<FormState>();


  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<void> addUser(String email, String password) async {
    try {
      DocumentReference docRef = _firestore.collection('ABC Company').doc('user_info');

      await _firestore.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(docRef);

        if (!snapshot.exists) {
          // If the document does not exist, create it with an initial list
          transaction.set(docRef, {
            'user_list': [
              {'email': email, 'password': password}
            ]
          });
        } else {
          // If the document exists, update the list
          List<dynamic> userList = snapshot['user_list'] ?? [];
          userList.add({'email': email, 'password': password});

          transaction.update(docRef, {'user_list': userList});
        }
      });

      print('User added successfully');
    } catch (e) {
      print('Error adding user: $e');
    }
  }


  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create New Account"),
      ),
     body: Padding(
       padding: const EdgeInsets.all(18.0),
       child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: defaultPadding),
              //Image.asset("lib/assets/logo/logo.png", height: defaultPadding),
              SizedBox(height: defaultPadding),
              CustomTextField1(
                textEditingController:
                emailcontroller,
                keyboardType:
                TextInputType.emailAddress,
                hintText: "Enter your email",
                svg:
                "lib/assets/icons/message_icon.svg",
                //validator: (value) => !_controller.isEmail.value ? null : emailValidation(_controller.email),

              ),
              SizedBox(height: defaultPadding / 2),
              CustomTextField1(
                textEditingController:
                passwordcontroller,
                keyboardType:
                TextInputType.visiblePassword,
                hintText: "Enter your password",
                svg: "lib/assets/icons/lock_icon.svg",
                obscureText: true,
                //validator: (value) => passwordValidation(_controller.password),

              ),
              SizedBox(height: defaultPadding / 2),

              SizedBox(height: defaultPadding),
              CustomElevatedButton(
                  expanded: true,
                  border: Border.all(width: borderWidth2, strokeAlign: BorderSide.strokeAlignOutside, color: Theme.of(context).cardColor),
                  child: const Text("Sign up"),

                  onTap:() async{

                   await Firebase_func.signUp(
                        context,
                        emailcontroller.text.toString(),
                        passwordcontroller.text
                            .toString());
                   Get.off(()=>AddEmployeeScreen());

                  }


              ),
            ],
          ),
        ),
     ),
    );
  }
}
