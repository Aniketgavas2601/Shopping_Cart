import 'package:flutter/material.dart';
import 'package:shopping_appl/providers/products.dart';
import 'package:shopping_appl/screens/edit_products_screen.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(this.id,this.title,this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl),),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(onPressed: (){
              Navigator.of(context).pushNamed(EditProductsScreen.routName, arguments: id);
            }, icon: Icon(Icons.edit),color: Theme.of(context).primaryColor,),
            IconButton(onPressed: (){
              Provider.of<Products>(context,listen: false).deleteProduct(id);
            }, icon: Icon(Icons.delete),color: Theme.of(context).errorColor,)
          ],
        ),
      ),
    );
  }
}