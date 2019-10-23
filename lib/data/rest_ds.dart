import 'dart:async';

import 'package:memezitos_land_admin/utils/network_util.dart';
import 'package:memezitos_land_admin/models/user.dart';
import 'package:memezitos_land_admin/models/instagram_account.dart';
import 'package:memezitos_land_admin/data/database_helper.dart';
import 'package:memezitos_land_admin/models/instagramfeed_item.dart';
import 'dart:convert';

class RestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "http://x.x.x.x.com:4444/api";
  static final LOGIN_URL = BASE_URL + "/login";
  static final INSTAGRAM_ACCOUNTS_URL = BASE_URL + "/instagram/accounts_get_feed";
  static final INSTAGRAM_FEED_URL = BASE_URL + "/instagram/feed/";
  static final INSTAGRAM_PUBLISH_VIDEO = BASE_URL + "/instagram/publish/video/";
  static final INSTAGRAM_PUBLISH_IMAGE = BASE_URL + "/instagram/publish/image/";

  static final _API_KEY = "somerandomkey";

  Future<User> login(String username, String password) {
    return _netUtil.post(LOGIN_URL, body: {
      "username": username,
      "password": password
    }).then((dynamic res) {
      print(res.toString());
      if(res["error"]) throw new Exception(res["error_msg"]);
      return new User.map(res["user"]);
    });
  }
  Future<List<InstagramAccount>> getInstagramAccounts() async{
    var db = new DatabaseHelper();
    Map<String, String> tokenHeader = {
      "x-access-token": await db.getTokenFromUser()
    };
    return _netUtil.get(INSTAGRAM_ACCOUNTS_URL, headers: tokenHeader).then((dynamic res) {
      print(res.toString());
      if(res["error"]) throw new Exception(res["error_msg"]);
      List<InstagramAccount> instagramAccounts = new List();
      res["instagram_accounts"].forEach((item) =>  instagramAccounts.add(new InstagramAccount.map(item)));

      return instagramAccounts;
    });
  }
  Future<List<InstagramFeedItem>> getInstagramFeed(int instagram_id, String cursor) async{
    var db = new DatabaseHelper();
    Map<String, String> tokenHeader = {
      "x-access-token": await db.getTokenFromUser()
    };
    return _netUtil.get(INSTAGRAM_FEED_URL + instagram_id.toString() +  '/cursor/' + cursor, headers: tokenHeader).then((dynamic res) {
      if(res["error"]) throw new Exception(res["error_msg"]);
      print(res);
      List<InstagramFeedItem> instagramFeed = new List();
      res["instagram_feed"].forEach((item) =>  instagramFeed.add(new InstagramFeedItem.map(item)));

      return instagramFeed;
    });
  }
  Future<bool> publishInstagramItem(InstagramFeedItem instagramFeedItem) async{
    var db = new DatabaseHelper();
    Map<String, String> tokenHeader = {
      "x-access-token": await db.getTokenFromUser(),
      "Accept": "application/json"
    };
    return _netUtil.post( instagramFeedItem.video.length > 0 ? INSTAGRAM_PUBLISH_VIDEO : INSTAGRAM_PUBLISH_IMAGE,
                          headers: tokenHeader,
                          body: instagramFeedItem.toJson()).then((dynamic res) {
      if(res["error"]) throw new Exception(res["error_msg"]);
      print(res);

      return res["success"];
    });
  }
}