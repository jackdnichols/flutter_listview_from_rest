import 'package:flutter/material.dart';
import 'RestaurantList.dart';
import 'RestaurantMenu.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Job Portal',
      routes: <String, WidgetBuilder>{
        //'/restaurantlist' : (BuildContext) => new RestaurantList(),
        '/restaurantmenu' : (BuildContextd) => new RestaurantMenu(),
      },
      home: Scaffold(
        appBar: AppBar(
          title: Text('Restaurants'),
        ),
        body: Center(
            child: RestaurantList()

        ),
      ),
    );
  }
}

