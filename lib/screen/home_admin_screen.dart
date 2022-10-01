import 'package:flutter/material.dart';
import 'package:toyota_app/screen/cars/cars_screen.dart';
import 'package:toyota_app/screen/cars/cars_title_bar.dart';
import 'package:toyota_app/screen/home_user_screen.dart';
import 'package:toyota_app/screen/insurance/insurance_list.dart';
import 'package:toyota_app/screen/parts/parts_screen.dart';

class HomeAdminScreen extends StatefulWidget {
  const HomeAdminScreen({Key? key}) : super(key: key);

  @override
  _HomeAdminScreenState createState() => _HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<HomeAdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
        title: const CarTitleBar(
          sectionName: 'Admin',
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeUserScreen(),
                ),
              );
            },
            icon: const Icon(Icons.supervised_user_circle),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: GridView.count(
            shrinkWrap: true,
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: <Widget>[
              Card(
                elevation: 5,
                margin: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ), //shadow
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CarsScreen(),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.network(
                            "https://thumbs.dreamstime.com/b/vector-cartoon-car-toyota-supra-orange-paint-white-background-vector-cartoon-car-toyota-supra-127487626.jpg"),
                      ),
                      Text(
                        "Cars",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5,
                margin: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ), //shadow
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PartScreen(),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.network(
                            "https://www.pngitem.com/pimgs/m/427-4276428_spare-parts-logo-png-transparent-png.png"),
                      ),
                      Text(
                        "Spare Parts",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5,
                margin: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ), //shadow
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CarsScreen(),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.network(
                            "https://www.pngitem.com/pimgs/m/219-2197356_advertising-clipart-download-news-media-microphone-advertising-clipart.png"),
                      ),
                      Text(
                        "Ads",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5,
                margin: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ), //shadow
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const InsuranceList(),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.network(
                            "https://png.pngtree.com/png-clipart/20190905/original/pngtree-financial-business-data-png-image_4513315.jpg"),
                      ),
                      Text(
                        "Insurance",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
