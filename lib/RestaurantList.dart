import 'package:flutter/material.dart';
import 'services/restaurantServices.dart';

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

class RestaurantList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Restaurant>>(
      future: Services.fetchRestaurants(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Restaurant> data = snapshot.data;
          return _listView(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  ListView _listView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return new GestureDetector(
            child: _listTile(data[index].restaurantName, data[index].address, data[index].city, data[index].state, data[index].zipCode, data[index].restaurantImageURL),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RestaurantMenu(data[index].restaurantId),
                ),
              );
            },
          );
        });
  }

  ListTile _listTile(String restaurantName, String address, String city, String state, String zipCode, String restaurantImageURL) => ListTile(
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

class RestaurantMenu extends StatelessWidget {

  final int restaurantId;

  RestaurantMenu(this.restaurantId);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
          children: <Widget>[
            Text('Card $restaurantId'),
            FlatButton(
                child: Text("Press Me"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
          ],
        )
    );
  }
}