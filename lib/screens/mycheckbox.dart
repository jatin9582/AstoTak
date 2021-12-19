import 'package:astrotak/callbacks/clickcallbacks.dart';
import 'package:flutter/material.dart';

class MyCheckBox extends StatefulWidget {
  Text text;
  bool isChecked = false;
  ClickCallback? onPressed;

  MyCheckBox(this.text, {this.isChecked = false, this.onPressed});

  @override
  _MyCheckBoxState createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {

        if( widget.onPressed!=null) {
          widget.isChecked = !widget.isChecked;


          widget.onPressed!( widget.isChecked, null, null );

          setState( () {} );
        }
      },
      child: Container(
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            widget.isChecked
                ? const Icon(
              Icons.check_circle,
              color:Colors.red,
              size: 25,
            )
                : Icon(
              Icons.radio_button_unchecked,
              color: Theme.of(context).iconTheme.color,
              size: 25,
            ),
            Padding(padding: EdgeInsets.only(left: 8)),
            Flexible(child: widget.text),
          ],
        ),
      ),
    );
  }
}
