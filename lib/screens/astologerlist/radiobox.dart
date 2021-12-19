
import 'package:astrotak/callbacks/clickcallbacks.dart';
import 'package:flutter/material.dart';

class MyRadioBox extends StatefulWidget {
  String text;
  dynamic groupValue;
  dynamic value;
  ClickCallback? onPressed;

  MyRadioBox(this.text, this.groupValue, {this.value, this.onPressed});

  @override
  _MyRadioBoxState createState() => _MyRadioBoxState();
}

class _MyRadioBoxState extends State<MyRadioBox> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        widget.onPressed!(widget.value, null, null);
      },
      child: Container(
        padding: EdgeInsets.only(right: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Radio(
              activeColor: Colors.red,
              value: widget.value,
              groupValue: widget.groupValue,
              onChanged: (dynamic v) {
                widget.onPressed!(widget.value, null, null);
              },
            ),
            Text(
              widget.text,
              style: Theme.of(context).primaryTextTheme.caption!.apply(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
