import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:toyota_app/provider/insurance_provider.dart';
import 'package:toyota_app/model/insurance.dart';
import 'package:toyota_app/screen/insurance/insurance_list.dart';
import 'package:toyota_app/services/firestore_insurance_service.dart';

class InsuranceEdit extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;

  const InsuranceEdit({Key? key, required this.documentSnapshot})
      : super(key: key);

  @override
  _InsuranceEditState createState() => _InsuranceEditState();
}

class _InsuranceEditState extends State<InsuranceEdit> {
  bool isLoading = false;
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late var imgUrl = "";

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
    await uploadFile();
  }

  Future uploadFile() async {
    final path = 'insurance/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() => () {});

    final downloadUrl = await snapshot.ref.getDownloadURL();
    imgUrl = downloadUrl.toString();
  }

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(
        text: widget.documentSnapshot != null
            ? widget.documentSnapshot['insuranceTitle']
            : '');
    priceController = TextEditingController(
        text: widget.documentSnapshot != null
            ? widget.documentSnapshot['insurancePrice'].toString()
            : '');
    descriptionController = TextEditingController(
        text: widget.documentSnapshot != null
            ? widget.documentSnapshot['insuranceDescription']
            : '');
    imgUrl = widget.documentSnapshot['insuranceImage'].toString();
  }

  @override
  Widget build(BuildContext context) {
    final insuranceProvider = Provider.of<InsuranceProvider>(context);

    final double height = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
          splashColor: Colors.white,
          color: const Color.fromARGB(255, 224, 55, 55),
        ),
      ),
      backgroundColor: const Color(0xFFffffff),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          "Update Package",
                          style: TextStyle(
                            fontSize: 25,
                            color: Color(0xFF363f93),
                          ),
                        ),
                      ),
                      Center(
                        child: Column(
                          children: [
                            pickedFile != null
                                ? Image.file(
                                    File(pickedFile!.path!),
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  )
                                : imgUrl != ""
                                    ? Image.network(
                                        imgUrl,
                                        width: 200,
                                        height: 200,
                                      )
                                    : Image.network(
                                        "https://media.istockphoto.com/photos/abstract-car-and-many-vehicles-parts-picture-id596780762?k=20&m=596780762&s=612x612&w=0&h=9Fu5vaEBQg5Qup1PjDVQiefBIyuzKXojwPi1eG1ix0k=",
                                        width: 200,
                                        height: 200,
                                      ),
                            ElevatedButton(
                                onPressed: selectFile,
                                child: const Text('Choose Image')),
                            SizedBox(height: height * 0.04),
                            TextFormField(
                              controller: titleController,
                              onChanged: (String value) {
                                insuranceProvider.changeTitle(value);
                              },
                              decoration: InputDecoration(
                                  labelText: "Name",
                                  hintText: "Enter the insurance name",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  )),
                              validator: (value) {
                                if (value!.isEmpty ||
                                    !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                                  return "Name cannot be empty";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(
                              height: height * 0.05,
                            ),
                            TextFormField(
                              controller: priceController,
                              onChanged: (String value) {
                                insuranceProvider.changePrice(value);
                              },
                              decoration: InputDecoration(
                                  labelText: "Price",
                                  hintText: "Enter the insurance price",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  )),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Price cannot be empty";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(
                              height: height * 0.05,
                            ),
                            TextFormField(
                              minLines: 6,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              controller: descriptionController,
                              onChanged: (String value) {
                                insuranceProvider.changeDesciption(value);
                              },
                              decoration: InputDecoration(
                                  labelText: "Description",
                                  hintText: "Enter the description",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  )),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Description cannot be empty";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(
                              height: height * 0.05,
                            ),
                            // j
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: size.width / 3.5,
                                  margin: EdgeInsets.all(10),
                                  child: RaisedButton(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(80.0)),
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
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      child: Container(
                                        constraints: const BoxConstraints(
                                            maxWidth: 250.0, minHeight: 50.0),
                                        alignment: Alignment.center,
                                        child: const Text(
                                          "Cancel",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
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
                                      print("CALLED");
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        Insurance part = Insurance(
                                          insuranceTitle: titleController.text,
                                          insurancePrice: double.parse(
                                              priceController.text),
                                          insuranceDescription:
                                              descriptionController.text,
                                          insuranceImage: await imgUrl,
                                          insuranceId: widget
                                              .documentSnapshot['insuranceId'],
                                        );
                                        print(part);
                                        await FirestoreInsuranceService()
                                            .updateInsurancePackage(part);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Record Updated Successfully')),
                                        );
                                        setState(() {
                                          isLoading = false;
                                        });
                                      }

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const InsuranceList(),
                                        ),
                                      );
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(80.0)),
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
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      child: Container(
                                        constraints: const BoxConstraints(
                                            maxWidth: 250.0, minHeight: 50.0),
                                        alignment: Alignment.center,
                                        child: const Text(
                                          "Update",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
