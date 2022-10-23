import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cartmodel.dart';

class CartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CartPageState();
  }
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cartItems = Provider.of<CartModel>(context).cartItems;
    final totalprice = Provider.of<CartModel>(context).totalCartValue;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("Cart"),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<CartModel>(context, listen: false).clearCart();
              },
              icon: Icon(Icons.delete))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: cartItems.length,
                itemBuilder: (context, index) => Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(cartItems[index].imgUrl),
                        ),
                        title: Text(cartItems[index].title),
                        subtitle: Row(
                          children: [
                            Text(cartItems[index].price.toString()),
                            SizedBox(
                              width: 20,
                            ),
                            Text(cartItems[index].qty.toString()),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            Provider.of<CartModel>(context, listen: false)
                                .deleteProductCart(cartItems[index]);
                          },
                        ),
                      ),
                    )),
          ),
          Center(
              child: Text(
            'Total: \$ $totalprice',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          )),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(onPressed: () {}, child: Text('Checkout'))
        ],
      ),
    );
  }
}
