class FavouriteModel {
  Data? _data;

  Data? get data => _data;

  FavouriteModel({
      Data? data}){
    _data = data;
}

  FavouriteModel.fromJson(dynamic json) {
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
  List<Rows>? _rows;
  Paginate? _paginate;

  List<Rows>? get rows => _rows;
  Paginate? get paginate => _paginate;

  Data({
      List<Rows>? rows, 
      Paginate? paginate}){
    _rows = rows;
    _paginate = paginate;
}

  Data.fromJson(dynamic json) {
    if (json['rows'] != null) {
      _rows = [];
      json['rows'].forEach((v) {
        _rows?.add(Rows.fromJson(v));
      });
    }
    _paginate = json['paginate'] != null ? Paginate.fromJson(json['paginate']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_rows != null) {
      map['rows'] = _rows?.map((v) => v.toJson()).toList();
    }
    if (_paginate != null) {
      map['paginate'] = _paginate?.toJson();
    }
    return map;
  }

}

class Paginate {
  int? _currentPage;
  String? _firstPageUrl;
  int? _from;
  int? _lastPage;
  String? _lastPageUrl;
  dynamic? _nextPageUrl;
  String? _path;
  String? _perPage;
  dynamic? _prevPageUrl;
  int? _to;
  int? _total;

  int? get currentPage => _currentPage;
  String? get firstPageUrl => _firstPageUrl;
  int? get from => _from;
  int? get lastPage => _lastPage;
  String? get lastPageUrl => _lastPageUrl;
  dynamic? get nextPageUrl => _nextPageUrl;
  String? get path => _path;
  String? get perPage => _perPage;
  dynamic? get prevPageUrl => _prevPageUrl;
  int? get to => _to;
  int? get total => _total;

  Paginate({
      int? currentPage, 
      String? firstPageUrl, 
      int? from, 
      int? lastPage, 
      String? lastPageUrl, 
      dynamic? nextPageUrl, 
      String? path, 
      String? perPage, 
      dynamic? prevPageUrl, 
      int? to, 
      int? total}){
    _currentPage = currentPage;
    _firstPageUrl = firstPageUrl;
    _from = from;
    _lastPage = lastPage;
    _lastPageUrl = lastPageUrl;
    _nextPageUrl = nextPageUrl;
    _path = path;
    _perPage = perPage;
    _prevPageUrl = prevPageUrl;
    _to = to;
    _total = total;
}

  Paginate.fromJson(dynamic json) {
    _currentPage = json['current_page'];
    _firstPageUrl = json['first_page_url'];
    _from = json['from'];
    _lastPage = json['last_page'];
    _lastPageUrl = json['last_page_url'];
    _nextPageUrl = json['next_page_url'];
    _path = json['path'];
    _perPage = json['per_page'];
    _prevPageUrl = json['prev_page_url'];
    _to = json['to'];
    _total = json['total'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['current_page'] = _currentPage;
    map['first_page_url'] = _firstPageUrl;
    map['from'] = _from;
    map['last_page'] = _lastPage;
    map['last_page_url'] = _lastPageUrl;
    map['next_page_url'] = _nextPageUrl;
    map['path'] = _path;
    map['per_page'] = _perPage;
    map['prev_page_url'] = _prevPageUrl;
    map['to'] = _to;
    map['total'] = _total;
    return map;
  }

}

class Rows {
  String? _modelId;
  String? _modelType;
  String? _image;
  String? _title;
  String? _price;
  bool?_is_purchased;
  String? _date;

  String? get modelId => _modelId;
  String? get modelType => _modelType;
  String? get image => _image;
  String? get title => _title;
  String? get price => _price;
  bool? get is_purchased =>_is_purchased;
  String? get date => _date;

  Rows({
      String? modelId, 
      String? modelType, 
      String? image, 
      String? title,
    bool?is_purchased,
    String? date,
      String? price}){
    _modelId = modelId;
    _modelType = modelType;
    _is_purchased=is_purchased;
    _image = image;
    _title = title;
    _price = price;
    _date = date;
}

  Rows.fromJson(dynamic json) {
    _modelId = json['model_id'] != null ? json['model_id'].toString() : null;
    _modelType = json['model_type'] != null ? json['model_type'].toString() : null;
    _image = json['image'] != null ? json['image'].toString() : null;
    _title = json['title'] != null ? json['title'].toString() : null;
    _price = json['price'] != null ? json['price'].toString() : null;
    _is_purchased = json['is_purchased'];
    _date = json['date'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['model_id'] = _modelId;
    map['model_type'] = _modelType;
    map['image'] = _image;
    map['title'] = _title;
    map['price'] = _price;
    map['is_purchased']=_is_purchased;
    return map;
  }

}