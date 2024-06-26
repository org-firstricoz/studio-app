import 'package:flutter/material.dart';

class ShimmerWidget extends StatelessWidget {
  final double? height, width;
  final BorderRadiusGeometry? borderRadiusGeometry;
  final EdgeInsetsGeometry? margin, padding;
  final Color? colors;
  const ShimmerWidget(
      {super.key,
      this.height,
      this.width,
      this.margin,
      this.padding,
      this.borderRadiusGeometry,
      this.colors});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: margin ?? EdgeInsets.all(8),
      padding: padding,
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: borderRadiusGeometry ?? BorderRadius.circular(10),
          color: colors ?? Colors.grey),
    );
  }
}
