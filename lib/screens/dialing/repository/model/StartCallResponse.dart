class StartCallResponse {
  StartCallResponse({
      Data? data,}){
    _data = data;
}

  StartCallResponse.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Data? _data;
StartCallResponse copyWith({  Data? data,
}) => StartCallResponse(  data: data ?? _data,
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
      Channel? channel,}){
    _message = message;
    _channel = channel;
}

  Data.fromJson(dynamic json) {
    _message = json['message'];
    _channel = json['channel'] != null ? Channel.fromJson(json['channel']) : null;
  }
  String? _message;
  Channel? _channel;
Data copyWith({  String? message,
  Channel? channel,
}) => Data(  message: message ?? _message,
  channel: channel ?? _channel,
);
  String? get message => _message;
  Channel? get channel => _channel;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    if (_channel != null) {
      map['channel'] = _channel?.toJson();
    }
    return map;
  }

}

class Channel {
  Channel({
      String? type, 
      String? channelName, 
      String? categoryKey, 
      String? period, 
      String? reciverName, 
      String? reciverImage, 
      String? senderName, 
      String? senderImage, 
      String? id,}){
    _type = type;
    _channelName = channelName;
    _categoryKey = categoryKey;
    _period = period;
    _reciverName = reciverName;
    _reciverImage = reciverImage;
    _senderName = senderName;
    _senderImage = senderImage;
    _id = id;
}

  Channel.fromJson(dynamic json) {
    _type = json['type'];
    _channelName = json['channel_name'];
    _categoryKey = json['category_key'];
    _period = json['period'].toString();
    _reciverName = json['reciver_name'];
    _reciverImage = json['reciver_image'];
    _senderName = json['sender_name'];
    _senderImage = json['sender_image'];
    _id = json['id'];
  }
  String? _type;
  String? _channelName;
  String? _categoryKey;
  String? _period;
  String? _reciverName;
  String? _reciverImage;
  String? _senderName;
  String? _senderImage;
  String? _id;
Channel copyWith({  String? type,
  String? channelName,
  String? categoryKey,
  String? period,
  String? reciverName,
  String? reciverImage,
  String? senderName,
  String? senderImage,
  String? id,
}) => Channel(  type: type ?? _type,
  channelName: channelName ?? _channelName,
  categoryKey: categoryKey ?? _categoryKey,
  period: period ?? _period,
  reciverName: reciverName ?? _reciverName,
  reciverImage: reciverImage ?? _reciverImage,
  senderName: senderName ?? _senderName,
  senderImage: senderImage ?? _senderImage,
  id: id ?? _id,
);
  String? get type => _type;
  String? get channelName => _channelName;
  String? get categoryKey => _categoryKey;
  String? get period => _period;
  String? get reciverName => _reciverName;
  String? get reciverImage => _reciverImage;
  String? get senderName => _senderName;
  String? get senderImage => _senderImage;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['channel_name'] = _channelName;
    map['category_key'] = _categoryKey;
    map['period'] = _period;
    map['reciver_name'] = _reciverName;
    map['reciver_image'] = _reciverImage;
    map['sender_name'] = _senderName;
    map['sender_image'] = _senderImage;
    map['id'] = _id;
    return map;
  }

}