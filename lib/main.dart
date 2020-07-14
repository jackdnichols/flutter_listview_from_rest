import 'package:flutter/material.dart';
import 'screens/restaurant_list.dart';
import 'screens/restaurant_menu.dart';
import 'google_map.dart';

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
        '/googlemap' : (context) => new MapPage(),
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

