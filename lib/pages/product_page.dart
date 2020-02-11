import 'package:demo/database/database.dart';
import 'package:demo/pages/checkout_page.dart';
import 'package:demo/pages/search_screen.dart';
import 'package:demo/services/constants.dart';
import 'package:demo/state/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  ProductPage({this.bookId});
  final String bookId;

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  String bookName;
  int bookPrice;
  String bookImage;
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

  search() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => SearchScreen()));
  }

  @override
  void initState() {
    super.initState();
    getProductDetails(widget.bookId).then((doc) {
      setState(() {
        bookName = doc.data['name'];
        bookPrice = doc.data['price'];
        bookImage = doc.data['image'];
      });
    });
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff5c6bc0),
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
                    padding:
                        EdgeInsets.all(perfectSize(cart.length == 0 ? 0 : 2.3)),
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
            padding: EdgeInsets.symmetric(vertical: perfectHeight(12)),
            child: IconButton(
              icon: Icon(Icons.person),
              iconSize: perfectSize(30),
              color: Colors.white,
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: bookName == null
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: perfectSize(25)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Container(
                          child: bookImage == null
                              ? Icon(
                                  Icons.photo,
                                  size: perfectSize(100),
                                )
                              : Image.network(bookImage),
                          height: perfectSize(
                              MediaQuery.of(context).size.width * 1.2),
                          padding:
                              EdgeInsets.symmetric(vertical: perfectSize(25)),
                        ),
                      ),
                      Text(bookName,
                          style: TextStyle(
                            fontSize: perfectSize(25),
                            fontWeight: FontWeight.w500,
                          )),
                      SizedBox(height: perfectHeight(10)),
                      Text(
                        '₹ ' + bookPrice.toString(),
                        style: TextStyle(
                          fontSize: perfectSize(28),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: perfectHeight(10)),
                      Text(
                        'Free Delivery',
                        style: TextStyle(
                            fontSize: perfectSize(18),
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: perfectHeight(7)),
                      Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: perfectSize(10),
                                vertical: perfectHeight(7)),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  '4.5',
                                  style: TextStyle(color: white),
                                ),
                                SizedBox(width: perfectSize(5)),
                                Icon(
                                  Icons.star,
                                  size: perfectSize(13),
                                  color: white,
                                ),
                              ],
                            ),
                            color: Colors.green,
                          ),
                          SizedBox(width: perfectSize(7)),
                          Text('2,864 ratings & 2,976 reviews'),
                        ],
                      ),
                      SizedBox(height: perfectHeight(10)),
                    ],
                  ),
                ),
                Divider(
                  color: Color(0xffbbbbbb),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {},
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(13.0),
                            child: Text('Share',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {},
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(perfectSize(13.0)),
                            child: Text('Wishlist',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: perfectHeight(25),
                  color: black,
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: perfectSize(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: perfectHeight(12.0)),
                          child: Text(
                            'Details',
                            style: TextStyle(
                                fontSize: perfectSize(20),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Divider(color: Color(0xffcccccc)),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: perfectHeight(8.0)),
                          child: Text(
                            'Highlights',
                            style: TextStyle(
                                fontSize: perfectSize(20),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(height: perfectHeight(7)),
                        Text(
                          (' - Languaue: English \n \n - Binding: Paperback \n\n - Genre: Fiction'),
                          style: TextStyle(
                              fontSize: perfectSize(17),
                              fontWeight: FontWeight.w500),
                        ),
                        Divider(color: Colors.grey),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: perfectHeight(12.0)),
                              child: Text(
                                'All Details',
                                style: TextStyle(
                                    fontSize: perfectSize(20),
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: perfectHeight(10),
                ),
                Card(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: perfectSize(20.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Ratings & Reviews',
                              style: TextStyle(
                                fontSize: perfectSize(20),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            RaisedButton(
                              color: white,
                              onPressed: () {},
                              child: Text(
                                'Rate Product',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: perfectSize(15),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(perfectSize(15.0)),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        '4.5',
                                        style: TextStyle(
                                          color: black,
                                          fontSize: perfectSize(40),
                                        ),
                                      ),
                                      SizedBox(width: perfectSize(5)),
                                      Icon(
                                        Icons.star,
                                        size: perfectSize(40),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: perfectSize(7)),
                                  Text('2,864 ratings and\n 2,976 reviews'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 3,
                  margin: EdgeInsets.only(bottom: perfectHeight(14)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: perfectSize(20.0),
                        vertical: perfectHeight(14)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'View All',
                          style: TextStyle(
                            fontSize: perfectSize(20),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                  ),
                ),
              ],
            ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            Expanded(
              child: RaisedButton(
                color: Color(0xffff8080),
                child: Padding(
                  padding: EdgeInsets.all(perfectSize(18.0)),
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(
                      fontSize: perfectSize(22),
                      fontWeight: FontWeight.w700,
                      color: white,
                    ),
                  ),
                ),
                onPressed: () => addItemToCart(
                  name: bookName,
                  price: bookPrice,
                ),
              ),
            ),
            Expanded(
              child: RaisedButton(
                color: Color(0xff5c6bc0),
                child: Padding(
                  padding: EdgeInsets.all(perfectSize(18)),
                  child: Text(
                    'Buy Now',
                    style: TextStyle(
                      fontSize: perfectSize(22),
                      fontWeight: FontWeight.w700,
                      color: white,
                    ),
                  ),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
