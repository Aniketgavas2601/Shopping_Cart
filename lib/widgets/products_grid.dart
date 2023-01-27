import 'package:flutter/material.dart';
import 'package:shopping_appl/providers/products.dart';
import 'package:shopping_appl/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {

  final bool showFavs;

  ProductsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showFavs ? productsData.favoriteItems : productsData.items;
    return GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 3 / 2),
        itemCount: products.length,
        itemBuilder: (context, index) => ChangeNotifierProvider.value(
          value: products[index],
          //create: (context) => products[index],
          child: ProductItem(
              // products[index].id,
              // products[index].title,
              // products[index].imageUrl
          ),));
  }
}