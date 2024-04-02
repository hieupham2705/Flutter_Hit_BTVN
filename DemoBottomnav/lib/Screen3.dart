import 'package:flutter/material.dart';
import 'package:hehe/HomeScreen.dart';

class Screen3 extends StatefulWidget {
  const Screen3({super.key});

  @override
  State<StatefulWidget> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const HomePage()));
        },
        child: const Text('Go to calculator'),
      ),
    );
  }
}
