
import 'package:flutter/material.dart';

import '../../components.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, this.child, this.height, this.width, this.color, this.isLoading = false, this.isLoadingHeight, this.heading, this.margin, this.padding});
  final Widget? child;
  final Widget? heading;
  final double? height;
  final double? width;
  final Color? color;
  final bool isLoading;
  final double? isLoadingHeight;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(defaultPadding / 4),
          boxShadow: shadowDown,
        ),
        child: Column(
          children: [
            if (heading != null) heading!,
            Container(
              width: width,
              height: isLoading ? isLoadingHeight ?? defaultPadding : height,
              padding: isLoading ? null : padding ?? EdgeInsets.all(defaultPadding / 2),
              child: isLoading ? LinearProgressIndicator(color: Theme.of(context).primaryColor.withOpacity(0.1)) : child,
            ),
          ],
        ));
  }
}
