import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toyota_app/components/insurance_details.dart';
import 'package:toyota_app/components/insurance_user_details.dart';
import '../../components/insurance_tile.dart';
import 'insurance_add.dart';

class InsuranceListUser extends StatefulWidget {
  const InsuranceListUser({Key? key}) : super(key: key);

  @override
  _InsuranceListUserState createState() => _InsuranceListUserState();
}

class _InsuranceListUserState extends State<InsuranceListUser> {
  @override
  Widget build(BuildContext context) {
    final CollectionReference _insuranceRef =
        FirebaseFirestore.instance.collection('insurance');

    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Packages List'),
      ),
      // backgroundColor: Colors.white,
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                    stream: _insuranceRef.snapshots(),
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.hasData) {
                        return GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                          ),
                          itemCount: streamSnapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot documentSnapshot =
                                streamSnapshot.data!.docs[index];

                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: InsuranceItem(
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InsuranceItem extends StatelessWidget {
  final dynamic itemData;
  final DocumentSnapshot documentSnapshot;

  const InsuranceItem({Key? key, this.itemData, required this.documentSnapshot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InsuranceDetailsUser(
              documentSnapshot: documentSnapshot,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          boxShadow: const [
            BoxShadow(
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ],
          color: Colors.grey[200],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: Image(
                    image: NetworkImage(documentSnapshot["insuranceImage"]),
                    fit: BoxFit.cover,
                    height: 200,
                    width: double.infinity,
                  ),
                ),
                const Positioned(
                  top: 15,
                  right: 15,
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      documentSnapshot["insuranceTitle"],
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 22),
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      "package",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          height: 1.5),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
              ),
              child: Text(
                documentSnapshot["insuranceDescription"],
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
