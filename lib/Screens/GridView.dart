import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop_it/models/Container_Tile.dart';
import '../Provider/Provider_Product.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class GridsView extends StatelessWidget {
  bool _showonlyfav;

  GridsView(this._showonlyfav);
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final productsData = Provider.of<Products>(context);
    final products = _showonlyfav ? productsData.itemsfav : productsData.items;
    return
    //     Column(
    //       children: [
    //     Card(
    //     shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(15.0),
    // ),
    // elevation: 12.0,
    // margin: EdgeInsets.only(bottom: 80.0),
    // child: Expanded(
    // child: Container(
    // height: 140,
    // constraints: BoxConstraints(
    // minHeight: 130),
    // width: deviceSize.width * 0.95,
    // padding: EdgeInsets.all(2.0),
    // child: Image.network('https://d1csarkz8obe9u.cloudfront.net/posterpreviews/fashion-sale-%7C-mens-clothing-sale-flyer-ad-design-template-b5062165e25ec65eb672d05ef5ff5225_screen.jpg?ts=1606886779'),
    // ),
    // ),
    // ),

        //     Container(
        //       height: 350.0,
        //       child: CarouselSlider(
        //         options: CarouselOptions(
        //           height: 350.0,
        //           enableInfiniteScroll: true,
        //           reverse: true,
        //           autoPlay: true,
        //           autoPlayInterval: Duration(seconds: 3),
        //           autoPlayAnimationDuration: Duration(milliseconds: 800),
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
        //                 decoration: BoxDecoration(color: Colors.amber),
        //                 child: Image(image: NetworkImage(i)),
        //               );
        //             },
        //           );
        //         }).toList(),
        //       ),
        //     ),


    GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        // create: (c) => products[i],
        child: Product_Item(
            // products[i].id, products[i].image_URL, products[i].tle,
            ),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    // ),
    //   ],

    );
  }
}

final List _Slider_Images = [
  'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/fashion-sale-%7C-mens-clothing-sale-flyer-ad-design-template-b5062165e25ec65eb672d05ef5ff5225_screen.jpg?ts=1606886779',
  'https://newspaperads.ads2publish.com/wp-content/uploads/2019/06/lifestyle-clothing-preview-sale-upto-50-off-ad-delhi-times-15-06-2019.png',
  'https://st4.depositphotos.com/11292408/23294/i/1600/depositphotos_232949278-stock-photo-sales-promotion-fashion-clothes-retail.jpg',
  'https://www.postcardmania.com/wp-content/uploads/blog/img/retail-postcard-example-750x530.jpg',
];
