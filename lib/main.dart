import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toyota_app/provider/car_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:toyota_app/provider/insurance_provider.dart';
import 'package:toyota_app/screen/splash_screen.dart';

import 'provider/part_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CarProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => InsuranceProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Toyota App',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
