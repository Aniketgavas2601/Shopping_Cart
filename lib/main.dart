import 'package:flutter/material.dart';
import 'package:shopping_appl/providers/cart.dart';
import 'package:shopping_appl/screens/cart_screen.dart';
import 'package:shopping_appl/screens/product_overview_screen.dart';
import 'package:shopping_appl/screens/proudct_detail_screen.dart';
import 'package:shopping_appl/providers/products.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          //create: (context) => Products(),
          value: Products(),
        ),
        ChangeNotifierProvider.value(
            //create: (context) => Cart()
          value: Cart(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: ProductOverViewScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          CartScreen.routeName: (context) => CartScreen()
        },
      ),
    );
  }
}
