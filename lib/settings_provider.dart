import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier{
  int _restaurantId;
  String _restaurantName;
  String _address;
  String _city;
  String _state;
  String _zipCode;
  String _emailAddress;
  String _restaurantImageURL;
  double _originLatitude;
  double _originLongitude;
  double _destinationLatitude;
  double _destinationLongitude;

  SettingsProvider(){
    loadPreferences();
  }

  // Getters
  int get restaurantId => _restaurantId;
  String get restaurantName => _restaurantName;
  String get address => _address;
  String get city => _city;
  String get state => _state;
  String get zipCode => _zipCode;
  String get emailAddress => _emailAddress;
  String get restaurantImageURL => _restaurantImageURL;
  double get originLatitude => _originLatitude;
  double get originLongitude => _originLongitude;
  double get destinationLatitude => _destinationLatitude;
  double get destinationLongitude => _destinationLongitude;

  // Setters
  void setRestaurantId(int restaurantId){
    _restaurantId = restaurantId;
    notifyListeners();
  }

  void setRestaurantName(String restaurantName){
    _restaurantName = restaurantName;
    notifyListeners();
  }

  void setAddress(String address){
    _address = address;
    notifyListeners();
  }

  void setCity(String city){
    _city = city;
    notifyListeners();
  }

  void setState(String state){
    _state = state;
    notifyListeners();
  }

  void setZipCode(String zipCode){
    _zipCode = zipCode;
    notifyListeners();
  }

  void setEmailAddress(String emailAddress){
    _emailAddress = emailAddress;
    notifyListeners();
  }

  void setRestaurantImageURL(String restaurantImageURL){
    _restaurantImageURL = restaurantImageURL;
    notifyListeners();
  }

  void setOriginLatitude(double  originLatitude){
    _originLatitude = originLatitude;
    notifyListeners();
  }

  void setOriginLongitude(double originLongitude){
    _originLongitude = originLongitude;
    notifyListeners();
  }

  void setDestinationLatitude(double destinationLatitude){
    _destinationLatitude = destinationLatitude;
    notifyListeners();
  }

  void setDestinationLongitude(double destinationLongitude){
    _destinationLongitude = destinationLongitude;
    notifyListeners();
  }

  savePreferences() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('restaurantId', _restaurantId);
    prefs.setString('restaurantName', _restaurantName);
    prefs.setString('address', _address);
    prefs.setString('city', _city);
    prefs.setString('state', _state);
    prefs.setString('zipCode', _zipCode);
    prefs.setString('emailAddress', _emailAddress);
    prefs.setString('restaurantImageURL', _restaurantImageURL);
    prefs.setDouble('originLatitude', _originLatitude);
    prefs.setDouble('originLongitude', _originLongitude);
    prefs.setDouble('destinationLatitude', _destinationLatitude);
    prefs.setDouble('destinationLongitude', _destinationLongitude);
  }

  loadPreferences() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int restaurantId = prefs.getInt('restaurantId');
    String restaurantName = prefs.getString('restaurantName');
    String address = prefs.getString('address');
    String city = prefs.getString('city');
    String state = prefs.getString('state');
    String zipCode = prefs.getString('zipCode');
    String emailAddress = prefs.getString('emailAddress');
    String restaurantImageURL = prefs.getString('restaurantImageURL');
    double originLatitude = prefs.getDouble('originLatitude');
    double originLongitude = prefs.getDouble('originLongitude');
    double destinationLatitude = prefs.getDouble('destinationLatitude');
    double destinationLongitude = prefs.getDouble('destinationLongitude');

    if (restaurantId != null) setRestaurantId(restaurantId);
    if (restaurantName != null) setRestaurantName(restaurantName);
    if (address != null) setAddress(address);
    if (city != null) setCity(city);
    if (state != null) setState(state);
    if (zipCode != null) setZipCode(zipCode);
    if (emailAddress != null) setEmailAddress(emailAddress);
    if (restaurantImageURL != null) setRestaurantImageURL(restaurantImageURL);
    if (originLatitude != null) setOriginLatitude(originLatitude);
    if (originLongitude != null) setOriginLongitude(originLongitude);
    if (destinationLatitude != null) setDestinationLatitude(destinationLatitude);
    if (destinationLongitude != null) setDestinationLongitude(destinationLongitude);

  }
}