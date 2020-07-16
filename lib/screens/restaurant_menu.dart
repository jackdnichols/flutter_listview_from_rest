import 'package:flutter/material.dart';
import 'package:flutter_listview_rest/providers/map_latlng_provider.dart';
import '../providers/restaurant_menu_provider.dart';
import 'package:flutter_listview_rest/settings_provider.dart';

class RestaurantMenu extends StatelessWidget {

  final RestaurantMenuProvider restaurantMenuArgs;
  RestaurantMenu({this.restaurantMenuArgs});

  //MapLatLngProvider mapRouteLatLng;

  @override
  Widget build(BuildContext context) {

    //SettingsProvider settingsProvider = new SettingsProvider();
    //settingsProvider.setOriginLatitude(123.46);

    //var settingsProvider = Provider.of<SettingsProvider>(context);
    //final ScreenArguments args = ModalRoute.of(context).settings.arguments;

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
                      arguments: MapLatLngProvider(
                          42.150520,    // originLongitude
                          -84.524340,   // originLongitude
                          42.458530,    // destinationLatitude
                          -83.167760     // destinationLongitude
                      ),
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
}
