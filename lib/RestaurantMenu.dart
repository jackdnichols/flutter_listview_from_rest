import 'package:flutter/material.dart';
import 'RestaurantList.dart';

class RestaurantMenu extends StatelessWidget {

  //final int restaurantId;

  //RestaurantMenu();

  @override
  Widget build(BuildContext context) {

    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    return Card(
        child: Column(
          children: <Widget>[
            Text('Restaurant Id ' + args.restautantId.toString()),
            // Text('Restaurant Id $restaurantId'),
            FlatButton(
              child: Text("Press Me"),
              onPressed: () {
                Navigator.of(context).pop();

                //Navigator.of(context).pushNamed('/restaurantlist');
                //Navigator.pop(context);
              },
            ),
          ],
        )
    );
  }
}
