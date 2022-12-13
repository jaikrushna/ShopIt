import 'package:flutter/material.dart';
import 'package:shop_it/Screens/Edit_Screen.dart';
import 'package:provider/provider.dart';
import 'package:shop_it/Provider/Provider_Product.dart';

class User_product_tile extends StatelessWidget {
  final String id;
  final String title;
  final String ImageUrl;

  User_product_tile(
    @required this.id,
    @required this.title,
    @required this.ImageUrl,
  );
  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(ImageUrl),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(Edit_User_Input.routee, arguments: id);
              },
              icon: Icon(Icons.edit_rounded),
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              onPressed: () async {
                try {
                  await Provider.of<Products>(context, listen: false)
                      .Deleteprod(id);
                  SnackBar(content: Text('Deleting Successfull!'));
                } catch (error) {
                  SnackBar(content: Text('Deleting Failed!'));
                }
              },
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
