import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/database/database.dart';
import 'package:demo/pages/admin.dart';
import 'package:demo/pages/checkout_page.dart';
import 'package:demo/state/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int cartCount = 0;
  addItems({String name, int price}) {
    final cart = Provider.of<CartState>(context, listen: false);

    cart.total = cart.total + price;
    cart.bookList.add(name);
    cart.priceList.add(price);

    updateCart(
        bookNames: cart.bookList,
        bookPrices: cart.priceList,
        total: cart.total);
  }

  getCartList() {
    final cart = Provider.of<CartState>(context, listen: false);

    getCartTotal().then((doc) {
      cart.bookList = doc.data['books'];
      cart.priceList = doc.data['price'];
      cart.total = doc.data['total'];
    }).catchError((onError) {});
  }

  @override
  void initState() {
    super.initState();
    getCartList();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartState>(context).bookList;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('The Book Store'),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 7),
              child: Stack(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.shopping_cart, size: 30),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Checkout(),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 1,
                    child: Container(
                      padding: EdgeInsets.all(cart.length == 0 ? 0 : 4),
                      child: Text(
                        cart.length == 0 ? '' : cart.length.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(width: cart.length == 0 ? 0 : 3),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        drawer: openDrawer(),
        body: StreamBuilder<DocumentSnapshot>(
          stream: getCartDetails(),
          builder: (context, snapshot1) => FutureBuilder<QuerySnapshot>(
            future: getBooks(),
            builder: (context, snapshot2) {
              return !snapshot2.hasData
                  ? Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: snapshot2.data.documents.length,
                      itemBuilder: (context, index) {
                        String book =
                            snapshot2.data.documents[index].data['name'];
                        int price =
                            snapshot2.data.documents[index].data['price'];

                        return Card(
                          child: GridTile(
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 15),
                                Text(
                                  book,
                                  style: TextStyle(fontSize: 30),
                                ),
                              ],
                            ),
                            footer: Column(
                              children: <Widget>[
                                Text(
                                  '₹ ${price.toString()}',
                                  style: TextStyle(fontSize: 20),
                                ),
                                FlatButton(
                                  child: Text(
                                    'Add to cart',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () =>
                                      addItems(name: book, price: price),
                                  color: Colors.blue,
                                ),
                                SizedBox(height: 5),
                              ],
                            ),
                          ),
                          elevation: 5,
                        );
                      });
            },
          ),
        ),
      ),
    );
  }

  Widget openDrawer() {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 240,
            width: MediaQuery.of(context).size.width,
            color: Colors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                    child: Text('Add Book'),
                    onPressed: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AdminPage(),
                        ),
                      );
                    }),
                Text(
                  '* Admin',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
