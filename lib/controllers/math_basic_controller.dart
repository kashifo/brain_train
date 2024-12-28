import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MathBasicController extends GetxController{
  int num1 = 0, num2 = 0;
  int score = 0, total = 0;
  int difficulty = 10;
  late FocusNode myFocusNode;
  TextEditingController textarea = TextEditingController();
  Color scoreColor = Colors.black, inputColor = Colors.black;
  var lastAnswer = "";
  var showError = false.obs;

  void toggleShowError(bool value) {
    showError.value = value;
    update(); // Notify GetBuilder to rebuild
  }

  @override
  void onInit() async {
    super.onInit();

    num1 = Random().nextInt(difficulty);
    num2 = Random().nextInt(difficulty);
    myFocusNode = FocusNode();
  }

  @override
  void onClose() {
    super.onClose();
    myFocusNode.dispose();
  }

  onSubmit(searchVal){
    int ans = int.parse(searchVal);

    if (ans == num1 + num2) {
      print('correct');
      reload(ans, true);
    } else {
      if (showError.value) {
        inputColor = Colors.red;
        myFocusNode.requestFocus();
      } else {
        print('wrong');
        reload(ans, false);
      }
    }

    update();
  }

  reload(int ans, bool isCorrect){
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

    textarea.clear();
    myFocusNode.requestFocus();
    update();
  }


}