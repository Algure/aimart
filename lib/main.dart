import 'package:aimart/pages/market_page.dart';
import 'package:aimart/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';


Future<void> main() async {runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        title: 'AiMart',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/':(context) =>MarketPage(),//DashboardHomeSubPage(openTestCourseDescription: (){},),//EditAdvertSubPage(),// LandingScreen(),
          '/search':(context) =>SearchPage()
        },
      ),
    );
  }
}
