import 'package:flutter/material.dart';
import 'package:flutter_riverpod_base/src/res/colors.dart';

class FormTextField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final String? initialValue;
  final bool enableObsecure;
  final Widget? child;
  final Color? backgroundColor;
  final Color? hintTextColors;
  final Color? textColor;
  final Widget? prefixWidget;
  final Widget? suffixIcon;
  final Function(String val)? onChanged;
  final TextEditingController? controller;
  const FormTextField({
    Key? key,
    this.labelText,
    this.child,
    this.initialValue,
    this.hintText,
    this.textColor,
    this.hintTextColors,
    this.backgroundColor,
    this.prefixWidget,
    this.onChanged,
    this.controller,
    this.suffixIcon,
    this.enableObsecure = false,
  }) : super(key: key);

  @override
  State<FormTextField> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  bool obscured = false;
  @override
  void initState() {
    super.initState();
    obscured = widget.enableObsecure == true ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.labelText != null
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  widget.labelText!,
                  style: textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    // color: widget.textColor,
                  ),
                ),
              )
            : const SizedBox.shrink(),
        widget.child != null
            ? Container(
                height: 54,
                width: double.maxFinite,
                // margin: const EdgeInsets.symmetric(vertical: 5),
                padding: const EdgeInsets.only(left: 14, right: 14, top: 3),
                decoration: BoxDecoration(
                  color: colorScheme.secondary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: widget.child)
            : Container(
                // margin: const EdgeInsets.symmetric(vertical: 5),
                // padding: const EdgeInsets.symmetric(horizontal: 14),
                padding: EdgeInsets.only(left: 14),
                decoration: BoxDecoration(
                  // color: widget.backgroundColor ??  color.secondary,
                  color: colorScheme.secondary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '${widget.labelText} cannot be empty';
                    }
                    return null;
                  },
                  initialValue: widget.initialValue,
                  controller: widget.controller,
                  onChanged: widget.onChanged,
                  obscureText: obscured,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    // color: widget.textColor,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: widget.prefixWidget,
                    prefixIconColor: colorScheme.secondary,
                    hintText: widget.hintText,
                    border: InputBorder.none,
                    // hintStyle: textTheme.titleLarge!.copyWith(
                    //     fontSize: 14,
                    //     fontWeight: FontWeight.w600,
                    //     ),
                    suffixIconColor: colorScheme.primary,
                    suffixIcon: widget.suffixIcon ??
                        (widget.enableObsecure
                            ? Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: GestureDetector(
                                    onTap: _toggleObscured,
                                    child: Icon(
                                      obscured
                                          ? Icons.visibility_rounded
                                          : Icons.visibility_off_rounded,
                                      size: 24,
                                    )))
                            : null),
                  ),
                ),
              ),
      ],
    );
  }

  void _toggleObscured() {
    obscured = !obscured;
    setState(() {});
  }
}
