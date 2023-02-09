import 'dart:core';
import 'package:flutter/material.dart';
import 'package:shop_it/Screens/App_Drawer.dart';
import 'package:shop_it/Screens/badge.dart';
import 'GridView.dart';
import 'package:provider/provider.dart';
import 'package:shop_it/Provider/Provider_Product.dart';
import 'package:shop_it/Provider/cart.dart';
import 'package:flutter/foundation.dart';
import 'package:shop_it/Screens/Cart_screen.dart';
import 'package:shop_it/models/product.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

enum Filter_options {
  fav_selected,
  select_all,
}

class products_view_screen extends StatefulWidget {
  @override
  State<products_view_screen> createState() => _products_view_screenState();
}

class _products_view_screenState extends State<products_view_screen> {
  bool _showfavonly = false;
  bool _initstate = true;
  bool _isload = false;
  @override
  void didChangeDependencies() {
    if (_initstate) {
      setState(() {
        _isload = true;
      });
      Provider.of<Products>(context).showproducts().then(
            (_) => setState(() {
              _isload = false;
            }),
          );
    }
    _initstate = false;
    super.didChangeDependencies();
  }

  // int _current = 0;
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    final productContainer = Provider.of<Products>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    // final List<String> _Slider_Images = [
    //   'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/fashion-sale-%7C-mens-clothing-sale-flyer-ad-design-template-b5062165e25ec65eb672d05ef5ff5225_screen.jpg?ts=1606886779',
    //   'https://newspaperads.ads2publish.com/wp-content/uploads/2019/06/lifestyle-clothing-preview-sale-upto-50-off-ad-delhi-times-15-06-2019.png',
    //   'https://st4.depositphotos.com/11292408/23294/i/1600/depositphotos_232949278-stock-photo-sales-promotion-fashion-clothes-retail.jpg',
    //   'https://www.postcardmania.com/wp-content/uploads/blog/img/retail-postcard-example-750x530.jpg',
    // ];
    // final List<Widget> imageSliders = _Slider_Images.map((item) => Container(
    //   child: Container(
    //     margin: EdgeInsets.all(5.0),
    //     child: ClipRRect(
    //         borderRadius: BorderRadius.all(Radius.circular(5.0)),
    //         child: Stack(
    //           children: <Widget>[
    //             Image.network(item, fit: BoxFit.cover, width: 1000.0),
    //             Positioned(
    //               bottom: 0.0,
    //               left: 0.0,
    //               right: 0.0,
    //               child: Container(
    //                 decoration: BoxDecoration(
    //                   gradient: LinearGradient(
    //                     colors: [
    //                       Color.fromARGB(200, 0, 0, 0),
    //                       Color.fromARGB(0, 0, 0, 0)
    //                     ],
    //                     begin: Alignment.bottomCenter,
    //                     end: Alignment.topCenter,
    //                   ),
    //                 ),
    //                 padding: EdgeInsets.symmetric(
    //                     vertical: 10.0, horizontal: 20.0),
    //                 child: Text(
    //                   'No. ${_Slider_Images.indexOf(item)} image',
    //                   style: TextStyle(
    //                     color: Colors.white,
    //                     fontSize: 20.0,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         )),
    //   ),
    // ))
    //     .toList();
    return Scaffold(
      drawer: App_Drawer(),
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.fromLTRB(30, 20, 0, 55),
          child: Image.asset(
            'assests/images/in.png',
            scale: 3,
          ),
        ),
        actions: <Widget>[
          PopupMenuButton(
              onSelected: (Filter_options selectedval) {
                setState(() {
                  if (selectedval == Filter_options.fav_selected) {
                    _showfavonly = true;
                  } else {
                    _showfavonly = false;
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    PopupMenuItem(
                        child: Text("Favs"),
                        value: Filter_options.fav_selected),
                    PopupMenuItem(
                        child: Text("All"), value: Filter_options.select_all),
                  ]),
          Consumer<Cart>(
            builder: (_, cart_data, ch) => Badge(
              child: ch,
              value: cart_data.count_of_products.toString(),
              color: Colors.red,
            ),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Cart_screen.routee);
                },
                icon: Icon(Icons.shopping_cart)),
          ),
        ],
      ),
      body:
          // SingleChildScrollView(
          //   child: Row(
          //     children: [
          GridsView(_showfavonly),
      //   ],
      // ),
      // Column(
      //   children: [
      // Padding(
      //   padding: EdgeInsets.all(20.0),
      //   child: Container(
      //     height: 300,
      //     width: double.maxFinite,
      //       child: CarouselSlider(
      //         options: CarouselOptions(
      //           height: 350.0,
      //           enableInfiniteScroll: true,
      //           reverse: true,
      //           autoPlay: true,
      //           autoPlayInterval: Duration(seconds: 3),
      //           autoPlayAnimationDuration:
      //           Duration(milliseconds: 800),
      //           autoPlayCurve: Curves.fastOutSlowIn,
      //           enlargeCenterPage: true,
      //           scrollDirection: Axis.horizontal,
      //         ),
      //         items: _Slider_Images.map((i) {
      //           return Builder(
      //             builder: (BuildContext context) {
      //               return Container(
      //                 width: MediaQuery.of(context).size.width,
      //                 margin: EdgeInsets.symmetric(horizontal: 6.0),
      //                 child: Image(image: NetworkImage(i)),
      //               );
      //             },
      //           );
      //         }).toList(),
      //       ),
      //   ),
      // ),
      // SizedBox(
      //   height: 20.0,
      // ),
      // Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Container(
      //     child: Row(
      //       children: [
      //         Text(
      //           "Tushar",
      //           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black,fontSize: 20),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      // SizedBox(
      //   height: 7.0,
      // ),
      // Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Container(
      //     child: Row(
      //       children: [
      //         Text("PRICE: ", style: TextStyle(fontWeight: FontWeight.bold),),
      //         Text(
      //           "120",
      //           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green,fontSize: 20),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      // SizedBox(
      //   height: 20.0,
      // ),
      // Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Container(
      //     child: Padding(
      //       padding: EdgeInsets.all(5.0),
      //       child: Column(
      //         children: [
      //           Text("DESCRIPTION: ",style: TextStyle(fontWeight: FontWeight.bold),),
      //           Text(
      //             "Hekwehjgjdhgejdgwe",
      //             style: TextStyle(
      //               color: Colors.blueGrey,
      //               fontWeight: FontWeight.w700,
      //             ),
      //             softWrap: true,
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
      // SizedBox(
      //   height: 20.0,
      // ),
      // Container(
      //     child: TextButton(
      //       style: ButtonStyle(
      //         backgroundColor: MaterialStateProperty.all(Colors.blue),
      //         elevation: MaterialStateProperty.all(10.0),
      //         fixedSize: MaterialStateProperty.all(Size(150.0, 40.0)),
      //       ),
      //       child: Text("Add To Cart", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      //       onPressed: () {
      //         // cart.addproduct(loaded_product.id, loaded_product.tle, loaded_product.price);
      //         ScaffoldMessenger.of(context).hideCurrentSnackBar();
      //         ScaffoldMessenger.of(context).showSnackBar(
      //           SnackBar(
      //
      //             content: Text("Item Added to Cart!!"),
      //             duration: Duration(seconds: 2),
      //             action: SnackBarAction(
      //               label: "UNDO",
      //               textColor: Colors.red,
      //               onPressed: () {
      //                 // cart.Remove_single_item(loaded_product.id);
      //               },
      //             ),
      //           ),
      //         );
      //       },
      //     )
      // ),
    );
    // body:SingleChildScrollView(
    //   child: Column(
    //       children: [
    //   Padding(
    //   padding: EdgeInsets.all(20.0),
    //   child: Container(
    //     height: 350.0,
    //     child: CarouselSlider(
    //       options: CarouselOptions(
    //         height: 350.0,
    //         enableInfiniteScroll: true,
    //         reverse: true,
    //         autoPlay: true,
    //         autoPlayInterval: Duration(seconds: 3),
    //         autoPlayAnimationDuration:
    //         Duration(milliseconds: 800),
    //         autoPlayCurve: Curves.fastOutSlowIn,
    //         enlargeCenterPage: true,
    //         scrollDirection: Axis.horizontal,
    //       ),
    //       items: _Slider_Images.map((i) {
    //         return Builder(
    //           builder: (BuildContext context) {
    //             return Container(
    //               width: MediaQuery.of(context).size.width,
    //               margin: EdgeInsets.symmetric(horizontal: 6.0),
    //               child: Image(image: NetworkImage(i)),
    //             );
    //           },
    //         );
    //       }).toList(),
    //     ),
    //   ),
    // ),
    //   SizedBox(
    //     height: 20.0,
    //   ),
    //   Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: Container(
    //       child: Row(
    //         children: [
    //           GridsView(_showfavonly),
    //         ],
    //       ),
    //     ),
    //   ),

    // _isload
    //     ? Center(
    //         child: CircularProgressIndicator(),
    //       )
    //     :
    // Column(
    // children: <Widget>[
    // CarouselSlider(
    // items: imageSliders,
    // options: CarouselOptions(enlargeCenterPage: true, height: 200),
    // carouselController: _controller,
    // ),
    // Row(
    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
    // children: <Widget>[
    // Flexible(
    // child: ElevatedButton(
    // onPressed: () => _controller.previousPage(),
    // child: Text('←'),
    // ),
    // ),
    // Flexible(
    // child: ElevatedButton(
    // onPressed: () => _controller.nextPage(),
    // child: Text('→'),
    // ),
    // ),
    // ...Iterable<int>.generate(4).map(
    // (int pageIndex) => Flexible(
    // child: ElevatedButton(
    // onPressed: () => _controller.animateToPage(pageIndex),
    // child: Text("$pageIndex"),
    // ),
    // ),
    // ),
    // ],
    // ),
    //
    // Container(
    //   child:
    //       SingleChildScrollView(
    //         child: Column(
    //           children: [
    //                 Padding(
    //                   padding: const EdgeInsets.all(8.0),
    //                   child: Flexible(
    //                     child:
    //                     Column(
    //                       children:[
    //                         Container(
    //                           height: 350.0,
    //                           child: CarouselSlider(
    //                             options: CarouselOptions(
    //                               height: 350.0,
    //                               enableInfiniteScroll: true,
    //                               reverse: true,
    //                               autoPlay: true,
    //                               autoPlayInterval: Duration(seconds: 3),
    //                               autoPlayAnimationDuration:
    //                               Duration(milliseconds: 800),
    //                               autoPlayCurve: Curves.fastOutSlowIn,
    //                               enlargeCenterPage: true,
    //                               scrollDirection: Axis.horizontal,
    //                             ),
    //                             items: _Slider_Images.map((i) {
    //                               return Builder(
    //                                 builder: (BuildContext context) {
    //                                   return Container(
    //                                     width: MediaQuery.of(context).size.width,
    //                                     margin: EdgeInsets.symmetric(horizontal: 6.0),
    //                                     child: Image(image: NetworkImage(i)),
    //                                   );
    //                                 },
    //                               );
    //                             }).toList(),
    //                           ),
    //                         ),
    //                       ];
    //                     ),
    //                   ),
    //               ),
    //             Row(
    //               children: [
    //                 GridsView(_showfavonly),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    // );
  }
}
