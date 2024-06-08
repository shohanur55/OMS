
import 'package:flutter/material.dart';

import '../../components.dart';
import '../base_components/custom_elevated_button_widget.dart';

class CustomIncrementButton extends StatefulWidget {
  final int initialValue;
  final int? minimumRange;
  final int? maximumRange;
  final int changeValue;
  final EdgeInsets? textPadding;
  final Duration autoIncrementDuration;
  final Function(int value)? onChange;

  const CustomIncrementButton({
    super.key,
    this.initialValue = 1,
    this.minimumRange = 1,
    this.maximumRange,
    this.changeValue = 1,
    this.onChange,
    this.autoIncrementDuration = const Duration(milliseconds: 100),
    this.textPadding = const EdgeInsets.symmetric(horizontal: 8),
  });

  @override
  State<CustomIncrementButton> createState() => _CustomIncrementButtonState();
}

class _CustomIncrementButtonState extends State<CustomIncrementButton> {
  late int currentValue;
  @override
  void initState() {
    currentValue = widget.initialValue;
    super.initState();
  }

  bool isTapped = false;

  _onLongPress(isRemoving) async {
    while (isTapped) {
      await Future.delayed(widget.autoIncrementDuration);
      _increment(isRemoving);
    }
  }

  _increment(isRemoving) {
    if (isRemoving) {
      if (widget.minimumRange != null && currentValue <= widget.minimumRange!) return;
      if (mounted) setState(() => currentValue = currentValue - widget.changeValue);
      if (widget.onChange != null) widget.onChange!(currentValue);
    } else {
      if (widget.maximumRange != null && currentValue >= widget.maximumRange!) return;
      if (mounted) setState(() => currentValue = currentValue + widget.changeValue);
      if (widget.onChange != null) widget.onChange!(currentValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: defaultBoxHeight - defaultPadding / 2, vertical: defaultPadding / 4),
          margin: widget.textPadding,
          child: Text(
            currentValue.toString().padLeft(2, '0'),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        // Quantity remove
        Positioned(
          top: 0,
          bottom: 0,
          child: Center(
            child: CustomElevatedButton(
              onLongPress: () async => await _onLongPress(true),
              onTap: () => _increment(true),
              margin: const EdgeInsets.all(0),
              onLongPressDown: (_) => isTapped = true,
              onLongPressUp: () => isTapped = false,
              backgroundColor: Colors.transparent,
              child: FittedBox(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Theme.of(context).primaryColor.withOpacity(widget.minimumRange != null && currentValue <= widget.minimumRange! ? 0.6 : 1),
                  ),
                  child: Icon(
                    Icons.remove,
                    color: Theme.of(context).canvasColor,
                  ),
                ),
              ),
            ),
          ),
        ),
        // Quantity add
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: Center(
            child: CustomElevatedButton(
              onLongPress: () async => await _onLongPress(false),
              onTap: () => _increment(false),
              onLongPressDown: (_) => isTapped = true,
              onLongPressUp: () => isTapped = false,
              margin: const EdgeInsets.all(0),
              backgroundColor: Colors.transparent,
              child: FittedBox(
                  child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Theme.of(context).primaryColor.withOpacity(widget.maximumRange != null && currentValue >= widget.maximumRange! ? 0.6 : 1),
                ),
                child: Icon(
                  Icons.add,
                  color: Theme.of(context).canvasColor,
                ),
              )),
            ),
          ),
        )
      ],
    );
  }
}
