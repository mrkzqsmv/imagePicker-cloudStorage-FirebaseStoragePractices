import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReadInfo extends StatelessWidget {
  final String docID;
  const ReadInfo({super.key, required this.docID});

  @override
  Widget build(BuildContext context) {
    CollectionReference students =
        FirebaseFirestore.instance.collection('students');

    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<DocumentSnapshot>(
          future: students.doc(docID).get(),
          builder: ((context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return const Text('Document does not exists');
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              return Text("Full Name: ${data['age']} ${data['city']}");
            }

            return const Text('Loading');
          }),
        ),
      ),
    );
  }
}
