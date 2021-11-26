import 'package:aimart/pages/market_page.dart';
import 'package:aimart/pages/signup_page.dart';
import 'package:flutter/material.dart';


Future<void> main() async {runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ai-Mart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MarketPage(),
    );
  }
}
