import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_it/Provider/Orders.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class Order_Tile extends StatefulWidget {
  final Order_items order;
  Order_Tile(
    @required this.order,
  );

  @override
  State<Order_Tile> createState() => _Order_TileState();
}

class _Order_TileState extends State<Order_Tile> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
      margin: EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 4.0,
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              title: Text(
                "\$${widget.order.price}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                  DateFormat("dd/mm/yyyy hh:mm").format(widget.order.datetime)),
              trailing: IconButton(
                icon: Icon(
                  _expanded
                      ? Icons.expand_less_rounded
                      : Icons.expand_more_rounded,
                ),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
            ),
            if (_expanded)
              Container(
                height: min(widget.order.products.length * 20.0 + 10, 180.0),
                child: ListView(
                    /*ikde Listview.builder nahi karan aplyala mahit ahe jast list nastil kami astil*/
                    children: widget.order.products
                        .map(
                          (prod) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                prod.tle,
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              Text(
                                "${prod.quantity} X \$${prod.price}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.lightGreen,
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList()),
              ),
          ],
        ),
      ),
    );
  }
}
