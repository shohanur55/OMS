
import 'package:flutter/material.dart';

import '../../components.dart';

class CustomPopUpWindow extends StatelessWidget {
  final Widget? title;
  final Widget? child;
  final Widget? footer;
  final EdgeInsetsGeometry padding;
  final CrossAxisAlignment crossAxisAlignment;
  final int indentIndex;
  final bool isExpanded;
  const CustomPopUpWindow({
    super.key,
    this.child,
    this.title,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.footer,
    this.padding = const EdgeInsets.all(0),
    this.indentIndex = 0,
    this.isExpanded = true,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      child: Container(
        width: isExpanded ? double.infinity : null,
        constraints: BoxConstraints(maxWidth: defaultMaxWidth),
        child: Padding(
          padding: padding,
          child: Padding(
            padding: EdgeInsets.all(defaultPadding * indentIndex),
            child: Container(
              margin: EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(color: Theme.of(context).canvasColor, borderRadius: BorderRadius.circular(defaultPadding)),
              padding: EdgeInsets.symmetric(vertical: defaultPadding),
              // height: null,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: crossAxisAlignment,
                  children: [
                    if (title != null)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                        child: DefaultTextStyle(
                          style: Theme.of(context).textTheme.headlineMedium ?? const TextStyle(),
                          child: title!,
                        ),
                      ),
                    if (title != null) SizedBox(height: defaultPadding),
                    Container(
                      constraints: BoxConstraints(maxHeight: (MediaQuery.of(context).size.height / 2) - (defaultPadding * 2)),
                      child: SingleChildScrollView(
                        child: Padding(padding: EdgeInsets.symmetric(horizontal: defaultPadding), child: child),
                      ),
                    ),
                    if (footer != null) SizedBox(height: defaultPadding),
                    if (footer != null)
                      Container(
                        constraints: BoxConstraints(maxHeight: (MediaQuery.of(context).size.height / 4) - (defaultPadding)),
                        child: SingleChildScrollView(
                          child: Padding(padding: EdgeInsets.symmetric(horizontal: defaultPadding), child: footer),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
