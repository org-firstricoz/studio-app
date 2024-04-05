import 'package:flutter/material.dart';
import 'package:flutter_riverpod_base/src/res/colors.dart';
import 'package:flutter_riverpod_base/src/utils/custom_text_button.dart';

class CustomElevatedContainer extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  final String? price;

  const CustomElevatedContainer({
    Key? key,
    required this.buttonText,
    required this.onTap,
      this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 20, vertical: buttonText == "Total Price" ? 5:15),
      decoration: BoxDecoration(
        color: ColorAssets.white,
        boxShadow: [BoxShadow(color: ColorAssets.lightGray, blurRadius: 3)],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Center(
        child: buttonText == "Total Price"
            ? _buildTotalPriceWidget(context)
            : CustomTextButton(
                text: buttonText,
                ontap: onTap,
              ),
      ),
    );
  }

  Widget _buildTotalPriceWidget(BuildContext context) {
    return ListTile(
      
      contentPadding: EdgeInsets.zero,
      title: Text(
        buttonText,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: ColorAssets.lightGray,
        ),
      ),
      subtitle: RichText(
        text: TextSpan(
          text: price,
          style: TextStyle(
            height: 1.5,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: ColorAssets.primaryBlue,
          ),
          children: [
            TextSpan(
              text: " /month",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: ColorAssets.lightGray,
              ),
            ),
          ],
        ),
      ),
      trailing: SizedBox(
        width: 148,
        height: 42,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: ColorAssets.primaryBlue,
            ),
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: ColorAssets.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
