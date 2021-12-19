import 'package:astrotak/blocs/astrologerbloc.dart';
import 'package:astrotak/contracts/astrologerlistcontract.dart';
import 'package:astrotak/screens/astologerlist/astrologercard.dart';
import 'package:astrotak/screens/listdialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AstrologerListPage extends StatelessWidget implements AstrologerListView {
  List ls = [{}, {}, {}, {}, {}, {}];
  late AstrologerBloc _astrologerBloc;
  String selectedFilter = '';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AstrologerBloc>(
      create: (context) => AstrologerBloc(),
      builder: (ctx, child) {
        _astrologerBloc = Provider.of<AstrologerBloc>(ctx);
        _astrologerBloc.init(ctx, this);
        return Consumer<AstrologerBloc>(builder: (ctx, bloc, child) {
          return bloc.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Talk to an Astrologer',
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 18),
                          ),
                          Row(
                            children: [
                              imageButton('assets/images/search.png', () {
                                bloc.searchedBarOpenClose(true);
                              }),
                              const SizedBox(
                                width: 10,
                              ),
                              imageButton('assets/images/filter.png', () {
                                bloc.applyFilter();
                              }),
                              const SizedBox(
                                width: 10,
                              ),
                              imageButton('assets/images/sort.png', () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      String? selectedFilter2 =
                                          selectedFilter;

                                      int selectedIndex = 0;
                                      return AlertDialog(
                                          title: Text(
                                            'Sort by',
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .subtitle1!.apply(color: Colors.black),
                                          ),
                                          actions: <Widget>[
                                            GestureDetector(
                                              behavior:
                                              HitTestBehavior.translucent,
                                              onTap: () {
                                                Navigator.pop(context);
                                                // sortColumn(
                                                //     selectedIndex);
                                                selectedFilter =
                                                    selectedFilter2!;
                                                bloc.sortList(selectedFilter);

                                                // setState(() {});
                                              },
                                              child: Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(
                                                    left: 20.0,
                                                    right: 20,
                                                    top: 10,
                                                    bottom: 10),
                                                child: Text('OK'),
                                              ),
                                            ),
                                            GestureDetector(
                                              behavior:
                                              HitTestBehavior
                                                  .translucent,
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                    left: 20.0,
                                                    right: 20,
                                                    top: 10,
                                                    bottom: 10),
                                                child: Text('CANCEL'),
                                              ),
                                            )
                                          ],
                                          content: ListDialog(
                                            ['Experience - high to low','Experience - low to high','Price - high to low','Price - low to high'],
                                            selectedFilter: selectedFilter2,
                                            onPressed: (d1, d2, d3) {
                                              selectedFilter2 = d1;
                                              selectedIndex = d2;
                                            },
                                          ));
                                    });
                              }),
                            ],
                          )
                        ],
                      ),
                      bloc.isSearchedTap?SizedBox(height: 10,):Container(),
                      bloc.isSearchedTap?Card(
                        child: Container(
                          height: 60,
                          color: const Color(0xffFAFAFA),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Image.asset("assets/images/search.png",width: 25,height: 25,),
                              ),
                              Flexible(
                                child: TextField(
                                  maxLines: 1,
                                  controller: bloc.searchFieldController,
                                  onChanged: (str) async {
                                    bloc.searchSpecialistList(str);
                                  },
                                  onSubmitted: (str) {
                                    bloc.searchSpecialistList(str);
//                                _bookSpecialistScreenBloc.filterSpecialistList(str);
                                  },
                                  decoration: const InputDecoration(
                                    // fillColor:Color(0xffFAFAFA),
                                    // filled: true,
                                    contentPadding: EdgeInsets.all(20),

                                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                                    hintText: 'Search Astrologer',
                                    border: InputBorder.none
                                    //fillColor: Colors.green
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0,right: 10),
                                child: GestureDetector(
                                  onTap: (){
                                    bloc.searchedBarOpenClose(false);
                                  },
                                    child: const Icon(Icons.close,size: 20,color: Color( 0xffFF944D),)),
                              ),
                            ],
                          ),
                        ),
                      ):Container(),
                      const SizedBox(
                        height: 20,
                      ),
                      Flexible(
                        child: ListView.builder(
                            itemCount: bloc.astrologerList!.length,
                            itemBuilder: (BuildContext ctx, int index) {
                              return AstrologerCard(bloc.astrologerList![index]);
                            }),
                      )
                    ],
                  ),
                );
        });
      },
    );
  }

  Widget imageButton(String image, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        image,
        width: 30,
        height: 30,
      ),
    );
  }



}
