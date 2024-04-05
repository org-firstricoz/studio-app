import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> showImagePickerBottomSheet(BuildContext context) async {
  File? selectedImage;

  await showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Wrap(
        children: [
          ListTile(
            leading: Icon(Icons.camera),
            title: Text('Take Photo'),
            onTap: () async {
              selectedImage = await _getImage(ImageSource.camera);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text('Choose from Gallery'),
            onTap: () async {
              selectedImage = await _getImage(ImageSource.gallery);
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );

  return selectedImage;
}

Future<File?> _getImage(ImageSource source) async {
  try {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile == null) return null;

    return File(pickedFile.path);
  } catch (e) {
    print("Error picking image: $e");
    return null;
  }
}
