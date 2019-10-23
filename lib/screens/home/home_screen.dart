import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:memezitos_land_admin/auth.dart';
import 'package:memezitos_land_admin/data/database_helper.dart';
import 'package:memezitos_land_admin/screens/home/home_screen_representer.dart';
import 'package:memezitos_land_admin/models/instagram_account.dart';
import 'package:memezitos_land_admin/screens/home/instagram_accounts_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen>
    implements HomeScreenContract, AuthStateListener {
  BuildContext _ctx;

  bool _isLoading = false;
  bool _showInstagramAccounts = false;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  List<InstagramAccount> _instagramAccounts;
  HomeScreenPresenter _presenter;

  HomeScreenState() {
    _presenter = new HomeScreenPresenter(this);
    var authStateProvider = new AuthStateProvider();
    authStateProvider.subscribe(this);
    _instagramAccounts = [];
  }

  void _getInstagramAccounts() {
      setState(() => _isLoading = true);
      _presenter.getInstagramAccounts();

  }
  void _logOut(){
    var db = new DatabaseHelper();
    db.deleteUsers();
    Navigator.of(_ctx).pushReplacementNamed("/login");
  }
  void _showSnackBar(String text) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }

  @override
  onAuthStateChanged(AuthState state) {

  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;

    var instagramAccountsList = InstagramAccountsWidget(_instagramAccounts);

    var container = new Container(
      child:  _showInstagramAccounts ? instagramAccountsList : new Text('nada')
    );

    return new Scaffold(
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Memezitos'),
              decoration: BoxDecoration(
                color: Colors.yellow,
              ),
            ),
            ListTile(
              title: Text('Instagram Accounts'),
              onTap: () {
                Navigator.pop(_ctx);
                _getInstagramAccounts();
              },
            ),
            ListTile(
              title: Text('Log Out'),
              onTap: () {
                _logOut();
                // ...
              },
            ),
          ],
        ),
      ),
      appBar: new AppBar(title: new Text("Home"),),
      body: new Center(
        child: _isLoading ? new CircularProgressIndicator() : container,
      ),
    );
  }
  @override
  void onGetInstagramAccountsError(String errorTxt) {
    _showSnackBar(errorTxt);
    setState(() => _isLoading = false);
  }

  @override
  void onGetInstagramAccountsSuccess(List<InstagramAccount> instagramAccounts) async {
    _instagramAccounts.addAll(instagramAccounts);
    setState((){
      _isLoading = false;
      _showInstagramAccounts = true;
    });

  }
}

