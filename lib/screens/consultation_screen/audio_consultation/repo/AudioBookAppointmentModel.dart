/// data : {"message":"تم الحجز بنجاح","book_id":17}

class AudioBookAppointmentModel {
  AudioBookAppointmentModel({
      Data? data,}){
    _data = data;
}

  AudioBookAppointmentModel.fromJson(dynamic json) {
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

/// message : "تم الحجز بنجاح"
/// book_id : 17

class Data {
  Data({
      String? message, 
      int? bookId,}){
    _message = message;
    _bookId = bookId;
}

  Data.fromJson(dynamic json) {
    _message = json['message'];
    _bookId = json['book_id'];
  }
  String? _message;
  int? _bookId;

  String? get message => _message;
  int? get bookId => _bookId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['book_id'] = _bookId;
    return map;
  }

}