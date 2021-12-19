import 'package:astrotak/blocs/panchangbloc.dart';
import 'package:astrotak/contracts/panchangcontract.dart';
import 'package:astrotak/model/locationmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PanchangPage extends StatelessWidget implements PanchangView{

  final TextEditingController dateFieldController = TextEditingController();
  late PanchangBloc _panchangBloc;
  DateTime? _picked;
  LocationModel? locationModel;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PanchangBloc>(
      create: (context)=>PanchangBloc(),
      builder: (ctx, child) {
        _panchangBloc = Provider.of<PanchangBloc>(ctx);
        _panchangBloc.init(ctx, this);

        return Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 10.0, vertical: 10),
          child: ListView(
            children: [
              const Text('Daily Panchang',style: TextStyle(
                  fontWeight: FontWeight.w800, fontSize: 18),),
              const SizedBox(height: 20,),
              Container(
                color: Colors.pink.withOpacity(0.1),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Expanded(child: Text('Date:',style: TextStyle(fontSize: 16),textAlign: TextAlign.center,)),
                        const SizedBox(width: 10,),
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: ()async {
                              final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: _picked??DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now().add(Duration(days: 365)),
                                  // confirmText: 'SET DATE',
                                 );
                              if (picked != null) {
                                print('picked $picked');
                                _picked = picked;
                                dateFieldController.text = DateFormat("dd MMMM, yyyy").format(picked);
                                if(locationModel != null){
                                  _panchangBloc.panchangGet(_picked!, locationModel!);
                                }
                              }
                            },
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  height: 50,
                                  // width: MediaQuery.of(context).size.width*0.6,
                                  child: TextField(
                                    controller: dateFieldController,
                                    maxLines: 1,
                                    decoration: const InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                                      border: InputBorder.none,
                                      //fillColor: Colors.green
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.transparent,
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        const Expanded(child: Text('Location:',style: TextStyle(fontSize: 16),textAlign: TextAlign.center,)),
                        const SizedBox(width: 10,),
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            height: 50,
                            // width: MediaQuery.of(context).size.width*0.58,
                            child: TypeAheadField<LocationModel>(
                              textFieldConfiguration:  TextFieldConfiguration(
                                  // autofocus: true,
                                  decoration: const InputDecoration(
                                      border:  InputBorder.none,
                                    fillColor: Colors.white,
                                    filled: true
                                  ),
                                controller: _panchangBloc.locFieldController
                              ),
                              suggestionsCallback: (pattern) async {
                                return await _panchangBloc.api.locList(pattern);
                              },
                              itemBuilder: (context, suggestion) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(suggestion.placeName),
                                );
                              },
                              errorBuilder: (ctx,error){
                                return Container(color: Colors.transparent,);
                              },
                              hideOnError: true,
                              hideOnLoading: true,
                              // hideOnEmpty: true,
                              onSuggestionSelected: (suggestion) {
                                print(suggestion.placeName);
                                locationModel = suggestion;
                                _panchangBloc.locFieldController.text = suggestion.placeName;
                                if(_picked != null){
                                  _panchangBloc.panchangGet(_picked!, suggestion);
                                }

                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) => ProductPage(product: suggestion)
                                // ));
                              },
                            )
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Consumer<PanchangBloc>(
                builder: (ctx,bloc,child) {
                  return bloc.panchangSearched?Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20,),
                      const Text('Tithi',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w800),),
                            titleAndDesc(
                                'Tithi Number',
                                bloc.panchangModel!
                                    .Tithi['details']['tithi_number']
                                    .toString()),
                            titleAndDesc(
                                'Tithi Name',
                                bloc.panchangModel!
                                    .Tithi['details']['tithi_name']
                                    .toString()),
                            titleAndDesc(
                                'Special',
                                bloc.panchangModel!.Tithi['details']['special']
                                    .toString()),
                            titleAndDesc(
                                'Summary',
                                bloc.panchangModel!.Tithi['details']['summary']
                                    .toString()),
                            titleAndDesc(
                                'Deity',
                                bloc.panchangModel!.Tithi['details']['deity']
                                    .toString()),
                            titleAndDesc('End Time',
                                '${bloc.panchangModel!.Tithi['end_time']['hour']}hr ${bloc.panchangModel!.Tithi['end_time']['minute']}min ${bloc.panchangModel!.Tithi['end_time']['second']}sec'),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text('Nakshatra',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w800),),
                      titleAndDesc('Nakshatra Number',bloc.panchangModel!
                          .Nakshatra['details']['nak_number']
                          .toString()),
                      titleAndDesc('Nakshatra Name',bloc.panchangModel!
                          .Nakshatra['details']['nak_name']
                          .toString()),
                      titleAndDesc('Ruler',bloc.panchangModel!
                          .Nakshatra['details']['ruler']
                          .toString()),
                      titleAndDesc('Deity',bloc.panchangModel!
                          .Nakshatra['details']['deity']
                          .toString()),
                      titleAndDesc('Special',bloc.panchangModel!
                          .Nakshatra['details']['special']
                          .toString()),
                      titleAndDesc('Summary',bloc.panchangModel!
                          .Nakshatra['details']['summary']
                          .toString()),
                      titleAndDesc('End Time',
                          '${bloc.panchangModel!.Nakshatra['end_time']['hour']}hr ${bloc.panchangModel!.Nakshatra['end_time']['minute']}min ${bloc.panchangModel!.Nakshatra['end_time']['second']}sec'),
                      const SizedBox(height: 20,),
                      const Text('Yog',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w800),),
                      titleAndDesc('Yog Number',bloc.panchangModel!
                          .Yog['details']['yog_number']
                          .toString()),
                      titleAndDesc('Yog Name',bloc.panchangModel!
                          .Yog['details']['yog_name']
                          .toString()),
                      titleAndDesc('Special',bloc.panchangModel!
                          .Yog['details']['special']
                          .toString()),
                      titleAndDesc('Meaning',bloc.panchangModel!
                          .Yog['details']['meaning']
                          .toString()),
                      titleAndDesc('End Time',
                          '${bloc.panchangModel!.Yog['end_time']['hour']}hr ${bloc.panchangModel!.Yog['end_time']['minute']}min ${bloc.panchangModel!.Yog['end_time']['second']}sec'),
                    ],
                  ):Container();
                }
              )

            ],
          ),
        );
      }
    );
  }

  Widget titleAndDesc(String title,String desc){
    return Padding(
      padding: const EdgeInsets.only(top:10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: Text(
                "$title:",
                style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),
              )),
          Expanded(
              flex: 1,
              child: Text(
                  desc,
                  // style: Theme.of(context)
                  //     .primaryTextTheme
                  //     .caption
              )),
        ],
      ),
    );
  }
}