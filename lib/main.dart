import 'package:demo/pages/home_page.dart';
import 'package:demo/state/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CartState(),
        ),
      ],
      child: MaterialApp(
        title: 'The Book Store',
        theme: ThemeData(
          primaryColor: Color(0xff5c6bc0),
        ),
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
