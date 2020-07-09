import 'package:flutter/material.dart';
import '../ScreenArguments.dart';

class RestaurantMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    return MaterialApp(
      title: 'Restautant Portal',
      routes: <String, WidgetBuilder>{
        '/restaurantmenu' : (context) => new RestaurantMenu(),
      },
      home: Scaffold(
        appBar: AppBar(
          title: Text('Restaurant - ' + args.restaurantName),
        ),
        body: ListView(
          children: <Widget>[
             Column(
              children: <Widget>[
                Image.network(
                  args.restaurantImageURL,
                  fit: BoxFit.fitWidth,

                ),
                //Text('Restaurant Id ' + args.restautantId.toString()),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      args.address + ' ' + args.city + ' ' + args.state + ' ' + args.zipCode,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                RaisedButton(
                  child: Text("Back"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
