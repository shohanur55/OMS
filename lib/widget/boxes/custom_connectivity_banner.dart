

import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../components.dart';
import '../../controller/dataController.dart';
import '../base_components/custom_animated_size_widget.dart';

class CustomConnectivityBanner extends StatelessWidget {
  CustomConnectivityBanner({super.key});

 final DataController _controller = Get.put(DataController());

  @override
  Widget build(BuildContext context) {
    return  Obx(()=>
      CustomAnimatedSize(
            widthFactor: 1,
            child:  _controller.isConnected.value
                ? null
                 :
               Container(
                    padding: EdgeInsets.symmetric(vertical: defaultPadding / 8),
                    color: Colors.yellow,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.signal_cellular_connected_no_internet_4_bar_outlined, size: defaultPadding / 1.5, color: Colors.red),
                        SizedBox(width: defaultPadding / 4),
                        const Text("No internet connection", style: TextStyle(color: Colors.black))
                      ],
                    ),
                  ),
      ),
    );
  }
}
