import 'package:memezitos_land_admin/data/rest_ds.dart';
import 'package:memezitos_land_admin/models/user.dart';
import 'package:memezitos_land_admin/models/instagramfeed_item.dart';

abstract class InstagramFeedScreenContract {
  void onGetInstagramFeedSuccess(List<InstagramFeedItem> instagramFeed);
  void onGetInstagramFeedError(String errorTxt);

  void onPublishInstagramItemSuccess(InstagramFeedItem instagramFeedItem);
  void onPublishInstagramItemError(String errorTxt);
}

class InstagramFeedScreenPresenter {
  InstagramFeedScreenContract _view;
  RestDatasource api = new RestDatasource();
  InstagramFeedScreenPresenter(this._view);

  getInstagramFeed(int instagram_id, String cursor) async{
    api.getInstagramFeed(instagram_id, cursor).then((List<InstagramFeedItem> instagramFeed) {
      print(instagramFeed);
      _view.onGetInstagramFeedSuccess(instagramFeed);
    }).catchError((Object error) => _view.onGetInstagramFeedError(error.toString()));
  }
  publishInstagramFeedItem(InstagramFeedItem instagramFeedItem){
    api.publishInstagramItem(instagramFeedItem).then((bool response){
      print(response);
      _view.onPublishInstagramItemSuccess(instagramFeedItem);
    }).catchError((Object error) => _view.onPublishInstagramItemError(error.toString()));
  }
}