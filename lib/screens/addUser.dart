import 'package:firebase_practises/screens/readInfo.dart';
import 'package:firebase_practises/widgets/customButton.dart';
import 'package:firebase_practises/widgets/customTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController cityController = TextEditingController();
    TextEditingController genderController = TextEditingController();

    final _formKey = GlobalKey<FormState>();

    @override
    void dispose() {
      emailController.dispose();
      passwordController.dispose();
      ageController.dispose();
      cityController.dispose();
      genderController.dispose();
      super.dispose();
    }

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    CollectionReference students = firestore.collection('students');

    Future<void> addUser(String email, String password, String age, String city,
        String gender) async {
      return students
          .add({
            'email': email,
            'password': password,
            'age': age,
            'city': city,
            'gender': gender,
          })
          .then((value) => debugPrint('USER ADDED'))
          .catchError((error) => debugPrint('FAILED TO ADDED USER $error'));
    }

    return SafeArea(
      child: Scaffold(
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                      hintText: 'Email', controller: emailController),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                      hintText: 'Password', controller: passwordController),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                      hintText: 'Age', controller: ageController),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                      hintText: 'City', controller: cityController),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                      hintText: 'Gender', controller: genderController),
                  CustomButton(
                    btnText: 'Add User Info',
                    btnFunc: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        addUser(
                            emailController.text,
                            passwordController.text,
                            ageController.text,
                            cityController.text,
                            genderController.text);
                      }
                      emailController.clear();
                      passwordController.clear();
                      ageController.clear();
                      cityController.clear();
                      genderController.clear();
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                      btnText: 'See your Info',
                      btnFunc: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ReadInfo(
                              docID: '3ekxaVtZzqXxou0jFBmX',
                            ),
                          ),
                        );
                      }),
                ],
              ),
            )),
      ),
    );
  }
}
