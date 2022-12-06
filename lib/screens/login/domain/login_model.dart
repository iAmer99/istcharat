class LoginModel {
  Data? _data;

  Data? get data => _data;

  LoginModel({
      Data? data}){
    _data = data;
}

  LoginModel.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

class Data {
  int? _id;
  String? _username;
  String? _email;
  Lecturer? _lecturer;
  String? _avatar;
  String? _balance;
  String? _currency;
  String? _role;
  String? _accessToken;
  String? _tokenType;
  int? _expiresIn;

  int? get id => _id;
  String? get username => _username;
  String? get email => _email;
  Lecturer? get lecturer => _lecturer;
  String? get avatar => _avatar;
  String? get balance => _balance;
  String? get currency => _currency;
  String? get role => _role;
  String? get accessToken => _accessToken;
  String? get tokenType => _tokenType;
  int? get expiresIn => _expiresIn;

  Data({
      int? id, 
      String? username, 
      String? email, 
      Lecturer? lecturer, 
      String? avatar, 
      String? balance, 
      String? currency, 
      String? role, 
      String? accessToken, 
      String? tokenType, 
      int? expiresIn}){
    _id = id;
    _username = username;
    _email = email;
    _lecturer = lecturer;
    _avatar = avatar;
    _balance = balance;
    _currency = currency;
    _role = role;
    _accessToken = accessToken;
    _tokenType = tokenType;
    _expiresIn = expiresIn;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _username = json['username'];
    _email = json['email'];
    _lecturer = json['lecturer'] != null ? Lecturer.fromJson(json['lecturer']) : null;
    _avatar = json['avatar'];
    _balance = json['balance'];
    _currency = json['currency'];
    _role = json['role'];
    _accessToken = json['access_token'];
    _tokenType = json['token_type'];
    _expiresIn = json['expires_in'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['username'] = _username;
    map['email'] = _email;
    if (_lecturer != null) {
      map['lecturer'] = _lecturer?.toJson();
    }
    map['avatar'] = _avatar;
    map['balance'] = _balance;
    map['currency'] = _currency;
    map['role'] = _role;
    map['access_token'] = _accessToken;
    map['token_type'] = _tokenType;
    map['expires_in'] = _expiresIn;
    return map;
  }

}

class Lecturer {
  String? _name;
  String? _position;
  String? _university;

  String? get name => _name;
  String? get position => _position;
  String? get university => _university;

  Lecturer({
      String? name, 
      String? position, 
      String? university}){
    _name = name;
    _position = position;
    _university = university;
}

  Lecturer.fromJson(dynamic json) {
    _name = json['name'];
    _position = json['position'];
    _university = json['university'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['name'] = _name;
    map['position'] = _position;
    map['university'] = _university;
    return map;
  }

}