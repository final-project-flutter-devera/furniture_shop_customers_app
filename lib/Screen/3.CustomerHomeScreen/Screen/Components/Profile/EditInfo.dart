import 'dart:io';
import 'package:flutter/material.dart';
import 'package:furniture_shop/Constants/Colors.dart';
import 'package:furniture_shop/Widgets/AppBarButton.dart';
import 'package:furniture_shop/Widgets/AppBarTitle.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class EditInfo extends StatefulWidget {
  const EditInfo({super.key});

  @override
  State<EditInfo> createState() => _EditInfoState();
}

class _EditInfoState extends State<EditInfo> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  dynamic _pickedImageError;

  void _pickImageFromCamera() async {
    try {
      final pickedImage = await _picker.pickImage(
          source: ImageSource.camera,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        _imageFile = pickedImage;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

  void _pickImageFromGallery() async {
    try {
      final pickedImage = await _picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        _imageFile = pickedImage;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 0,
        leading: const AppBarBackButtonPop(),
        title: const AppBarTitle(label: 'Edit Information'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.save, color: AppColor.black),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    child: CircleAvatar(
                      backgroundColor: AppColor.amber,
                      radius: 110,
                      child: CircleAvatar(
                        radius: 100,
                        backgroundColor: AppColor.white,
                        backgroundImage: _imageFile == null
                            ? null
                            : FileImage(File(_imageFile!.path)),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15))),
                        child: IconButton(
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _pickImageFromCamera();
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15))),
                        child: IconButton(
                          icon: const Icon(
                            Icons.photo,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _pickImageFromGallery();
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
              PhysicalModel(
                color: AppColor.white,
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      editInfoTextFormField(label: 'Name'),
                      editInfoTextFormField(label: 'Email'),
                      editInfoTextFormField(label: 'Phone'),
                      editInfoTextFormField(label: 'Address'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField editInfoTextFormField({required String label}) {
    return TextFormField(
      textCapitalization: TextCapitalization.characters,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.nunito(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF909090),
        ),
      ),
    );
  }
}
