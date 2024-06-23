import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components.dart';
import '../widget/base_components/custom_elevated_button_widget.dart';
import '../widget/custom_text_field1.dart';

class Giventask extends StatefulWidget {
  const Giventask({super.key});

  @override
  State<Giventask> createState() => _GiventaskState();
}

class _GiventaskState extends State<Giventask> {

  TextEditingController namec=TextEditingController();
  TextEditingController topicn=TextEditingController();
  TextEditingController topicd=TextEditingController();
  TextEditingController duration=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Give Task"),
        centerTitle: true,

      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: [
            Text(
              "Assign To",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),

            CustomTextField1(
              textEditingController: namec,
              keyboardType: TextInputType.emailAddress,
              hintText: "Enter employee name",
              svg: "lib/assets/icons/message_icon.svg",
              //validator: (value) => !_controller.isEmail.value ? null : emailValidation(_controller.email),
            ),
            SizedBox(
              height: 5.sp,
            ),


            Text(
              "Topic name",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            CustomTextField1(
              textEditingController: topicn,
              keyboardType: TextInputType.text,
              hintText: "Enter Task Name",
              svg: "lib/assets/icons/message_icon.svg",
              //validator: (value) => !_controller.isEmail.value ? null : emailValidation(_controller.email),
            ),
            Text(
              "Topic Description",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green,width: 3),
              ),
              child: TextField(
                decoration:
                InputDecoration(labelText: 'Enter Task Description',),
                controller: topicd,
                keyboardType: TextInputType.multiline,
                minLines: 5, // <-- SEE HERE
                maxLines: 10, // <-- SEE HERE
              ),
            ),
            Text(
              "Duration",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            CustomTextField1(
              textEditingController: duration,
              keyboardType: TextInputType.text,
              hintText: "Enter Task duration time",
              svg: "lib/assets/icons/message_icon.svg",
              //validator: (value) => !_controller.isEmail.value ? null : emailValidation(_controller.email),
            ),
            SizedBox(
              height: 10.sp,
            ),
            CustomElevatedButton(
                expanded: false,
                border: Border.all(
                    width: borderWidth2,
                    strokeAlign: BorderSide.strokeAlignOutside,
                    color: Theme.of(context).cardColor),
                child: const Text("Send"),
                onTap: () async{
                 // await saveData();


                }),
          ],
        ),
      ),
    );
  }
}
