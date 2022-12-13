import 'package:flutter/foundation.dart';
import 'package:shop_it/models/Container_Tile.dart';

class Cartitem {
  String id;
  String tle;
  int quantity;
  double price;

  Cartitem({
    @required this.id,
    @required this.tle,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, Cartitem> _items = {};
  Map<String, Cartitem> get items {
    return {..._items};
  }

  double get Total_price {
    double Total_cost = 0.0;
    _items.forEach((key, cartItem) {
      Total_cost += cartItem.price * cartItem.quantity;
    });
    return Total_cost;
  }

  int get count_of_products {
    return _items.length;
  }

  void addproduct(String Product_id, String title, double price) {
    if (_items.containsKey(Product_id)) {
      _items.update(
        Product_id,
        (existing_key) => Cartitem(
            id: existing_key.id,
            tle: existing_key.tle,
            quantity: existing_key.quantity + 1,
            price: existing_key.price),
      );
    } else {
      _items.putIfAbsent(
          Product_id,
          () => Cartitem(
              id: DateTime.now().toString(),
              tle: title,
              quantity: 1,
              price: price));
    }
    notifyListeners();
  }

  void Remove_single_item(String product_id) {
    if (!_items.containsKey(product_id)) {
      return;
    }
    if (_items[product_id].quantity > 1) {
      _items.update(
        product_id,
        (existingCartItem) => Cartitem(
            id: existingCartItem.id,
            tle: existingCartItem.tle,
            quantity: existingCartItem.quantity - 1,
            price: existingCartItem.price),
      );
    } else {
      _items.remove(product_id);
    }
    notifyListeners();
  }

  void remove_item(product_id) {
    _items.remove(product_id);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
