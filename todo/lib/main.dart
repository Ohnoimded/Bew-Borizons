import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/utilities/home_page.dart';



//WE are using Hive for DB and this will run the homepage 
void main() async {
  await Hive.initFlutter(); 
  await Hive.openBox('dbox'); 
  runApp(MyApp());  }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(), 
    );
  }
}
