import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toyota_app/model/part.dart';

class FirestorePartService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createPart(Part part) async {
    final docPart = _db.collection("parts").doc();
    part.partId = docPart.id;

    final json = part.toJson();
    await docPart.set(json);
  }

  Future<void> updatePart(Part part) {
    return _db.collection("parts").doc(part.partId).update(part.toJson());
  }

  Future<void> deletePart(String? partId) {
    return _db.collection("parts").doc(partId).delete();
  }
}
