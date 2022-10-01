import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toyota_app/components/cars/cars_item_userview_details.dart';
import 'package:toyota_app/screen/home_admin_screen.dart';
import 'cars_title_bar.dart';

class CarsUserViewScreen extends StatefulWidget {
  const CarsUserViewScreen({Key? key}) : super(key: key);

  @override
  State<CarsUserViewScreen> createState() => _CarsUserViewScreen();
}

class _CarsUserViewScreen extends State<CarsUserViewScreen> {
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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeAdminScreen(),
                ),
              );
            },
            icon: const Icon(Icons.admin_panel_settings_outlined),
          ),
        ],
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
                  child: CarsItemUserViewDetail(
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
