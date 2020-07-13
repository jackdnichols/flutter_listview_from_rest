import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());
Completer<GoogleMapController> _controller = Completer();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurant Map"),
      ),
      body: Stack(
        children: <Widget>[_googleMaps(context)],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToNextLocation,
        label: Text('To the Next Location'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }
}

Widget _googleMaps(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    child: GoogleMap(
      mapType: MapType.terrain,
      initialCameraPosition:
      CameraPosition(target: LatLng(15.841461, 74.512202), zoom: 18),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      markers: {belgaum},
    ),
  );
}

Marker belgaum = Marker(
  markerId: MarkerId("Belgaum"),
  position: LatLng(15.841461, 74.512202),
  infoWindow: InfoWindow(title: "Belgaum"),
  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
);

Future<void> _goToNextLocation() async {
  final GoogleMapController controller = await _controller.future;
  var currentLocation = await Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

  controller.animateCamera(
    CameraUpdate.newCameraPosition(
      CameraPosition(
          target: LatLng(37.43296265331129, -122.08832357078792),
          zoom: 19.151926040649414,
          tilt: 59.440717697143555,
          bearing: 192.8334901395799),
    ),
  );
}