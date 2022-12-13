import 'package:flutter/material.dart';
import 'package:shop_it/models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shop_it/models/HttpRequest.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
        id: 'I1',
        tle: 'Bluey',
        description: 'Ocean blue summer shirt',
        price: 499,
        image_URL:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5So3iW2baNz_H27yYQK2TEzxpZGCH4ceK2A&usqp=CAU'),
    Product(
        id: 'I2',
        tle: 'Flowery',
        description: 'Beach shirt for men',
        price: 799,
        image_URL:
            'https://5.imimg.com/data5/SELLER/Default/2021/1/DX/BF/MF/22863510/ap0044-500x500.jpg'),
  ];
  String auth_token;
  String user_id;
  Products(this.auth_token, this._items, this.user_id);
  // bool showFavonly = false;
  List<Product> get items {
    return [..._items];
  }

  List<Product> get itemsfav {
    return _items.where((prodItem) => prodItem.isfav).toList();
  }

  // void favselected() {
  //   showFavonly = true;
  //   notifyListeners();
  // }
  //
  // void selectedall() {
  //   showFavonly = false;
  //   notifyListeners();
  // }

  Product findbyid(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> showproducts([Showfilterstatus = false]) async {
    var urlshort =
        Showfilterstatus ? 'orderBy=$user_id & equalTo=$user_id' : '';
    var url = Uri.parse(
        'https://shopit-53507-default-rtdb.firebaseio.com/product.json?auth=$auth_token & $urlshort');
    try {
      var response = await http.get(url);
      var extractdata = json.decode(response.body) as Map<String, dynamic>;
      if (extractdata == null) {
        return null;
      }
      var url2 = Uri.parse(
          'https://shopit-53507-default-rtdb.firebaseio.com/product/user_fav/$user_id.json?auth=$auth_token');
      var fav_response = await http.get(url2);
      var extractdata2 = json.decode(fav_response.body);
      final List<Product> _productstoload = [];
      extractdata.forEach((prodid, prodvalue) {
        _productstoload.add(Product(
          id: prodid,
          tle: prodvalue['tle'],
          description: prodvalue['description'],
          price: prodvalue['price'],
          isfav: extractdata2 == null ? false : extractdata2[user_id] ?? false,
          image_URL: prodvalue['image_URL'],
        ));
      });
      _items = _productstoload;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addproduct(Product product) async {
    var url = Uri.parse(
        'https://shopit-53507-default-rtdb.firebaseio.com/product.json?auth=$auth_token');
    try {
      var response = await http.post(
        url,
        body: json.encode({
          'tle': product.tle,
          'price': product.price,
          'description': product.description,
          'image_URL': product.image_URL,
          'creator_id': product.id,
        }),
      );
      final newproduct = Product(
        id: json.decode(response.body)['name'],
        tle: product.tle,
        price: product.price,
        description: product.description,
        image_URL: product.image_URL,
      );
      _items.add(newproduct);
      notifyListeners();
    } catch (Error) {
      throw (Error);
    }
  }

  Future<void> editproduct(Product editproduct, String id) async {
    final editid = _items.indexWhere((prod) => prod.id == id);
    if (editid >= 0) {
      final url = Uri.parse(
          'https://shopit-53507-default-rtdb.firebaseio.com/product/$id.jsonauth=$auth_token');
      await http.patch(url,
          body: json.encode({
            'tle': editproduct.tle,
            'price': editproduct.price,
            'description': editproduct.description,
            'image_URL': editproduct.image_URL,
          }));
      _items[editid] = editproduct;
      notifyListeners();
    } else {
      print(".....");
    }
  }

  Future<void> Deleteprod(String id) async {
    final url = Uri.parse(
        'https://shopit-53507-default-rtdb.firebaseio.com/product/$id.jsonauth=$auth_token');
    final _prodindex = _items.indexWhere((prod) => prod.id == id);
    var _prodindexitem = _items[_prodindex];
    var response = await http.delete(url);
    _items.removeAt(_prodindex);
    notifyListeners();
    if (response.statusCode >= 400) {
      _items.insert(_prodindex, _prodindexitem);
      notifyListeners();
      throw HttpRequest('Could not delete product');
    }
    _prodindexitem = null;
  }
}
