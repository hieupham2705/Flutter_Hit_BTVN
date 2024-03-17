import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: const Text(
                'Flutter layout demo',
                style: TextStyle(fontSize: 24),
              ),
            ),
            Image.asset(
              'assets/5T5A1265.jpeg',
            ),
            Container(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Oeschinen Lake Campground',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Kanajsdljaflijalskfj',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.red,
                          ),
                          Text('41'),
                        ],
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.all(32),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Icon(Icons.phone),
                            Text('CALL'),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.phone),
                            Text('CALL'),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.phone),
                            Text('CALL'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    'áli fhadsk lfhsdlkf hjsdklfjs dlkfhjsd klfhsdklf hsdklfhsdl kvhsvbs dklbs djlvn dbslv jsdklfjsdlifusiodsyhvlksahflkshefdil',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
