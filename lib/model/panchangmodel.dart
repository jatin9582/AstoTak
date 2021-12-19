class PanchangModel {

 late String sunrise;
 late String sunset;
 late String moonrise;
 late String moonSet;
 late Map Tithi;
 late Map Nakshatra;
 late Map Yog;

 PanchangModel.fromMap(Map data){
   sunrise = data['sunrise']??'';
   sunset = data['sunset']??'';
   moonrise = data['moonrise']??'';
   moonSet = data['moonset']??'';
   Tithi = data['tithi']??{};
   Nakshatra = data['nakshatra']??{};
   Yog = data['yog']??{};
 }

}