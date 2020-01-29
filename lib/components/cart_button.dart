import 'package:flutter/material.dart';
import 'package:prent/screens/cart_screen.dart';
Widget shoppingCartIconButton(BuildContext context) {
  return new Padding(
          padding:
          const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 25, left: 10),
          child: new Container(
            height: 150.0,
            width: 30.0,
            child: new GestureDetector(
              onTap: () {
                MaterialPageRoute route =
                MaterialPageRoute(builder: (context) => CartScreen());
                Navigator.push(context, route);
              },
              child: new Stack(
                children: <Widget>[
              Tab(icon: new Image.asset('assets/icons/shopping-bag.png',color: Colors.white,)),
                ],
              ),
            ),
          ),
        );
      ;
}