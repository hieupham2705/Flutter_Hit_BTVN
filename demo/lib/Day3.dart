import 'package:flutter/material.dart';
import 'main.dart';
void main() {
  runApp(const Demo());
}

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  void click() {
    setState(() {
      showTimePicker(context: context, initialTime: TimeOfDay.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SafeArea(
          child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

            ],
          ),
        ),
      )),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              const Text('1+1'),
              const Text('=6'),
              Row(
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.check)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.remove))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
