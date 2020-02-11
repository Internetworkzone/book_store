import 'package:demo/pages/home_page.dart';
import 'package:demo/services/constants.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  goToHomePage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => HomePage()));
  }

  double perfectSize(double size) {
    return MediaQuery.of(context).size.width / 100 / 3.9272727272727277 * size;
  }

  double perfectHeight(double size) {
    return MediaQuery.of(context).size.height / 100 / 7.374545454545455 * size;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff5c6bc0),
        leading: IconButton(
          icon: Icon(Icons.home),
          color: Colors.white,
          iconSize: perfectSize(30),
          onPressed: () => goToHomePage(),
        ),
      ),
      body: Center(
        child: SimpleDialog(
          contentPadding: EdgeInsets.symmetric(
            vertical: perfectHeight(30),
            horizontal: perfectSize(30),
          ),
          children: [
            SizedBox(height: perfectHeight(30)),
            Text(
              'Order Placed',
              style: TextStyle(fontSize: perfectSize(40)),
            ),
            Text(
              'Successfully',
              style: TextStyle(fontSize: perfectSize(40)),
            ),
            SizedBox(height: perfectHeight(30)),
            RaisedButton(
              child: Text(
                'continue shopping',
                style: TextStyle(fontSize: perfectSize(20), color: white),
              ),
              color: Color(0xffff8080),
              onPressed: () => goToHomePage(),
            ),
          ],
        ),
      ),
    );
  }
}
