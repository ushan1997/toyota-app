import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PartDetails extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;
  const PartDetails({Key? key, required this.documentSnapshot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const double appPadding = 30.0;
    return Positioned(
      top: size.height * 0.55,
      child: Container(
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: appPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        documentSnapshot['name'],
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'By Toyota Automotive Manufacture',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const SizedBox(height: 10),
              Text(
                'Rs.' + documentSnapshot['price'].toString(),
                style: const TextStyle(
                  color: Colors.orangeAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.6,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Description',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                documentSnapshot['description'],
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Roboto',
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
