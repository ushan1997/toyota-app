import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:toyota_app/model/car_data.dart';
import 'package:toyota_app/provider/car_provider.dart';
import 'package:toyota_app/screen/cars/cars_title_bar.dart';
import 'package:toyota_app/services/firestore_car_service.dart';
import 'package:uuid/uuid.dart';

class CarsAddForm extends StatefulWidget {
  static String routeName = '/addcar';
  const CarsAddForm({Key? key}) : super(key: key);

  @override
  _CarsAddFormState createState() => _CarsAddFormState();
}

class _CarsAddFormState extends State<CarsAddForm> {
  bool isloading = false;
  var uuid = const Uuid();
  PlatformFile? pickedImage;
  UploadTask? uploadTask;
  late var imageUrl = "";
  final _formKey = GlobalKey<FormState>();
  final imageController = TextEditingController();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  Future getImage() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedImage = result.files.first;
    });
    uploadImage();
  }

  Future uploadImage() async {
    final path = 'carImages/${pickedImage!.name}';
    final file = File(pickedImage!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();

    imageUrl = urlDownload.toString();
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
                        "Insert New Vehicle",
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
                                        "https://png.pngtree.com/png-vector/20191129/ourlarge/pngtree-image-upload-icon-photo-upload-icon-png-image_2047547.jpg",
                                        width: 200,
                                        height: 200,
                                      ),
                            const SizedBox(
                              height: 16,
                            ),
                            imageUrl == ""
                                ? const Text(
                                    "Enter valid Image",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 224, 55, 55),
                                      fontSize: 20,
                                      fontStyle: FontStyle.italic,
                                      fontFamily: 'RobotoMono',
                                    ),
                                  )
                                : const Text(""),
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
                        decoration: InputDecoration(
                          hintText: 'Vehicle Name',
                          labelText: 'Enter Vehicle Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter validate Vehicle name";
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
                        onChanged: (String value) {
                          carProvider.changePrice(value);
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Price',
                          labelText: 'Enter Vehicle Price',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter validate Vehicle price";
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
                            return "Enter validate Vehicle Description";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 16,
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
                                      carId: uuid.v4(),
                                      // ignore: await_only_futures
                                      image: await imageUrl,
                                      name: nameController.text,
                                      price: double.parse(priceController.text),
                                      description: descriptionController.text,
                                    );
                                    FirestoreCarService().createCar(car);

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Record Saved Successfully')),
                                    );
                                    setState(() {
                                      isloading = false;
                                    });
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text("Submit")),
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
          Text(' Pick a image'),
        ],
      ),
    ),
  );
}
