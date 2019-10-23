class InstagramAccount {
  int _instagram_id;
  String _name;
  String _language;
  bool _get_videos;
  bool _get_images;
  bool _get_caption;
  String __id;

  InstagramAccount(this.__id, this._instagram_id, this._name, this._language, this._get_videos, this._get_images, this._get_caption);

  InstagramAccount.map(dynamic obj) {
    this._instagram_id = obj["instagram_id"];
    this._name = obj["name"];
    this._language = obj["language"];
    this._get_videos = obj["get_videos"];
    this._get_images = obj["get_images"];
    this._get_caption = obj["get_caption"];
    this.__id = obj["_id"];
  }

  int get instagram_id => _instagram_id;
  String get name => _name;
  String get language => _language;
  bool get get_videos => _get_videos;
  bool get get_images => _get_images;
  bool get get_caption => _get_caption;
  String get id => __id;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["instagram_id"] = _instagram_id;
    map["name"] = _name;
    map["language"] = _language;
    map["get_videos"] = _get_videos;
    map["get_images"] = _get_images;
    map["get_caption"] = _get_caption;
    map["_id"] = __id;

    return map;
  }
}