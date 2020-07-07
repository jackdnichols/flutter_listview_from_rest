import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Restaurant {
  final int restaurantId;
  final String restaurantName;
  final String address;
  final String city;
  final String state;
  final String zipCode;
  final String emailAddress;
  final String restaurantImageURL;
  final DateTime endDate;

  Restaurant({
        this.restaurantId,
        this.restaurantName,
        this.address,
        this.city,
        this.state,
        this.zipCode,
        this.emailAddress,
        this.restaurantImageURL,
        this.endDate
  });


  /*----------------------------------------------------------------------------
    Here, we are creating a factory method called Restaurant.fromJson whose objective
    is to simply deserialize the json and return a single object of type Restaurant.

    The factory keyword is used when implementing a constructor that doesn’t
    always create a new instance of its class.
  ----------------------------------------------------------------------------*/
  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      restaurantId: json['RestaurantId'],
      restaurantName: json['RestaurantName'],
      address: json['Address'],
      city: json['City'],
      state: json['State'],
      zipCode: json['ZipCode'],
      emailAddress: json['EmailAddress'],
      restaurantImageURL: json['RestaurantImageURL'],
      endDate: json['EndDate'],
    );
  }
}

class RestaurantListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Restaurant>>(
      future: _fetchRestaurants(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Restaurant> data = snapshot.data;
          return _restaurantsListView(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  // Call the web service
  Future<List<Restaurant>> _fetchRestaurants() async {

    final restaurantsListAPIUrl = 'https://restaurants.nicholssoftware.com/api/getrestaurants';
    final response = await http.get(restaurantsListAPIUrl);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((restaurant) => new Restaurant.fromJson(restaurant)).toList();
    } else {
      throw Exception('Failed to load Restaurants from API');
    }
  }

  ListView _restaurantsListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _tile(data[index].restaurantName, data[index].address, data[index].city, data[index].state, data[index].zipCode, data[index].restaurantImageURL);
        });
  }

  ListTile _tile(String restaurantName, String address, String city, String state, String zipCode, String restaurantImageURL) => ListTile(
      title: Text(
          restaurantName,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          )),

      subtitle: Text(
        city + ' ' + state + ' ' + zipCode,
        style: TextStyle(
          fontSize: 22,
          //color: Colors.green,
        ),
      ),

      leading: Image.network(
        restaurantImageURL,
        width: 100,
      )

  );
}