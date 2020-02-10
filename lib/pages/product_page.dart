import 'package:demo/services/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProductPage extends StatefulWidget {
  ProductPage({this.bookName, this.bookPrice});
  final String bookName;
  final int bookPrice;
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.bookName),
      ),
      body: ListView(
        children: [],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            Expanded(
              child: RaisedButton(
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: white,
                    ),
                  ),
                ),
                onPressed: () {},
              ),
            ),
            Expanded(
              child: RaisedButton(
                color: Colors.green,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    'Buy Now',
                    style: TextStyle(
                      fontSize: 22,
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
