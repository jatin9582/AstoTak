class AstrologerModel{
  late int id;
  late String fullName;
  String? imageUrl;
  List<String> languages = [];
  List<String> skills = [];
  late String experience;
  late double pricePerMinute;


  AstrologerModel.fromMap(Map map){
    id = map['id'];
    fullName = "${map['firstName']??''} ${map['lastName']??''}";
    setLanguage(map['languages']);
    setSkills(map['skills']);
    experience = double.parse(map['experience'].toString()).toStringAsFixed(0);
    imageUrl = map['images']['large']['imageUrl'];
    pricePerMinute = map['minimumCallDurationCharges'];
  }

  void setLanguage(List list){
    for(Map m in list){
      languages.add(m['name']);
    }
  }

  void setSkills(List list){
    for(Map m in list){
      skills.add(m['name']);
    }
  }

  void setPricePerMinute(){

  }
}