import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> data = ['', ''];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('HomeScreen'),
          backgroundColor: Colors.red,
        ),
        body: Column(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.bottomRight,
                  child: const Text(
                    '1',
                    textAlign: TextAlign.end,
                    style: TextStyle(color: Colors.black, fontSize: 44),
                  ),
                )),
            Expanded(
                flex: 2,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 10,
                    crossAxisCount: 4,
                    crossAxisSpacing: 1,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemCount: 20,
                  itemBuilder: (BuildContext context, int index) {
                    return CustomButton(
                      textButton: data[index],
                      onPressed: () {
                        setState(() {
                          data.addAll([]);
                        });
                      },
                    );
                  },
                ))
          ],
        ));
  }
}

class CustomButton extends StatefulWidget {
  final String textButton;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key, // Đặt tên cho tham số key
    required this.textButton,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: widget.onPressed, child: Text(widget.textButton));
  }
}
