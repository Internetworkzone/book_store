import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

FirebaseStorage storage = FirebaseStorage.instance;

Future<String> uploadBookImage(File bookImage, String bookName) async {
  StorageUploadTask uploadTask =
      storage.ref().child('images/books/$bookName.png').putFile(bookImage);
  StorageTaskSnapshot snapshot = await uploadTask.onComplete;
  String imageUrl = await snapshot.ref.getDownloadURL();
  return imageUrl;
}
