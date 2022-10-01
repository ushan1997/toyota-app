import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/insurance.dart';

class FirestoreInsuranceService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final dbRef = FirebaseFirestore.instance.collection("insurance");

  Stream<List<Insurance>> getInsurancePackages() {
    Stream<List<Insurance>> iList = _db.collection("insurance").snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => Insurance.fromJson(doc.data()))
            .toList());
    return iList;
  }

  Future<void> createInsurancePackage(Insurance insurance) async {
    final docInsurance = _db.collection("insurance").doc();
    insurance.insuranceId = docInsurance.id;

    final json = insurance.toJson();
    print("insurance=======>json");
    print(json);
    await docInsurance.set(json);
  }

  Future<void> updateInsurancePackage(Insurance insurance) {
    return _db
        .collection("insurance")
        .doc(insurance.insuranceId)
        .update(insurance.toJson());
  }

  Future<void> deleteInsurancePackage(String insuranceId) {
    return _db.collection("insurance").doc(insuranceId).delete();
  }
}
