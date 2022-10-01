import 'package:flutter/material.dart';
import 'package:toyota_app/screen/cars/cars_userview_screen.dart';
import 'package:toyota_app/screen/insurance/insurance_user_list.dart';
import 'package:toyota_app/screen/parts/part_userview_screen.dart';

class HomeUserScreen extends StatefulWidget {
  //static const String routeName = '/';
  const HomeUserScreen({Key? key}) : super(key: key);

  @override
  State<HomeUserScreen> createState() => _HomeUserScreenState();
}

class _HomeUserScreenState extends State<HomeUserScreen> {
  var currentPageIndex = 0;
  final screens = [
    const CarsUserViewScreen(),
    const UserViewScreen(),
    //change code here
    const CarsUserViewScreen(),
    const InsuranceListUser(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentPageIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPageIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => currentPageIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: "Cars",
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.construction_sharp),
            label: "Spare Parts",
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ads_click),
            label: "Ads",
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on_outlined),
            label: "Insurance",
            backgroundColor: Colors.red,
          ),
        ],
      ),
    );
  }
}
