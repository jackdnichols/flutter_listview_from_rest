import 'package:flutter/material.dart';
import '../restaurant_menu_arguments.dart';

class RestaurantMenu extends StatelessWidget {

  final RestaurantMenuArguments restaurantMenuArgs;

  RestaurantMenu({
    this.restaurantMenuArgs
  });

  @override
  Widget build(BuildContext context) {
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
                  child: Text('Test Directions'),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/testpage');
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
