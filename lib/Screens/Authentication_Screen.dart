import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_it/Provider/Auth.dart';
import 'package:shop_it/Provider/Constants.dart';
import 'package:shop_it/models/Padding_Buttong.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(1, 159, 255, 1).withOpacity(0.5),
                  Color.fromRGBO(1, 255, 159, 1).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Image.asset('assests/images/spa.png'),
                    padding: EdgeInsets.fromLTRB(64, 24, 24, 24),

                  ),
                  // Flexible(
                  //   child: Container(
                  //     margin: EdgeInsets.only(bottom: 20.0),
                  //     padding:
                  //         EdgeInsets.symmetric(vertical: 8.0, horizontal: 94.0),
                  //     transform: Matrix4.rotationZ(-8 * pi / 180)
                  //       ..translate(-10.0),
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(20),
                  //       color: Colors.deepOrange.shade900,
                  //       boxShadow: [
                  //         BoxShadow(
                  //           blurRadius: 8,
                  //           color: Colors.black26,
                  //           offset: Offset(0, 2),
                  //         )
                  //       ],
                  //     ),
                  //     child: Text(
                  //       'ShopIT',
                  //       style: TextStyle(
                  //         color: Theme.of(context).accentColor,
                  //         fontSize: 50,
                  //         fontWeight: FontWeight.normal,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    // ignore: prefer_const_constructors
    Key key,

    ///
  }) : super(key: key);
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  bool _isloading = false;
  final _passwordController = TextEditingController();
  void signinerror(String error_message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('Authentication Failed!'),
              content: Text(error_message),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text('Okay'))
              ],
            ));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    setState(() {
      _isloading = true;
    });
    try {
      final shredpref = await SharedPreferences.getInstance();
      shredpref.setBool("isLogin", true);
      shredpref.setString("email", _authData['email']);
      if (_authMode == AuthMode.Login) {
        await Provider.of<Auth>(context, listen: false)
            .login(_authData['email'], _authData['password']);
      } else {
        await Provider.of<Auth>(context, listen: false)
            .signup(_authData['email'], _authData['password']);
      }
    } on HttpException catch (error) {
      var error_message = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        error_message = 'Email already exits';
      }
      if (error.toString().contains('INVALID_EMAIL')) {
        error_message = 'Invalid email';
      }
      if (error.toString().contains('WEAK_PASSWORD')) {
        error_message = 'PAssword is weak, Enter another';
      }
      if (error.toString().contains('EMAIL_NOT_FOUND')) {
        error_message = 'Email not found!!';
      }
      if (error.toString().contains('INVALID_PASSSWORD')) {
        error_message = 'Password incorrect!!';
      }
      signinerror(error_message);
    } catch (error) {
      var error_message = 'Authentication failed something went wrong';
      signinerror(error_message);
    }

    setState(() {
      _isloading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 12.0,
      margin: EdgeInsets.only(bottom: 80.0),
      child: Expanded(
        child: Container(
          height: _authMode == AuthMode.Signup ? 350 : 280,
          constraints: BoxConstraints(
              minHeight: _authMode == AuthMode.Signup ? 320 : 260),
          width: deviceSize.width * 0.75,
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: kInputDecormail.copyWith(hintText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Invalid email';
                    }
                  },
                  onSaved: (value) {
                    _authData['email'] = value;
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  decoration: kInputDecormail.copyWith(hintText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                  },
                    onSaved: (value) {
                      _authData['password'] = value;
                    },
                ),
                // TextFormField(
                //   decoration: InputDecoration(labelText: 'Password'),
                //   obscureText: true,
                //   controller: _passwordController,
                //   validator: (value) {
                //     if (value.isEmpty || value.length < 5) {
                //       return 'Password is too short!';
                //     }
                //   },
                //   onSaved: (value) {
                //     _authData['password'] = value;
                //   },
                // ),
                SizedBox(
                  height: 5,
                ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration: kInputDecormail.copyWith(hintText: 'Confirm Password'),
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    validator: _authMode == AuthMode.Signup
                          ? (value) {
                          if (value != _passwordController.text) {
                                  return 'Pasword do not match!';
                          }
                          }
                    : null,
                    onSaved: (value) {
                      _authData['password'] = value;
                    },
                  ),
                  // TextFormField(
                  //   enabled: _authMode == AuthMode.Signup,
                  //   decoration: InputDecoration(labelText: 'Confirm Password'),
                  //   obscureText: true,
                  //   validator: _authMode == AuthMode.Signup
                  //       ? (value) {
                  //           if (value != _passwordController.text) {
                  //             return 'Pasword do not match!';
                  //           }
                  //         }
                  //       : null,
                  // ),
                SizedBox(
                  height: 10,
                ),
                if (_isloading)
                  CircularProgressIndicator()
                else
                  padding_button(
                    Title: _authMode == AuthMode.Login ? 'LOGIN' : 'SIGNUP',
                    OnPressed: _submit,
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(30),
                    // ),
                    // padding:
                    //     EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                    colour: Theme.of(context).primaryColor,
                  ),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).primaryColor),
                  ),
                  onPressed: _switchAuthMode,
                  // padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4)
                  // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  child: Text(
                      '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'}'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
