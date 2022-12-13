import 'package:flutter/material.dart';
import 'package:shop_it/Provider/Orders.dart';
import 'package:shop_it/Provider/cart.dart';
import 'package:shop_it/Screens/Authentication_Screen.dart';
import 'Screens/products_view_screen.dart';
import 'package:shop_it/Screens/Screen_detail.dart';
import 'Provider/Provider_Product.dart';
import 'package:provider/provider.dart';
import 'Provider/cart.dart';
import 'package:shop_it/Screens/Cart_screen.dart';
import 'package:shop_it/Screens/Orders_screen.dart';
import 'package:shop_it/Screens/User_Product_Screen.dart';
import 'package:shop_it/Screens/Edit_Screen.dart';
import 'package:shop_it/Provider/Auth.dart';
import 'package:shop_it/Screens/SplashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
        ChangeNotifierProxyProvider<Auth, Products>(
            create: null,
            update: (context, auth, previousProducts) => Products(
                  auth.token,
                  previousProducts == null ? [] : previousProducts.items,
                  auth.user_id,
                )),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProxyProvider<Auth, Orders>(
            create: null,
            update: (context, auth, previousProducts) => Orders(
                  auth.token,
                  auth.user_id,
                  previousProducts == null ? [] : previousProducts.orders,
                )),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth_value, _) => MaterialApp(
          title: 'Shop Pune',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: auth_value.auth_value
              ? products_view_screen()
              : FutureBuilder(
                  future: auth_value.autosigin(),
                  builder: (ctx, signinsnapshot) =>
                      signinsnapshot.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen()),
          routes: {
            Screen_Detail.routee: (ctx) => Screen_Detail(),
            Cart_screen.routee: (ctx) => Cart_screen(),
            Order_screen.routee: (ctx) => Order_screen(),
            User_product_screen.routee: (ctx) => User_product_screen(),
            Edit_User_Input.routee: (ctx) => Edit_User_Input(),
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Center(child: Text('Shop It!!')),
      // ),
      body: products_view_screen(),
    );
  }
}
