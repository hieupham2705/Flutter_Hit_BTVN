import 'package:flutter/material.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key});
  @override
  State<StatefulWidget> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  String _textButton = 'Click hear';
  final TextEditingController _text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: _text,
                decoration: const InputDecoration(labelText: 'Enter your text'),
              )),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _textButton = _text.text;
              });
            },
            child: Text(_textButton),
          ),
        ]);
  }
}
