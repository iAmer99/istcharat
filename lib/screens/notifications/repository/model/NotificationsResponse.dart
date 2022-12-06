class NotificationsResponse {
  NotificationsResponse({
      Data? data,}){
    _data = data;
}

  NotificationsResponse.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Data? _data;
NotificationsResponse copyWith({  Data? data,
}) => NotificationsResponse(  data: data ?? _data,
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
      List<Rows>? rows, 
      Paginate? paginate,}){
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
  List<Rows>? _rows;
  Paginate? _paginate;
Data copyWith({  List<Rows>? rows,
  Paginate? paginate,
}) => Data(  rows: rows ?? _rows,
  paginate: paginate ?? _paginate,
);
  List<Rows>? get rows => _rows;
  Paginate? get paginate => _paginate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
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
  Paginate({
      String? currentPage,
      String? firstPageUrl,
    String? from,
    String? lastPage,
      String? lastPageUrl, 
      dynamic nextPageUrl, 
      String? path,
    String? perPage,
      dynamic prevPageUrl,
    String? to,
    String? total,}){
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
    _currentPage = json['current_page'].toString();
    _firstPageUrl = json['first_page_url'].toString();
    _from = json['from'].toString();
    _lastPage = json['last_page'].toString();
    _lastPageUrl = json['last_page_url'].toString();
    _nextPageUrl = json['next_page_url'].toString();
    _path = json['path'].toString();
    _perPage = json['per_page'].toString();
    _prevPageUrl = json['prev_page_url'].toString();
    _to = json['to'].toString();
    _total = json['total'].toString();
  }
  String? _currentPage;
  String? _firstPageUrl;
  String? _from;
  String? _lastPage;
  String? _lastPageUrl;
  dynamic _nextPageUrl;
  String? _path;
  String? _perPage;
  dynamic _prevPageUrl;
  String? _to;
  String? _total;
Paginate copyWith({  String? currentPage,
  String? firstPageUrl,
  String? from,
  String? lastPage,
  String? lastPageUrl,
  dynamic nextPageUrl,
  String? path,
  String? perPage,
  dynamic prevPageUrl,
  String? to,
  String? total,
}) => Paginate(  currentPage: currentPage ?? _currentPage,
  firstPageUrl: firstPageUrl ?? _firstPageUrl,
  from: from ?? _from,
  lastPage: lastPage ?? _lastPage,
  lastPageUrl: lastPageUrl ?? _lastPageUrl,
  nextPageUrl: nextPageUrl ?? _nextPageUrl,
  path: path ?? _path,
  perPage: perPage ?? _perPage,
  prevPageUrl: prevPageUrl ?? _prevPageUrl,
  to: to ?? _to,
  total: total ?? _total,
);
  String? get currentPage => _currentPage;
  String? get firstPageUrl => _firstPageUrl;
  String? get from => _from;
  String? get lastPage => _lastPage;
  String? get lastPageUrl => _lastPageUrl;
  dynamic get nextPageUrl => _nextPageUrl;
  String? get path => _path;
  String? get perPage => _perPage;
  dynamic get prevPageUrl => _prevPageUrl;
  String? get to => _to;
  String? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
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
  Rows({
      int? id, 
      dynamic modelId, 
      String? modelType, 
      String? icon, 
      String? title,
    String? date,
    String? time,
      String? body,}){
    _id = id;
    _modelId = modelId;
    _modelType = modelType;
    _icon = icon;
    _title = title;
    _body = body;
}

  Rows.fromJson(dynamic json) {
    _id = json['id'];
    _modelId = json['model_id'];
    _modelType = json['model_type'];
    _icon = json['icon'];
    _title = json['title'];
    _body = json['body'];
    _date = json['date'];
    _time = json['time'];
  }
  int? _id;
  dynamic _modelId;
  String? _modelType;
  String? _icon;
  String? _title;
  String? _body;
  String? _date;
  String? _time;
Rows copyWith({  int? id,
  dynamic modelId,
  String? modelType,
  String? icon,
  String? title,
  String? body,
}) => Rows(  id: id ?? _id,
  modelId: modelId ?? _modelId,
  modelType: modelType ?? _modelType,
  icon: icon ?? _icon,
  title: title ?? _title,
  body: body ?? _body,
);
  int? get id => _id;
  dynamic get modelId => _modelId;
  String? get modelType => _modelType;
  String? get icon => _icon;
  String? get title => _title;
  String? get body => _body;
  String? get date => _date;
  String? get time => _time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['model_id'] = _modelId;
    map['model_type'] = _modelType;
    map['icon'] = _icon;
    map['title'] = _title;
    map['body'] = _body;
    return map;
  }

}