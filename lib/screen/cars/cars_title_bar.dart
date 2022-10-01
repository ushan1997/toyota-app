import 'package:flutter/material.dart';

class CarTitleBar extends StatelessWidget {
  const CarTitleBar({
    Key? key,
    required this.sectionName,
  }) : super(key: key);

  final String sectionName;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, //down axisi | allighnment
      mainAxisSize: MainAxisSize.min, //main axis => allighnment
      children: [
        Image.network(
          'https://www.freepnglogos.com/uploads/toyota-logo-png/toyota-logos-brands-logotypes-0.png',
          height: 25,
        ),
        const SizedBox(width: 8),
        const Text(
          'TOYOTA',
          style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontSize: 16,
          ),
        ),
        Text(
          // ignore: unnecessary_string_interpolations
          ' $sectionName',
          style: const TextStyle(color: Colors.orange, fontSize: 18),
        ),
      ],
    );
  }
}
