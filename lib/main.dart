import 'package:flutter/material.dart';
import 'RestaurantList.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Job Portal',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Restaurants'),
        ),
        body: Center(
            child: RestaurantList()
            //child: RestaurantMenu()
        ),
      ),
    );
  }
}

