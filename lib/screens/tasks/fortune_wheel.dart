import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firstapp/data/data.dart'; 

import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

class FortuneWheelScreen extends StatefulWidget {
  @override
  _FortuneWheelScreenState createState() => _FortuneWheelScreenState();
}

class _FortuneWheelScreenState extends State<FortuneWheelScreen> {
  final StreamController<int> _controller = StreamController<int>();
  bool _showingResult = false;

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fortune Wheel',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.width * 1.2,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FortuneWheel(
                      selected: _controller.stream,
                      animateFirst: false,
                      duration: Duration(seconds: 5),
                      items: [
                        for (int i = 0; i < catData.length; i++)
                          FortuneItem(
                            child: Text(
                              catData[i]['name'],
                              style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 202, 201, 201),
                              ),
                            ),
                          ),
                      ],
                      onAnimationEnd: () {
                        //Future.delayed(Duration(seconds: 5));                       
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 150,
              height: kToolbarHeight,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.tertiary,
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                  transform: const GradientRotation(pi / 6),
                ),
                borderRadius: BorderRadius.circular(45),
              ),
              child: ElevatedButton(
                onPressed: () {
                  final randomIndex = Random().nextInt(catData.length);
                  _controller.add(randomIndex); // 添加隨機索引
                  _showResultDialog(context, catData[randomIndex]); // 顯示結果對話框
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45),
                  ),
                ),
                child: Text(
                  'Spin the Wheel',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 202, 201, 201),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showResultDialog(BuildContext context, Map<String, dynamic> selectedItem) {
    // Delay for 5 seconds before showing the dialog
    Future.delayed(Duration(seconds: 5), () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Raffle Results',
              style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
              ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20),
                Image.asset(
                  'assets/${selectedItem['image']}.png',
                  height: 180,
                ),
                SizedBox(height: 20),
                Text(
                  selectedItem['name'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  ),
                
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    });
  }
  }
