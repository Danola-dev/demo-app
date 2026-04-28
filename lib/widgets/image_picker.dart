import 'dart:io';

import 'package:demo_app/widgets/wavy.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key, required this.onPickedImage});
  final void Function(File pickedImage) onPickedImage;
  @override
  State<UserImagePicker> createState() {
    return UserImagePickerState();
  }
}

class UserImagePickerState extends State<UserImagePicker> {
  File? pickedImageFile;

  void pickedImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickedImage == null) {
      return;
    }

    setState(() {
      pickedImageFile = File(pickedImage.path);
    });
    widget.onPickedImage(pickedImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: AlignmentGeometry.center,
      children: [
        ClipPath(
          clipper: WaveClipper(),
          child: Container(
            width: double.infinity,
            height: 300,
            color: const Color.fromARGB(255, 91, 203, 255),
            child: Padding(
              padding: const EdgeInsets.only(top: 60, left: 29),
              child: Text(
                'Profile',
                style: TextStyle(fontSize: 29, fontWeight: FontWeight.w900),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -30,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundColor: Colors.grey,
                foregroundImage: pickedImageFile != null
                    ? FileImage(pickedImageFile!)
                    : null,
              ),
              Positioned(
                bottom: 16,
                right: 1,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      pickedImage();
                    },
                    child: Icon(Icons.camera_alt, size: 30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
