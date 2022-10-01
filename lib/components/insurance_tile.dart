import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toyota_app/components/cars/cars_item_detail.dart';
import 'package:toyota_app/components/insurance_details.dart';
import 'package:toyota_app/provider/insurance_provider.dart';

class InsuranceTile extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;

  const InsuranceTile({Key? key, required this.documentSnapshot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double appPadding = 30.0;
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => InsuranceDetails(
        //       documentSnapshot: documentSnapshot,
        //     ),
        //   ),
        // );
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Card(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InsuranceDetails(
                    documentSnapshot: documentSnapshot,
                  ),
                ),
              );
            },
            child: SizedBox(
              height: 350.0,
              child: Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      height: 200,
                      width: 300,
                      child: Image(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          documentSnapshot["insuranceImage"],
                        ),
                      ),
                      // child: Image.network(
                      //     "https://www.focus2move.com/wp-content/uploads/2020/08/Tesla-Roadster-2020-1024-03.jpg"),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.wash,
                        size: 30.0,
                        color: Colors.orange,
                      ),
                      title: Text(
                        documentSnapshot["insuranceTitle"],
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                      subtitle: Text(
                        documentSnapshot["insuranceDescription"],
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 25.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
