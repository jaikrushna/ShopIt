import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_it/Provider/Orders.dart';
import 'package:shop_it/Provider/cart.dart';
import 'package:shop_it/Screens/App_Drawer.dart';
import 'package:shop_it/models/Order_tile.dart';
import 'package:shop_it/Screens/App_Drawer.dart';

class Order_screen extends StatefulWidget {
  static const routee = '/Orderss';

  @override
  State<Order_screen> createState() => _Order_screenState();
}

class _Order_screenState extends State<Order_screen> {
  var _isloading = false;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isloading = true;
      });
      await Provider.of<Orders>(context, listen: false).getorders();
      setState(() {
        _isloading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderproduct = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Your Orders")),
      ),
      drawer: App_Drawer(),
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (context, i) => Order_Tile(orderproduct.orders[i]),
              itemCount: orderproduct.orders.length,
            ),
    );
  }
}
