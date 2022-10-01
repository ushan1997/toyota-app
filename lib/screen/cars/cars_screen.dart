import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toyota_app/components/cars/cars_item_detail.dart';
import 'package:flutter/material.dart';
import 'cars_add_form.dart';
import 'cars_title_bar.dart';

class CarsScreen extends StatefulWidget {
  const CarsScreen({Key? key}) : super(key: key);

  @override
  State<CarsScreen> createState() => _CarsState();
}

class _CarsState extends State<CarsScreen> {
  @override
  Widget build(BuildContext context) {
    final CollectionReference _cars =
        FirebaseFirestore.instance.collection('cars');

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 224, 220, 220),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
        title: const CarTitleBar(
          sectionName: 'Cars',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CarsAddForm()));
        },
        backgroundColor: Colors.red,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
      ),
      body: StreamBuilder(
        stream: _cars.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: CarsItemDetail(
                    documentSnapshot: documentSnapshot,
                  ),
                );
              },
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
