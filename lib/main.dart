import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cartmodel.dart';
import 'home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shopping Cart',
        home: HomePage(),
      ),
    );
  }
}
