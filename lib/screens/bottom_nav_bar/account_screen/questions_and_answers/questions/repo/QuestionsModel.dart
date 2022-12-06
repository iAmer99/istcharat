/// data : {"rows":[{"id":18,"tiny_question":"asd","question":"asd","answer":null,"price":"1.00","date":"2022-04-23","time":"09:42 م","status":"قيد الإنتظار"},{"id":17,"tiny_question":"ggg","question":"ggg","answer":null,"price":"1.00","date":"2022-04-23","time":"07:21 م","status":"قيد الإنتظار"},{"id":16,"tiny_question":"as","question":"as","answer":null,"price":"1.00","date":"2022-04-23","time":"06:11 م","status":"قيد الإنتظار"},{"id":15,"tiny_question":"dghh","question":"dghh","answer":null,"price":"1.00","date":"2022-04-23","time":"06:03 م","status":"قيد الإنتظار"},{"id":14,"tiny_question":"ask","question":"ask","answer":null,"price":"1.00","date":"2022-04-15","time":"03:22 م","status":"قيد الإنتظار"},{"id":13,"tiny_question":"ask","question":"ask","answer":null,"price":"1.00","date":"2022-04-15","time":"03:14 م","status":"قيد الإنتظار"},{"id":12,"tiny_question":"ask your quesiton here ?","question":"ask your quesiton here ?","answer":null,"price":"1.00","date":"2022-04-15","time":"02:41 م","status":"تمت الإجابة"}],"paginate":{"current_page":1,"first_page_url":"https://api-istchrat.mazadak.net/api/v1/faqs?page=1","from":1,"last_page":1,"last_page_url":"https://api-istchrat.mazadak.net/api/v1/faqs?page=1","next_page_url":null,"path":"https://api-istchrat.mazadak.net/api/v1/faqs","per_page":"10","prev_page_url":null,"to":7,"total":7}}

class QuestionsModel {
  QuestionsModel({
      Data? data,}){
    _data = data;
}

  QuestionsModel.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Data? _data;
QuestionsModel copyWith({  Data? data,
}) => QuestionsModel(  data: data ?? _data,
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

/// rows : [{"id":18,"tiny_question":"asd","question":"asd","answer":null,"price":"1.00","date":"2022-04-23","time":"09:42 م","status":"قيد الإنتظار"},{"id":17,"tiny_question":"ggg","question":"ggg","answer":null,"price":"1.00","date":"2022-04-23","time":"07:21 م","status":"قيد الإنتظار"},{"id":16,"tiny_question":"as","question":"as","answer":null,"price":"1.00","date":"2022-04-23","time":"06:11 م","status":"قيد الإنتظار"},{"id":15,"tiny_question":"dghh","question":"dghh","answer":null,"price":"1.00","date":"2022-04-23","time":"06:03 م","status":"قيد الإنتظار"},{"id":14,"tiny_question":"ask","question":"ask","answer":null,"price":"1.00","date":"2022-04-15","time":"03:22 م","status":"قيد الإنتظار"},{"id":13,"tiny_question":"ask","question":"ask","answer":null,"price":"1.00","date":"2022-04-15","time":"03:14 م","status":"قيد الإنتظار"},{"id":12,"tiny_question":"ask your quesiton here ?","question":"ask your quesiton here ?","answer":null,"price":"1.00","date":"2022-04-15","time":"02:41 م","status":"تمت الإجابة"}]
/// paginate : {"current_page":1,"first_page_url":"https://api-istchrat.mazadak.net/api/v1/faqs?page=1","from":1,"last_page":1,"last_page_url":"https://api-istchrat.mazadak.net/api/v1/faqs?page=1","next_page_url":null,"path":"https://api-istchrat.mazadak.net/api/v1/faqs","per_page":"10","prev_page_url":null,"to":7,"total":7}

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

/// current_page : 1
/// first_page_url : "https://api-istchrat.mazadak.net/api/v1/faqs?page=1"
/// from : 1
/// last_page : 1
/// last_page_url : "https://api-istchrat.mazadak.net/api/v1/faqs?page=1"
/// next_page_url : null
/// path : "https://api-istchrat.mazadak.net/api/v1/faqs"
/// per_page : "10"
/// prev_page_url : null
/// to : 7
/// total : 7

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

/// id : 18
/// tiny_question : "asd"
/// question : "asd"
/// answer : null
/// price : "1.00"
/// date : "2022-04-23"
/// time : "09:42 م"
/// status : "قيد الإنتظار"

class Rows {
  Rows({
      int? id, 
      String? tinyQuestion, 
      String? question, 
      dynamic answer, 
      String? price, 
      String? date, 
      String? time, 
      String? status,}){
    _id = id;
    _tinyQuestion = tinyQuestion;
    _question = question;
    _answer = answer;
    _price = price;
    _date = date;
    _time = time;
    _status = status;
}

  Rows.fromJson(dynamic json) {
    _id = json['id'];
    _tinyQuestion = json['tiny_question'];
    _question = json['question'];
    _answer = json['answer'];
    _price = json['price'];
    _date = json['date'];
    _time = json['time'];
    _status = json['status'];
  }
  int? _id;
  String? _tinyQuestion;
  String? _question;
  dynamic _answer;
  String? _price;
  String? _date;
  String? _time;
  String? _status;
Rows copyWith({  int? id,
  String? tinyQuestion,
  String? question,
  dynamic answer,
  String? price,
  String? date,
  String? time,
  String? status,
}) => Rows(  id: id ?? _id,
  tinyQuestion: tinyQuestion ?? _tinyQuestion,
  question: question ?? _question,
  answer: answer ?? _answer,
  price: price ?? _price,
  date: date ?? _date,
  time: time ?? _time,
  status: status ?? _status,
);
  int? get id => _id;
  String? get tinyQuestion => _tinyQuestion;
  String? get question => _question;
  dynamic get answer => _answer;
  String? get price => _price;
  String? get date => _date;
  String? get time => _time;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['tiny_question'] = _tinyQuestion;
    map['question'] = _question;
    map['answer'] = _answer;
    map['price'] = _price;
    map['date'] = _date;
    map['time'] = _time;
    map['status'] = _status;
    return map;
  }

}