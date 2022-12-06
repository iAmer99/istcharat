class WalletResponse {
  WalletResponse({
      Data? data,}){
    _data = data;
}

  WalletResponse.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Data? _data;
WalletResponse copyWith({  Data? data,
}) => WalletResponse(  data: data ?? _data,
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
      String? balance, 
      String? currency, 
      List<Items>? items,}){
    _balance = balance;
    _currency = currency;
    _items = items;
}

  Data.fromJson(dynamic json) {
    _balance = json['balance'];
    _currency = json['currency'];
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(Items.fromJson(v));
      });
    }
  }
  String? _balance;
  String? _currency;
  List<Items>? _items;
Data copyWith({  String? balance,
  String? currency,
  List<Items>? items,
}) => Data(  balance: balance ?? _balance,
  currency: currency ?? _currency,
  items: items ?? _items,
);
  String? get balance => _balance;
  String? get currency => _currency;
  List<Items>? get items => _items;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['balance'] = _balance;
    map['currency'] = _currency;
    if (_items != null) {
      map['items'] = _items?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Items {
  Items({
      String? category, 
      String? categoryKey, 
      String? price, 
      String? currency, 
      String? status, 
      String? rejectReason, 
      String? delayedDate, 
      String? delayedTime,}){
    _category = category;
    _categoryKey = categoryKey;
    _price = price;
    _currency = currency;
    _status = status;
    _rejectReason = rejectReason;
    _delayedDate = delayedDate;
    _delayedTime = delayedTime;
}

  Items.fromJson(dynamic json) {
    _category = json['category'].toString();
    _categoryKey = json['category_key'].toString();
    _price = json['price'].toString();
    _currency = json['currency'].toString();
    _status = json['status'].toString();
    _rejectReason = json['reject_reason'].toString();
    _delayedDate = json['delayed_date'].toString();
    _delayedTime = json['delayed_time'].toString();
  }
  String? _category;
  String? _categoryKey;
  String? _price;
  String? _currency;
  String? _status;
  String? _rejectReason;
  String? _delayedDate;
  String? _delayedTime;
Items copyWith({  String? category,
  String? categoryKey,
  String? price,
  String? currency,
  String? status,
  String? rejectReason,
  String? delayedDate,
  String? delayedTime,
}) => Items(  category: category ?? _category,
  categoryKey: categoryKey ?? _categoryKey,
  price: price ?? _price,
  currency: currency ?? _currency,
  status: status ?? _status,
  rejectReason: rejectReason ?? _rejectReason,
  delayedDate: delayedDate ?? _delayedDate,
  delayedTime: delayedTime ?? _delayedTime,
);
  String? get category => _category;
  String? get categoryKey => _categoryKey;
  String? get price => _price;
  String? get currency => _currency;
  String? get status => _status;
  String? get rejectReason => _rejectReason;
  String? get delayedDate => _delayedDate;
  String? get delayedTime => _delayedTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['category'] = _category;
    map['category_key'] = _categoryKey;
    map['price'] = _price;
    map['currency'] = _currency;
    map['status'] = _status;
    map['reject_reason'] = _rejectReason;
    map['delayed_date'] = _delayedDate;
    map['delayed_time'] = _delayedTime;
    return map;
  }

}