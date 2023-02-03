import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_appl/providers/cart.dart';
import 'package:shopping_appl/providers/orders.dart';
import 'package:shopping_appl/widgets/cart_item.dart' as ci;

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmout.toStringAsFixed(2)}',
                      style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .titleMedium!
                              .color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  TextButton(
                      onPressed: () {
                        Provider.of<Orders>(context, listen: false).addOrder(
                            cart.items.values.toList(),
                            cart.totalAmout);
                        cart.clear();
                      },
                      child: Text(
                        'Order Now',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) => ci.CartItem(
                        cart.items.values.toList()[index]!.id,
                        cart.items.keys.toList()[index],
                        cart.items.values.toList()[index]!.price,
                        cart.items.values.toList()[index]!.quantity,
                        cart.items.values.toList()[index]!.title,
                      )))
        ],
      ),
    );
  }
}
