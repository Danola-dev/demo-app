import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/widgets/wavy.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    getUserimage();
  }

  Future<void> pickedImage() async {
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

    // storing the picked image on firebase storage
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final storageRef = FirebaseStorage.instance.ref().child(
      'profile_image/$uid.jpg',
    );

    await storageRef.putFile(pickedImageFile!);

    final downloadUrl = await storageRef.getDownloadURL();

    await FirebaseFirestore.instance.collection('user_img').doc(uid).set({
      'image_url': downloadUrl,
    });

    setState(() {
      imageUrl = downloadUrl;
    });
  }

  // getting the stored image to display always
  Future<void> getUserimage() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final doc = await FirebaseFirestore.instance
        .collection('user_img')
        .doc(uid)
        .get();

    setState(() {
      imageUrl = doc['image_url'];
    });
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
                backgroundImage: imageUrl != null
                    ? NetworkImage(imageUrl!)
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
