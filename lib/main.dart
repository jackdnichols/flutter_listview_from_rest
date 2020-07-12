import 'package:flutter/material.dart';
import 'screens/RestaurantList.dart';
import 'screens/RestaurantMenu.dart';
import 'GoogleMap.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Job Portal',
      routes: <String, WidgetBuilder>{
        '/restaurantmenu' : (context) => new RestaurantMenu(),
        '/googlemap' : (context) => new MyApp(),
      },
      home: Scaffold(
        appBar: AppBar(
          title: Text('Restaurants'),
        ),
        body: Center(
            child: RestaurantList(),
        ),
      ),
    );
  }
}

