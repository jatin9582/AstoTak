import 'package:flutter/cupertino.dart';

abstract class PanchangView {}

abstract class PanchangPresenter {
  init(BuildContext context, PanchangView view,) {}
}
