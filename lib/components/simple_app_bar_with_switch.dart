import 'package:flutter/material.dart';

class SimpleAppBarWithSwitch extends StatefulWidget
    implements PreferredSizeWidget {
  final String appBarTitle;
  final bool isTrue;
  final Function(bool) onChanged;

  const SimpleAppBarWithSwitch({
    required this.appBarTitle,
    required this.isTrue,
    required this.onChanged,
    super.key,
  });

  @override
  State<SimpleAppBarWithSwitch> createState() => _SimpleAppBarWithSwitchState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _SimpleAppBarWithSwitchState extends State<SimpleAppBarWithSwitch> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.appBarTitle),
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

            value: widget.isTrue,
            onChanged: (value) {
              widget.onChanged(value);  // Notify parent when switch is toggled
            },
          ),
        ),
        SizedBox(width: 16),
        InkWell(
          onTap: () {
            Navigator.pop(context);
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
}
