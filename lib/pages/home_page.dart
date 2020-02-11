import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/database/database.dart';
import 'package:demo/pages/admin.dart';
import 'package:demo/pages/checkout_page.dart';
import 'package:demo/pages/product_page.dart';
import 'package:demo/pages/search_screen.dart';
import 'package:demo/services/constants.dart';
import 'package:demo/state/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  addItemToCart({String name, int price}) {
    final cart = Provider.of<CartState>(context, listen: false);

    cart.total = cart.total + price;
    cart.bookList.add(name);
    cart.priceList.add(price);

    updateCart(
      bookNames: cart.bookList,
      bookPrices: cart.priceList,
      total: cart.total,
    );
  }

  getCartList() {
    final cart = Provider.of<CartState>(context, listen: false);

    getCartTotal().then((doc) {
      cart.bookList = doc.data['books'];
      cart.priceList = doc.data['price'];
      cart.total = doc.data['total'];
    }).catchError((onError) {});
  }

  search() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => SearchScreen()));
  }

  @override
  void initState() {
    super.initState();
    getCartList();
  }

  double perfectSize(double size) {
    return MediaQuery.of(context).size.width / 100 / 3.9272727272727277 * size;
  }

  double perfectHeight(double size) {
    return MediaQuery.of(context).size.height / 100 / 7.374545454545455 * size;
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartState>(context).bookList;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff5c6bc0),
          title: Text('The Book Store'),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: perfectHeight(12)),
              child: IconButton(
                icon: Icon(Icons.search),
                iconSize: perfectSize(30),
                color: Colors.white,
                onPressed: () => search(),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: perfectHeight(12), horizontal: perfectSize(7)),
              child: Stack(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.shopping_cart, size: perfectSize(30)),
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
                      padding: EdgeInsets.all(
                          perfectSize(cart.length == 0 ? 0 : 2.3)),
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
                        border: Border.all(
                            width: perfectSize(cart.length == 0 ? 0 : 3)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: perfectSize(12)),
              child: IconButton(
                  icon: Icon(Icons.person),
                  iconSize: perfectSize(30),
                  color: Colors.white,
                  onPressed: () {}),
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
                        childAspectRatio: 0.6,
                      ),
                      itemCount: snapshot2.data.documents.length,
                      itemBuilder: (context, index) {
                        String bookName =
                            snapshot2.data.documents[index].data['name'];
                        int bookPrice =
                            snapshot2.data.documents[index].data['price'];
                        String bookImage =
                            snapshot2.data.documents[index].data['image'];
                        String bookId =
                            snapshot2.data.documents[index].documentID;

                        return GestureDetector(
                          child: Card(
                            elevation: 0,
                            borderOnForeground: false,
                            margin: EdgeInsets.all(perfectSize(3)),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                color: Color(0xffdddddd),
                              )),
                              child: GridTile(
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: perfectHeight(15)),
                                    Container(
                                      child: bookImage == null
                                          ? Icon(
                                              Icons.photo,
                                              size: perfectSize(150),
                                            )
                                          : Image(
                                              image: NetworkImage(bookImage),
                                              fit: BoxFit.contain,
                                            ),
                                      height: perfectHeight(225),
                                      width: perfectSize(150),
                                    ),
                                  ],
                                ),
                                footer: Column(
                                  children: <Widget>[
                                    Text(
                                      bookName.length > 20
                                          ? bookName.substring(0, 20) + '...'
                                          : bookName,
                                      style: TextStyle(
                                          color: black,
                                          fontSize: perfectSize(18),
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Text(
                                          '₹ ${bookPrice.toString()}',
                                          style: TextStyle(
                                            fontSize: perfectSize(20),
                                            color: black,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        FlatButton(
                                          padding: EdgeInsets.all(0),
                                          child: Text(
                                            'Add to cart',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () => addItemToCart(
                                              name: bookName, price: bookPrice),
                                          color: Color(0xff00bfa5),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: perfectHeight(5)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProductPage(
                                bookId: bookId,
                              ),
                            ),
                          ),
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
            color: Color(0xff00bfa5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                    child: Text('Add Books'),
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
