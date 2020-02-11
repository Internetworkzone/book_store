import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/database/database.dart';
import 'package:demo/pages/order_page.dart';
import 'package:demo/services/constants.dart';
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

  double perfectSize(double size) {
    return MediaQuery.of(context).size.width / 100 / 3.9272727272727277 * size;
  }

  double perfectHeight(double size) {
    return MediaQuery.of(context).size.height / 100 / 7.374545454545455 * size;
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
        backgroundColor: Color(0xff5c6bc0),
      ),
      body: cart.bookList.isEmpty
          ? Center(child: Text('Your cart is empty'))
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
                                style: TextStyle(fontSize: perfectSize(25)),
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
                                style: TextStyle(fontSize: perfectSize(25)),
                              ),
                            ),
                          );
                        },
                      );
              },
            ),
      bottomNavigationBar: BottomAppBar(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            width: perfectSize(3),
          ),
          Text(
            '₹ ' + cart.total.toString(),
            style: TextStyle(
              fontSize: perfectSize(30),
              fontWeight: FontWeight.w700,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: perfectSize(15), vertical: perfectHeight(10)),
            child: AbsorbPointer(
              absorbing: cart.bookList.length == 0,
              child: RaisedButton(
                color:
                    cart.bookList.length == 0 ? Colors.grey : Color(0xff00bfa5),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: perfectSize(15), vertical: perfectHeight(10)),
                  child: Text(
                    'Place order',
                    style: TextStyle(
                      fontSize: perfectSize(22),
                      fontWeight: FontWeight.w700,
                      color: white,
                    ),
                  ),
                ),
                onPressed: () => placeOrder(),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
