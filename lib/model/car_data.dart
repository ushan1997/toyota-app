class CarData {
  String carId;
  final String image;
  final String name;
  final double price;
  final String description;

  CarData({
    this.carId = "",
    required this.image,
    required this.name,
    required this.price,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'carId': carId,
      'image': image,
      'name': name,
      'price': price,
      'description': description,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'carId': carId,
      'image': image,
      'name': name,
      'price': price,
      'description': description,
    };
  }

  factory CarData.fromJson(Map<String, dynamic> json) {
    return CarData(
        carId: json['carId'],
        image: json['image'],
        name: json['name'],
        price: json['price'],
        description: json['description']);
  }
}
