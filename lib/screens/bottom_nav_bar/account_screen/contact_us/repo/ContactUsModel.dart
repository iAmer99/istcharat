/// data : {"message":"تم إرسال الرسالة بنجاح"}

class ContactUsModel {
  ContactUsModel({
      Data? data,}){
    _data = data;
}

  ContactUsModel.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Data? _data;
ContactUsModel copyWith({  Data? data,
}) => ContactUsModel(  data: data ?? _data,
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

/// message : "تم إرسال الرسالة بنجاح"

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