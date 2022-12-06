class ConfirmBuyingResponse {
  ConfirmBuyingResponse({
      Data? data,}){
    _data = data;
}

  ConfirmBuyingResponse.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Data? _data;
ConfirmBuyingResponse copyWith({  Data? data,
}) => ConfirmBuyingResponse(  data: data ?? _data,
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

class Data {
  Data({
      String? message, 
      String? paymentLink,}){
    _message = message;
    _paymentLink = paymentLink;
}

  Data.fromJson(dynamic json) {
    _message = json['message'];
    _paymentLink = json['payment_link'];
  }
  String? _message;
  String? _paymentLink;
Data copyWith({  String? message,
  String? paymentLink,
}) => Data(  message: message ?? _message,
  paymentLink: paymentLink ?? _paymentLink,
);
  String? get message => _message;
  String? get paymentLink => _paymentLink;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['payment_link'] = _paymentLink;
    return map;
  }

}