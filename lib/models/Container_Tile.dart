import 'dart:ui';
import 'package:shop_it/Screens/Screen_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_it/Provider/Provider_Product.dart';
import 'product.dart';
import 'package:shop_it/Provider/cart.dart';
import 'package:shop_it/Provider/Auth.dart';

class Product_Item extends StatelessWidget {
  // final String id;
  // final String Image_url;
  // final String tle;
  //
  // Product_Item(this.id, this.Image_url, this.tle);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    final authdata = Provider.of<Auth>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(Screen_Detail.routee, arguments: product.id);
          },
          child: Image.network(
            product.image_URL,
            fit: BoxFit.contain,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black12,
          title: Text(
            product.tle,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          trailing: IconButton(
              onPressed: () {
                cart.addproduct(product.id, product.tle, product.price);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Item Added to Cart!!"),
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(
                      label: "UNDO",
                      textColor: Colors.red,
                      onPressed: () {
                        cart.Remove_single_item(product.id);
                      },
                    ),
                  ),
                );
              },
              icon: Icon(Icons.shopping_cart),
              color: Colors.lightBlueAccent),
          leading: IconButton(
            onPressed: () {
              product.toogle_fav_status(authdata.token, authdata.user_id);
            },
            icon: Icon(product.isfav
                ? Icons.favorite
                : Icons.favorite_border_outlined),
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
