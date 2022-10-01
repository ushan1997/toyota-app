class Insurance {
  String insuranceId;
  final String insuranceTitle;
  final String insuranceDescription;
  final String insuranceImage;
  final double insurancePrice;

  Insurance({
    this.insuranceId = '',
    required this.insuranceTitle,
    required this.insuranceDescription,
    required this.insuranceImage,
    required this.insurancePrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'insuranceId': insuranceId,
      'insuranceTitle': insuranceTitle,
      'insuranceDescription': insuranceDescription,
      'insuranceImage': insuranceImage,
      'insurancePrice': insurancePrice,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'insuranceId': insuranceId,
      'insuranceTitle': insuranceTitle,
      'insuranceDescription': insuranceDescription,
      'insuranceImage': insuranceImage,
      'insurancePrice': insurancePrice,
    };
  }

  factory Insurance.fromJson(Map<String, dynamic> json) {
    return Insurance(
      insuranceId: json['insuranceId'],
      insuranceTitle: json['insuranceTitle'],
      insuranceDescription: json['insuranceDescription'],
      insuranceImage: json['insuranceImage'],
      insurancePrice: json['insurancePrice'],
    );
  }
}
