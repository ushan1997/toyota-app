import 'package:flutter/material.dart';

class CommonNavBar extends StatelessWidget {
  const CommonNavBar({Key? key, required this.sectionName}) : super(key: key);

  final String sectionName;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.network(
          'https://www.freepnglogos.com/uploads/toyota-logo-png/toyota-logos-brands-logotypes-0.png',
          height: 25,
        ),
        const SizedBox(width: 8),
        const Text(
          'TOYOTA',
          style: TextStyle(
            color: Colors.white,
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
