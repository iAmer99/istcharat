/// data : {"message":"تم تأكيد الحجز بنجاح","payment_url":"https://api.upayments.com/test/payment?ref=vV0G3D6Obe33-video_consultations165072577416986088676264138e0c21c&sess_id=0bc12860fb7bec8c7709d5a376efede6"}

class ConfirmReservationModel {
  ConfirmReservationModel({
    Data? data,}){
    _data = data;
  }

  ConfirmReservationModel.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Data? _data;
  int? statusCode;
  ConfirmReservationModel copyWith({  Data? data,
  }) => ConfirmReservationModel(  data: data ?? _data,
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

/// message : "تم تأكيد الحجز بنجاح"
/// payment_url : "https://api.upayments.com/test/payment?ref=vV0G3D6Obe33-video_consultations165072577416986088676264138e0c21c&sess_id=0bc12860fb7bec8c7709d5a376efede6"

class Data {
  Data({
    String? message,
    String? paymentUrl,}){
    _message = message;
    _paymentUrl = paymentUrl;
  }

  Data.fromJson(dynamic json) {
    _message = json['message'];
    _paymentUrl = json['payment_url'];
  }
  String? _message;
  String? _paymentUrl;
  Data copyWith({  String? message,
    String? paymentUrl,
  }) => Data(  message: message ?? _message,
    paymentUrl: paymentUrl ?? _paymentUrl,
  );
  String? get message => _message;
  String? get paymentUrl => _paymentUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['payment_url'] = _paymentUrl;
    return map;
  }

}