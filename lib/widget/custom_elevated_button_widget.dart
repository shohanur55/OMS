import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'custom_animated_size_widget.dart';



class CustomElevatedButton extends StatefulWidget {
  final List<BoxShadow>? boxShadow;
  final bool enable;
  final double? height;
  final double? width;
  final Duration duration;
  final double? iconHeight;
  final BoxConstraints? constraints;
  final BorderRadius borderRadius;
  final BoxBorder? border;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? margin;
  final Future<bool?>? Function()? onTap;
  final Function(bool? isSuccess)? onDone;
  final void Function()? onLongPress;
  final Widget? child;
  final Widget? onRunningWidget;
  final Widget? onSuccessWidget;
  final Widget? onErrorWidget;
  final bool expanded;
  final bool? expandedIcon;
  final MainAxisAlignment verticalAlignment;
  final AlignmentGeometry? horizontalAlignment;
  final Duration statusShowingDuration;
  final Color? backgroundColor;
  final Color iconColor;
  final bool roundBorderWhenRunning;
  final Function(ButtonStatus buttonStatus)? onStatusChange;

  final void Function(TapDownDetails details)? onTapDown;
  final void Function(TapUpDetails details)? onTapUp;
  final void Function(LongPressDownDetails details)? onLongPressDown;
  final void Function()? onLongPressUp;
  final void Function(LongPressMoveUpdateDetails details)? onLongPressMoveUpdate;
  const CustomElevatedButton({
    Key? key,
    this.boxShadow,
    this.enable = true,
    this.height,
    this.width,
    this.duration = const Duration(milliseconds: 150),
    this.iconHeight = 24,
    this.constraints = const BoxConstraints(minHeight: 40),
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.border,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
    this.margin,
    this.onTap,
    this.onDone,
    this.onLongPress,
    this.child,
    this.onRunningWidget,
    this.onSuccessWidget,
    this.onErrorWidget,
    this.expanded = false,
    this.expandedIcon,
    this.verticalAlignment = MainAxisAlignment.center,
    this.horizontalAlignment = Alignment.center,
    this.statusShowingDuration = const Duration(seconds: 2),
    this.backgroundColor,
    this.iconColor = Colors.white,
    this.roundBorderWhenRunning = false,
    this.onStatusChange,
    this.onTapDown,
    this.onTapUp,
    this.onLongPressDown,
    this.onLongPressUp,
    this.onLongPressMoveUpdate,
  }) : super(key: key);

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  ButtonStatus isRunning = ButtonStatus.stable;
  bool? result;

  Widget child(Widget c) {
    return Flexible(
      child: Container(
        padding: widget.iconHeight == null ? widget.contentPadding : null,
        child: SizedBox(
          height: widget.iconHeight,
          child: AspectRatio(
            aspectRatio: 1,
            child: FittedBox(
              child: c,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedSize(
      child: Container(
        margin: widget.margin,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: !widget.roundBorderWhenRunning
              ? widget.borderRadius
              : isRunning == ButtonStatus.running
                  ? BorderRadius.circular(100)
                  : widget.borderRadius,
          border: widget.border,
          boxShadow: widget.boxShadow,
          color: widget.boxShadow == null ? null : Colors.white,
        ),
        child: Material(
          color: widget.backgroundColor ?? Theme.of(context).primaryColor,
          child: GestureDetector(
            onLongPress: widget.onLongPress,
            onLongPressDown: widget.onLongPressDown,
            onLongPressUp: widget.onLongPressUp,
            onLongPressCancel: widget.onLongPressUp,
            onLongPressEnd: (_) {
              if (widget.onLongPressUp != null) widget.onLongPressUp!();
            },
            onLongPressMoveUpdate: widget.onLongPressMoveUpdate,
            child: InkWell(
              onTapDown: widget.onTapDown,
              onTapUp: widget.onTapUp,
              onTap: !widget.enable
                  ? null
                  : () async {
                      if (!widget.enable) return;
                      if (isRunning != ButtonStatus.stable) return;
                      if (mounted) setState(() => isRunning = ButtonStatus.running);
                      if (widget.onStatusChange != null) widget.onStatusChange!(isRunning);
                      if (widget.onTap != null) {
                        result = await widget.onTap!();
                        if (result != null) {
                          if (result! && mounted) setState(() => isRunning = ButtonStatus.success);
                          if (!result! && mounted) setState(() => isRunning = ButtonStatus.error);
                          if (widget.onStatusChange != null) widget.onStatusChange!(isRunning);
                          await Future.delayed(widget.statusShowingDuration);
                        }
                      }
                      if (mounted) setState(() => isRunning = ButtonStatus.running);
                      if (widget.onStatusChange != null) widget.onStatusChange!(isRunning);
                      if (widget.onDone != null) await widget.onDone!(result);
                      if (mounted) setState(() => isRunning = ButtonStatus.stable);
                      if (widget.onStatusChange != null) widget.onStatusChange!(isRunning);
                    },
              child: Container(
                height: widget.height,
                width: widget.width,
                alignment: isRunning == ButtonStatus.stable
                    ? widget.expanded
                        ? widget.horizontalAlignment
                        : null
                    : widget.expandedIcon ?? widget.expanded
                        ? widget.horizontalAlignment
                        : null,
                padding: widget.contentPadding,
                constraints: widget.constraints,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: widget.verticalAlignment,
                  children: [
                    if (isRunning == ButtonStatus.running)
                      child(
                        widget.onRunningWidget ?? CircularProgressIndicator(color: widget.iconColor),
                      )
                    else if (isRunning == ButtonStatus.success)
                      child(
                        widget.onSuccessWidget ?? Icon(Icons.done, color: widget.iconColor),
                      )
                    else if (isRunning == ButtonStatus.error)
                      child(
                        widget.onErrorWidget ?? Icon(Icons.error, color: widget.iconColor),
                      )
                    else
                      DefaultTextStyle(
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  color: Theme.of(context).canvasColor,
                                  fontWeight: FontWeight.bold,
                                ) ??
                            const TextStyle(),
                        child: widget.child ?? Container(),
                      )
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

enum ButtonStatus {
  stable,
  running,
  success,
  error
}
