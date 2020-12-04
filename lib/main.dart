import 'package:flutter/material.dart';
import 'package:ventas_muebles/src/pages/create_muebles_page.dart';
import 'package:ventas_muebles/src/pages/furniture_page.dart';
import 'package:ventas_muebles/src/pages/home_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'home',
      routes: {
        'home' : (BuildContext context) => HomePage(),
        'furniture' : (BuildContext context) => FurniturePage(),
        'crear' : (BuildContext context) => CreateMueblesPage(),
      },
    );
  }
}