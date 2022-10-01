import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toyota_app/components/common_navbar.dart';
import 'package:toyota_app/screen/parts/parts_add_screen.dart';
import '../../components/parts/part_tile.dart';

class PartScreen extends StatefulWidget {
  const PartScreen({Key? key}) : super(key: key);

  @override
  State<PartScreen> createState() => _PartScreen();
}

class _PartScreen extends State<PartScreen> {
  @override
  Widget build(BuildContext context) {
    final CollectionReference _parts =
        FirebaseFirestore.instance.collection('parts');
    const double appPadding = 30.0;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
        title: const CommonNavBar(
          sectionName: 'Parts',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const PartAddScreen()));
        },
        backgroundColor: Colors.redAccent,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
      ),
      body: StreamBuilder(
        stream: _parts.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: appPadding),
              child: GridView.builder(
                padding: const EdgeInsets.only(bottom: appPadding * 2),
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                ),
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  return PartTile(
                    documentSnapshot: documentSnapshot,
                  );
                },
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
