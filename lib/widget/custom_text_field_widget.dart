import 'dart:async';


import 'package:flutter/material.dart';

import '../components.dart';


class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.boxConstraints,
    this.textEditingController,
    this.hintText = "",
    this.borderRadius,
    this.initialValue,
    this.focusNode,
    this.textCapitalization = TextCapitalization.none,
    this.keyboardType = TextInputType.text,
    this.minLines,
    this.maxLines = 1,
    this.maxLength,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.autocorrect = true,
    this.enabled = true,
    this.readOnly = false,
    this.cursorColor,
    this.obscureText = false,
    this.obscuringCharacter = "•",
    this.autofillHints,
    this.style,
    this.onChangeDebouncer = const Duration(milliseconds: 500),
    this.fullTextSelection = true,
    this.label,
    this.labelText,
    this.labelStyle,
    this.prefixIcon,
    this.prefix,
    this.suffixIcon,
    this.suffix,
    this.loadingIcon,
    this.loadingIconColor,
    this.loadingIconsSize = 24,
    this.showPrefixLoadingIcon = false,
    this.showSuffixLoadingIcon = false,
    this.fillColor,
    this.hintStyle,
    this.errorStyle,
    this.contentPadding,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.disabledBorder,
    this.textAlignVertical = TextAlignVertical.center,
    this.isCollapsed = false,
    this.floatingLabelBehavior,
    this.isDense = false,

    //Functions
    this.onFocusChange,
    this.onComplete,
    this.onTapOutside,
    this.validator,
    this.onTap,
    this.onChanged,
    this.onChangedProcessing,
    this.errorCheck,
  });

  final BoxConstraints? boxConstraints;
  final TextEditingController? textEditingController;
  final String hintText;
  final BorderRadius? borderRadius;
  final String? initialValue;
  final FocusNode? focusNode;
  final TextCapitalization textCapitalization;
  final TextInputType keyboardType;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final TextAlign textAlign;
  final bool autofocus;
  final bool autocorrect;
  final bool enabled;
  final bool readOnly;
  final Color? cursorColor;
  final bool obscureText;
  final String obscuringCharacter;
  final List<String>? autofillHints;
  final TextStyle? style;
  final Duration onChangeDebouncer;
  final bool fullTextSelection;
  final Widget? label;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? prefix;
  final Widget? suffixIcon;
  final Widget? suffix;
  final Widget? loadingIcon;
  final double? loadingIconsSize;
  final Color? loadingIconColor;
  final bool showPrefixLoadingIcon;
  final bool showSuffixLoadingIcon;
  final Color? fillColor;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final InputBorder? disabledBorder;
  final TextAlignVertical? textAlignVertical;
  final bool isCollapsed;
  final bool isDense;
  final FloatingLabelBehavior? floatingLabelBehavior;

  //Functions
  final Function(bool isFocused)? onFocusChange;
  final void Function(String? value)? onComplete;
  final void Function(PointerDownEvent pointerDownEvent)? onTapOutside;
  final String? Function(String? value)? validator;
  final void Function()? onTap;
  final void Function(String value)? onChanged;
  final Future<void>? Function(String value)? onChangedProcessing;
  final void Function(bool error)? errorCheck;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isFocused = false;
  late TextEditingController textEditingController;
  late String hintText;
  late BorderRadius borderRadius;
  bool error = false;
  bool isIdle = true;
  bool firstTimeTap = false;
  List<String> searchProductList = [];
  Timer? debounce;

  @override
  void initState() {
    super.initState();
    textEditingController = widget.textEditingController ?? TextEditingController();
    hintText = widget.hintText;
    borderRadius = widget.borderRadius ?? BorderRadius.circular(8);
    if (widget.initialValue != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        textEditingController.text = widget.initialValue!;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    // textEditingController.dispose();
    debounce?.cancel();
  }

  Widget? showLoadingIcon(bool value) {
    if (value && !isIdle) {
      return widget.loadingIcon ??
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxHeight: widget.loadingIconsSize ?? double.infinity,
                  maxWidth: widget.loadingIconsSize ?? double.infinity,
                ),
                child: FittedBox(child: CircularProgressIndicator(color: widget.loadingIconColor ?? Theme.of(context).colorScheme.primary)),
              ),
            ],
          );
    } else {
      return null;
    }
  }

  Widget? _setIcon(Widget? icon) {
    if (icon == null) return null;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (value) {
        firstTimeTap = false;
        if (mounted) setState(() => isFocused = value);
        if (widget.onFocusChange != null) widget.onFocusChange!(value);
      },
      child: TextFormField(
        textAlignVertical: widget.textAlignVertical,
        controller: textEditingController,
        focusNode: widget.focusNode,
        textCapitalization: widget.textCapitalization,
        keyboardType: widget.keyboardType,
        minLines: widget.minLines,
        maxLines: widget.obscureText ? 1 : widget.maxLines,
        maxLength: widget.maxLength,
        textAlign: widget.textAlign,
        autofocus: widget.autofocus,
        autocorrect: widget.autocorrect,
        enabled: widget.enabled,
        readOnly: widget.readOnly,
        cursorColor: widget.cursorColor ?? Theme.of(context).colorScheme.primary,
        obscureText: widget.obscureText,
        obscuringCharacter: widget.obscuringCharacter,
        autofillHints: widget.autofillHints,
        style: widget.style ?? Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),

        //! Functions
        onEditingComplete: () {
          if (widget.onComplete != null) widget.onComplete!(textEditingController.text);
        },
        onTapOutside: (PointerDownEvent pointerDownEvent) {
          FocusScope.of(context).unfocus();
          if (widget.onTapOutside != null) widget.onTapOutside!(pointerDownEvent);
        },
        onChanged: (value) {
          //* On change without processing
          if (widget.onChanged != null) widget.onChanged!(value);

          //* On change with processing
          if (widget.onChangedProcessing != null) {
            if (debounce?.isActive ?? false) debounce?.cancel();
            debounce = Timer(
              widget.onChangeDebouncer,
              () async {
                searchProductList.add(value);
                if (isIdle && searchProductList.isNotEmpty) {
                  String searchingProduct = searchProductList.last;
                  searchProductList = [];
                  if (mounted) setState(() => isIdle = false);
                  await widget.onChangedProcessing!(searchingProduct);
                  if (mounted) setState(() => isIdle = true);
                }
              },
            );
          }
          if (error) {
            hintText = widget.hintText;
            error = false;
            if (widget.errorCheck != null) widget.errorCheck!(error);
          }
          if (mounted) setState(() {});
        },
        onTap: () {
          if (widget.fullTextSelection && !firstTimeTap) {
            textEditingController.selection = TextSelection(
              baseOffset: 0,
              extentOffset: textEditingController.value.text.length,
            );
            firstTimeTap = true;
          }
          if (widget.onTap != null) widget.onTap!();
          if (error) {
            hintText = widget.hintText;
            error = false;
            if (widget.errorCheck != null) widget.errorCheck!(error);
          }
          if (mounted) setState(() {});
        },
        validator: (value) {
          if (widget.validator == null) return null;
          String? s = widget.validator!(value);
          if (s == null) return null;
          error = true;
          if (widget.errorCheck != null) widget.errorCheck!(error);
          textEditingController.clear();
          hintText = s;
          if (mounted) setState(() {});
          return "";
        },
        //! ------------------------------------------

        decoration: InputDecoration(
          isDense: widget.isDense,
          isCollapsed: widget.isCollapsed,
          hintText: hintText,
          label: widget.label,
          labelText: widget.labelText,
          labelStyle: widget.labelStyle,
          floatingLabelBehavior: widget.floatingLabelBehavior,
          constraints: widget.boxConstraints ?? BoxConstraints(minHeight: defaultBoxHeight),
          prefix: widget.prefix,
          suffix: widget.suffix,
          prefixIcon: showLoadingIcon(widget.showPrefixLoadingIcon) ?? _setIcon(widget.prefixIcon),
          suffixIcon: showLoadingIcon(widget.showSuffixLoadingIcon) ?? _setIcon(widget.suffixIcon),
          filled: widget.fillColor == null ? false : true,
          fillColor: widget.fillColor,
          hintStyle: !error ? widget.hintStyle ?? TextStyle(color: Theme.of(context).colorScheme.primary.withOpacity(0.5)) : widget.errorStyle ?? widget.hintStyle?.copyWith(color: Theme.of(context).colorScheme.error) ?? TextStyle(color: Theme.of(context).colorScheme.error),
          errorStyle: const TextStyle(height: 0),
          contentPadding: widget.contentPadding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          // contentPadding: EdgeInsets.zero,
          enabledBorder: widget.enabledBorder ??
              OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),
              ),
          focusedBorder: widget.focusedBorder ??
              OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.primary),
              ),
          errorBorder: widget.errorBorder ??
              OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.error),
              ),
          focusedErrorBorder: widget.focusedErrorBorder ??
              OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),
              ),
          disabledBorder: widget.disabledBorder ??
              OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.primary.withOpacity(0.1)),
              ),
        ),
      ),
    );
  }
}
