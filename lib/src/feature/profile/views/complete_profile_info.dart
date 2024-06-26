import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod_base/src/core/user.dart';
import 'package:flutter_riverpod_base/src/feature/profile/widgets/profile_form_fields.dart';
import 'package:flutter_riverpod_base/src/res/assets.dart';
import 'package:flutter_riverpod_base/src/res/colors.dart';
import 'package:flutter_riverpod_base/src/res/strings.dart';
import 'package:flutter_riverpod_base/src/utils/custom_extension_methods.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

class CompleteYourProfileInfoView extends StatefulWidget {
  static String routePath = '/complete-profile-info';

  const CompleteYourProfileInfoView({super.key});

  @override
  State<CompleteYourProfileInfoView> createState() =>
      _CompleteYourProfileInfoViewState();
}

class _CompleteYourProfileInfoViewState
    extends State<CompleteYourProfileInfoView> {
  File pickedImage = File('');

  _profileAsset() async {
    String textasset = ImageAssets.profileImageJpeg; //path to text file asset
    ByteData byteData = await rootBundle.load(textasset);

    final tempPath = await getTemporaryDirectory();

    final file = File(
        '${tempPath.path}/${ImageAssets.profileImageJpeg.split('/').last}');

    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    setState(() {
      pickedImage = file;
    });
  }

  void pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      userDetails.addAll({'photoUrl': File(image.path)});
      setState(() {
        pickedImage = File(image.path);
      });
    } else {
      userDetails.addAll({'photoUrl': pickedImage});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _profileAsset();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 54),
                Text(
                  "Complete Your Profile",
                  style: textTheme.titleLarge!.copyWith(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    // color: ColorAssets.black,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Don’t worry, only you can see your personal data. No one else will be able to see it.",
                  textAlign: TextAlign.center,
                  style: textTheme.titleMedium!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: color.tertiary),
                ),
                _profilePickBuilder(context),
                ProfileFormFields(
                  save: () {
                    userDetails.addAll({'photoUrl': pickedImage});
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _profilePickBuilder(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Container(
      width: 150,
      height: 150,
      margin: const EdgeInsets.all(30),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: FileImage(pickedImage!), fit: BoxFit.cover),
          color: color.secondary,
          shape: BoxShape.circle),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            bottom: 10,
            right: 10,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: ColorAssets.primaryBlue,
              ),
              width: 32,
              height: 32,
              child: const Icon(
                Icons.edit_rounded,
                size: 14,
                color: ColorAssets.white,
              ),
            ).onTap(pickImage),
          )
        ],
      ),
    );
  }
}
