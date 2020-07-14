import '../screens/restaurant_list.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Services {

  Services() ;

  static Future<List<Restaurant>> fetchRestaurants() async {

    final restaurantsListAPIUrl = 'https://restaurants.nicholssoftware.com/api/getrestaurants';
    final response = await http.get(restaurantsListAPIUrl);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((restaurant) => new Restaurant.fromJson(restaurant)).toList();
    } else {
      throw Exception('Failed to load Restaurants from API');
    }
  }
}