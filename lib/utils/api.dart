
import 'dart:io';
import 'package:astrotak/model/locationmodel.dart';
import 'package:astrotak/model/panchangmodel.dart';
import 'package:dio/dio.dart' as dio;

import 'package:astrotak/model/astrologermodel.dart';
import 'package:dio/dio.dart';

class Api {

  Map<String, String> getHeader() {
    Map<String, String> header = Map();
    header[HttpHeaders.contentTypeHeader] = ContentType.json.value;
    return header;
  }

  dio.Dio getDio(){
    final myDio = dio.Dio(dio.BaseOptions());
    myDio.options.headers = getHeader();
    return myDio;
  }


  Future<List<AstrologerModel>> astrologersList() async {
    try{
      Response response = await getDio().get('https://www.astrotak.com/astroapi/api/agent/all');

      print(response.statusCode);
      List<AstrologerModel> astrologerList = [];
      if(response.statusCode == 200){
        print(response.data);
        List list = response.data['data'];
        print('$list');
        for(Map m in list){
          AstrologerModel astrologerModel = AstrologerModel.fromMap(m);
          astrologerList.add(astrologerModel);
        }
        print(astrologerList.length);
        return astrologerList;
      }
      return astrologerList;

    }catch(e){
      print(e);
      rethrow;
    }
  }


  Future<List<LocationModel>> locList(String text) async {
    try{
      Response response = await getDio().get('https://www.astrotak.com/astroapi/api/location/place?inputPlace=$text');

      print(response.statusCode);
      List<LocationModel> locationList = [];
      if(response.statusCode == 200){
        print(response.data);
        List list = response.data['data'];
        print('$list');
        for(Map m in list){
          LocationModel locModel = LocationModel(m['placeId'],m['placeName']);
          locationList.add(locModel);
        }
        print(locationList.length);
        return locationList;
      }
      return locationList;

    }catch(e){
      print(e);
      rethrow;
    }
  }

  Future<PanchangModel?> panchangGet(DateTime time,LocationModel locationModel) async {
    Map data = {
      "day":time.day,
      "month":time.month,
      "year":time.year,
      "placeId":locationModel.placeId
    };
    try{
      Response response = await getDio().post('https://www.astrotak.com/astroapi/api/horoscope/daily/panchang',data: data);

      print(response.statusCode);
      if(response.statusCode == 200){
        print(response.data);
        PanchangModel panchangModel = PanchangModel.fromMap(response.data['data']);
        return panchangModel;
      }
      return null;

    }catch(e){
      print(e);
      rethrow;
    }
  }



}