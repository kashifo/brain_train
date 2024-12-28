import 'package:brain_train/controllers/math_basic_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/simple_app_bar_with_switch.dart';

class MathBasic extends StatelessWidget {
  const MathBasic({super.key, required this.appBarTitle});
  final String appBarTitle;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MathBasicController>(
      init: MathBasicController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: SimpleAppBarWithSwitch(
            appBarTitle: appBarTitle,
            isTrue: controller.showError.value,
            onChanged: (value) {
              controller.toggleShowError(value);
            },
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
                        'Score: ${controller.score} / ${controller.total}',
                        style: TextStyle(fontSize: 24),
                      ),
                      Text(
                        controller.lastAnswer,
                        style: TextStyle(fontSize: 22, color: controller.scoreColor),
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
                      '${controller.num1} + ${controller.num2}',
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
                        focusNode: controller.myFocusNode,
                        controller: controller.textarea,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 24, color: controller.inputColor),
                        textInputAction: TextInputAction.next,
                        onChanged: (value){
                          if(controller.showError.value) {
                            controller.inputColor = Colors.black;
                          }
                        },
                        onSubmitted: (searchVal) {
                          controller.onSubmit(searchVal);
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
    );
  }
}
