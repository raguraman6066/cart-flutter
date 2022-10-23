import 'package:flutter/material.dart';
import 'package:grocery_app/cartpage.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';

import 'cartmodel.dart';

class HomePage extends StatelessWidget {
  var imageUrl = TextEditingController();
  var name = TextEditingController();
  var price = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _products = Provider.of<ProductModel>(context).products;
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("Home"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => CartPage())),
          )
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: _products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 0.8),
        itemBuilder: (context, index) {
          return Card(
              child: Column(children: <Widget>[
            Image.network(
              _products[index].imgUrl,
              height: 120,
              width: 120,
            ),
            Text(
              _products[index].title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("\$" + _products[index].price.toString()),
            OutlinedButton(
                child: Text("Add"),
                onPressed: () => Provider.of<CartModel>(context, listen: false)
                    .addProductCart(_products[index]))
          ]));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    content: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(hintText: 'imageUrl'),
                          controller: imageUrl,
                        ),
                        TextField(
                          decoration: InputDecoration(hintText: 'name'),
                          controller: name,
                        ),
                        TextField(
                          decoration: InputDecoration(hintText: 'price'),
                          controller: price,
                        ),
                      ],
                    ),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel')),
                      ElevatedButton(
                          onPressed: () {
                            Provider.of<ProductModel>(context, listen: false)
                                .addNewProduct(Product(
                              id: 12,
                              title: name.text,
                              price: double.parse(price.text),
                              qty: 1,
                              imgUrl: imageUrl.text,
                            ));
                            Navigator.of(context).pop();
                          },
                          child: Text('Submit')),
                    ],
                  ));
        },
      ),
      // ListView.builder(
      //   itemExtent: 80,
      //   itemCount: _products.length,
      //   itemBuilder: (context, index) {
      //     return ScopedModelDescendant<CartModel>(
      //         builder: (context, child, model) {
      //       return ListTile(
      //           leading: Image.network(_products[index].imgUrl),
      //           title: Text(_products[index].title),
      //           subtitle: Text("\$"+_products[index].price.toString()),
      //           trailing: OutlineButton(
      //               child: Text("Add"),
      //               onPressed: () => model.addProduct(_products[index])));
      //     });
      //   },
      // ),
    );
  }
}
