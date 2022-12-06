class SuccessBuyResponse {
  Data? _data;

  Data? get data => _data;

  SuccessBuyResponse({
      Data? data}){
    _data = data;
}

  SuccessBuyResponse.fromJson(dynamic json) {
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
  String? _message;
  int? _orderId;

  String? get message => _message;
  int? get orderId => _orderId;

  Data({
      String? message, 
      int? orderId}){
    _message = message;
    _orderId = orderId;
}

  Data.fromJson(dynamic json) {
    _message = json['message'];
    _orderId = json['order_id'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['message'] = _message;
    map['order_id'] = _orderId;
    return map;
  }

}