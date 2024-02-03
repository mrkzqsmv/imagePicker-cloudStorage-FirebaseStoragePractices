// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebase_practises/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StoragePractices extends StatefulWidget {
  const StoragePractices({super.key});

  @override
  State<StoragePractices> createState() => _StoragePracticesState();
}

class _StoragePracticesState extends State<StoragePractices> {
  final storageRef = FirebaseStorage.instance.ref();

  File? _selectedImg;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Storage Practices'),
        ),
        body: Container(
          child: Column(
            children: [
              CustomButton(
                  btnText: 'Choose Image from Gallery',
                  btnFunc: () {
                    _pickImgFromGallery();
                  }),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                  btnText: 'Take Image from Camera',
                  btnFunc: () {
                    _pickImgFromCamera();
                  }),
              const SizedBox(
                height: 10,
              ),
              CircleAvatar(
                radius: 150,
                child: _selectedImg != null
                    ? Image.file(_selectedImg!)
                    : const Text('Please select an image'),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                  btnText: 'Upload Image To Storage',
                  btnFunc: () {
                    uploadImgToStorage();
                  }),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                  btnText: 'Get Download Url',
                  btnFunc: () {
                    getDownloadUrl();
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Future _pickImgFromGallery() async {
    final returnedImg =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImg == null) return;

    setState(() {
      _selectedImg = File(returnedImg.path);
    });
  }

  Future _pickImgFromCamera() async {
    final returnedImg =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (returnedImg == null) return;

    setState(() {
      _selectedImg = File(returnedImg.path);
    });
  }

  Future uploadImgToStorage() async {
    if (_selectedImg == null) return;

    Reference storageReference =
        FirebaseStorage.instance.ref().child('images/${DateTime.now()}.jpg');

    UploadTask uploadTask = storageReference.putFile(_selectedImg!);

    await uploadTask.whenComplete(() => null);

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Resim yuklendi')));
  }

  Future getDownloadUrl() async {
    final url = await storageRef.getDownloadURL();
    print(url);
  }
}
