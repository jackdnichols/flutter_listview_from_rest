import 'package:flutter/material.dart';
import 'screens/restaurant_list.dart';
import 'screens/restaurant_menu.dart';
import 'google_map.dart';
import 'restaurant_menu_arguments.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final pageArgs = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => RestaurantList());
      case '/restaurantmenu':
        // Validation of correct data type
        if (pageArgs is RestaurantMenuArguments) {
          return MaterialPageRoute(
            builder: (_) => RestaurantMenu(
              restaurantMenuArgs: pageArgs,
            ),
          );
        }
        break;
      case '/googlemap':
        return MaterialPageRoute(builder: (_) => MapPage());

        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        // return _errorRoute();
      default:
      // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
    return null;
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}