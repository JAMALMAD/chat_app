
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  static void _defaultOnTap() {}
  const CustomTextField({super.key,
    this.textEditingController,
    this.focusNode,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.cursorColor = Colors.black,
    this.inputTextStyle = const TextStyle(color: Colors.black),
    this.textAlignVertical = TextAlignVertical.center,
    this.textAlign = TextAlign.start,
    this.maxLines = 1,
    this.maxLength,
    this.validator,
    this.hintText,
    this.labelText = '',
    this.hintStyle = const TextStyle(color: Colors.black),
    this.fillColor =Colors.transparent,
    this.suffixIconColor,
    this.suffixIcon,
    this.borderRadius = 8,
    this.fieldBorderColor = Colors.black,
    this.focusBorderColor = Colors.black,
    this.onChanged,
    this.onFieldSubmitted,
    this.isPassword = false,
    this.isPrefixIcon = false,
    this.onTapClick = _defaultOnTap,
    this.readOnly =  false,
    this.height = 50,

  });
  final TextEditingController? textEditingController;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Color cursorColor;
  final TextStyle? inputTextStyle;
  final TextAlignVertical? textAlignVertical;
  final TextAlign textAlign;
  final int? maxLines;
  final int? maxLength;

  final FormFieldValidator? validator;
  final String? hintText;
  final String labelText;
  final TextStyle? hintStyle;
  final Color? fillColor;
  final Color? suffixIconColor;
  final Widget? suffixIcon;
  final double borderRadius;
  final Color fieldBorderColor;
  final Color focusBorderColor;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final bool isPassword;
  final bool isPrefixIcon;
  final VoidCallback onTapClick;
  final bool readOnly;
  final double height;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(0.r),
        child: TextFormField(
          onTap: (){
            widget.onTapClick();
          },
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onFieldSubmitted,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          readOnly: widget.readOnly,
          controller: widget.textEditingController,
          focusNode: widget.focusNode,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          cursorColor: widget.cursorColor,
          style: widget.inputTextStyle,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          obscureText: widget.isPassword ? obscureText : false,
          validator: widget.validator,
          decoration: InputDecoration(
            isDense: true,
            errorMaxLines: 2,
            hintText: widget.hintText,
            hintStyle: widget
                .hintStyle, // TextStyle(color: AppColors.blueLightActive),
            fillColor: widget.fillColor,
            filled: true,

            prefixIcon: widget.isPrefixIcon
                ? Padding(
              padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 0, vertical: 0),
              child: Icon(
                Icons.search,
                color: Colors.white,
                size: 28.h,
              ),
            )
                : null,
            suffixIcon: widget.isPassword
                ? GestureDetector(
              onTap: toggle,
              child: Padding(
                padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 16, vertical: 14),
                child: obscureText
                    ? const Icon(
                  Icons.visibility_off_outlined,
                  color: Colors.white,
                )
                    : const Icon(Icons.visibility_outlined,
                    color: Colors.white),
              ),
            )
                : widget.suffixIcon,
            suffixIconColor: widget.suffixIconColor,

            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide:
                BorderSide(color: widget.fieldBorderColor, width: 0),
                gapPadding: 0),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide:
                BorderSide(color: widget.focusBorderColor, width: 0),
                gapPadding: 0),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide:
                BorderSide(color: widget.fieldBorderColor, width: 0),
                gapPadding: 0),
          ),
        ),
      ),
    );
  }

  void toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}