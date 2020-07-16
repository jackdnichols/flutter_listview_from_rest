import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_listview_rest/providers/map_latlng_provider.dart';
import 'package:flutter_listview_rest/settings_provider.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const double CAMERA_ZOOM = 13;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;
LatLng SOURCE_LOCATION = LatLng(43.150520,-84.524340);
LatLng DEST_LOCATION = LatLng(43.45979, -83.18197);


class MapDirections extends StatefulWidget {

  final MapLatLngProvider mapRouteLatLngArgs;
  MapDirections({this.mapRouteLatLngArgs}){
    SOURCE_LOCATION = LatLng(mapRouteLatLngArgs.originLatitude, mapRouteLatLngArgs.originLongitude);
    DEST_LOCATION = LatLng(mapRouteLatLngArgs.destinationLatitude, mapRouteLatLngArgs.destinationLongitude);
  }

  @override
  State<StatefulWidget> createState() => MapDirectionsState();
}

class MapDirectionsState extends State<MapDirections> {
  /*
  double originLatitude = mapRouteLatLngArgs.originLatitude;
  static double originLongitude = this.mapRouteLatLngArgs.originLongitude;
  static double destinationLatitude = this.mapRouteLatLngArgs.destinationLatitude;
  static double destinationLongitude = this.mapRouteLatLngArgs.destinationLongitude;
   */

 // static final SOURCE_LOCATION = LatLng(originLatitude, originLongitude);

  Completer<GoogleMapController> _controller = Completer();
  // this set will hold my markers
  Set<Marker> _markers = {};
  // this will hold the generated polylines
  Set<Polyline> _polylines = {};
  // this will hold each polyline coordinate as Lat and Lng pairs
  List<LatLng> polylineCoordinates = [];
  // this is the key object - the PolylinePoints
  // which generates every polyline between start and finish
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPIKey = 'AIzaSyAMrVirJth-x5uKSiXOITExOud-99txpN0';
  // for my custom icons
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;
  @override
  void initState() {
    super.initState();
    setSourceAndDestinationIcons();
  }
  void setSourceAndDestinationIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/driving_pin.png');
    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/destination_map_marker.jpg');
  }

  Future<void> _getCurrentLocation() async {
    // this.restaurantMenuArgs.address + ' ' + this.restaurantMenuArgs.city + ' ' + this.restaurantMenuArgs.state + ' ' + this.restaurantMenuArgs.zipCode
    List<Placemark> placemarkSourceLocation = await Geolocator().placemarkFromAddress("300 Union st. Horton Michigan 49246");
    List<Placemark> placemarkDestinationLocation = await Geolocator().placemarkFromAddress("10371 corning oak park michigan 48237");

    print ('placemarkSourceLocation latitude: ' + placemarkSourceLocation[0].position.latitude.toString());
    print ('placemarkSourceLocation longitude: ' + placemarkSourceLocation[0].position.longitude.toString());

    print ('placemarkDestinationLocation latitude: ' + placemarkDestinationLocation[0].position.latitude.toString());
    print ('placemarkDestinationLocation longitude: ' + placemarkDestinationLocation[0].position.longitude.toString());

    setState(){
      SOURCE_LOCATION = LatLng(placemarkSourceLocation[0].position.latitude, placemarkSourceLocation[0].position.longitude);
      DEST_LOCATION = LatLng(placemarkDestinationLocation[0].position.latitude, placemarkDestinationLocation[0].position.longitude);
    }
  }

  @override
  Widget build(BuildContext context) {

    //final MapLatLngProvider mapLatLngProvider = ModalRoute.of(context).settings.arguments;
    /*
    print('originLatitude: ' + mapLatLngProvider.originLatitude);
    print('originLongitude: ' + mapLatLngProvider.originLongitude);
    print('destinationLatitude: ' + mapLatLngProvider.destinationLatitude);
    print('destinationLongitude: ' + mapLatLngProvider.destinationLongitude);

     */

   // This blows up
  //  var asdf = Provider.of<SettingsProvider>(context);
    //print('This blasted thing finally passed a parameter!' + asdf.originLongitude.toString());

/*
    if (mapRouteLatLngArgs != null) {
      print('originLatitude: ' + mapRouteLatLngArgs.originLatitude.toString());
      print('originLongitude: ' + mapRouteLatLngArgs.originLongitude.toString());
      print('destinationLatitude: ' +
          mapRouteLatLngArgs.destinationLatitude.toString());
      print('destinationLongitude: ' +
          mapRouteLatLngArgs.destinationLongitude.toString());
    }
*/

    CameraPosition initialLocation = CameraPosition(
        zoom: CAMERA_ZOOM,
        bearing: CAMERA_BEARING,
        tilt: CAMERA_TILT,
        target: SOURCE_LOCATION
    );
    return Scaffold(
        appBar: AppBar(
        title: Text('Restaurant Map'),
    ),
    body: Stack(
      children: <Widget>[
        GoogleMap(
            myLocationEnabled: true,
            compassEnabled: true,
            tiltGesturesEnabled: false,
            markers: _markers,
            polylines: _polylines,
            mapType: MapType.normal,
            initialCameraPosition: initialLocation,
            onMapCreated: onMapCreated
        ),
      ]
    ));
  }

  void onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    setMapPins();
    setPolylines();
  }

  void setMapPins() {
    setState(() {
      // source pin
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: SOURCE_LOCATION,
          icon: sourceIcon
      ));
      // destination pin
      _markers.add(Marker(
          markerId: MarkerId('destPin'),
          position: LatLng(DEST_LOCATION.latitude, DEST_LOCATION.longitude), //DEST_LOCATION,
          icon: destinationIcon
      ));
    });
  }
  setPolylines() async {
    List<PointLatLng> result = await
    polylinePoints?.getRouteBetweenCoordinates(
        googleAPIKey,
        SOURCE_LOCATION.latitude,
        SOURCE_LOCATION.longitude,
        DEST_LOCATION.latitude,
        DEST_LOCATION.longitude);
    if(result.isNotEmpty){
      // loop through all PointLatLng points and convert them
      // to a list of LatLng, required by the Polyline
      result.forEach((PointLatLng point){
        polylineCoordinates.add(
            LatLng(point.latitude, point.longitude));
      });
    }
    setState(() {
      // create a Polyline instance
      // with an id, an RGB color and the list of LatLng pairs
      Polyline polyline = Polyline(
          polylineId: PolylineId("poly"),
          color: Color.fromARGB(255, 40, 122, 198),
          points: polylineCoordinates
      );

      // add the constructed polyline as a set of points
      // to the polyline set, which will eventually
      // end up showing up on the map
      _polylines.add(polyline);
    });
  }
}