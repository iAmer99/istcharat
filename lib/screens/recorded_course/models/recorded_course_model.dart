/// data : {"rows":[{"id":11,"image":"https://api-istchrat.mazadak.net/uploads/offlineCourses/2022-03-07-07-47-42-06226615e8c8a1.png","date":"March, 07 2022","time":"07:00 م","title":"هذا النص هو مثال لنص يمكن ان يستبدل هنا","price":"10.00"},{"id":10,"image":"https://api-istchrat.mazadak.net/uploads/offlineCourses/2022-03-07-07-47-52-062266168106b5.png","date":"March, 07 2022","time":"07:00 م","title":"هذا النص هو مثال لنص يمكن ان يستبدل هنا","price":"10.00"},{"id":9,"image":"https://api-istchrat.mazadak.net/uploads/offlineCourses/2022-03-07-07-48-02-0622661728a3f7.png","date":"March, 07 2022","time":"07:00 م","title":"هذا النص هو مثال لنص يمكن ان يستبدل هنا","price":"10.00"},{"id":8,"image":"https://api-istchrat.mazadak.net/uploads/offlineCourses/2022-03-07-07-48-13-06226617d069b9.png","date":"March, 07 2022","time":"07:00 م","title":"هذا النص هو مثال لنص يمكن ان يستبدل هنا","price":"10.00"},{"id":7,"image":"https://api-istchrat.mazadak.net/uploads/offlineCourses/2022-03-07-07-48-23-06226618756a92.png","date":"March, 07 2022","time":"07:00 م","title":"هذا النص هو مثال لنص يمكن ان يستبدل هنا","price":"10.00"}],"paginate":{"current_page":1,"first_page_url":"https://api-istchrat.mazadak.net/api/v1/offlineCourses?page=1","from":1,"last_page":3,"last_page_url":"https://api-istchrat.mazadak.net/api/v1/offlineCourses?page=3","next_page_url":"https://api-istchrat.mazadak.net/api/v1/offlineCourses?page=2","path":"https://api-istchrat.mazadak.net/api/v1/offlineCourses","per_page":"5","prev_page_url":null,"to":5,"total":11}}

class Recorded_course_model {
  Data? data;

  Recorded_course_model({this.data});

  Recorded_course_model.fromJson(dynamic json) {
    data = json["data"] != null ? Data.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (data != null) {
      map["data"] = data!.toJson();
    }
    return map;
  }
}

/// rows : [{"id":11,"image":"https://api-istchrat.mazadak.net/uploads/offlineCourses/2022-03-07-07-47-42-06226615e8c8a1.png","date":"March, 07 2022","time":"07:00 م","title":"هذا النص هو مثال لنص يمكن ان يستبدل هنا","price":"10.00"},{"id":10,"image":"https://api-istchrat.mazadak.net/uploads/offlineCourses/2022-03-07-07-47-52-062266168106b5.png","date":"March, 07 2022","time":"07:00 م","title":"هذا النص هو مثال لنص يمكن ان يستبدل هنا","price":"10.00"},{"id":9,"image":"https://api-istchrat.mazadak.net/uploads/offlineCourses/2022-03-07-07-48-02-0622661728a3f7.png","date":"March, 07 2022","time":"07:00 م","title":"هذا النص هو مثال لنص يمكن ان يستبدل هنا","price":"10.00"},{"id":8,"image":"https://api-istchrat.mazadak.net/uploads/offlineCourses/2022-03-07-07-48-13-06226617d069b9.png","date":"March, 07 2022","time":"07:00 م","title":"هذا النص هو مثال لنص يمكن ان يستبدل هنا","price":"10.00"},{"id":7,"image":"https://api-istchrat.mazadak.net/uploads/offlineCourses/2022-03-07-07-48-23-06226618756a92.png","date":"March, 07 2022","time":"07:00 م","title":"هذا النص هو مثال لنص يمكن ان يستبدل هنا","price":"10.00"}]
/// paginate : {"current_page":1,"first_page_url":"https://api-istchrat.mazadak.net/api/v1/offlineCourses?page=1","from":1,"last_page":3,"last_page_url":"https://api-istchrat.mazadak.net/api/v1/offlineCourses?page=3","next_page_url":"https://api-istchrat.mazadak.net/api/v1/offlineCourses?page=2","path":"https://api-istchrat.mazadak.net/api/v1/offlineCourses","per_page":"5","prev_page_url":null,"to":5,"total":11}

