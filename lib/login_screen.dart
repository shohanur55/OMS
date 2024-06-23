
import 'package:firebase_series/widget/custom_text_field1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'Firebase_part/firebase_func.dart';
import 'components.dart';
import 'controller/storageController.dart';
import 'widget/custom_elevated_button_widget.dart';


class LoginScreen extends StatelessWidget {
  String dept;
  LoginScreen({super.key,required this.dept});
  StorageController store = Get.put(StorageController());
  //final LoginScreenController _controller = Get.put(LoginScreenController());

  final _formKey = GlobalKey<FormState>();

  showPopup() {}
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
     appBar: AppBar(
       title: Text(dept+" Login"),
       centerTitle: true,
     ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            child: ListView(

              children: [
                Center(child: Text("Office Management System",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 22,),)),
                SizedBox(height: defaultPadding),
                Text("Please Login",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 22,),),
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
                  child: const Text("Login"),

                  onTap:() {
                    store.saveEmail(emailcontroller.text);
                    Firebase_func.logIn(
                        context,
                        emailcontroller.text.toString(),
                        passwordcontroller.text
                            .toString());
                  }

                  //!
                  // onTap: () async {
                  //   var res = _formKey.currentState?.validate();
                  //   if (!(res ?? true)) return false;
                  //  // bool isSuccess = await _controller.login();
                  //   if (!isSuccess) return false;
                  //   if (!context.mounted) return null;
                  //   //! ---------------------------------------------------------------------------- Dialog Box (Select Company)
                  //   final int? selectedCompany = await showDialog<int>(
                  //     context: context,
                  //     builder: (ctx) {
                  //       List<CompanyModel> companies = _controller.userCompanyModel.value?.companyList ?? [];
                  //       return CustomPopUpWindow(
                  //         title: const Text("Select company"),
                  //         child: companies.isEmpty
                  //             ? Text("Its Seems like you don't have any Subscription, please Contact with your Software Provider", style: Theme.of(context).textTheme.headlineMedium)
                  //             : Column(
                  //                 children: [
                  //                   for (int i = 0; i < companies.length; i++)
                  //                     CustomElevatedButton(
                  //                       expanded: true,
                  //                       margin: EdgeInsets.symmetric(vertical: defaultPadding / 8),
                  //                       child: Text(companies.elementAt(i).companyName ?? "", textAlign: TextAlign.center),
                  //                       onDone: (_) => Get.back<int>(result: i),
                  //                     )
                  //                 ],
                  //               ),
                  //       );
                  //     },
                  //   );
                  //   if (selectedCompany == null) return false;
                  //
                  //   if (!await _controller.getProduct(selectedCompany)) return false;
                  //
                  //   if (!context.mounted) return null;
                  //   //! ---------------------------------------------------------------------------- Dialog Box (Select Product)
                  //   final SoftwareModel? selectedProduct = await showDialog<SoftwareModel>(
                  //     context: context,
                  //     builder: (ctx) {
                  //       List<SoftwareModel> software = _controller.userProductModel.value?.softwareList ?? [];
                  //       return CustomPopUpWindow(
                  //         title: const Text("Select Product"),
                  //         child: Column(
                  //           children: [
                  //             for (int i = 0; i < software.length; i++)
                  //               CustomElevatedButton(
                  //                 expanded: true,
                  //                 margin: EdgeInsets.symmetric(vertical: defaultPadding / 8),
                  //                 child: Text(software.elementAt(i).softwareName ?? "", textAlign: TextAlign.center),
                  //                 onDone: (_) => Get.back<SoftwareModel>(result: software.elementAt(i)),
                  //               )
                  //           ],
                  //         ),
                  //       );
                  //     },
                  //   );
                  //   if (selectedProduct == null) return false;
                  //
                  //   _controller.userCompanyModel.value?.selectedCompany = _controller.userCompanyModel.value!.companyList!.elementAt(selectedCompany);
                  //   _controller.userProductModel.value?.selectedSoftware = selectedProduct;
                  //
                  //   return true;
                  // },

                  //!
                  // onDone: (isSuccess) {
                  //   if (isSuccess != null && isSuccess) _controller.goHome();
                  // },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
