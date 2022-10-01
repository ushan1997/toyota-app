import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:toyota_app/services/firestore_insurance_service.dart';
import 'package:flutter/cupertino.dart';

class InsuranceProvider with ChangeNotifier {
  final firestoreService = FirestoreInsuranceService();

  String? _insuranceId;
  String? _insuranceTitle;
  String? _insuranceDescription;
  String? _insuranceImage;
  double? _insurancePrice;

  var uuid = Uuid();

  String? get insuranceTitle => _insuranceTitle;
  String? get insuranceDescription => _insuranceDescription;
  String? get insuranceImage => _insuranceImage;
  double? get insurancePrice => _insurancePrice;

  changeTitle(String? value) {
    _insuranceTitle = value;
    notifyListeners();
  }

  changeDesciption(String? value) {
    _insuranceDescription = value;
    notifyListeners();
  }

  changeImage(String? value) {
    _insuranceImage = value;
    notifyListeners();
  }

  changePrice(String? value) {
    _insurancePrice = double.parse(value!);
    notifyListeners();
  }

  void removeInsurance(String? insuranceId) {
    firestoreService.deleteInsurancePackage(insuranceId!);
  }
}
