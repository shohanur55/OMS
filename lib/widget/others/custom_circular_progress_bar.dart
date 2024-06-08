
import 'package:flutter/material.dart';

import '../../components.dart';

class CustomCircularProgressBar extends StatelessWidget {
  final double? size;
  final Color? color;
  final double strokeWidth;
  const CustomCircularProgressBar({
    super.key,
    this.size,
    this.color,
    this.strokeWidth = 2,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size ?? defaultPadding / 2,
      width: size ?? defaultPadding / 2,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        color: color ?? Theme.of(context).primaryColor,
      ),
    );
  }
}
