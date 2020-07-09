import 'package:flutter/material.dart';

class ScreenArguments {
  final int restautantId;
  final String restaurantName;
  final String address;
  final String city;
  final String state;
  final String zipCode;
  final String emailAddress;
  final String restaurantImageURL;

  ScreenArguments(
      this.restautantId,
      this.restaurantName,
      this.address,
      this.city,
      this.state,
      this.zipCode,
      this.emailAddress,
      this.restaurantImageURL,);
}