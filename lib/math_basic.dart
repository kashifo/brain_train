import 'dart:math';

import 'package:flutter/material.dart';

class MathBasic extends StatefulWidget {
  const MathBasic({super.key});

  @override
  State<MathBasic> createState() => _MathBasicState();
}

class _MathBasicState extends State<MathBasic> {
  int num1 = 0, num2 = 0;
  int score = 0, total = 0;
  int difficulty = 10;
  late FocusNode myFocusNode;
  TextEditingController textarea = TextEditingController();
  Color scoreColor = Colors.black;
  var lastAnswer = "";

  @override
  void initState() {
    super.initState();
    num1 = Random().nextInt(difficulty);
    num2 = Random().nextInt(difficulty);
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Basic Maths Game'),
      ),
      body: Column(
        children: [
          Container(
              width: double.infinity,
              alignment: Alignment.topRight,
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'Score: $score / $total',
                    style: TextStyle(fontSize: 28, color: scoreColor),
                  ),
                  Text(
                    lastAnswer,
                    style: TextStyle(fontSize: 20, color: scoreColor),
                  ),
                ],
              )),
          Expanded(
            child: Container(
              height: double.infinity,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$num1 + $num2',
                    style: TextStyle(fontSize: 72),
                  ),
                  Container(
                    width: 300,
                    child: TextField(
                      autofocus: true,
                      focusNode: myFocusNode,
                      controller: textarea,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24),
                      textInputAction: TextInputAction.next,
                      onSubmitted: (searchVal) {
                        int ans = int.parse(searchVal);

                        setState(() {
                          if (ans == num1 + num2) {
                            print('correct');
                            total += 1;

                            score += 1;
                            scoreColor = Colors.green;

                            if(score%3==0){
                              difficulty += 10;
                            }
                          } else {
                            print('wrong');
                            total += 1;

                            scoreColor = Colors.red;
                          }

                          lastAnswer = "$num1 + $num2 = $ans";
                          num1 = Random().nextInt(difficulty);
                          num2 = Random().nextInt(difficulty);
                        });

                        textarea.clear();
                        myFocusNode.requestFocus();
                      },
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.all(15),
                          hintText: 'Type your answer here',
                          hintStyle: const TextStyle(
                              color: Colors.black38, fontSize: 24),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none)),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
