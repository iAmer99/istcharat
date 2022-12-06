/// row : {"id":8,"image":"https://api-istchrat.mazadak.net/uploads/users/2022-03-25-05-12-08-0623df7e88b420.9j","name":"Ahmed Ali","email":"aa@gmail.com","mobile":"51084200"}

class EditAccInfoModel {
  EditAccInfoModel({
      Row? row,}){
    _row = row;
}

  EditAccInfoModel.fromJson(dynamic json) {
    _row = json['row'] != null ? Row.fromJson(json['row']) : null;
  }
  Row? _row;

  Row? get row => _row;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_row != null) {
      map['row'] = _row?.toJson();
    }
    return map;
  }

}

/// id : 8
/// image : "https://api-istchrat.mazadak.net/uploads/users/2022-03-25-05-12-08-0623df7e88b420.9j"
/// name : "Ahmed Ali"
/// email : "aa@gmail.com"
/// mobile : "51084200"

class Row {
  Row({
      int? id, 
      String? image, 
      String? name, 
      String? email, 
      String? mobile,}){
    _id = id;
    _image = image;
    _name = name;
    _email = email;
    _mobile = mobile;
}

  Row.fromJson(dynamic json) {
    _id = json['id'];
    _image = json['image'];
    _name = json['name'];
    _email = json['email'];
    _mobile = json['mobile'];
  }
  int? _id;
  String? _image;
  String? _name;
  String? _email;
  String? _mobile;

  int? get id => _id;
  String? get image => _image;
  String? get name => _name;
  String? get email => _email;
  String? get mobile => _mobile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['image'] = _image;
    map['name'] = _name;
    map['email'] = _email;
    map['mobile'] = _mobile;
    return map;
  }

}