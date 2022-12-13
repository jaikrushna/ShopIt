import 'package:flutter/material.dart';
import 'cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Order_items {
  final double price;
  final String id;
  final List<Cartitem> products;
  final DateTime datetime;
  Order_items(
    @required this.price,
    @required this.id,
    @required this.products,
    @required this.datetime,
  );
}

class Orders with ChangeNotifier {
  List<Order_items> _orders = [];
  String token;
  String user_id;
  Orders(this.token, this.user_id, this._orders);
  List<Order_items> get orders {
    return [..._orders];
  }

  Future<void> getorders() async {
    final url = Uri.parse(
        'https://shopit-53507-default-rtdb.firebaseio.com/orders/$user_id.json?auth=$token');
    final response = await http.get(url);
    final List<Order_items> loaded_prod = [];
    final extracted_prod = json.decode(response.body) as Map<String, dynamic>;
    if (extracted_prod == null) {
      return;
    }
    extracted_prod.forEach((Order_id, Order_prod) {
      loaded_prod.add(Order_items(
          Order_prod['price'],
          Order_id,
          (Order_prod['product'] as List<dynamic>)
              .map((cpr) => Cartitem(
                  id: cpr['id'],
                  tle: cpr['tle'],
                  quantity: cpr['quantity'],
                  price: cpr['price']))
              .toList(),
          DateTime.parse(Order_prod['dateTime'])));
    });
    _orders = loaded_prod.reversed.toList();
    notifyListeners();
  }

  Future<void> additems(
    double price,
    List<Cartitem> product,
  ) async {
    final timestamp = DateTime.now();
    final url = Uri.parse(
        'https://shopit-53507-default-rtdb.firebaseio.com/orders/$user_id.json?auth=$token');
    final response = await http.post(
      url,
      body: json.encode({
        'price': price,
        'dateTime': timestamp.toIso8601String(),
        'product': product
            .map((cp) => {
                  'id': cp.id,
                  'tle': cp.tle,
                  'quantity': cp.quantity,
                  'price': cp.price,
                })
            .toList(),
      }),
    );
    _orders.insert(
        0,
        Order_items(
          price,
          json.decode(response.body)['name'],
          product,
          timestamp,
        ));
    notifyListeners();
  }
}
