import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toyota_app/provider/part_provider.dart';
import 'package:toyota_app/screen/parts/part_detail_screen.dart';
import 'package:toyota_app/screen/parts/parts_edit_screen.dart';

class PartTile extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;
  const PartTile({Key? key, required this.documentSnapshot}) : super(key: key);

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
                height: size.height * 0.19,
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
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PartEditScreen(
                                      documentSnapshot: documentSnapshot)));
                        },
                        icon: const Icon(
                          Icons.edit_rounded,
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () async {
                          if (await showConfirmationDialog(context)) {
                            Provider.of<PartProvider>(context, listen: false)
                                .removePart(documentSnapshot['partId']);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Record Deleted Successfully')),
                            );
                          }
                        },
                        icon: const Icon(
                          Icons.delete_rounded,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future showConfirmationDialog(BuildContext context) => showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
          content: const Text("Are you sure want to delete ?"),
          actions: <Widget>[
            TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text("Yes")),
            TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("No")),
          ],
        ),
      );
}
