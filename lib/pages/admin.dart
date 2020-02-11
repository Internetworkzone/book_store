import 'dart:io';

import 'package:demo/database/database.dart';
import 'package:demo/storage/image_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  String bookName = '';
  String bookPrice = '';
  File image;

  selectImage() async {
    File selectedImage =
        await ImagePicker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      setState(() {
        image = selectedImage;
      });
    }
  }

  onAddBook() async {
    String imageUrl = await uploadBookImage(image, bookName);
    addBook(bookName: bookName, price: int.parse(bookPrice), url: imageUrl);
    nameController.clear();
    priceController.clear();
    setState(() {
      image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xff00bfa5)),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              child: GridTile(
                child: Container(
                  child: image == null
                      ? Icon(
                          Icons.add_a_photo,
                          size: 100,
                        )
                      : Image(
                          image: FileImage(image),
                          fit: BoxFit.cover,
                        ),
                  height: 200,
                  width: 150,
                ),
              ),
              onTap: () => selectImage(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
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
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: TextField(
                decoration: InputDecoration(hintText: 'price'),
                controller: priceController,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    bookPrice = value;
                  });
                },
              ),
            ),
            SizedBox(height: 25),
            AbsorbPointer(
              absorbing: bookPrice != '' && bookName != '' && image != null
                  ? true
                  : false,
              child: MaterialButton(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 30),
                  child: Text(
                    'Add Book',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
                color: bookPrice != '' && bookName != '' && image != null
                    ? Color(0xffff8080)
                    : Colors.grey,
                onPressed: () => onAddBook(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
