/// data : {"rows":[{"id":1,"notification":"تلقي إشعارات بالدوارات والكتب الجديدة","status":true},{"id":2,"notification":"التذكير بموعد الدوارات الأونلاين","status":true},{"id":3,"notification":"العروض والخصومات","status":true},{"id":4,"notification":"رسائل البريد الإلكتروني","status":true},{"id":5,"notification":"رسائل الجوال النصية","status":false}]}

class AccountNotificationsModel {
  AccountNotificationsModel({
      Data? data,}){
    _data = data;
}

  AccountNotificationsModel.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Data? _data;

  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// rows : [{"id":1,"notification":"تلقي إشعارات بالدوارات والكتب الجديدة","status":true},{"id":2,"notification":"التذكير بموعد الدوارات الأونلاين","status":true},{"id":3,"notification":"العروض والخصومات","status":true},{"id":4,"notification":"رسائل البريد الإلكتروني","status":true},{"id":5,"notification":"رسائل الجوال النصية","status":false}]

class Data {
  Data({
      List<Rows>? rows,}){
    _rows = rows;
}

  Data.fromJson(dynamic json) {
    if (json['rows'] != null) {
      _rows = [];
      json['rows'].forEach((v) {
        _rows?.add(Rows.fromJson(v));
      });
    }
  }
  List<Rows>? _rows;

  List<Rows>? get rows => _rows;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_rows != null) {
      map['rows'] = _rows?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// notification : "تلقي إشعارات بالدوارات والكتب الجديدة"
/// status : true

class Rows {
  Rows({
      int? id, 
      String? notification, 
      bool? status,}){
    _id = id;
    _notification = notification;
    _status = status;
}

  Rows.fromJson(dynamic json) {
    _id = json['id'];
    _notification = json['notification'];
    _status = json['status'];
  }
  int? _id;
  String? _notification;
  bool? _status;

  int? get id => _id;
  String? get notification => _notification;
  bool? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['notification'] = _notification;
    map['status'] = _status;
    return map;
  }

}