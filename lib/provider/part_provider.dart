import 'package:flutter/material.dart';
import 'package:toyota_app/services/firestore_part_service.dart';
import 'package:uuid/uuid.dart';

class PartProvider extends ChangeNotifier {
  final firestoreService = FirestorePartService();
  String? _partId;
  String? _name;
  double? _price;
  String? _description;
  String? _imageUrl;

  var uuid = Uuid();

  String? get name => _name;
  double? get price => _price;
  String? get description => _description;
  String? get imageUrl => _imageUrl;

  changeName(String? value) {
    _name = value;
    notifyListeners();
  }

  changePrice(String? value) {
    _price = double.parse(value!);
    notifyListeners();
  }

  changeDesciption(String? value) {
    _description = value;
    notifyListeners();
  }

  changeImgUrl(String? value) {
    _imageUrl = value;
    notifyListeners();
  }

  void removePart(String? partId) {
    firestoreService.deletePart(partId);
  }
}
