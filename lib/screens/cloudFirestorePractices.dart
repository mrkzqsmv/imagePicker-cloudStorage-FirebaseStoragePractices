import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_practises/screens/addUser.dart';
import 'package:firebase_practises/screens/storagePractices.dart';
import 'package:firebase_practises/screens/userInformation.dart';
import 'package:firebase_practises/widgets/customButton.dart';
import 'package:flutter/material.dart';

class CloudFirestorePractices extends StatelessWidget {
  const CloudFirestorePractices({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference students =
        FirebaseFirestore.instance.collection('students');
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 10),
            CustomButton(
              btnText: 'Add User',
              btnFunc: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AddUser(),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            CustomButton(
              btnText: 'User Information',
              btnFunc: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const UserInformation(),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            CustomButton(
              btnText: 'Add Field',
              btnFunc: () {
                return students
                    .doc('3ekxaVtZzqXxou0jFBmX')
                    .set({
                      'compModel': 'ACER',
                      'carModel': 'PORSCHE',
                      'camps': ['camp1', 'camp2'],
                      'tents': {'tent', 'tent2'},
                    }, SetOptions(merge: true))
                    .then((value) => print('SUCCESS ADDED FIELD'))
                    .catchError((err) => print('FAILED ADDED FIELD'));
              },
            ),
            const SizedBox(height: 10),
            CustomButton(
              btnText: 'Delete Field',
              btnFunc: () {
                students
                    .doc('3ekxaVtZzqXxou0jFBmX')
                    .update({
                      'gender': FieldValue.delete(),
                    })
                    .then((value) => print('DELETED FIELD SUCCESS'))
                    .catchError((err) => print('ERROR $err'));
              },
            ),
            const SizedBox(height: 10),
            CustomButton(
              btnText: 'Delete Doc',
              btnFunc: () {
                students
                    .doc('Enr0I0Mn1H12AyYFJ05e')
                    .delete()
                    .then((value) => print('DELETED DOC SUCCESS'))
                    .catchError((err) => print('ERROR $err'));
              },
            ),
            const SizedBox(height: 10),
            CustomButton(
                btnText: 'Storage',
                btnFunc: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const StoragePractices(),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
