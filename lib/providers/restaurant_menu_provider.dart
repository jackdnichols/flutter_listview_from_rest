import 'package:flutter/cupertino.dart';

class RestaurantMenuProvider with ChangeNotifier  {
  int _restaurantId;
  String _restaurantName;
  String _address;
  String _city;
  String _state;
  String _zipCode;
  String _emailAddress;
  String _restaurantImageURL;

  // Getters
  int get restaurantId => _restaurantId;
  String get restaurantName => _restaurantName;
  String get address => _address;
  String get city => _city;
  String get state => _state;
  String get zipCode => _zipCode;
  String get emailAddress => _emailAddress;
  String get restaurantImageURL => _restaurantImageURL;

  // Setters
  void setRestautantId(int restautantId){
    _restaurantId = restautantId;
    notifyListeners();
  }

  RestaurantMenuProvider(
      this._restaurantId,
      this._restaurantName,
      this._address,
      this._city,
      this._state,
      this._zipCode,
      this._emailAddress,
      this._restaurantImageURL,);
}