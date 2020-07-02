import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ARestaurant {
  final int Restaurant_Id;
  final String Restaurant_Name;
  final String Address;
  final String City;
  final String State;
  final String Zip_Code;
  final String Email_Address;
  final String Restaurant_Image_URL;
  final DateTime End_Date;

  ARestaurant({this.Restaurant_Id, this.Restaurant_Name, this.Address, this.City, this.State, this.Zip_Code, this.Email_Address, this.Restaurant_Image_URL, this.End_Date});


  /*----------------------------------------------------------------------------
    Here, we are creating a factory method called Restaurant.fromJson whose objective
    is to simply deserialize the json and return a single object of type Restaurant.

    The factory keyword is used when implementing a constructor that doesn’t
    always create a new instance of its class.
  ----------------------------------------------------------------------------*/
  factory ARestaurant.fromJson(Map<String, dynamic> json) {
    return ARestaurant(
      Restaurant_Id: json['RestaurantId'],
      Restaurant_Name: json['RestaurantName'],
      Address: json['Address'],
      City: json['City'],
      State: json['State'],
      Zip_Code: json['ZipCode'],
      Email_Address: json['EmailAddress'],
      Restaurant_Image_URL: json['RestaurantImageURL'],
      End_Date: json['EndDate'],
    );
  }
}

class RestaurantListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ARestaurant>>(
      future: _fetchRestaurants(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ARestaurant> data = snapshot.data;
          return _RestaurantsListView(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  // Call the web service
  Future<List<ARestaurant>> _fetchRestaurants() async {

    final restaurantsListAPIUrl = 'https://restaurants.nicholssoftware.com/api/getrestaurants';
    final response = await http.get(restaurantsListAPIUrl);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((Restaurant) => new ARestaurant.fromJson(Restaurant)).toList();
    } else {
      throw Exception('Failed to load Restaurants from API');
    }
  }

  ListView _RestaurantsListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _tile(data[index].Restaurant_Name, data[index].Address, data[index].City, data[index].State, data[index].Zip_Code, data[index].Restaurant_Image_URL);
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
      leading: Image.network(restaurantImageURL)
  );
}