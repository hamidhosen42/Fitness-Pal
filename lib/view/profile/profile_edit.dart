// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors, unused_local_variable, no_leading_underscores_for_local_identifiers, prefer_interpolation_to_compose_strings, avoid_print, use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../components/violetButton.dart';

class ProfileEditScreen extends StatefulWidget {
  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  var fnameController = TextEditingController();
  var lnameController = TextEditingController();
  var emailController = TextEditingController();
  var heightController = TextEditingController();
  var weightController = TextEditingController();


  
  @override
  void initState() {
    super.initState();
    // Initialize controllers and image here
    initControllers();
  }

  void initControllers() {
    fnameController.text = "";
    lnameController.text = "";
    emailController.text = "";
    heightController.text = "";
    weightController.text = "";
    _image = null;
  }

  File? _image;
  final _picker = ImagePicker();

  Future getImageGally() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No Image Picked");
      }
    });
  }

  showUserData({required data}) {
    fnameController.text = data['f_name'];
    lnameController.text = data['l_name'];
    emailController.text = data['email'];
    heightController.text = data['height'];
    weightController.text = data['weight'];

    return SingleChildScrollView(
      child: Column(
        children: [
          formField(
            icon: Icons.person,
            controller: fnameController,
            inputType: TextInputType.name,
            hint: "First Name",
          ),
          SizedBox(
            height: 5.h,
          ),
          formField(
            icon: Icons.person,
            controller: lnameController,
            inputType: TextInputType.name,
            hint: "Last Name",
          ),
          SizedBox(
            height: 5.h,
          ),
          formField(
              icon: Icons.email,
              controller: emailController,
              inputType: TextInputType.emailAddress,
              hint: "email",
              readOnly: true),
          SizedBox(
            height: 5.h,
          ),
          formField(
            icon: Icons.height,
            controller: heightController,
            inputType: TextInputType.number,
            hint: "Height",
          ),
          SizedBox(
            height: 5.h,
          ),
          formField(
            icon: Icons.width_full,
            controller: weightController,
            inputType: TextInputType.number,
            hint: "Weight",
          ),
          SizedBox(height: 15.h),
          InkWell(
            onTap: () {
              getImageGally();
            },
            child: Container(
              height: 150.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black),
              ),
              child: _image != null
                  ? Image.file(_image!)
                  : Center(
                      child: data['image'] != ""
                          ? Image.network(data['image'])
                          : Image.asset("assets/images/2.png")),
            ),
          ),
          SizedBox(height: 15.h),
          VioletButton(
            isLoading: false,
            title: "Update",
            onAction: () async {
              String id = DateTime.now().microsecondsSinceEpoch.toString();
              var ref = FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.email);

              if (_image != null) {
                firebase_storage.Reference ref1 = firebase_storage
                    .FirebaseStorage.instance
                    .ref('/profile/' + id);
                firebase_storage.UploadTask uploadTask = ref1.putFile(_image!);
                await uploadTask.whenComplete(() => null);
                String downloadUrl = await ref1.getDownloadURL();

                // Update the profile image URL in the user's document
                ref.update({'image': downloadUrl});
              }

              print(weightController.text);

              try {
                // Update other user profile fields
                ref
                    .update({
                      'f_name': fnameController.text,
                      'l_name': lnameController.text,
                      'email': emailController.text,
                      'height': heightController.text,
                      'weight': weightController.text,
                    })
                    .then((value) => showTopSnackBar(
                          Overlay.of(context),
                          CustomSnackBar.success(
                            message: "Updated Successfully",
                          ),
                        ))
                    .then(
                      (value) => Navigator.pop(context),
                    );
              } catch (e) {
                showTopSnackBar(
                  Overlay.of(context),
                  CustomSnackBar.error(
                    message: "Something is wrong",
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Edit"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.email)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              var data = snapshot.data;
              return showUserData(data: data);
            }
          },
        ),
      ),
    );
  }
}

Widget formField(
    {required IconData icon, controller, inputType, hint, readOnly = false}) {
  return TextFormField(
      controller: controller,
      keyboardType: inputType,
      readOnly: readOnly,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.black45,
        ),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 16.0,
          color: const Color(0xFFABB3BB),
          height: 1.0,
        ),
      ));
}
