
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components.dart';
import '../base_components/custom_text_field_widget.dart';

class CustomTextFormField1 extends StatefulWidget {
  const CustomTextFormField1({
    super.key,
    this.label,
    this.labelText,
    this.labelStyle,
    this.autofocus = false,
    this.hintText = "",
    this.svg = "",
    this.textEditingController,
    this.onChanged,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.initialValue,
    this.onChangedProcessing,
    this.maxLines,
    this.prefix,
  });

  final void Function(String value)? onChanged;
  final Future<void>? Function(String)? onChangedProcessing;
  final String? Function(String? value)? validator;
  final bool autofocus;
  final String hintText;
  final String? initialValue;
  final TextInputType keyboardType;
  final bool obscureText;
  final String svg;
  final TextEditingController? textEditingController;
  final String? labelText;
  final TextStyle? labelStyle;
  final Widget? label;
  final int? maxLines;
  final Widget? prefix;

  @override
  State<CustomTextFormField1> createState() => _CustomTextFormField1State();
}

class _CustomTextFormField1State extends State<CustomTextFormField1> {
  late final TextEditingController tC;
  final RxString s = "".obs;
  final RxBool errorStatus = false.obs;
  late final RxBool showText = true.obs;

  @override
  initState() {
    super.initState();
    tC = widget.textEditingController ?? TextEditingController();
    s.value = tC.text;
    showText.value = !widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomTextFormField(
        labelText: widget.labelText,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        prefixIcon: widget.prefix ??
            (widget.labelText == null
                ? null
                : Text(
                    "${widget.labelText}: ",
                    style: Theme.of(context).textTheme.titleMedium,
                  )),
        isCollapsed: false,
        autofocus: widget.autofocus,
        textEditingController: tC,
        initialValue: widget.initialValue,
        hintText: widget.hintText,
        keyboardType: widget.keyboardType,
        obscureText: !showText.value,
        loadingIconsSize: 10,
        maxLines: widget.maxLines,
        onFocusChange: (isFocused) => {
          if (widget.obscureText && !isFocused) showText.value = false
        },
        //! Eye button
        suffixIcon: !widget.obscureText
            ? null
            : s.isEmpty
                ? null
                : GestureDetector(
                    onTap: () => showText.value = !showText.value,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                      child: FittedBox(child: Icon(showText.value ? Icons.remove_red_eye : Icons.remove_red_eye_outlined)),
                    ),
                  ),
        validator: widget.validator,
        errorCheck: (error) {
          s.value = "";
          errorStatus.value = error;
        },
        onChanged: (value) {
          s.value = value;
          if (widget.onChanged != null) widget.onChanged!(value);
        },
        onChangedProcessing: widget.onChangedProcessing,
        showPrefixLoadingIcon: widget.onChangedProcessing != null,

        fillColor: Theme.of(context).canvasColor,
        hintStyle: TextStyle(color: Theme.of(context).primaryColor.withOpacity(0.5)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: borderWidth3, color: Theme.of(context).shadowColor),
          borderRadius: BorderRadius.circular(defaultPadding / 6),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: borderWidth2, color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(defaultPadding / 6),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: borderWidth2, color: Theme.of(context).colorScheme.error),
          borderRadius: BorderRadius.circular(defaultPadding / 6),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: borderWidth2, color: Theme.of(context).shadowColor),
          borderRadius: BorderRadius.circular(defaultPadding / 6),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: borderWidth2, color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(defaultPadding / 6),
        ),
      ),
    );
  }
}
