import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:toyota_app/components/cars/cars_item_detail.dart';
import 'package:toyota_app/provider/insurance_provider.dart';
import 'package:toyota_app/screen/insurance/insurance_edit.dart';

class InsuranceDetails extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;

  const InsuranceDetails({Key? key, required this.documentSnapshot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(documentSnapshot);
    Size size = MediaQuery.of(context).size;
    const double appPadding = 30.0;

    return Scaffold(
      appBar: AppBar(
        title: Text("Package Details"),
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(documentSnapshot["insuranceImage"]),
                fit: BoxFit.cover,
              ),
            ),
            // child: SingleChildScrollView(
            //   physics: const BouncingScrollPhysics(),
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: appPadding),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         const SizedBox(height: 15),
            //         ClipRRect(
            //           borderRadius: BorderRadius.circular(25.0),
            //           child: Image(
            //             image: NetworkImage(documentSnapshot["insuranceImage"]),
            //             height: size.height * 0.3,
            //             width: size.width,
            //             fit: BoxFit.contain,
            //           ),
            //         ),
            //         const SizedBox(height: 10),
            //         Center(
            //           child: Text(
            //             documentSnapshot["insuranceTitle"],
            //             style: const TextStyle(
            //               fontSize: 30,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //         ),
            //         const SizedBox(height: 10),
            //         Text(
            //           documentSnapshot["insuranceDescription"],
            //           style: const TextStyle(
            //             fontSize: 20,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             TextButton(
            //               style: ButtonStyle(
            //                 foregroundColor:
            //                     MaterialStateProperty.all<Color>(Colors.blue),
            //               ),
            //               onPressed: () {
            //                 Navigator.push(
            //                   context,
            //                   MaterialPageRoute(
            //                     builder: (context) => InsuranceEdit(
            //                       documentSnapshot: documentSnapshot,
            //                     ),
            //                   ),
            //                 );
            //               },
            //               child: Text('Edit'),
            //             ),
            //             ElevatedButton(
            //               style: ButtonStyle(
            //                 foregroundColor:
            //                     MaterialStateProperty.all<Color>(Colors.white),
            //               ),
            //               onPressed: () async {
            //                 print("F");
            //                 if (await showConfirmationDialog(context)) {
            //                   Provider.of<InsuranceProvider>(context, listen: false)
            //                       .removeInsurance(documentSnapshot['insuranceId']);
            //                   ScaffoldMessenger.of(context).showSnackBar(
            //                     const SnackBar(
            //                       content: Text('Record Deleted Successfully'),
            //                     ),
            //                   );
            //                   Navigator.pop(context);
            //                 }
            //               },
            //               child: Text('DElete'),
            //             ),
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height * 0.5,
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(0, -4),
                    blurRadius: 8,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            documentSnapshot['insuranceTitle'],
                            style: GoogleFonts.ptSans(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            " Rs. ${documentSnapshot['insurancePrice'].toString()}",
                            style: GoogleFonts.ptSans(
                                fontSize: 25,
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        documentSnapshot['insuranceDescription'],
                        style: GoogleFonts.ptSans(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: size.width / 3.5,
                            margin: EdgeInsets.all(10),
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => InsuranceEdit(
                                      documentSnapshot: documentSnapshot,
                                    ),
                                  ),
                                );
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(80.0)),
                              padding: EdgeInsets.all(0.0),
                              child: Ink(
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 128, 73, 231),
                                        Color.fromARGB(255, 118, 94, 184)
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(30.0)),
                                child: Container(
                                  constraints: const BoxConstraints(
                                      maxWidth: 250.0, minHeight: 50.0),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "Edit",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: size.width / 3.5,
                            margin: EdgeInsets.all(10),
                            child: RaisedButton(
                              onPressed: () async {
                                print("F");
                                if (await showConfirmationDialog(context)) {
                                  Provider.of<InsuranceProvider>(context,
                                          listen: false)
                                      .removeInsurance(
                                          documentSnapshot['insuranceId']);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Record Deleted Successfully'),
                                    ),
                                  );
                                  Navigator.pop(context);
                                }
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(80.0)),
                              padding: EdgeInsets.all(0.0),
                              child: Ink(
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 235, 50, 50),
                                        Color.fromARGB(255, 173, 38, 67)
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(30.0)),
                                child: Container(
                                  constraints: const BoxConstraints(
                                      maxWidth: 250.0, minHeight: 50.0),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "Delete",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
