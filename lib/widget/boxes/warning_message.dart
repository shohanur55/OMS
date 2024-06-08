
import 'package:flutter/material.dart';

import '../../components.dart';

class WarningMessage extends StatelessWidget {
  const WarningMessage({super.key, this.message = "No Data Found"});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding / 2),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
