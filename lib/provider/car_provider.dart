import 'package:flutter/cupertino.dart';
import 'package:toyota_app/services/firestore_car_service.dart';
import 'package:uuid/uuid.dart';
import '../model/car_data.dart';

class CarProvider with ChangeNotifier {
  final firestoreService = FirestoreCarService();
  var uuid = Uuid();

  late String _carId;
  late String _image;
  late String _name;
  late double _price;
  late String _description;

  String get image => _image;
  String get name => _name;
  double get price => _price;
  String get description => _description;
  Stream<List<CarData>> get cars => firestoreService.getCar();

  changeImage(String value) {
    _image = value;
    notifyListeners();
  }

  changeName(String value) {
    _name = value;
    notifyListeners();
  }

  changePrice(String value) {
    _price = double.parse(value);
    notifyListeners();
  }

  changeDescription(String value) {
    _description = value;
    notifyListeners();
  }

  Stream<List<CarData>> getAllParts() {
    return firestoreService.getCar();
  }

  void addCar() {
    var newCar = CarData(
      carId: uuid.v4(),
      image: _image,
      name: _name,
      price: _price,
      description: _description,
    );
    firestoreService.createCar(newCar);
  }

  void deleteCar(String carId) {
    firestoreService.deleteCar(carId);
  }
}
