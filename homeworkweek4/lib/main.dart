import 'package:flutter/material.dart';
import 'categories.dart';
import 'listfood.dart';
import 'fooddetail.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
         Categories.routeName : (context) => const Categories(),
         ListFood.routeName:(context) =>  const ListFood(),
         FoodDetail.routeName:(context) => const FoodDetail(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
