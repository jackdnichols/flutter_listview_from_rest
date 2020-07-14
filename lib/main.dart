import 'package:flutter/material.dart';
import 'route_generator.dart';
import 'screens/restaurant_list.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Job Portal',
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
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

