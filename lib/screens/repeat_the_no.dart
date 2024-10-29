import 'dart:async';
import 'dart:math';

import 'package:brain_train/utils/common_views.dart';
import 'package:flutter/material.dart';

class RepeatNo extends StatefulWidget {
  const RepeatNo({super.key, required this.appBarTitle});
  final String appBarTitle;

  @override
  State<RepeatNo> createState() => _RepeatNoState();
}

class _RepeatNoState extends State<RepeatNo> {
  final myController = TextEditingController();
  late FocusNode myFocusNode;
  late String randNum;
  int right = 0, wrong = 0, randMax = 9999;
  var currColor = Colors.black;

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
    setNum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: simpleAppBar(widget.appBarTitle, context),
        body: SafeArea(
            child: Column(
          children: [
            Align(
              child: Text('Right: $right, Wrong: $wrong \nLevel: ${randMax.toString().length}', style: TextStyle(fontSize: 22),),
              alignment: Alignment.topRight,
            ),
            Expanded(
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: TextField(
                    autofocus: true,
                    controller: myController,
                    focusNode: myFocusNode,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.go,
                    onSubmitted: (text) {
                      checkSubmission();
                    },
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold,  color: currColor),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white70,
                        contentPadding: const EdgeInsets.all(16),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            )),
                  ),
                ),
              ),
            ),
          ],
        )));
  }

  void checkSubmission() {
    String input = myController.text;
    if (input == randNum) {
      setState(() {
        right += 1;
        setLevel(true);
      });
    } else {
      setState(() {
        wrong += 1;
        setLevel(false);
      });
    }

    setNum();
  }

  void setLevel(bool increase){
    if(increase && right%2==0){
      var randMaxStr = randMax.toString();
      randMaxStr = randMaxStr.padRight( randMaxStr.length+1, '9' );
      randMax = int.parse(randMaxStr);
    } else if(!increase && wrong%2==0){
      String randMaxStr = randMax.toString();
      int len = randMaxStr.length;
      String freshRandMaxStr = '9';

      var randMaxStr2 = randMaxStr;
      if(len>4){
        randMaxStr2 = freshRandMaxStr.padRight(len-1, '9');
      }

      randMax = int.parse(randMaxStr2);
    }
  }

  void setNum() {
    randNum = Random().nextInt( randMax ).toString();
    setState(() {
      currColor = Colors.green;
    });
    myController.text = randNum;

    Timer(Duration(seconds: 2), hideNum);
  }

  void hideNum() {

    setState(() {
      currColor = Colors.black;
    });

    myController.text = '';
    myFocusNode.requestFocus();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    myFocusNode.dispose();
    super.dispose();
  }
}
