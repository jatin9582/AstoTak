
import 'package:astrotak/callbacks/clickcallbacks.dart';
import 'package:flutter/material.dart';

import 'mycheckbox.dart';

class ListDialog extends StatefulWidget {
  String? selectedFilter;
  ClickCallback? onPressed;
  List<String>? list;

  ListDialog(this.list, {this.selectedFilter = '', this.onPressed});

  @override
  _ListDialogState createState() => _ListDialogState();
}

class _ListDialogState extends State<ListDialog> {
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(widget.list!.length, (i) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              MyCheckBox(
                Text(
                  widget.list![i].toUpperCase(),
                  style: Theme.of(context).primaryTextTheme.subtitle1!.apply(color: Colors.black),
                ),
                isChecked: widget.selectedFilter!.contains(widget.list![i]),
                onPressed: (d1, d2, d3) {
                  widget.selectedFilter = widget.list![i];
                  widget.onPressed!(widget.selectedFilter, i, null);
                  setState(() {});
                },
              ),
              Divider(),
            ],
          );
        }),
      ),
    );
  }
}
