import 'package:memezitos_land_admin/data/rest_ds.dart';
import 'package:memezitos_land_admin/models/user.dart';
import 'package:memezitos_land_admin/models/instagram_account.dart';

abstract class HomeScreenContract {
  void onGetInstagramAccountsSuccess(List<InstagramAccount> instagramAccounts);
  void onGetInstagramAccountsError(String errorTxt);
}

class HomeScreenPresenter {
  HomeScreenContract _view;
  RestDatasource api = new RestDatasource();
  HomeScreenPresenter(this._view);

  getInstagramAccounts() {
    api.getInstagramAccounts().then((List<InstagramAccount> instagramAccounts) {
      print(instagramAccounts);
      _view.onGetInstagramAccountsSuccess(instagramAccounts);
    }).catchError((Exception error) => _view.onGetInstagramAccountsError(error.toString()));
  }
}