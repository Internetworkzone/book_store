import 'package:flutter/foundation.dart';

class CartState extends ChangeNotifier {
  int _total = 0;
  int get total => _total;
  set total(int value) {
    _total = value;
    notifyListeners();
  }

  List _bookList = [];
  List get bookList => _bookList;
  set bookList(List books) {
    _bookList = books;
    notifyListeners();
  }

  List _priceList = [];
  List get priceList => _priceList;
  set priceList(List prices) {
    _priceList = prices;
    notifyListeners();
  }
}
