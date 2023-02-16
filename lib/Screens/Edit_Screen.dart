import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_it/Provider/Provider_Product.dart';
import 'package:shop_it/models/product.dart';
import 'package:provider/provider.dart';

class Edit_User_Input extends StatefulWidget {
  static const routee = '/Editee';
  @override
  _Edit_User_InputState createState() => _Edit_User_InputState();
}

class _Edit_User_InputState extends State<Edit_User_Input> {
  final _primefocus = FocusNode();
  final _primefocus2 = FocusNode();
  final _primefocus3 = FocusNode();
  final _URLcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  var _newproduct =
      Product(id: null, tle: '', description: '', price: 0.0, image_URL: '');
  @override
  void initState() {
    _primefocus3.addListener(_ChangeURLFocus);
    super.initState();
  }

  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'image_URL': '',
  };

  var _isintistate = true;
  var _isloading = false;
  @override
  void didChangeDependencies() {
    if (_isintistate) {
      final editid = ModalRoute.of(context).settings.arguments as String;
      if (editid != null) {
        _newproduct =
            Provider.of<Products>(context, listen: false).findbyid(editid);

        _initValues = {
          'title': _newproduct.tle,
          'description': _newproduct.description,
          'price': _newproduct.price.toString(),
          'image_URL': '',
        };
        _URLcontroller.text = _newproduct.image_URL;
      }
    }

    _isintistate = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _primefocus3.removeListener(_ChangeURLFocus);
    _primefocus3.dispose();
    _URLcontroller.dispose();
    _primefocus.dispose();
    _primefocus2.dispose();
    super.dispose();
  }

  void _ChangeURLFocus() {
    if (!_primefocus3.hasFocus) {
      if ((!_URLcontroller.text.startsWith("http") &&
              !_URLcontroller.text.startsWith("https")) ||
          (!_URLcontroller.text.endsWith(".png") &&
              !_URLcontroller.text.endsWith(".jpg") &&
              !_URLcontroller.text.endsWith(".jpeg"))) {
        return;
      }
      setState(() {});
    }
  }

  Future<void> _Saveform() async {
    final IsValid = _formkey.currentState.validate();
    if (!IsValid) {
      return;
    }
    _formkey.currentState.save();
    setState(() {
      _isloading = true;
    });
    if (_newproduct.id != null) {
      await Provider.of<Products>(context, listen: false)
          .editproduct(_newproduct, _newproduct.id);
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addproduct(_newproduct);
      } catch (error) {
        await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text("An error occured!"),
                  content: Text("Something went wrong"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Text("Okay"),
                    ),
                  ],
                ));
      }
    }

    setState(() {
      _isloading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
        actions: [
          IconButton(
            onPressed: _Saveform,
            icon: Icon(Icons.save_rounded),
          ),
        ],
      ),
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formkey,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _initValues['title'],
                      decoration: InputDecoration(labelText: "Title"),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_primefocus);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter a Title";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _newproduct = Product(
                            id: _newproduct.id,
                            isfav: _newproduct.isfav,
                            tle: value,
                            description: _newproduct.description,
                            price: _newproduct.price,
                            image_URL: _newproduct.image_URL);
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['price'],
                      decoration: InputDecoration(labelText: "Price"),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _primefocus2,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_primefocus2);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please Enter a Price";
                        }
                        if (double.tryParse(value) == null) {
                          return "Please Enter a valid Price";
                        }
                        if (double.parse(value) < 0) {
                          return "Please Enter a real value";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _newproduct = Product(
                            id: _newproduct.id,
                            isfav: _newproduct.isfav,
                            tle: _newproduct.tle,
                            description: _newproduct.description,
                            price: double.parse(value),
                            image_URL: _newproduct.image_URL);
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['description'],
                      decoration: InputDecoration(labelText: "Description"),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: _primefocus2,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please Enter a Description";
                        }
                        if (value.length < 10) {
                          return "Please Enter more description";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _newproduct = Product(
                            id: _newproduct.id,
                            isfav: _newproduct.isfav,
                            tle: _newproduct.tle,
                            description: value,
                            price: _newproduct.price,
                            image_URL: _newproduct.image_URL);
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          margin: EdgeInsets.only(top: 8, right: 10),
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Colors.blueGrey,
                            width: 1.0,
                          )),
                          child: Container(
                            child: _URLcontroller.text.isEmpty
                                ? Text("Input URL")
                                : FittedBox(
                                    child: Image.network(_URLcontroller.text),
                                    fit: BoxFit.fitWidth,
                                  ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: "ImageURL"),
                            keyboardType: TextInputType.url,
                            focusNode: _primefocus3,
                            textInputAction: TextInputAction.done,
                            controller: _URLcontroller,
                            onFieldSubmitted: (_) {
                              _Saveform();
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please Enter a ImageURL";
                              }
                              if (!value.startsWith("http") &&
                                  !value.startsWith("https")) {
                                return "Please Enter a valid URL";
                              }
                              if (!value.endsWith(".png") &&
                                  !value.endsWith(".jpg") &&
                                  !value.endsWith(".jpeg")) {
                                return "Please Enter a valid Image URL";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _newproduct = Product(
                                  id: _newproduct.id,
                                  isfav: _newproduct.isfav,
                                  tle: _newproduct.tle,
                                  description: _newproduct.description,
                                  price: _newproduct.price,
                                  image_URL: value);
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
