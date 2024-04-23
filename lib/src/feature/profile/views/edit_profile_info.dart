import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/user.dart';
import 'package:flutter_riverpod_base/src/feature/home/presentation/view/home.dart';
import 'package:flutter_riverpod_base/src/feature/settings/presentation/bloc/settings_bloc.dart';
import 'package:flutter_riverpod_base/src/res/assets.dart';
import 'package:flutter_riverpod_base/src/res/colors.dart';
import 'package:flutter_riverpod_base/src/utils/custom_extension_methods.dart';
import 'package:flutter_riverpod_base/src/utils/custom_text_button.dart';
import 'package:flutter_riverpod_base/src/utils/form_text_field.dart';

import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileInfoView extends StatefulWidget {
  static String routePath = '/edit-profile-info';

  const EditProfileInfoView({super.key});

  @override
  State<EditProfileInfoView> createState() => _EditProfileInfoViewState();
}

class _EditProfileInfoViewState extends State<EditProfileInfoView> {
  UpdateParams updateParams = UpdateParams();
  final TextEditingController nameController =
      TextEditingController(text: user.name);
  final TextEditingController phoneController =
      TextEditingController(text: user.phoneNumber);
  final TextEditingController emailController =
      TextEditingController(text: user.email);

  @override
  void initState() {
    // TODO: implement initState
    _image();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state is UpdateSuccessState) {
          user = state.user;
          context.go(HomeView.routePath);
        } else if (state is SettingsFailureState) {
          ScaffoldMessenger.of(context).clearMaterialBanners();
          ScaffoldMessenger.of(context).showMaterialBanner(
            MaterialBanner(
                content: Text('Unable to Update Data ${state.message}'),
                actions: [
                  CloseButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).clearMaterialBanners();
                    },
                  )
                ]),
          );
        }
        // TODO: implement listener
      },
      child: Scaffold(
        // backgroundColor: ColorAssets.white,
        body: Padding(
          padding: const EdgeInsets.all(14),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _profilePickBuilder(context),
                        _buildFormFields(context),
                      ],
                    ),
                  ),
                ),
                //
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: CustomTextButton(
                      text: "Update Profile",
                      ontap: () {
                        final updateParams = UpdateParams(
                            gender: user.gender,
                            name: nameController.text.trim(),
                            email: emailController.text.trim(),
                            phoneNumber: phoneController.text.trim());
                        context
                            .read<SettingsBloc>()
                            .add(UpdateEvent(updateParams: updateParams));
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildFormFields(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FormTextField(
            controller: nameController,
            labelText: "Name",
            hintText: "Tara Choudhary",
          ),
          TextField(
            controller: phoneController,
            enabled: false,
            decoration: const InputDecoration(
                border: InputBorder.none, label: Text('Phone Number')),
            // labelText: "Phone Number",

            // hintText: "1235468790",
          ),
          // email
          FormTextField(
            controller: emailController,
            labelText: "Email",
            hintText: "example@gmail.com",
          ),
          // gender
          FormTextField(
              labelText: "Gender",
              child: DropdownButton(
                value: user.gender[0],
                underline: const SizedBox(),
                isExpanded: true,
                items: const [
                  DropdownMenuItem(
                    value: 'f',
                    child: Text(
                      "Female",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        // color: ColorAssets.blackFaded,
                      ),
                    ),
                  ),
                  DropdownMenuItem(
                    value: "m",
                    child: Text(
                      "Male",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        // color: ColorAssets.blackFaded,
                      ),
                    ),
                  ),
                ],
                onChanged: (data) {
                  user = user.copyWith(gender: data);
                  setState(() {});
                },
              )),

          // button
        ],
      ).addSpacingBetweenElements(20),
    );
  }

  var pickedImage;

  _pickImage() async {
    XFile? img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      final _pickedImage = File(img.path);

      Hive.box('USER').put('image', img.path);
      return setState(() {
        photoUrl = img.path;
        pickedImage = FileImage(_pickedImage);
      });
    }
  }

  _profilePickBuilder(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return GestureDetector(
        onTap: () {
          _pickImage();
        },
        child: Container(
          width: 100,
          height: 130,
          margin: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: pickedImage,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.edit,
                    size: 18,
                    color: color.primary,
                  ),
                  Text(
                    "EDIT",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: color.primary,
                        fontSize: 18),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  _image() {
    pickedImage = photoUrl == null
        ? NetworkImage(
            'https://media.istockphoto.com/id/587805156/vector/profile-picture-vector-illustration.jpg?s=1024x1024&w=is&k=20&c=N14PaYcMX9dfjIQx-gOrJcAUGyYRZ0Ohkbj5lH-GkQs=')
        : FileImage(File(photoUrl!));
    return pickedImage;
  }
}
