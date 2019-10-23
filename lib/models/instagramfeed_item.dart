import 'dart:convert';

class InstagramFeedItem {
  String _video;
  int _video_height;
  int _video_width;
  String _image;
  String _caption;
  String    _instagram_id;
  String _cursor;
  String _video_duration;
  String _instagram_account_id;

  InstagramFeedItem(this._instagram_account_id, this._video, this._video_height, this._video_width, this._image, this._caption, this._instagram_id, this._cursor, this._video_duration);

  InstagramFeedItem.map(dynamic obj) {
    this._instagram_id = obj["instagram_id"];
    this._video = obj["video"];
    this._video_height = obj["video_height"];
    this._video_width = obj["video_width"];
    this._image = obj["image"];
    this._caption = obj["caption"];
    this._cursor = obj["cursor"];
    this._video_duration = obj["video_duration"].toString().split(".")[0];
    this._instagram_account_id = obj["instagram_account_id"];
  }

  String get instagram_id => _instagram_id;
  String get video => _video;
  int get video_height => _video_height;
  int get video_width => _video_width;
  String get image => _image;
  String get caption => _caption;
  String get cursor => _cursor;
  String get video_duration => _video_duration;
  String get instagram_account_id => _instagram_account_id;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["instagram_id"] = _instagram_id;
    map["video"] = _video;
    map["video_height"] = _video_height;
    map["video_width"] = _video_width;
    map["image"] = _image;
    map["caption"] = _caption;
    map["cursor"] = _cursor;
    map["video_duration"] = _video_duration;
    map["instagram_account_id"] = _instagram_account_id;

    return map;
  }
  Map<String, String> toJson() {
    var map = new Map<String, String>();
    map["instagram_id"] = _instagram_id;
    map["video"] = _video;
    map["video_height"] = _video_height.toString();
    map["video_width"] = _video_width.toString();
    map["image"] = _image;
    map["caption"] = _caption;
    map["cursor"] = _cursor;
    map["video_duration"] = _video_duration;
    map["instagram_account_id"] = _instagram_account_id;

    return map;
  }
}