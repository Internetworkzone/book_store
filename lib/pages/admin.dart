import 'package:demo/database/database.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  String bookName;
  int price;

  onAddBook() {
    addBook(bookName: bookName, price: price);
    nameController.clear();
    priceController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              child: TextField(
                decoration: InputDecoration(hintText: 'Book Name'),
                controller: nameController,
                onChanged: (val) {
                  setState(() {
                    bookName = val;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              child: TextField(
                decoration: InputDecoration(hintText: 'price'),
                controller: priceController,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    price = int.parse(value);
                  });
                },
              ),
            ),
            SizedBox(height: 25),
            MaterialButton(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Add Book',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              color: Colors.blue,
              onPressed: () => onAddBook(),
            ),
          ],
        ),
      ),
    );
  }
}
