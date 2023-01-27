import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_appl/providers/cart.dart';
import 'package:shopping_appl/providers/products.dart';
import 'package:shopping_appl/screens/cart_screen.dart';
import 'package:shopping_appl/widgets/products_grid.dart';
import 'package:shopping_appl/widgets/badge.dart';

enum FilterOptions { Favorites, All }

class ProductOverViewScreen extends StatefulWidget {
  @override
  State<ProductOverViewScreen> createState() => _ProductOverViewScreenState();
}

class _ProductOverViewScreenState extends State<ProductOverViewScreen> {
  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    //final productContainer = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<Cart>(
              builder: (context, cart, ch) => Badge(
                  value: cart.itemCount.toString(),
                  child: ch!,
              ),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                }, icon: Icon(Icons.shopping_cart)),
          )
        ],
      ),
      body: ProductsGrid(_showOnlyFavorites),
    );
  }
}
