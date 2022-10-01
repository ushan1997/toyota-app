import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:toyota_app/model/insurance.dart';
import 'package:toyota_app/provider/insurance_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:toyota_app/services/firestore_insurance_service.dart';
import 'package:uuid/uuid.dart';

class InsuranceAddScreen extends StatefulWidget {
  const InsuranceAddScreen({Key? key}) : super(key: key);

  @override
  _InsuranceAddScreenState createState() => _InsuranceAddScreenState();
}

class _InsuranceAddScreenState extends State<InsuranceAddScreen> {
  var uuid = Uuid();
  bool isLoading = false;
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
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
    print("IMAGE URL : ${imgUrl}");
  }

  @override
  Widget build(BuildContext context) {
    final partProvider = Provider.of<InsuranceProvider>(context);
    final double height = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        // title: Text("New Package"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
          splashColor: Colors.white,
        ),
      ),
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
                      SizedBox(height: height * 0.04),
                      const Center(
                        child: Text(
                          "Add New Insurance Package",
                          style:
                              TextStyle(fontSize: 25, color: Color(0xFF363f93)),
                        ),
                      ),
                      SizedBox(height: height * 0.03),
                      Center(
                        child: Column(
                          children: [
                            SizedBox(height: height * 0.04),
                            if (pickedFile != null)
                              Image.file(
                                File(pickedFile!.path!),
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ElevatedButton(
                              onPressed: selectFile,
                              child: const Text('Choose Cover Image'),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            SizedBox(height: height * 0.04),
                            TextFormField(
                              controller: titleController,
                              onChanged: (String value) {
                                partProvider.changeTitle(value);
                              },
                              decoration: const InputDecoration(
                                labelText: "Name",
                                hintText: "Enter the title",
                              ),
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
                              height: height * 0.04,
                            ),
                            TextFormField(
                              controller: priceController,
                              onChanged: (String value) {
                                partProvider.changePrice(value);
                              },
                              decoration: const InputDecoration(
                                labelText: "Price",
                                hintText: "Enter the package price",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Price cannot be empty";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(
                              height: height * 0.04,
                            ),
                            TextFormField(
                              minLines: 6,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              controller: descriptionController,
                              onChanged: (String value) {
                                partProvider.changeDesciption(value);
                              },
                              decoration: const InputDecoration(
                                labelText: "Desciption",
                                hintText: "Enter the description",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Description cannot be empty";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            Row(
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
                                            BorderRadius.circular(30.0),
                                      ),
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
                                      if (_formKey.currentState!.validate()) {
                                        print("IMAGE URL 2 : ${imgUrl}");
                                        setState(() {
                                          isLoading = true;
                                        });

                                        Insurance insurance = Insurance(
                                          insuranceId: uuid.v4(),
                                          insuranceTitle: titleController.text,
                                          insurancePrice: double.parse(
                                              priceController.text),
                                          insuranceDescription:
                                              descriptionController.text,
                                          insuranceImage: imgUrl,
                                        );
                                        FirestoreInsuranceService()
                                            .createInsurancePackage(insurance);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Record Saved Successfully')),
                                        );
                                        setState(() {
                                          isLoading = false;
                                        });
                                        Navigator.pop(context);
                                      }
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
                                          "Upload",
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
                            ),
                            SizedBox(
                              height: height * 0.03,
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
