/// data : {"rows":[{"id":11,"image":"https://api-istchrat.mazadak.net/uploads/books/2022-03-07-07-57-36-0622663b07bb00.jpeg","title":"الطالب العبقري","price":"12.00"},{"id":10,"image":"https://api-istchrat.mazadak.net/uploads/books/2022-03-07-08-06-20-0622665bcdc47f.jpeg","title":"إدارة الوقت من المنظور الإسلامي والإداري","price":"12.00"},{"id":9,"image":"https://api-istchrat.mazadak.net/uploads/books/2022-03-07-08-11-38-0622666fa0422a.png","title":"كيف تقرأ كتابا","price":"12.00"},{"id":8,"image":"https://api-istchrat.mazadak.net/uploads/books/2022-03-07-08-20-36-062266914034e9.jpeg","title":"صاحب الظل الطويل","price":"12.00"},{"id":7,"image":"https://api-istchrat.mazadak.net/uploads/books/2022-03-07-08-24-46-062266a0ee930f.jpeg","title":"أمواج أكما","price":"10.00"}],"paginate":{"current_page":1,"first_page_url":"https://api-istchrat.mazadak.net/api/v1/books?page=1","from":1,"last_page":1,"last_page_url":"https://api-istchrat.mazadak.net/api/v1/books?page=1","next_page_url":null,"path":"https://api-istchrat.mazadak.net/api/v1/books","per_page":"10","prev_page_url":null,"to":5,"total":5}}

class BookModel {
  Data? data;

  BookModel({this.data});

  BookModel.fromJson(dynamic json) {
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

/// rows : [{"id":11,"image":"https://api-istchrat.mazadak.net/uploads/books/2022-03-07-07-57-36-0622663b07bb00.jpeg","title":"الطالب العبقري","price":"12.00"},{"id":10,"image":"https://api-istchrat.mazadak.net/uploads/books/2022-03-07-08-06-20-0622665bcdc47f.jpeg","title":"إدارة الوقت من المنظور الإسلامي والإداري","price":"12.00"},{"id":9,"image":"https://api-istchrat.mazadak.net/uploads/books/2022-03-07-08-11-38-0622666fa0422a.png","title":"كيف تقرأ كتابا","price":"12.00"},{"id":8,"image":"https://api-istchrat.mazadak.net/uploads/books/2022-03-07-08-20-36-062266914034e9.jpeg","title":"صاحب الظل الطويل","price":"12.00"},{"id":7,"image":"https://api-istchrat.mazadak.net/uploads/books/2022-03-07-08-24-46-062266a0ee930f.jpeg","title":"أمواج أكما","price":"10.00"}]
/// paginate : {"current_page":1,"first_page_url":"https://api-istchrat.mazadak.net/api/v1/books?page=1","from":1,"last_page":1,"last_page_url":"https://api-istchrat.mazadak.net/api/v1/books?page=1","next_page_url":null,"path":"https://api-istchrat.mazadak.net/api/v1/books","per_page":"10","prev_page_url":null,"to":5,"total":5}

class Data {
  List<books>? book_list;
  Paginate? paginate;

  Data({this.book_list, this.paginate});

  Data.fromJson(dynamic json) {
    if (json["rows"] != null) {
      book_list = [];
      json["rows"].forEach((v) {
        book_list!.add(books.fromJson(v));
      });
    }
    paginate =
        json["paginate"] != null ? Paginate.fromJson(json["paginate"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (book_list != null) {
      map["rows"] = book_list!.map((v) => v.toJson()).toList();
    }
    if (paginate != null) {
      map["paginate"] = paginate!.toJson();
    }
    return map;
  }
}

/// current_page : 1
/// first_page_url : "https://api-istchrat.mazadak.net/api/v1/books?page=1"
/// from : 1
/// last_page : 1
/// last_page_url : "https://api-istchrat.mazadak.net/api/v1/books?page=1"
/// next_page_url : null
/// path : "https://api-istchrat.mazadak.net/api/v1/books"
/// per_page : "10"
/// prev_page_url : null
/// to : 5
/// total : 5

class Paginate {
  int? currentPage;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  dynamic? nextPageUrl;
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
/// image : "https://api-istchrat.mazadak.net/uploads/books/2022-03-07-07-57-36-0622663b07bb00.jpeg"
/// title : "الطالب العبقري"
/// price : "12.00"

class books {
  int? id;
  String? image;
  String? title;
  String? price;
  String? currency;
  bool? isFavorite;
  bool? isPurchased;
  String? publishedAt;

  books(
      {this.id,
      this.image,
      this.title,
      this.price,
      this.currency,
      this.isFavorite,
        this.publishedAt,
      this.isPurchased});

  books.fromJson(dynamic json) {
    id = json["id"];
    image = json["image"];
    title = json["title"];
    price = json["price"];
    currency = json["currency"];
    isFavorite = json["is_favorite"];
    isPurchased = json["is_purchased"];
    publishedAt = json['published_at'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["image"] = image;
    map["title"] = title;
    map["price"] = price;
    map["is_purchased"] = isPurchased;
    map["is_favorite"] = isFavorite;
    map["currency"] = currency;
    return map;
  }
}
