import 'package:flutter/material.dart';
import 'package:flutter_listview_rest/providers/map_latlng_provider.dart';
import 'screens/map_directions.dart';
import 'screens/restaurant_list.dart';
import 'screens/restaurant_menu.dart';
import 'continuous_tracking_map.dart';
import 'providers/restaurant_menu_provider.dart';
import 'map_and_directions.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final routeSettingArgs = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => RestaurantList());
      case '/restaurantmenu':
        // Validation of correct data type
        if (routeSettingArgs != null && routeSettingArgs is RestaurantMenuProvider) {
          return MaterialPageRoute(
            builder: (_) => RestaurantMenu(
              restaurantMenuArgs: routeSettingArgs,
            ),
          );
        }
        break;
      case '/googlemap':
        return MaterialPageRoute(builder: (_) => MapPage());

      case '/mapdirections':
        // Validation of correct data type
        if (routeSettingArgs != null && routeSettingArgs is MapLatLngProvider) {
          return MaterialPageRoute(
            builder: (_) => MapDirections(
              mapRouteLatLngArgs: routeSettingArgs,
            ),
          );
        }
        break;
       // return MaterialPageRoute(builder: (_) => MapDirections());

      case '/mapanddirections':
        return MaterialPageRoute(builder: (_) => MapAndDirections());

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