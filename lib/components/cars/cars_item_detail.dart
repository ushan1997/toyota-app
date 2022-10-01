import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toyota_app/provider/car_provider.dart';
import 'package:toyota_app/screen/cars/cars_detail_screen.dart';
import '../../screen/cars/cars_edit_form.dart';

class CarsItemDetail extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;
  const CarsItemDetail({
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
              Row(
                children: [
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CarsEditForm(
                                    documentSnapshot: documentSnapshot)));
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: () async {
                        if (await showConfirmationDialog(context)) {
                          Provider.of<CarProvider>(context, listen: false)
                              .deleteCar(documentSnapshot['carId']);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Record Deleted Successfully')),
                          );
                        }
                      },
                      icon: const Icon(
                        Icons.delete_rounded,
                        color: Color.fromARGB(255, 235, 6, 6),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future showConfirmationDialog(BuildContext context) => showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        content: const Text("Are you sure want to delete ?"),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Yes"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("No"),
          ),
        ],
      ),
    );
