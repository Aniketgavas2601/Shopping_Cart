import 'package:flutter/material.dart';
import 'package:shopping_appl/providers/_auth.dart';
import 'package:shopping_appl/providers/cart.dart';
import 'package:shopping_appl/providers/orders.dart';
import 'package:shopping_appl/screens/auth_screen.dart';
import 'package:shopping_appl/screens/cart_screen.dart';
import 'package:shopping_appl/screens/edit_products_screen.dart';
import 'package:shopping_appl/screens/product_overview_screen.dart';
import 'package:shopping_appl/screens/proudct_detail_screen.dart';
import 'package:shopping_appl/providers/products.dart';
import 'package:provider/provider.dart';
import 'package:shopping_appl/screens/orders_screen.dart';
import 'package:shopping_appl/screens/user_products_screen.dart';

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
            value: Auth()),
        ChangeNotifierProvider(
          create: (context) => Products(),
          //value: Products(),
        ),
        ChangeNotifierProvider(
            create: (context) => Cart()
          //value: Cart(),
        ),
        ChangeNotifierProvider(
            create: (context) => Orders()
                //value: Orders()
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
        home: AuthScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          CartScreen.routeName: (context) => CartScreen(),
          OrdersScreen.routeName: (context) => OrdersScreen(),
          UserProductsScreen.routeName: (context) => UserProductsScreen(),
          EditProductsScreen.routName: (context) => EditProductsScreen(),
        },
      ),
    );
  }
}
