/// data : {"rows":[{"id":"4","key":"voice_consultations","type":"إستشارات صوتية","username":"User 1","country_code":"+987","mobile":"123456789","date":"2022-03-27","time":"04:00 مساءاُ","status":null,"reject_reason":null,"delayed":false,"delayed_date":null,"delayed_time":null,"approved_by_user":null,"price":"15.00","currency":"دينار","approved_btn":true,"approved_btn_active":false,"rejected_btn":true,"rejected_btn_active":false,"delayed_btn":true,"delayed_btn_active":false,"button_status":null}],"paginate":{"current_page":1,"first_page_url":"https://api-istchrat.mazadak.net/api/v1/logs?page=1","from":1,"last_page":1,"last_page_url":"https://api-istchrat.mazadak.net/api/v1/logs?page=1","next_page_url":null,"path":"https://api-istchrat.mazadak.net/api/v1/logs","per_page":"5","prev_page_url":null,"to":1,"total":1}}

class LogsItemsModel1 {
  LogsItemsModel1({
      Data? data,}){
    _data = data;
}

  LogsItemsModel1.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Data? _data;
LogsItemsModel1 copyWith({  Data? data,
}) => LogsItemsModel1(  data: data ?? _data,
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

/// rows : [{"id":"4","key":"voice_consultations","type":"إستشارات صوتية","username":"User 1","country_code":"+987","mobile":"123456789","date":"2022-03-27","time":"04:00 مساءاُ","status":null,"reject_reason":null,"delayed":false,"delayed_date":null,"delayed_time":null,"approved_by_user":null,"price":"15.00","currency":"دينار","approved_btn":true,"approved_btn_active":false,"rejected_btn":true,"rejected_btn_active":false,"delayed_btn":true,"delayed_btn_active":false,"button_status":null}]
/// paginate : {"current_page":1,"first_page_url":"https://api-istchrat.mazadak.net/api/v1/logs?page=1","from":1,"last_page":1,"last_page_url":"https://api-istchrat.mazadak.net/api/v1/logs?page=1","next_page_url":null,"path":"https://api-istchrat.mazadak.net/api/v1/logs","per_page":"5","prev_page_url":null,"to":1,"total":1}

class Data {
  Data({
      List<items>? rows,
      Paginate? paginate,}){
    _rows = rows;
    _paginate = paginate;
}

  Data.fromJson(dynamic json) {
    if (json['rows'] != null) {
      _rows = [];
      json['rows'].forEach((v) {
        _rows?.add(items.fromJson(v));
      });
    }
    _paginate = json['paginate'] != null ? Paginate.fromJson(json['paginate']) : null;
  }
  List<items>? _rows;
  Paginate? _paginate;
Data copyWith({  List<items>? rows,
  Paginate? paginate,
}) => Data(  rows: rows ?? _rows,
  paginate: paginate ?? _paginate,
);
  List<items>? get rows => _rows;
  Paginate? get paginate => _paginate;
  set setPaginate(Paginate? paginate) => _paginate = paginate;

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

/// current_page : 1
/// first_page_url : "https://api-istchrat.mazadak.net/api/v1/logs?page=1"
/// from : 1
/// last_page : 1
/// last_page_url : "https://api-istchrat.mazadak.net/api/v1/logs?page=1"
/// next_page_url : null
/// path : "https://api-istchrat.mazadak.net/api/v1/logs"
/// per_page : "5"
/// prev_page_url : null
/// to : 1
/// total : 1

class Paginate {
  Paginate({
      int? currentPage, 
      String? firstPageUrl, 
      int? from, 
      int? lastPage, 
      String? lastPageUrl, 
      dynamic nextPageUrl, 
      String? path, 
      String? perPage, 
      dynamic prevPageUrl, 
      int? to, 
      int? total,}){
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
    _perPage = json['per_page'].toString();
    _prevPageUrl = json['prev_page_url'];
    _to = json['to'];
    _total = json['total'];
  }
  int? _currentPage;
  String? _firstPageUrl;
  int? _from;
  int? _lastPage;
  String? _lastPageUrl;
  dynamic _nextPageUrl;
  String? _path;
  String? _perPage;
  dynamic _prevPageUrl;
  int? _to;
  int? _total;
Paginate copyWith({  int? currentPage,
  String? firstPageUrl,
  int? from,
  int? lastPage,
  String? lastPageUrl,
  dynamic nextPageUrl,
  String? path,
  String? perPage,
  dynamic prevPageUrl,
  int? to,
  int? total,
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
  int? get currentPage => _currentPage;
  String? get firstPageUrl => _firstPageUrl;
  int? get from => _from;
  int? get lastPage => _lastPage;
  String? get lastPageUrl => _lastPageUrl;
  dynamic get nextPageUrl => _nextPageUrl;
  String? get path => _path;
  String? get perPage => _perPage;
  dynamic get prevPageUrl => _prevPageUrl;
  int? get to => _to;
  int? get total => _total;

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

/// id : "4"
/// key : "voice_consultations"
/// type : "إستشارات صوتية"
/// username : "User 1"
/// country_code : "+987"
/// mobile : "123456789"
/// date : "2022-03-27"
/// time : "04:00 مساءاُ"
/// status : null
/// reject_reason : null
/// delayed : false
/// delayed_date : null
/// delayed_time : null
/// approved_by_user : null
/// price : "15.00"
/// currency : "دينار"
/// approved_btn : true
/// approved_btn_active : false
/// rejected_btn : true
/// rejected_btn_active : false
/// delayed_btn : true
/// delayed_btn_active : false
/// button_status : null

class items {
  items({
      String? id, 
      String? key, 
      String? type, 
      String? username, 
      String? countryCode, 
      String? mobile, 
      String? date, 
      String? time, 
      dynamic status, 
      dynamic rejectReason, 
      bool? delayed, 
      dynamic delayedDate, 
      dynamic delayedTime, 
      dynamic approvedByUser, 
      String? price, 
      String? currency, 
      bool? approvedBtn, 
      bool? approvedBtnActive, 
      bool? rejectedBtn, 
      bool? rejectedBtnActive, 
      bool? delayedBtn,
    String? notes,
      bool? delayedBtnActive,
    String? question,
    String? answer,
      dynamic buttonStatus,}){
    _id = id;
    _key = key;
    _type = type;
    _username = username;
    _countryCode = countryCode;
    _mobile = mobile;
    _date = date;
    _time = time;
    _status = status;
    _rejectReason = rejectReason;
    _delayed = delayed;
    _delayedDate = delayedDate;
    _delayedTime = delayedTime;
    _approvedByUser = approvedByUser;
    _price = price;
    _currency = currency;
    _approvedBtn = approvedBtn;
    _approvedBtnActive = approvedBtnActive;
    _rejectedBtn = rejectedBtn;
    _rejectedBtnActive = rejectedBtnActive;
    _delayedBtn = delayedBtn;
    _delayedBtnActive = delayedBtnActive;
    _buttonStatus = buttonStatus;
    _notes = notes;
    _question = question;
    _answer = answer;
}

  items.fromJson(dynamic json) {
    _id = json['id'].toString();
    _key = json['key'];
    _type = json['type'];
    _username = json['username'];
    _countryCode = json['country_code'];
    _mobile = json['mobile'];
    _date = json['date'];
    _time = json['time'];
    _status = json['status'];
    _notes = json['reply'];
    _rejectReason = json['reject_reason'];
    _delayed = json['delayed'];
    _delayedDate = json['delayed_date'];
    _delayedTime = json['delayed_time'];
    _approvedByUser = json['approved_by_user'];
    _price = json['price'];
    _currency = json['currency'];
    _approvedBtn = json['approved_btn'];
    _approvedBtnActive = json['approved_btn_active'];
    _rejectedBtn = json['rejected_btn'];
    _rejectedBtnActive = json['rejected_btn_active'];
    _delayedBtn = json['delayed_btn'];
    _delayedBtnActive = json['delayed_btn_active'];
    _buttonStatus = json['button_status'];
    _question = json['question'];
    _answer = json['answer'];
  }
  String? _id;
  String? _key;
  String? _type;
  String? _username;
  String? _countryCode;
  String? _mobile;
  String? _date;
  String? _time;
  dynamic _status;
  dynamic _rejectReason;
  bool? _delayed;
  dynamic _delayedDate;
  dynamic _delayedTime;
  dynamic _approvedByUser;
  String? _price;
  String? _notes;
  String? _currency;
  bool? _approvedBtn;
  bool? _approvedBtnActive;
  bool? _rejectedBtn;
  bool? _rejectedBtnActive;
  bool? _delayedBtn;
  bool? _delayedBtnActive;
  dynamic _buttonStatus;
  String? _question;
  String? _answer;
items copyWith({  String? id,
  String? key,
  String? type,
  String? username,
  String? countryCode,
  String? mobile,
  String? date,
  String? time,
  dynamic status,
  dynamic rejectReason,
  bool? delayed,
  dynamic delayedDate,
  dynamic delayedTime,
  dynamic approvedByUser,
  String? price,
  String? currency,
  bool? approvedBtn,
  bool? approvedBtnActive,
  bool? rejectedBtn,
  bool? rejectedBtnActive,
  bool? delayedBtn,
  bool? delayedBtnActive,
  dynamic buttonStatus,
  String? question,
}) => items(  id: id ?? _id,
  key: key ?? _key,
  type: type ?? _type,
  username: username ?? _username,
  countryCode: countryCode ?? _countryCode,
  mobile: mobile ?? _mobile,
  date: date ?? _date,
  time: time ?? _time,
  status: status ?? _status,
  rejectReason: rejectReason ?? _rejectReason,
  delayed: delayed ?? _delayed,
  delayedDate: delayedDate ?? _delayedDate,
  delayedTime: delayedTime ?? _delayedTime,
  approvedByUser: approvedByUser ?? _approvedByUser,
  price: price ?? _price,
  currency: currency ?? _currency,
  approvedBtn: approvedBtn ?? _approvedBtn,
  approvedBtnActive: approvedBtnActive ?? _approvedBtnActive,
  rejectedBtn: rejectedBtn ?? _rejectedBtn,
  rejectedBtnActive: rejectedBtnActive ?? _rejectedBtnActive,
  delayedBtn: delayedBtn ?? _delayedBtn,
  delayedBtnActive: delayedBtnActive ?? _delayedBtnActive,
  buttonStatus: buttonStatus ?? _buttonStatus,
);
  String? get id => _id;
  String? get key => _key;
  String? get type => _type;
  String? get username => _username;
  String? get countryCode => _countryCode;
  String? get mobile => _mobile;
  String? get date => _date;
  String? get time => _time;
  dynamic get status => _status;
  dynamic get rejectReason => _rejectReason;
  bool? get delayed => _delayed;
  dynamic get delayedDate => _delayedDate;
  dynamic get delayedTime => _delayedTime;
  dynamic get approvedByUser => _approvedByUser;
  String? get price => _price;
  String? get currency => _currency;
  bool? get approvedBtn => _approvedBtn;
  bool? get approvedBtnActive => _approvedBtnActive;
  bool? get rejectedBtn => _rejectedBtn;
  bool? get rejectedBtnActive => _rejectedBtnActive;
  bool? get delayedBtn => _delayedBtn;
  bool? get delayedBtnActive => _delayedBtnActive;
  dynamic get buttonStatus => _buttonStatus;
  String? get notes => _notes;
  String? get question => _question;
  String? get answer => _answer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['key'] = _key;
    map['type'] = _type;
    map['username'] = _username;
    map['country_code'] = _countryCode;
    map['mobile'] = _mobile;
    map['date'] = _date;
    map['time'] = _time;
    map['status'] = _status;
    map['reject_reason'] = _rejectReason;
    map['delayed'] = _delayed;
    map['delayed_date'] = _delayedDate;
    map['delayed_time'] = _delayedTime;
    map['approved_by_user'] = _approvedByUser;
    map['price'] = _price;
    map['currency'] = _currency;
    map['approved_btn'] = _approvedBtn;
    map['approved_btn_active'] = _approvedBtnActive;
    map['rejected_btn'] = _rejectedBtn;
    map['rejected_btn_active'] = _rejectedBtnActive;
    map['delayed_btn'] = _delayedBtn;
    map['delayed_btn_active'] = _delayedBtnActive;
    map['button_status'] = _buttonStatus;
    return map;
  }

}