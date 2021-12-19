// import 'package:digiswasthya_patient/contracts/bookspecialist_contract.dart';
// import 'package:digiswasthya_patient/models/SpecialistModel.dart';
import 'package:astrotak/contracts/astrologerlistcontract.dart';
import 'package:astrotak/model/astrologermodel.dart';
import 'package:astrotak/screens/astologerlist/filterscreen.dart';
import 'package:astrotak/utils/api.dart';
import 'package:flutter/material.dart';


class AstrologerBloc with ChangeNotifier  implements AstrologerListPresenter {
  AstrologerListView? _view;
  BuildContext? _context;
  bool isLoading  = true;
  final TextEditingController searchFieldController = TextEditingController();
  bool isSearchedTap = false;
  Set<String?> languageSet = {};
  Set<String?> skillsSet = {};

  Api api = Api();
  List<AstrologerModel>? astrologerList;

  List<AstrologerModel>? originalList = [];

  void searchedBarOpenClose(bool val){
    isSearchedTap = val;
    searchFieldController.clear();
    astrologerList = originalList;
    notifyListeners();
  }

  void sortList(String type){
    if(type == 'Experience - high to low'){
      astrologerList!.sort((a, b) => double.parse(b.experience).compareTo(double.parse(a.experience)));
      notifyListeners();
      // print(astrologerList!.first.experience);

    }else if(type == 'Experience - low to high'){
      astrologerList!.sort((a, b) => double.parse(a.experience).compareTo(double.parse(b.experience)));
      notifyListeners();
    }else if(type == 'Price - high to low'){
      astrologerList!.sort((a, b) => b.pricePerMinute.compareTo(a.pricePerMinute));
      notifyListeners();

    }else if(type == 'Price - low to high'){
      astrologerList!.sort((a, b) => a.pricePerMinute.compareTo(b.pricePerMinute));
      notifyListeners();

    }
  }
  void listOfAstrologers() {
    api.astrologersList().then((value){
      astrologerList = value;
      originalList = value;
      if(astrologerList!.isNotEmpty){
        for (AstrologerModel model in astrologerList!) {
          languageSet.addAll(model.languages);
          skillsSet.addAll(model.skills);
        }
        print('fdfds $languageSet');
        print('fdfds $skillsSet');
      }
      isLoading = false;
      notifyListeners();
    }).catchError((error){

    });
  }



  @override
  init(BuildContext context, AstrologerListView view) {
    if(_view == null || _context==null ){
      _view = view;
      _context = context;
      listOfAstrologers();
    }
  }

  void searchSpecialistList(String text) {
    List<AstrologerModel> list = [];
    if(text.isNotEmpty && text.length>3){
      astrologerList!.forEach((element) {
        if (element.fullName.toLowerCase().contains(text.toLowerCase()) ||
            element.languages.join(',').toLowerCase().contains(
                text.toLowerCase()) || element.skills.join(',').toLowerCase().contains(
            text.toLowerCase())){
          list.add(element);
        }
      });
      astrologerList = list;
    }
    else if(text.isEmpty || astrologerList!.isEmpty){
      astrologerList = originalList;
    }
    notifyListeners();
  }

  void applyFilter(){
    Navigator.push(
        _context!,
        MaterialPageRoute(
            builder: (_) => FiltersScreen(
                  languagesList: languageSet.toList(),
                  skillsList: skillsSet.toList(),
              onFilter: (p1,p2,p3){
                    List<AstrologerModel>filterList =[];
                    Map map = Map.from(p1);
                    astrologerList!.forEach((element) {
                      bool addIt =true;
                      if(!element.languages.contains(map['language']) && map['language'] !=
                          "ALL"){
                        addIt =false;
                      }
                      if(!element.skills.contains(map['skills']) && map['skills'] != "ALL"){
                        addIt = false;
                      }
                      if (addIt) filterList.add(element);
                    });
                    astrologerList = filterList;
                    notifyListeners();
              },
                )));
  }


}
