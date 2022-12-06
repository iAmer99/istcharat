/// data : {"message":"Validation code has been sent to your email."}

class ForgetPasswordModel {
  ForgetPasswordModel({
      Data? data,}){
    _data = data;
}

  ForgetPasswordModel.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Data? _data;
ForgetPasswordModel copyWith({  Data? data,
}) => ForgetPasswordModel(  data: data ?? _data,
);
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// message : "Validation code has been sent to your email."

class Data {
  Data({
      String? message,}){
    _message = message;
}

  Data.fromJson(dynamic json) {
    _message = json['message'];
  }
  String? _message;
Data copyWith({  String? message,
}) => Data(  message: message ?? _message,
);
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    return map;
  }

}