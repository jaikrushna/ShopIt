import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  String id;
  String tle;
  String description;
  double price;
  String image_URL;
  bool isfav;

  Product({
    @required this.id,
    @required this.tle,
    @required this.description,
    @required this.price,
    @required this.image_URL,
    this.isfav = false,
  });
  bool _isfav(bool status) {
    isfav = status;
  }

  Future<void> toogle_fav_status(String token, String user_id) async {
    final oldfav = isfav;
    isfav = !isfav;
    notifyListeners();
    final url = Uri.parse(
        'https://shopit-53507-default-rtdb.firebaseio.com/product/user_fav/$user_id/$id.json?auth=$token');
    try {
      final response = await http.post(
        url,
        body: json.encode(
          isfav,
        ),
      );
      if (response.statusCode >= 400) {
        isfav = oldfav;
        _isfav(oldfav);
        notifyListeners();
      }
      _isfav(isfav);
    } catch (error) {
      isfav = oldfav;
      _isfav(oldfav);
      notifyListeners();
    }
  }
}