class Data {
  List<recordedCourses>? recordedList;
  Paginate? paginate;

  Data({this.recordedList, this.paginate});

  Data.fromJson(dynamic json) {
    if (json["rows"] != null) {
      recordedList = [];
      json["rows"].forEach((v) {
        recordedList!.add(recordedCourses.fromJson(v));
      });
    }
    paginate =
        json["paginate"] != null ? Paginate.fromJson(json["paginate"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (recordedList != null) {
      map["rows"] = recordedList!.map((v) => v.toJson()).toList();
    }
    if (paginate != null) {
      map["paginate"] = paginate!.toJson();
    }
    return map;
  }
}

/// current_page : 1
/// first_page_url : "https://api-istchrat.mazadak.net/api/v1/offlineCourses?page=1"
/// from : 1
/// last_page : 3
/// last_page_url : "https://api-istchrat.mazadak.net/api/v1/offlineCourses?page=3"
/// next_page_url : "https://api-istchrat.mazadak.net/api/v1/offlineCourses?page=2"
/// path : "https://api-istchrat.mazadak.net/api/v1/offlineCourses"
/// per_page : "5"
/// prev_page_url : null
/// to : 5
/// total : 11

class Paginate {
  int? currentPage;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  String? perPage;
  dynamic? prevPageUrl;
  int? to;
  int? total;

  Paginate(
      {this.currentPage,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  Paginate.fromJson(dynamic json) {
    currentPage = json["current_page"];
    firstPageUrl = json["first_page_url"];
    from = json["from"];
    lastPage = json["last_page"];
    lastPageUrl = json["last_page_url"];
    nextPageUrl = json["next_page_url"];
    path = json["path"];
    perPage = json["per_page"];
    prevPageUrl = json["prev_page_url"];
    to = json["to"];
    total = json["total"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["current_page"] = currentPage;
    map["first_page_url"] = firstPageUrl;
    map["from"] = from;
    map["last_page"] = lastPage;
    map["last_page_url"] = lastPageUrl;
    map["next_page_url"] = nextPageUrl;
    map["path"] = path;
    map["per_page"] = perPage;
    map["prev_page_url"] = prevPageUrl;
    map["to"] = to;
    map["total"] = total;
    return map;
  }
}

/// id : 11
/// image : "https://api-istchrat.mazadak.net/uploads/offlineCourses/2022-03-07-07-47-42-06226615e8c8a1.png"
/// date : "March, 07 2022"
/// time : "07:00 م"
/// title : "هذا النص هو مثال لنص يمكن ان يستبدل هنا"
/// price : "10.00"

class recordedCourses {
  int? id;
  String? image;
  String? date;
  String? time;
  String? title;
  String? price;
  String? currency;
  bool? is_favorite;
  bool? is_purchased;

  recordedCourses(
      {this.id,
      this.image,
      this.date,
      this.time,
      this.title,
      this.price,
      this.currency,
      this.is_favorite,
      this.is_purchased});

  recordedCourses.fromJson(dynamic json) {
    id = json["id"];
    image = json["image"];
    date = json["date"];
    time = json["time"];
    title = json["title"];
    price = json["price"];
    currency = json["currency"];
    is_favorite = json["is_favorite"];
    is_purchased = json["is_purchased"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["image"] = image;
    map["date"] = date;
    map["time"] = time;
    map["title"] = title;
    map["price"] = price;
    map["currency"] = currency;
    map["is_favorite"] = is_favorite;
    map["is_purchased"] = is_purchased;
    return map;
  }
}
