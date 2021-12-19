import 'package:rxdart/rxdart.dart';

class MapsFilterBloc {
  var refreshController = BehaviorSubject<bool>();

  Map<String, dynamic> filterData = {};

  void refresh() {
    refreshController.add(true);
  }

  dispose() {
    filterData.clear();
    refreshController.close();
  }
}
