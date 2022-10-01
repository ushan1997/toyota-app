import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:toyota_app/components/common_navbar.dart';
import 'package:toyota_app/model/part.dart';
import 'package:toyota_app/provider/part_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:toyota_app/screen/parts/parts_screen.dart';
import 'package:toyota_app/services/firestore_part_service.dart';
import 'package:uuid/uuid.dart';

class PartAddScreen extends StatefulWidget {
  const PartAddScreen({Key? key}) : super(key: key);

  @override
  State<PartAddScreen> createState() => _PartAddScreenState();
}

class _PartAddScreenState extends State<PartAddScreen> {
  var uuid = Uuid();
  bool isLoading = false;
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
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
    final path = 'parts/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() => () {});

    final downloadUrl = await snapshot.ref.getDownloadURL();
    imgUrl = downloadUrl.toString();
  }

  @override
  Widget build(BuildContext context) {
    final partProvider = Provider.of<PartProvider>(context);
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
        title: const CommonNavBar(
          sectionName: 'Parts',
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
                      SizedBox(
                        height: height * 0.05,
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
                                        "https://t3.ftcdn.net/jpg/02/70/22/86/360_F_270228625_yujevz1E4E45qE1mJe3DyyLPZDmLv4Uj.jpg",
                                        width: 200,
                                        height: 200,
                                      ),
                            const SizedBox(
                              height: 16,
                            ),
                            imgUrl == ""
                                ? const Text(
                                    "Enter valid Image",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 224, 55, 55),
                                      fontSize: 10,
                                      fontStyle: FontStyle.italic,
                                      fontFamily: 'RobotoMono',
                                    ),
                                  )
                                : const Text(""),
                            ElevatedButton(
                                onPressed: selectFile,
                                child: const Text('Choose Image')),
                            SizedBox(height: height * 0.04),
                            TextFormField(
                              controller: nameController,
                              onChanged: (String value) {
                                partProvider.changeName(value);
                              },
                              decoration: InputDecoration(
                                  labelText: "Name",
                                  hintText: "Enter the part name",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  )),
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
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
                              decoration: InputDecoration(
                                  labelText: "Price",
                                  hintText: "Enter the part price",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
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
                              decoration: InputDecoration(
                                  labelText: "Desciption",
                                  hintText: "Enter the description",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Description cannot be empty";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(
                              height: height * 0.08,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red,
                                      minimumSize: const Size(40, 40),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const PartScreen()));
                                    },
                                    child: const Text("Cancel"),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.blue,
                                      minimumSize: const Size(40, 40),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate() &&
                                          imgUrl != "") {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        Part part = Part(
                                          partId: uuid.v4(),
                                          name: nameController.text,
                                          price: double.parse(
                                              priceController.text),
                                          description:
                                              descriptionController.text,
                                          imageUrl: await imgUrl,
                                        );
                                        FirestorePartService().createPart(part);
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
                                    child: const Text("Submit"),
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
