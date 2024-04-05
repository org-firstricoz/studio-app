import 'package:flutter/material.dart';
import 'package:flutter_riverpod_base/src/res/colors.dart';
import 'package:share_plus/share_plus.dart';

class SharingUtils {
  

  static void shareUserProfileINFO(
      {required BuildContext context,
      required String text,
      required String subject}) async {
    final box = context.findRenderObject() as RenderBox?;

    return await Share.share(
      text,
      subject: subject,
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }
  static void shareStudioScrenshotContent(
      {required BuildContext context,
      required String text,
      required String subject}) async {
    final box = context.findRenderObject() as RenderBox?;

    return await Share.share(
      text,
      subject: subject,
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }
}
