import 'package:flutter/material.dart';
import 'package:shop_it/Provider/Auth.dart';
import 'package:shop_it/Provider/Orders.dart';
import 'package:shop_it/Screens/Orders_screen.dart';
import 'package:shop_it/Screens/User_Product_Screen.dart';
import 'package:provider/provider.dart';

class App_Drawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('ShopIT'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          TextButton(
            child: ListTile(
              title: Text("SHOP"),
              trailing: Icon(
                Icons.shop,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          TextButton(
            child: ListTile(
              title: Text("Orders"),
              trailing: Icon(
                Icons.shopping_bag,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(Order_screen.routee);
            },
          ),
          Divider(),
          TextButton(
            child: ListTile(
              title: Text("User Products"),
              trailing: Icon(
                Icons.edit_rounded,
              ),
            ),
            onPressed: () {
              Navigator.of(context)
                  .pushReplacementNamed(User_product_screen.routee);
            },
          ),
          Divider(),
          TextButton(
            child: ListTile(
              title: Text("Log Out"),
              trailing: Icon(
                Icons.logout,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              // Navigator.pushReplacementNamed('/');
              Provider.of<Auth>(context, listen: false).logout();
              // Navigator.of(context)
              //     .pushReplacementNamed(User_product_screen.routee);
            },
          ),
        ],
      ),
    );
  }
}
