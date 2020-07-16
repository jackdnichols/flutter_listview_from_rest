import 'package:flutter/material.dart';
import 'package:flutter_listview_rest/providers/map_latlng_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../providers/restaurant_menu_provider.dart';
import 'package:flutter_listview_rest/settings_provider.dart';

class RestaurantMenu extends StatelessWidget {

  final RestaurantMenuProvider restaurantMenuArgs;
  RestaurantMenu({this.restaurantMenuArgs});
  MapLatLngProvider _originDestinationLatLng;


  void getDestinationLatLng() async {
    final MapLatLngProvider originDestinationLatLng = await getOriginDestination();
    _originDestinationLatLng = originDestinationLatLng;
  }

  @override
  Widget build(BuildContext context) {
    getDestinationLatLng();

    /*
    if (_originDestinationLatLng == null){
        _originDestinationLatLng = MapLatLngProvider(
            42.150520,    // originLongitude
            -84.524340,   // originLongitude
            42.458530,    // destinationLatitude
            -83.167760     // destinationLongitude
        );
    }
    */
    
    return Scaffold(
        appBar: AppBar(
          title: Text('Restaurant - ' + restaurantMenuArgs.restaurantName),
        ),
        body: ListView(
          children: <Widget>[
             Column(
              children: <Widget>[
                Image.network(
                  restaurantMenuArgs.restaurantImageURL,
                  fit: BoxFit.fitWidth,

                ),
                //Text('Restaurant Id ' + args.restautantId.toString()),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      restaurantMenuArgs.address + ' ' + restaurantMenuArgs.city + ' ' + restaurantMenuArgs.state + ' ' + restaurantMenuArgs.zipCode,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                RaisedButton(
                  child: Text("Map"),
                  onPressed: () {
                    //Navigator.of(context).pop();
                    Navigator.of(context).pushNamed('/googlemap');
                  },
                ),
                RaisedButton(
                  child: Text('Map Directions'),
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      '/mapdirections',
                      arguments: _originDestinationLatLng,
                    );
                  },
                ),
                RaisedButton(
                  child: Text('More Directions'),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/mapanddirections');
                  },
                ),
              ],
            )
          ],
        ),
    );
  }

  MapLatLngProvider getMapLatLng()
  {
    /*
    List<Placemark> placemarkSourceLocation =
        await Geolocator().placemarkFromAddress(
              restaurantMenuArgs.address + ' ' +
              restaurantMenuArgs.city + ' ' +
              restaurantMenuArgs.state + ' ' +
              restaurantMenuArgs.zipCode);
*/
  // var placemarkDestinationLocation =  getDestinationLatLngFromAddress();

    return MapLatLngProvider(
        42.150520,    // originLongitude
        -84.524340,   // originLongitude
        42.458530,    // destinationLatitude
        -83.167760     // destinationLongitude
    );
  }

  Future<MapLatLngProvider> getOriginDestination() async
  {
    List<Placemark> placemarkDestinationLocation =
      await Geolocator().placemarkFromAddress(
        restaurantMenuArgs.address + ' ' +
        restaurantMenuArgs.city + ' ' +
        restaurantMenuArgs.state + ' ' +
        restaurantMenuArgs.zipCode);

    LatLng originLatLng = new LatLng(42.150520, -84.524340);
    LatLng destinationLatLng =
      new LatLng(
          placemarkDestinationLocation[0].position.latitude,
          placemarkDestinationLocation[0].position.longitude);

    MapLatLngProvider mapLatLngProvider = new MapLatLngProvider(
        originLatLng.latitude,
        originLatLng.longitude,
        destinationLatLng.latitude,
        destinationLatLng.longitude,
    );
    return mapLatLngProvider;
  }

  /*
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

   */
}
