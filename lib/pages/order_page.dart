import 'package:demo/pages/home_page.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.home),
          color: Colors.white,
          iconSize: 30,
          onPressed: () {},
        ),
      ),
      body: Center(
        child: SimpleDialog(
          contentPadding: EdgeInsets.all(30),
          children: [
            SizedBox(height: 30),
            Text(
              'Order Placed',
              style: TextStyle(fontSize: 40),
            ),
            Text(
              'Successfully',
              style: TextStyle(fontSize: 40),
            ),
            SizedBox(height: 30),
            RaisedButton(
              child: Text(
                'continue shopping',
                style: TextStyle(fontSize: 20),
              ),
              color: Colors.blue,
              onPressed: () => goToHomePage(),
            ),
          ],
        ),
      ),
    );
  }
}
