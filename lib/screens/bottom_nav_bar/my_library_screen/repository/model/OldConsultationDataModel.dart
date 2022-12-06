class OldConsultationDataModel {
  OldConsultationDataModel({
    Data? data,
  }) {
    _data = data;
  }

  OldConsultationDataModel.fromJson(dynamic json) {
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

class Data {
  Data({
    List<Rows>? rows,
    Paginate? paginate,
  }) {
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
    _paginate =
        json['paginate'] != null ? Paginate.fromJson(json['paginate']) : null;
  }

  List<Rows>? _rows;
  Paginate? _paginate;

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
    int? currentPage,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    String? nextPageUrl,
    String? path,
    int? perPage,
    dynamic prevPageUrl,
    int? to,
    int? total,
  }) {
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

  int? _currentPage;
  String? _firstPageUrl;
  int? _from;
  int? _lastPage;
  String? _lastPageUrl;
  String? _nextPageUrl;
  String? _path;
  int? _perPage;
  dynamic _prevPageUrl;
  int? _to;
  int? _total;

  int? get currentPage => _currentPage;

  String? get firstPageUrl => _firstPageUrl;

  int? get from => _from;

  int? get lastPage => _lastPage;

  String? get lastPageUrl => _lastPageUrl;

  String? get nextPageUrl => _nextPageUrl;

  String? get path => _path;

  int? get perPage => _perPage;

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

class Rows {
  Rows({
    int? id,
    String? date,
    String? time,
    String? period,
    String? price,
    String? currency,
    bool? confirmed,
    bool? cancelled,
    bool? delayed,
    String? delayedDate,
    String? question,
    String? answer,
    String? delayedTime,
    dynamic approvedByUser,
    bool? paid,
    String? status,
    String? rejectReason,
    String? reply,
  }) {
    _id = id;
    _date = date;
    _time = time;
    _period = period;
    _price = price;
    _currency = currency;
    _confirmed = confirmed;
    _cancelled = cancelled;
    _delayed = delayed;
    _delayedDate = delayedDate;
    _delayedTime = delayedTime;
    _approvedByUser = approvedByUser;
    _paid = paid;
    _status = status;
    _rejectReason = rejectReason;
    _answer = answer;
    _question = question;
    _reply = reply;
  }

  Rows.fromJson(dynamic json) {
    _id = json['id'];
    _date = json['date'];
    _time = json['time'];
    _period = json['period'];
    _price = json['price'];
    _currency = json['currency'];
    _confirmed = json['confirmed'];
    _cancelled = json['cancelled'];
    _delayed = json['delayed'];
    _delayedDate = json['delayed_date'];
    _delayedTime = json['delayed_time'];
    _approvedByUser = json['approved_by_user'];
    _paid = json['paid'];
    _status = json['status'];
    _rejectReason = json['reject_reason'];
    _question = json['question'];
    _answer = json['answer'];
    _reply = json['reply'];
  }

  int? _id;
  String? _date;
  String? _time;
  String? _period;
  String? _price;
  String? _currency;
  bool? _confirmed;
  bool? _cancelled;
  bool? _delayed;
  String? _delayedDate;
  String? _delayedTime;
  dynamic _approvedByUser;
  bool? _paid;
  String? _status;
  String? _rejectReason;
  String? _question;
  String? _answer;
  String? _reply;

  int? get id => _id;

  String? get date => _date;

  String? get time => _time;

  String? get period => _period;

  String? get price => _price;

  String? get currency => _currency;

  bool? get confirmed => _confirmed;

  bool? get cancelled => _cancelled;

  bool? get delayed => _delayed;

  String? get delayedDate => _delayedDate;

  String? get delayedTime => _delayedTime;

  dynamic get approvedByUser => _approvedByUser;

  bool? get paid => _paid;

  String? get status => _status;

  String? get rejectReason => _rejectReason;

  String? get question => _question;

  String? get answer => _answer;

  String? get reply => _reply;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['date'] = _date;
    map['time'] = _time;
    map['period'] = _period;
    map['price'] = _price;
    map['currency'] = _currency;
    map['confirmed'] = _confirmed;
    map['cancelled'] = _cancelled;
    map['delayed'] = _delayed;
    map['delayed_date'] = _delayedDate;
    map['delayed_time'] = _delayedTime;
    map['approved_by_user'] = _approvedByUser;
    map['paid'] = _paid;
    map['status'] = _status;
    map['reject_reason'] = _rejectReason;
    return map;
  }
}
