import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GameBallPage extends StatefulWidget {
  const GameBallPage({super.key});

  @override
  State<GameBallPage> createState() => _GameBallPageState();
}

enum direction { UP, DOWN, LEFT, RIGHT }

class _GameBallPageState extends State<GameBallPage> {
  late Timer _timer;
  direction ballYDirection = direction.UP;
  direction ballXDirection = direction.RIGHT;
  bool hasGameStarted = false;
  double ballX = 0;
  double ballY = 0;
  double ballSpeads = 0.01;

  // player
  double playerX = 0;
  double playerWidth = 0.5;

// start game
  void startGame() {
    hasGameStarted = true;
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      updateDirection();
      moveBall();
    });
  }

  // xử lý va chạm
  void handleCollision() {
    // vị trí tương đối
    double playerLeft = playerX;
    double playerRight = playerX + playerWidth;
    double playerTop = 0.9;
    double playerBottom = playerTop + 0.02;
    // Kiểm tra va chạm
    if (ballX >= playerLeft &&
        ballX <= playerRight &&
        ballY >= playerTop &&
        ballY <= playerBottom) {
      ballYDirection =
          ballYDirection == direction.UP ? direction.DOWN : direction.UP;
    }
  }

  // move ball
  void moveBall() {
    setState(() {
      // move Y
      if (ballYDirection == direction.DOWN) {
        ballY -= ballSpeads;
      } else if (ballYDirection == direction.UP) {
        ballY += ballSpeads;
      }
      // move X
      if (ballXDirection == direction.LEFT) {
        ballX -= ballSpeads;
      } else if (ballXDirection == direction.RIGHT) {
        ballX += ballSpeads;
      }
      handleCollision();
    });
  }

  // updateDirection
  void updateDirection() {
    setState(() {
      if (ballY >= 1) {
        _timer.cancel();
        hasGameStarted = false;
        ballX = 0;
        ballY = 0;
      } else if (ballY <= -1) {
        ballYDirection = direction.UP;
      }
      if (ballX >= 1) {
        ballXDirection = direction.LEFT;
      } else if (ballX <= -1) {
        ballXDirection = direction.RIGHT;
      }
    });
  }

// move left
  void moveLeft() {
    setState(() {
      if (!(playerX <= -1)) {
        playerX -= 0.2;
      }
    });
  }

// move right
  void moveRight() {
    setState(() {
      if (!(playerX + playerWidth >= 1)) {
        playerX += 0.2;
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
        focusNode: FocusNode(),
        autofocus: true,
        onKey: (event) {
          if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
            moveLeft();
          } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
            moveRight();
          }
        },
        child: GestureDetector(
          onTap: () {
            startGame();
          },
          child: Scaffold(
            backgroundColor: Colors.deepPurple[100],
            body: Center(
              child: Stack(
                children: [
                  // tap to play
                  CoverScreen(
                    hasgameStarted: hasGameStarted,
                  ),
                  // ball
                  MyBall(ballX: ballX, ballY: ballY),
                  Container(
                    alignment: Alignment(
                        (2 * playerX + playerWidth) / ((2 - playerWidth)), 0.9),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 10,
                        width:
                            MediaQuery.of(context).size.width * playerWidth / 2,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                  // Container(
                  //   alignment: Alignment((2*playerX + playerWidth)/(2-playerWidth),0.9),
                  //   child: Container(
                  //     color: Colors.red,
                  //
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ));
  }
}

class CoverScreen extends StatelessWidget {
  final bool hasgameStarted;

  const CoverScreen({super.key, required this.hasgameStarted});

  @override
  Widget build(BuildContext context) {
    return (hasgameStarted)
        ? Container()
        : Container(
            alignment: Alignment(0, -0.2),
            child: Text(
              'Tap to play',
              style: TextStyle(color: Colors.deepPurple[400]),
            ),
          );
  }
}

class MyBall extends StatelessWidget {
  final double ballX;
  final double ballY;

  const MyBall({super.key, required this.ballX, required this.ballY});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(ballX, ballY),
      child: Container(
        height: 15,
        width: 15,
        decoration:
            const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
      ),
    );
  }
}
