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
import 'package:shopping_appl/screens/splash_screen.dart';
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
            value: Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Products>(
            create: (_) => Products(
              '',
              '',
              [],
            ),
            update: (context, auth, previousProducts) => Products(
                auth.token,
                auth.userId,
                previousProducts == null ? [] : previousProducts.items),
          ),
          ChangeNotifierProvider.value(
            //create: (context) => Cart()
            value: Cart(),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
              create: (_) => Orders('', '', []),
              update: (context, auth, previousOrder) => Orders(
                  auth.token,
                  auth.userId,
                  previousOrder == null ? [] : previousOrder.orders))
        ],
        child: Consumer<Auth>(
          builder: (context, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.deepOrange,
              fontFamily: 'Lato',
            ),
            home: auth.isAuth
                ? ProductOverViewScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (context, authResultSnapshot) =>
                        authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? SplashScreen()
                            : AuthScreen()),
            routes: {
              ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
              CartScreen.routeName: (context) => CartScreen(),
              OrdersScreen.routeName: (context) => OrdersScreen(),
              UserProductsScreen.routeName: (context) => UserProductsScreen(),
              EditProductsScreen.routName: (context) => EditProductsScreen(),
            },
          ),
        ));
  }
}
