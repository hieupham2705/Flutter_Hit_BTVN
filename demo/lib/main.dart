import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SafeArea(
          child: Scaffold(
        body: MyHomePage(true),
      )),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  final bool loading;

  const MyHomePage(this.loading, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      child:  Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Đăng Nhập",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20))
              ],
            ),
            const SizedBox(height: 10),
            const Text("Username"),
            const TextField(
                decoration: InputDecoration(
                    labelText: 'Enter your username',
                    prefixIcon: Icon(Icons.person))),
            const SizedBox(height: 10),
            const Text("Password"),
            const TextField(
                decoration: InputDecoration(
                    labelText: 'Enter your password',
                    prefixIcon: Icon(Icons.lock))),

            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ElevatedButton(onPressed: () {}, child: const Text('Đăng nhập')),],
            )
          ],
        ),
      ),
    );
  }
}
