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
  String wrongQuestion='', wrongAnswer='';

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
    setNum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
        appBar: simpleAppBar(widget.appBarTitle, context),
        body: SafeArea(
            child: Column(
          children: [
            Align(
              child: Text('LEVEL: ${randMax.toString().length}', style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check, color: Colors.green,),
                Text(right.toString()),
                SizedBox(width: 8),
                Icon(Icons.close, color: Colors.red,),
                Text(wrong.toString()),
              ],
            ),
            SizedBox(width: 8),
            RichText(text: TextSpan(
              children: [
                TextSpan(
                  text: '$wrongQuestion  ',
                  style: TextStyle(color: Colors.green, fontSize: 18)
                ),
                TextSpan(
                    text: wrongAnswer,
                    style: TextStyle(color: Colors.red, fontSize: 18)
                )
              ]
            )),

            Expanded(
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: const Color(0xff1D1617).withOpacity(0.11),
                        blurRadius: 40,
                        spreadRadius: 0.0)
                  ]),
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
                            borderSide: BorderSide.none)),
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

        wrongQuestion='';
        wrongAnswer='';

        setLevel(true);
      });
    } else {
      setState(() {
        wrong += 1;

        wrongQuestion=randNum;
        wrongAnswer=input;

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
