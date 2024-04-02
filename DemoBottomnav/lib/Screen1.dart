import 'package:flutter/material.dart';
import 'main.dart';
import 'Screen2.dart';

class Screen1 extends StatefulWidget {
  final VoidCallback goToPage2;
  const Screen1({super.key,  required this.goToPage2});
  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
            widget.goToPage2();
        },
        child: const Text('Click hear'),
      ),
    );
  }
}
