import 'package:flutter/material.dart';
import 'custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String linkImageBgrLogin =
      'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif';
  late TextEditingController _inputAccountControler;
  late TextEditingController _inputPasswordControler;

  @override
  void initState() {
    _inputAccountControler = TextEditingController();
    _inputPasswordControler = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("asset/images/bgr.png"),
                  fit: BoxFit.cover,
                ),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height:20,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(
                          linkImageBgrLogin,
                        )),
                  ),
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: CustomTextField(
                        inputEditingControler: _inputAccountControler,
                        name: "Enter account",
                        prefixIcon: Icons.person,
                        obscureText: false,
                        inputType: TextInputType.name),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: CustomTextField(
                        inputEditingControler: _inputPasswordControler,
                        name: "Enter password",
                        prefixIcon: Icons.lock,
                        obscureText: true,
                        inputType: TextInputType.name),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 10),
                          textStyle: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            )));
  }
}
