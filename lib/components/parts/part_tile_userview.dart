import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toyota_app/screen/parts/part_detail_screen.dart';

class PartTileUserView extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;
  const PartTileUserView({Key? key, required this.documentSnapshot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double appPadding = 30.0;
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PartViewScreen(
              documentSnapshot: documentSnapshot,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(appPadding / 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                fit: BoxFit.cover,
                height: size.height * 0.25,
                width: size.width * 0.45,
                image: NetworkImage(
                  documentSnapshot['imageUrl'],
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              documentSnapshot['name'],
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'By Toyota Manufacture',
              style: TextStyle(
                color: Colors.black.withOpacity(0.5),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
