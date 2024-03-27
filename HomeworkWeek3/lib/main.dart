import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

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
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int page = 0;
  int time = 10;
  int total = 8;

// playpage
  late AnimationController controller;
  data question = data();
  int correctQuestion = 0;
  int quantityQuestion = 10;

// end page
  bool endgame = true;
  late int correct;
  late int wrong;

// home page
  late String level = 'Dễ';

  void startTimer(_time) {
    question = generateQuestion();
    controller = AnimationController(
      duration:  Duration(seconds: _time),
      vsync: this,
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            question = generateQuestion();
            controller.reset();
            controller.forward();
          });
        }
        if (status == AnimationStatus.dismissed) {
          quantityQuestion--;
          if (quantityQuestion == -1) {
            if (correctQuestion >= 0.7 * total) {
              endgame = true;
            } else {
              endgame = false;
            }
            correct = correctQuestion;
            wrong = total - correctQuestion;
            quantityQuestion = total;
            correctQuestion = 0;
            page = 2;
            controller.stop();
          }
          print(quantityQuestion);
        }
      });
    controller.repeat(reverse: false);
  }

  @override
  void initState() {
    super.initState();
    startTimer(time);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body:
          (page == 0) ? homePage() : ((page == 1) ? playGamePage() : endPage()),
    ));
  }

  Container homePage() {
    return Container(
      alignment: Alignment.center,
      color: Colors.blueGrey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 160,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            alignment: Alignment.center,
            // color: Colors.white,
            child: const Text('1+1=2',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Freaking',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w300)),
              Text('Math',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ))
            ],
          ),
          const SizedBox(
            height: 200,
          ),
          Container(
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: IconButton(
              onPressed: () {
                setState(() {
                  page = 1;
                  question = generateQuestion();
                  controller.reset();
                  controller.forward();
                });
              },
              icon: const Icon(Icons.play_arrow_rounded,
                  size: 40, color: Colors.blue),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Text(
                level,
                style: const TextStyle(fontSize: 30, color: Colors.white),
              ),
              Positioned(
                top: 16,
                child: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          alignment: Alignment.center,
                          title: Text(
                            'Độ khó',
                            style: TextStyle(fontSize: 25, color: Colors.black),
                          ),
                          content: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 1,
                                  color: Colors.grey,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      level = 'Dễ';
                                      levelOfDifficult(6, 10);
                                      Navigator.of(context).pop();
                                    });
                                  },
                                  child: Text(
                                    'Dễ',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.blue),
                                  ),
                                ),
                                Container(
                                  height: 1,
                                  color: Colors.grey,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      level = 'Trung bình';
                                      levelOfDifficult(3, 10);
                                      Navigator.of(context).pop();
                                    });
                                  },
                                  child: Text(
                                    'Trung bình',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.blue),
                                  ),
                                ),
                                Container(
                                  height: 1,
                                  color: Colors.grey,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      level = 'Khó';
                                      levelOfDifficult(1, 15);
                                      Navigator.of(context).pop();
                                    });
                                  },
                                  child: Text(
                                    'khó',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.blue),
                                  ),
                                ),
                                Container(
                                  height: 1,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.keyboard_arrow_down_rounded,
                      size: 60, color: Colors.blue),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Container endPage() {
    return Container(
      alignment: Alignment.center,
      color: Colors.blueGrey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            (endgame == true) ? 'WINNER' : 'GAME OVER',
            style: const TextStyle(
                fontSize: 50, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 100,
          ),
          const Text(
            'Correct',
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.normal),
          ),
          Text(
            '$correct',
            style: const TextStyle(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const Text(
            'Wrong',
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.normal),
          ),
          Text(
            '$wrong',
            style: const TextStyle(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      page = 1;
                      question = generateQuestion();
                      controller.reset();
                      controller.forward();
                    });
                  },
                  icon: const Icon(Icons.restart_alt,
                      size: 80, color: Colors.grey),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      page = 0;
                    });
                  },
                  icon: const Icon(Icons.home, size: 80, color: Colors.grey),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Container playGamePage() {
    return Container(
        alignment: Alignment.center,
        color: Colors.pink,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LinearProgressIndicator(
              minHeight: 10,
              color: Colors.black,
              value: controller.value,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                  question.toString(),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 200,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: IconButton(
                        onPressed: () {
                          if (question.isCorrect) {
                            correctQuestion++;
                          }
                          setState(() {
                            question = generateQuestion();
                            controller.reset();
                            controller.forward();
                          });
                        },
                        icon: const Icon(Icons.check,
                            size: 100, color: Colors.blue),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: IconButton(
                        onPressed: () {
                          if (!question.isCorrect) {
                            correctQuestion++;
                          }
                          setState(() {
                            question = generateQuestion();
                            controller.reset();
                            controller.forward();
                          });
                        },
                        icon: const Icon(Icons.close,
                            size: 100, color: Colors.red),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ],
        ));
  }

  data generateQuestion() {
    question.isCorrect = Random().nextBool();
    question.firstNumber = Random().nextInt(1000);
    question.secondNumber = Random().nextInt(1000);
    switch (Random().nextInt(4)) {
      case 0:
        question.calculation = '+';
        question.resultNumber = (question.isCorrect
                ? (question.firstNumber + question.secondNumber)
                : (randomError(question.firstNumber + question.secondNumber)))
            .toDouble();
      case 1:
        question.calculation = '-';
        question.resultNumber = (question.isCorrect
                ? (question.firstNumber - question.secondNumber)
                : (randomError(question.firstNumber - question.secondNumber)))
            .toDouble();
      case 2:
        question.calculation = '*';
        question.resultNumber = (question.isCorrect
                ? (question.firstNumber * question.secondNumber)
                : (randomError(question.firstNumber * question.secondNumber)))
            .toDouble();
      case 3:
        question.calculation = '÷';
        if (question.isCorrect) {
          question.resultNumber =
              (question.firstNumber / question.secondNumber);
        } else {
          question.resultNumber =
              (randomError(question.firstNumber ~/ question.secondNumber))
                  .toDouble();
        }
    }
    return question;
  }

  int randomError(int number) {
    int randomNumber;
    do {
      randomNumber = Random().nextInt(1000);
    } while (randomNumber == number);
    return randomNumber;
  }

  void levelOfDifficult(int _time, int totalSentence) {
    time = time;
    total = totalSentence;
    quantityQuestion = totalSentence;
    controller.dispose();
    startTimer(_time);
  }
}

class data {
  int firstNumber = 0;
  int secondNumber = 0;
  double resultNumber = 0;
  String calculation = '';
  bool isCorrect = true;

  @override
  String toString() {
    return '$firstNumber$calculation$secondNumber=${(resultNumber == resultNumber.toInt()) ? resultNumber.toInt() : resultNumber}';
  }
}
