import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/database/database.dart';
import 'package:demo/pages/order_page.dart';
import 'package:demo/state/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Checkout extends StatefulWidget {
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  deleteItem({String name, int price}) {
    final cart = Provider.of<CartState>(context, listen: false);
    cart.total = cart.total - price;
    cart.bookList.remove(name);
    cart.priceList.remove(price);
    updateCart(
      bookNames: cart.bookList,
      bookPrices: cart.priceList,
      total: cart.total,
    );
  }

  placeOrder() {
    final cart = Provider.of<CartState>(context, listen: false);
    updateOrder(
        bookList: cart.bookList, priceList: cart.priceList, total: cart.total);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => OrderPage()));
    deleteCart();
    cart.bookList.clear();
    cart.priceList.clear();
    cart.total = 0;
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: cart.bookList.isEmpty
          ? Center(child: Text('You did not add anything yet'))
          : StreamBuilder<DocumentSnapshot>(
              stream: getCartDetails(),
              builder: (context, snapshot) {
                return !snapshot.hasData
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: snapshot.data['books'].length,
                        itemBuilder: (context, index) {
                          String book = snapshot.data['books'][index];
                          int price = snapshot.data['price'][index];
                          return Card(
                            child: ListTile(
                              title: Text(
                                book,
                                style: TextStyle(fontSize: 25),
                              ),
                              leading: IconButton(
                                padding: EdgeInsets.all(0),
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                                onPressed: () =>
                                    deleteItem(name: book, price: price),
                              ),
                              trailing: Text(
                                '₹ ' + price.toString(),
                                style: TextStyle(fontSize: 25),
                              ),
                            ),
                          );
                        },
                      );
              },
            ),
      persistentFooterButtons: <Widget>[
        Text(
          '₹ ' + cart.total.toString(),
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: 100),
        AbsorbPointer(
          absorbing: cart.bookList.length == 0,
          child: RaisedButton(
            color: cart.bookList.length == 0 ? Colors.grey : Colors.green,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Text(
                'Place order',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            onPressed: () => placeOrder(),
          ),
        )
      ],
    );
  }
}
