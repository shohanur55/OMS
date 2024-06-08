
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import '../../components.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({super.key, required this.text, this.isHeading = false});
  final String text;
  final bool isHeading;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: defaultPadding / 4),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 11.sp, fontWeight: isHeading ? FontWeight.bold : FontWeight.normal, color: isHeading ? Theme.of(context).canvasColor : null),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
