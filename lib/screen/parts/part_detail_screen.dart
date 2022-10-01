import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toyota_app/components/common_navbar.dart';
import 'package:toyota_app/components/parts/part_details.dart';
import 'package:toyota_app/components/parts/part_image.dart';

class PartViewScreen extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;
  const PartViewScreen({Key? key, required this.documentSnapshot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
        title: const CommonNavBar(
          sectionName: 'Parts',
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            PartImage(documentSnapshot: documentSnapshot),
            PartDetails(documentSnapshot: documentSnapshot),
          ],
        ),
      ),
    );
  }
}
