import 'package:cloud_firestore/cloud_firestore.dart';

Firestore firestore = Firestore.instance;

addBook({String bookName, int price}) {
  firestore.collection('books').add({
    'name': bookName ?? '',
    'price': price ?? '',
  });
}

Future<QuerySnapshot> getBooks() async {
  return await firestore.collection('books').getDocuments();
}

updateCart({List bookNames, List bookPrices, int total}) {
  firestore.collection('cart').document('items').setData({
    'books': bookNames,
    'price': bookPrices,
    'total': total,
  });
}

Stream<DocumentSnapshot> getCartDetails() {
  return firestore.collection('cart').document('items').snapshots();
}

Future<DocumentSnapshot> getCartTotal() {
  return firestore.collection('cart').document('items').get();
}

Future<void> deleteCart() async {
  await firestore.collection('cart').document('items').delete();
}

updateOrder({List bookList, List priceList, int total}) {
  firestore.collection('orders').add({
    'books': bookList,
    'prices': priceList,
    'total': total,
    'timesStamp': FieldValue.serverTimestamp(),
  });
}

Future<QuerySnapshot> searchBooks({String name}) {
  Future<QuerySnapshot> result = firestore
      .collection('books')
      .where('name', isGreaterThanOrEqualTo: name)
      .getDocuments();
  return result;
}
