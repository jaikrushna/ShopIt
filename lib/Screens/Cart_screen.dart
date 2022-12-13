import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_it/Provider/Orders.dart';
import 'package:shop_it/Provider/cart.dart';
import 'package:shop_it/models/Cart_picked.dart';

class Cart_screen extends StatelessWidget {
  static const routee = '/cartscreen';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(10.0),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(children: [
                Text(
                  "Total",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                Spacer(),
                Chip(
                  label: Text(
                    "\$${cart.Total_price.toStringAsFixed(2)}",
                    style: TextStyle(
                        color: Theme.of(context)
                            .primaryTextTheme
                            .titleMedium
                            .color),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                SizedBox(
                  width: 20.0,
                ),
                Order_button(cart: cart)
              ]),
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, i) => Cart_Picked(
                cart.items.values.toList()[i].id,
                cart.items.keys.toList()[i],
                cart.items.values.toList()[i].quantity,
                cart.items.values.toList()[i].tle,
                cart.items.values.toList()[i].price),
            itemCount: cart.items.length,
          ))
        ],
      ),
    );
  }
}

class Order_button extends StatefulWidget {
  const Order_button({
    Key key,
    @required this.cart,
    @required bool isloading,
  })  : _isloading = isloading,
        super(key: key);

  final Cart cart;
  final bool _isloading;

  @override
  State<Order_button> createState() => _Order_buttonState();
}

class _Order_buttonState extends State<Order_button> {
  var _isloading = false;
  var _icon = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: _isloading
          ? CircularProgressIndicator()
          : Text("Order NOW",
              style: (_icon)
                  ? TextStyle(
                      color: Colors.black,
                    )
                  : TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold)),
      onPressed: (widget.cart.Total_price <= 0 || _isloading)
          ? null
          : () async {
              setState(() {
                _isloading = true;
                _icon = true;
              });
              await Provider.of<Orders>(context, listen: false).additems(
                widget.cart.Total_price,
                widget.cart.items.values.toList(),
              );
              setState(() {
                _isloading = false;
              });
              widget.cart.clear();
            },
    );
  }
}
