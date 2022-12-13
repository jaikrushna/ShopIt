import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_it/Provider/Provider_Product.dart';
import 'package:shop_it/Provider/cart.dart';
class Screen_Detail extends StatelessWidget {
  static const routee = '/Detail_container';
  @override
  Widget build(BuildContext context) {
    final product_id = ModalRoute.of(context).settings.arguments as String;
    final cart = Provider.of<Cart>(context, listen: false);
    final loaded_product =
        Provider.of<Products>(context, listen: true).findbyid(product_id);
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text(loaded_product.tle)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Container(
                  height: 300,
                  width: double.maxFinite,
                  child: Image.network(
                    loaded_product.image_URL,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Row(
                    children: [
                      Text(
                        "${loaded_product.tle}",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black,fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 7.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    child: Row(
                      children: [
                        Text("PRICE: ", style: TextStyle(fontWeight: FontWeight.bold),),
                        Text(
                          "\$${loaded_product.price}",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green,fontSize: 20),
                        ),
                      ],
                    ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Text("DESCRIPTION: ",style: TextStyle(fontWeight: FontWeight.bold),),
                          Text(
                              loaded_product.description,
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w700,
                              ),
                              softWrap: true,
                            ),
                        ],
                      ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    elevation: MaterialStateProperty.all(10.0),
                    fixedSize: MaterialStateProperty.all(Size(150.0, 40.0)),
                  ),
                  child: Text("Add To Cart", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  onPressed: () {
                    cart.addproduct(loaded_product.id, loaded_product.tle, loaded_product.price);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(

                        content: Text("Item Added to Cart!!"),
                        duration: Duration(seconds: 2),
                        action: SnackBarAction(
                          label: "UNDO",
                          textColor: Colors.red,
                          onPressed: () {
                            cart.Remove_single_item(loaded_product.id);
                          },
                        ),
                      ),
                    );
                  },
                )
              ),
            ],
          ),
        ));
  }
}
