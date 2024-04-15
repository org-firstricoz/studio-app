import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod_base/src/core/user.dart';
import 'package:flutter_riverpod_base/src/feature/profile/widgets/profile_form_fields.dart';
import 'package:flutter_riverpod_base/src/res/colors.dart';
import 'package:flutter_riverpod_base/src/utils/custom_extension_methods.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
  File? pickedImage;

  pickedProfileimage() {
    return photoUrl == null
        ? const NetworkImage(
            'https://media.istockphoto.com/id/587805156/vector/profile-picture-vector-illustration.jpg?s=1024x1024&w=is&k=20&c=N14PaYcMX9dfjIQx-gOrJcAUGyYRZ0Ohkbj5lH-GkQs=')
        : FileImage(pickedImage!);
    // var imageProfile;
    // if (pickedImage == null) {
    //   imageProfile = const NetworkImage(
    //       'https://media.istockphoto.com/id/587805156/vector/profile-picture-vector-illustration.jpg?s=1024x1024&w=is&k=20&c=N14PaYcMX9dfjIQx-gOrJcAUGyYRZ0Ohkbj5lH-GkQs=');
    // } else {
    //   imageProfile = FileImage(pickedImage!);
    //   photoUrl = pickedImage!.path;
    //   Hive.box('USER').put('image', photoUrl);
    // }
    // return imageProfile;
  }

  void pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      print(image.path);

      userDetails.addAll({'photoUrl': pickedImage!.path});
      setState(() {
        pickedImage = File(image.path);
        photoUrl = image.path;
      });
    } else {
      pickedImage = File(
          'https://media.istockphoto.com/id/587805156/vector/profile-picture-vector-illustration.jpg?s=1024x1024&w=is&k=20&c=N14PaYcMX9dfjIQx-gOrJcAUGyYRZ0Ohkbj5lH-GkQs=');
      userDetails.addAll({'photoUrl': pickedImage!.path});
    }
  }

  saveImage() {
    // pickedImage = File(
    //     'https://media.istockphoto.com/id/587805156/vector/profile-picture-vector-illustration.jpg?s=1024x1024&w=is&k=20&c=N14PaYcMX9dfjIQx-gOrJcAUGyYRZ0Ohkbj5lH-GkQs=');
    // userDetails.addAll({'photoUrl': pickedImage!.path});
    Hive.box('USER').put('image', photoUrl);
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: ColorAssets.white,
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
                  saveImage: saveImage,
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
          image:
              DecorationImage(image: pickedProfileimage(), fit: BoxFit.cover),
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
