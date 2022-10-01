import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toyota_app/components/parts/curve_clipper.dart';

class PartImage extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;
  const PartImage({Key? key, required this.documentSnapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ClipPath(
      clipper: CurveClipper(),
      child: Align(
        alignment: Alignment.topCenter,
        child: Center(
          child: Image(
            image: NetworkImage(documentSnapshot['imageUrl']),
            height: size.height * 0.6,
            width: size.width,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
