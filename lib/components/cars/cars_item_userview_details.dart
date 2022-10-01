import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toyota_app/screen/cars/cars_detail_screen.dart';

class CarsItemUserViewDetail extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;
  const CarsItemUserViewDetail({
    required this.documentSnapshot,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 250,
      child: Card(
        // elevation: 8,
        // borderOnForeground: true,
        margin: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CarsDetailScreen(
                  documentSnapshot: documentSnapshot,
                ),
              ),
            );
          },
          child: Column(
            children: [
              Expanded(
                child: Image.network(
                  documentSnapshot['image'],
                  height: 100,
                  width: 300,
                ),
              ),
              Text(
                documentSnapshot['name'].toString(),
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                'Rs.' + documentSnapshot['price'].toString(),
                style: Theme.of(context).textTheme.caption,
              ),
              Text(
                "Click For Details",
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
