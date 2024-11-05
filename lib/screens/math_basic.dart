import 'dart:math';

import 'package:brain_train/components/simple_app_bar.dart';
import 'package:flutter/material.dart';

import '../components/simple_app_bar_with_switch.dart';

class MathBasic extends StatefulWidget {
  const MathBasic({super.key, required this.appBarTitle});
  final String appBarTitle;

  @override
  State<MathBasic> createState() => _MathBasicState();
}

class _MathBasicState extends State<MathBasic> {
  int num1 = 0, num2 = 0;
  int score = 0, total = 0;
  int difficulty = 10;
  late FocusNode myFocusNode;
  TextEditingController textarea = TextEditingController();
  Color scoreColor = Colors.black, inputColor = Colors.black;
  var lastAnswer = "";
  bool showError = false;

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

  void _handleSwitchChange(bool value) {
    setState(() {
      showError = value;  // Update the local state when the switch changes
    });
  }

  reload(int ans, bool isCorrect){
    setState(() {
      if(isCorrect){
        total += 1;
        score += 1;
        scoreColor = Colors.green;

        if (score % 3 == 0) {
          difficulty += 10;
        }
      }else{
        total += 1;
        scoreColor = Colors.red;
      }

      lastAnswer = "$num1 + $num2 = $ans";
      num1 = Random().nextInt(difficulty);
      num2 = Random().nextInt(difficulty);
    });

    textarea.clear();
    myFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: SimpleAppBarWithSwitch(
        appBarTitle: widget.appBarTitle,  // Pass the app bar title
        isTrue: showError,  // Pass the current state of the switch
        onChanged: _handleSwitchChange,  // Callback to update the state
      ),
      body: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
              width: double.infinity,
              alignment: Alignment.topRight,
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'Score: $score / $total',
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    lastAnswer,
                    style: TextStyle(fontSize: 22, color: scoreColor),
                  ),
                ],
              )),
          Container(
            height: double.infinity,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$num1 + $num2',
                  style: TextStyle(fontSize: 64),
                ),
                Container(
                  width: 300,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: const Color(0xff1D1617).withOpacity(0.11),
                        blurRadius: 40,
                        spreadRadius: 0.0)
                  ]),
                  child: TextField(
                    autofocus: true,
                    focusNode: myFocusNode,
                    controller: textarea,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, color: inputColor),
                    textInputAction: TextInputAction.next,
                    onChanged: (value){
                      if(showError) {
                        inputColor = Colors.black;
                      }
                    },
                    onSubmitted: (searchVal) {
                      int ans = int.parse(searchVal);

                      if (ans == num1 + num2) {
                        print('correct');
                        reload(ans, true);
                      } else {
                        if (showError) {
                          setState(() {
                            inputColor = Colors.red;
                          });
                          myFocusNode.requestFocus();
                        } else {
                          print('wrong');
                          reload(ans, false);
                        }
                      }

                    },//onSubmitted
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
          )
        ],
      ),
    );
  }
}
