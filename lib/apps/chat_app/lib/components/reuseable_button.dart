import 'package:flutter/material.dart';

class ReuseableButton extends StatelessWidget {
  const ReuseableButton({
    this.title,
    this.color,
    @required this.onPressed,
  });

  final String title;
  final Color color;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(2.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          colorBrightness: Brightness.dark,
          child: Text(
            title,
          ),
        ),
      ),
    );
  }
}
