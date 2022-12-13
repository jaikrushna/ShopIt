import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:shop_it/models/HttpRequest.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _token;
  String _userId;
  DateTime _expirydate;
  Timer _autolog;
  bool get auth_value {
    return token != 'null';
  }

  String get token {
    if (_expirydate != null &&
        _expirydate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return 'null';
  }

  String get user_id {
    return _userId;
  }

  Future<void> signup(String email, String password) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyD0gjz5XjciDEjoXhIXnA8S_rpQh_yFfqo');
    try {
      var response = await http.post(url,
          body: jsonEncode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));
      final response_data = jsonDecode(response.body);
      if (response_data['error'] != null) {
        throw HttpException(response_data['error']['message']);
      }
      _token = response_data['idToken'];
      _expirydate = DateTime.now()
          .add(Duration(seconds: int.parse(response_data['expiresIn'])));
      _userId = response_data['localId'];
      notifyListeners();
      final shredpref = await SharedPreferences.getInstance();
      final datainput = json.encode({
        '_token': _token,
        '_userId': _userId,
        '_expirydate': _expirydate.toIso8601String(),
      });
      shredpref.setString('userdata', datainput);
    } catch (error) {
      throw error;
    }
  }

  Future<void> login(String email, String password) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyD0gjz5XjciDEjoXhIXnA8S_rpQh_yFfqo');
    try {
      var response = await http.post(url,
          body: jsonEncode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));
      final response_data = jsonDecode(response.body);
      if (response_data['error'] != null) {
        throw HttpException(response_data['error']['message']);
      }
      _token = response_data['idToken'];
      _expirydate = DateTime.now()
          .add(Duration(seconds: int.parse(response_data['expiresIn'])));
      _userId = response_data['localId'];
      autologout();
      notifyListeners();
      final shredpref = await SharedPreferences.getInstance();
      final datainput = json.encode({
        '_token': _token,
        '_userId': _userId,
        '_expirydate': _expirydate.toIso8601String(),
      });
      shredpref.setString('userdata', datainput);
    } catch (error) {
      throw error;
    }
  }

  Future<bool> autosigin() async {
    final shredpref = await SharedPreferences.getInstance();
    if (!shredpref.containsKey('userdata')) {
      return false;
    }
    final prefdata =
        json.decode(shredpref.getString('userdata')) as Map<String, Object>;
    final expirydate = DateTime.parse(prefdata['_expirydate']);
    if (expirydate.isAfter(DateTime.now())) {
      return false;
    }
    _token = prefdata['_token'];
    _userId = prefdata['_userId'];
    _expirydate = expirydate;
    notifyListeners();
    autologout();
    return true;
  }

  Future<void> logout() async {
    _userId = null;
    _token = null;
    _expirydate = null;
    if (_autolog != null) {
      _autolog.cancel();
      _autolog = null;
    }
    notifyListeners();
    final shredpref = await SharedPreferences.getInstance();
    shredpref.clear();
  }

  void autologout() {
    if (_autolog != null) {
      _autolog.cancel();
    }
    final expirytime = _expirydate.difference(DateTime.now()).inSeconds;
    _autolog = Timer(Duration(seconds: expirytime), logout);
  }
}
