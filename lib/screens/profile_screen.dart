import 'dart:io';

import 'package:demo_app/widgets/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    File? selectedImage;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            UserImagePicker(
              onPickedImage: (pickedImage) {
                if (selectedImage == null) {
                  return;
                }
                selectedImage = pickedImage;
              },
            ),
            SizedBox(height: 40),
            Column(
              children: [
                Text(
                  'Danola Isaac',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                Text('View full profile', style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 45),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 17),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: Colors.blue.shade50,
                    ),
                    height: 53,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: Row(
                        children: [
                          Icon(Icons.person),
                          SizedBox(width: 20),
                          Text(
                            'Account information',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 22),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: Colors.blue.shade50,
                    ),
                    height: 53,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: Row(
                        children: [
                          Icon(Icons.lock),
                          SizedBox(width: 20),
                          Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 22),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: Colors.blue.shade50,
                    ),
                    height: 53,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: Row(
                        children: [
                          Icon(Icons.settings, fontWeight: FontWeight.bold),
                          SizedBox(width: 20),
                          Text(
                            'Settings',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 22),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: Colors.blue.shade50,
                    ),
                    height: 53,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: Row(
                        children: [
                          Icon(Icons.call, fontWeight: FontWeight.bold),
                          SizedBox(width: 20),
                          Text(
                            'Help & Support',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 22),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: Colors.blue.shade50,
                    ),
                    height: 53,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(width: 20),
                          GestureDetector(
                            onTap: () => FirebaseAuth.instance.signOut(),
                            child: Text(
                              'Log out',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
