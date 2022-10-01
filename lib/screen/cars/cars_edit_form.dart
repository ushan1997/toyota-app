import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:toyota_app/model/car_data.dart';
import 'package:toyota_app/provider/car_provider.dart';
import 'package:toyota_app/screen/cars/cars_title_bar.dart';
import 'package:toyota_app/services/firestore_car_service.dart';

class CarsEditForm extends StatefulWidget {
  static String routeName = '/editcar';
  final DocumentSnapshot documentSnapshot;

  const CarsEditForm({
    Key? key,
    required this.documentSnapshot,
  }) : super(key: key);

  @override
  _CarsEditFormState createState() => _CarsEditFormState();
}

class _CarsEditFormState extends State<CarsEditForm> {
  bool isloading = false;
  PlatformFile? pickedImage;
  UploadTask? uploadTask;
  late var imageUrl = "";
  final _formKey = GlobalKey<FormState>();
  TextEditingController imageController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    imageController = TextEditingController(
        text: widget.documentSnapshot != null
            ? widget.documentSnapshot['image'].toString()
            : '');
    nameController = TextEditingController(
        text: widget.documentSnapshot != null
            ? widget.documentSnapshot['name'].toString()
            : '');
    priceController = TextEditingController(
        text: widget.documentSnapshot != null
            ? widget.documentSnapshot['price'].toString()
            : '');
    descriptionController = TextEditingController(
        text: widget.documentSnapshot != null
            ? widget.documentSnapshot['description'].toString()
            : '');
    imageUrl = widget.documentSnapshot['image'].toString();
  }

  Future getImage() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedImage = result.files.first;
    });
    uploadImage();
  }

  Future uploadImage() async {
    setState(() {
      isloading = true;
    });
    imageUrl = "";
    final path = 'carImages/${pickedImage!.name}';
    final file = File(pickedImage!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    imageUrl = urlDownload.toString();
    setState(() {
      isloading = false;
    });
  }

  void clearText() {
    nameController.clear();
    priceController.clear();
    descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final carProvider = Provider.of<CarProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
        title: const CarTitleBar(
          sectionName: 'Admin',
        ),
      ),
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Edit Vehicle",
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                              color: Colors.grey, letterSpacing: .5),
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Center(
                        child: Column(
                          children: [
                            pickedImage != null
                                ? Image.file(
                                    File(pickedImage!.path!),
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  )
                                : imageUrl != ""
                                    ? Image.network(
                                        imageUrl,
                                        width: 200,
                                        height: 200,
                                      )
                                    : Image.network(
                                        "https://toppng.com/uploads/preview/automobile-car-drive-ride-silhouette-styli-car-rental-logo-11563237916okmwcwglxx.png",
                                        width: 200,
                                        height: 200,
                                      ),
                            const SizedBox(
                              height: 16,
                            ),
                            ImagePickButton(
                              onClick: () => getImage(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: nameController,
                        onChanged: (String value) {
                          carProvider.changeName(value);
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Vehicle Name',
                          labelText: 'Enter Vehicle Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter valid Vehicle name";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: priceController,
                        keyboardType: TextInputType.number,
                        onChanged: (String value) {
                          carProvider.changePrice(value);
                        },
                        decoration: InputDecoration(
                          hintText: 'Price',
                          labelText: 'Enter Vehicle Price',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter valid Vehicle price";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: descriptionController,
                        onChanged: (String value) {
                          carProvider.changeDescription(value);
                        },
                        decoration: InputDecoration(
                          hintText: 'Description',
                          labelText: 'Enter valid Description',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter valid Vehicle Description";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                                minimumSize: const Size(50, 50),
                              ),
                              onPressed: () {
                                clearText();
                              },
                              child: const Text("Clear"),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue,
                                  minimumSize: const Size(50, 50),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate() &&
                                      imageUrl != "") {
                                    setState(() {
                                      isloading = true;
                                    });
                                    CarData car = CarData(
                                      carId: widget.documentSnapshot['carId'],
                                      // ignore: await_only_futures
                                      image: await imageUrl,
                                      name: nameController.text,
                                      price: double.parse(priceController.text),
                                      description: descriptionController.text,
                                    );
                                    await FirestoreCarService().updateCar(car);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Record Updated Successfully')),
                                    );
                                    setState(() {
                                      isloading = false;
                                    });
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text("Update")),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget ImagePickButton({
  required VoidCallback onClick,
}) {
  return SizedBox(
    width: 150,
    height: 30,
    child: ElevatedButton(
      onPressed: () {
        onClick();
      },
      child: Row(
        children: const [
          Icon(Icons.image_outlined),
          Text('Pick a image'),
        ],
      ),
    ),
  );
}
