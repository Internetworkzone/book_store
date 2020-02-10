import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/database/database.dart';
import 'package:demo/pages/product_page.dart';
import 'package:demo/services/constants.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  String searchText;
  Future<QuerySnapshot> searchResult;

  clearSearch() {
    searchController.clear();
    setState(() {
      searchResult = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 8,
        iconTheme: IconThemeData(color: black),
        title: TextField(
          autofocus: true,
          controller: searchController,
          decoration: InputDecoration(
            hasFloatingPlaceholder: true,
            hintText: 'search for your favourite books',
          ),
          onChanged: (input) {
            if (input != '') {
              setState(() {
                searchText = input;
                searchResult = searchBooks(name: searchText);
              });
            } else {
              setState(() {
                searchResult = null;
              });
            }
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            color: black,
            onPressed: () => clearSearch(),
          ),
        ],
      ),
      body: searchResult == null
          ? Center(child: Text('Search Books'))
          : FutureBuilder<QuerySnapshot>(
              future: searchResult,
              builder: (context, snapshot) {
                return !snapshot.hasData
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          String bookName =
                              snapshot.data.documents[index].data['name'];
                          int bookPrice =
                              snapshot.data.documents[index]['price'];
                          return ListTile(
                              title: Text(bookName),
                              onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ProductPage(
                                        bookName: bookName,
                                        bookPrice: bookPrice,
                                      ),
                                    ),
                                  ));
                        });
              },
            ),
    );
  }
}
