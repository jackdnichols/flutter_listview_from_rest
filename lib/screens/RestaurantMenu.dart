import 'package:flutter/material.dart';
import '../ScreenArguments.dart';

class RestaurantMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    return MaterialApp(
      title: 'Job Portal',
      routes: <String, WidgetBuilder>{
        '/restaurantmenu' : (context) => new RestaurantMenu(),
      },
      home: Scaffold(
        appBar: AppBar(
          title: Text(args.restaurantName),
        ),
        body: Container(

          //child: Center(
            child: Card(
                child: Column(
                  children: <Widget>[
                    Image.network(
                      args.restaurantImageURL,
                      fit: BoxFit.fitWidth,
                      
                    ),
                    Text('Restaurant Id ' + args.restautantId.toString()),
                    // Text('Restaurant Id $restaurantId'),
                    FlatButton(
                      child: Text("Press Me"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                )
            ),
          //),
        ),
      ),
    );



  }
}
