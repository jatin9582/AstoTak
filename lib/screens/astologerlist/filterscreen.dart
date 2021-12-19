import 'package:astrotak/blocs/mapfilterbloc.dart';
import 'package:astrotak/callbacks/clickcallbacks.dart';
import 'package:astrotak/screens/astologerlist/radiobox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class FiltersScreen extends StatefulWidget {
  final ClickCallback? onFilter;
  List<String?>? skillsList =[];
  List<String?>? languagesList= [];

  FiltersScreen(
      {this.skillsList,
        this.languagesList,
        this.onFilter});

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
//  CustomProgressDialog customProgressDialog = CustomProgressDialog();
  MapsFilterBloc mapsFilterBloc = MapsFilterBloc();

  @override
  void initState() {
    super.initState();

    mapsFilterBloc.filterData['language'] = "ALL";
    mapsFilterBloc.filterData['skills'] = "ALL";

    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      mapsFilterBloc.refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading:  IconButton(icon:Icon(Icons.arrow_back),color: Colors.black,onPressed: (){
            Navigator.pop(context);
          },),
          title: Text(
            'Filter',
            style: Theme.of(context).textTheme.headline6!.apply(color: Colors.black),
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          height: 60,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(5),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    mapsFilterBloc.filterData = Map();
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.red,
                    child: Text(
                      'CANCEL',
                      style: Theme.of(context).textTheme.subtitle2!.apply(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    applyFilter(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.green,
                    child: Text(
                      'APPLY FILTER',
                      style: Theme.of(context).textTheme.subtitle2!.apply(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
            child: StreamBuilder<Object>(
                stream: mapsFilterBloc.refreshController,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.waiting &&
                      snapshot.data as bool) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            'Language',
                            style: Theme.of(context)
                                .primaryTextTheme
                                .subtitle1!
                                .apply(fontWeightDelta: 2,color: Colors.black),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 8.0),
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            color: Colors.white,
                            child: Wrap(
                                direction: Axis.horizontal,
                                children: List.generate(
                                    widget.languagesList!.length + 1,
                                        (index) {
                                      if (index == 0) {
                                        return MyRadioBox(
                                          "ALL",
                                          mapsFilterBloc.filterData['language'],
                                          value: "ALL",
                                          onPressed: (d1, d2, d3) {
                                            setParam('language', d1);
                                          },
                                        );
                                      } else {
                                        return MyRadioBox(
                                          widget.languagesList![index - 1]!,
                                          mapsFilterBloc
                                              .filterData['language'],
                                          value:
                                          widget.languagesList![index - 1],
                                          onPressed: (d1, d2, d3) {
                                            setParam('language', d1);
                                          },
                                        );
                                      }
                                    })),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Text(
                            'Skills',
                            style: Theme.of(context)
                                .primaryTextTheme
                                .subtitle1!
                                .apply(fontWeightDelta: 2,color: Colors.black),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 8.0),
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            color: Colors.white,
                            child: Wrap(
                                direction: Axis.horizontal,
                                children: List.generate(
                                    widget.skillsList!.length + 1, (index) {
                                  if (index == 0) {
                                    return MyRadioBox(
                                      "ALL",
                                      mapsFilterBloc.filterData['skills'],
                                      value: "ALL",
                                      onPressed: (d1, d2, d3) {
                                        setParam('skills', d1);
                                      },
                                    );
                                  } else {
                                    return MyRadioBox(
                                      widget.skillsList![index - 1]!,
                                      mapsFilterBloc.filterData['skills'],
                                      value: widget.skillsList![index - 1],
                                      onPressed: (d1, d2, d3) {
                                        setParam('skills', d1);
                                      },
                                    );
                                  }
                                })),
                          ),
                        ),
                      ],
                    );
                  }
                  return CircularProgressIndicator();
                }),
          ),
        ));
  }

  void setParam(String key, dynamic val) {
    mapsFilterBloc.filterData[key] = val;
    mapsFilterBloc.refresh();
  }


  void applyFilter(BuildContext context) {
    Navigator.pop(context);
    if (mapsFilterBloc.filterData.isNotEmpty)
      widget.onFilter!(mapsFilterBloc.filterData, null, null);
  }


  @override
  void dispose() {
    super.dispose();
    mapsFilterBloc.dispose();
  }
}
