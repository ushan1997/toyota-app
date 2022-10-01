import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/car_data.dart';

class FirestoreCarService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final dbRef = FirebaseFirestore.instance.collection("cars");

  Stream<List<CarData>> getCar() {
    Stream<List<CarData>> cars = _db.collection("cars").snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => CarData.fromJson(doc.data())).toList());
    return cars;
  }

  Future<void> createCar(CarData car) async {
    final docCar = _db.collection("cars").doc();
    car.carId = docCar.id;

    final json = car.toJson();
    print("car=======>json");
    print(json);
    await docCar.set(json);
  }

  Future<void> updateCar(CarData car) {
    return _db.collection("cars").doc(car.carId).update(car.toJson());
  }

  Future<void> deleteCar(String carId) {
    return _db.collection("cars").doc(carId).delete();
  }
}
