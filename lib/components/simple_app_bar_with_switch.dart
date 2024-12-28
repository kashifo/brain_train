import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SimpleAppBarWithSwitch extends StatelessWidget
    implements PreferredSizeWidget {
  final String appBarTitle;
  final bool isTrue;
  final ValueChanged<bool> onChanged;

  const SimpleAppBarWithSwitch({
    required this.appBarTitle,
    required this.isTrue,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(appBarTitle),
      automaticallyImplyLeading: false,
      elevation: 2.0,
      actions: [
        Transform.scale(
          scale: 0.8,
          child: Switch(
            inactiveThumbColor: Colors.grey,
            activeColor: Colors.black,

            trackOutlineColor: MaterialStateProperty.all(Colors.black),
            trackColor: MaterialStateProperty.all(Colors.grey.shade300),

            value: isTrue,
            onChanged: onChanged,
          ),
        ),
        SizedBox(width: 16),
        InkWell(
          onTap: () {
            // Navigator.pop(context);
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(Icons.close),
          ),
        ),
        SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
