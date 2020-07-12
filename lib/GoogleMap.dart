
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GoogleMapController mapController;

  GetMyLocation getmylocation = new GetMyLocation();


  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Restaurant Map'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      ),
    );
  }

  void getMyLocation () async {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    // return true if location service is enable, false if not
    bool locationServiceEnable = await geolocator.isLocationServiceEnabled();
    // position instace
    Position position;

    // if location service enable get current position
    if (locationServiceEnable) {
      // await current position
      position = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      // if location service is not enable get last known position
    } else {
      // await last known position
      position = await geolocator.getLastKnownPosition(
          desiredAccuracy: LocationAccuracy.best);
    }

    if (position != null) {
      // fetch weather data with position data
      print('Latitdue: ' + position.latitude.toString() + ' longnitude: ' + position.longitude.toString());
      //return Position;
    }
  }
}

class GetMyLocation {

  getMyLocation () async {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    // return true if location service is enable, false if not
    bool locationServiceEnable = await geolocator.isLocationServiceEnabled();
    // position instace
    Position position;

    // if location service enable get current position
    if (locationServiceEnable) {
      // await current position
      position = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      // if location service is not enable get last known position
    } else {
      // await last known position
      position = await geolocator.getLastKnownPosition(
          desiredAccuracy: LocationAccuracy.best);
    }

    if (position != null) {
      // fetch weather data with position data
      print('Latitdue: ' + position.latitude.toString() + ' longnitude: ' + position.longitude.toString());
      //return Position;
    }
  }
}