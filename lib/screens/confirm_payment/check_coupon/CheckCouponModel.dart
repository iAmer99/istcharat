/// data : {"message":"تم التحقيق من الكود بنجاح 1"}

class CheckCouponModel {
  CheckCouponModel({
      Data? data,}){
    _data = data;
}

  CheckCouponModel.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Data? _data;
CheckCouponModel copyWith({  Data? data,
}) => CheckCouponModel(  data: data ?? _data,
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

/// message : "تم التحقيق من الكود بنجاح 1"

class Data {
  Data({
      String? message,}){
    _message = message;
}

  Data.fromJson(dynamic json) {
    _message = json['message'];
    _discount = json['discount'] != null ? json['discount'].toString() : null;
    _priceAfterDiscount = json['price_after_discount'] != null ? json['price_after_discount'].toString() : null;
  }
  String? _message;
  String? _discount;
  String? _priceAfterDiscount;
Data copyWith({  String? message,
}) => Data(  message: message ?? _message,
);
  String? get message => _message;
  String? get discount => _discount;
  String? get priceAfterDiscount => _priceAfterDiscount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    return map;
  }

}