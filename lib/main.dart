import 'package:demo/pages/home_page.dart';
import 'package:demo/state/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CartState(),
        ),
      ],
      child: MaterialApp(
        title: 'The Book Store',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
