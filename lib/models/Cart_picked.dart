import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_it/Provider/cart.dart';

class Cart_Picked extends StatelessWidget {
  final double Price;
  final String product_key;
  final int quantity;
  final String id;
  final String title;
  Cart_Picked(
    @required this.id,
    @required this.product_key,
    @required this.quantity,
    @required this.title,
    @required this.Price,
  );
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete_sweep,
          color: Colors.white70,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(15.0),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(
              "Are you Sure?",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text("Do you want to remove the whole item from cart..."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
                child: Text(
                  "NO",
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
                child: Text(
                  "YES",
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).remove_item(product_key);
      },
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0))),
        margin: EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 4.0,
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: ListTile(
            leading: Padding(
              padding: const EdgeInsets.all(2.0),
              child: FittedBox(
                  child: Chip(
                label: Text("\$${Price}"),
                backgroundColor: Theme.of(context).primaryColor,
              )),
            ),
            title: Text(title),
            subtitle: Text("Total: \$${Price * quantity}"),
            trailing: Text("${quantity}x"),
          ),
        ),
      ),
    );
  }
}
