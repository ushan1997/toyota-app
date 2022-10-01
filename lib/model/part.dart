class Part {
  String partId;
  final String name;
  final double price;
  final String description;
  final String imageUrl;

  Part(
      {this.partId = '',
      required this.name,
      required this.price,
      required this.description,
      required this.imageUrl});

  Map<String, dynamic> toMap() {
    return {
      'partId': partId,
      'name': name,
      'price': price,
      'description': description,
      'imageUrl': imageUrl
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'partId': partId,
      'name': name,
      'price': price,
      'description': description,
      'imageUrl': imageUrl
    };
  }

  factory Part.fromJson(Map<String, dynamic> json) {
    return Part(
        partId: json['partId'],
        name: json['name'],
        price: json['price'],
        description: json['desciption'],
        imageUrl: json['imageUrl']);
  }
}
