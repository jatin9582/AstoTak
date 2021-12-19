import 'package:astrotak/contracts/panchangcontract.dart';
import 'package:astrotak/model/locationmodel.dart';
import 'package:astrotak/model/panchangmodel.dart';
import 'package:astrotak/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class PanchangBloc with ChangeNotifier implements PanchangPresenter{

  PanchangView? _view;
  BuildContext? _context;
  Api api = Api();
  bool panchangSearched = false;
  PanchangModel? panchangModel;
  final TextEditingController locFieldController = TextEditingController();


  @override
  init(BuildContext context, PanchangView view) {
    if(_view == null || _context == null){
      _view = view;
      _context = context;
    }
  }


  void panchangGet(DateTime dateTime,LocationModel locationModel){
    api.panchangGet(dateTime, locationModel).then((value){
      if(value != null){
        panchangModel = value;
        panchangSearched = true;
        notifyListeners();
      }
    }).catchError((error){

    });
  }


}