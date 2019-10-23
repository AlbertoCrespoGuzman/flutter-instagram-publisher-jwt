import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:memezitos_land_admin/auth.dart';
import 'package:memezitos_land_admin/models/instagramfeed_item.dart';
import 'package:memezitos_land_admin/screens/home/instagram_accounts_widget.dart';
import 'package:memezitos_land_admin/screens/instagramfeed/instagramfeed_screen_representer.dart';
import 'package:memezitos_land_admin/screens/instagramfeed/instagramfeed_widget.dart';

typedef void MyCallback(InstagramFeedItem instagramFeedItem);

class InstagramFeedScreen extends StatefulWidget {



  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new InstagramFeedScreenState();
  }
}

class InstagramFeedScreenState extends State<InstagramFeedScreen>
    implements InstagramFeedScreenContract, AuthStateListener {
  BuildContext _ctx;


  bool _isLoading = false;
  bool _isPublishing = false;
  bool _showInstagramItems = false;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  List<InstagramFeedItem> _instagramFeedItems;
  InstagramFeedScreenPresenter _presenter;

  InstagramFeedScreenState() {
    _presenter = new InstagramFeedScreenPresenter(this);
    var authStateProvider = new AuthStateProvider();
    authStateProvider.subscribe(this);
    _instagramFeedItems = [];
  }

  void _getInstagramFeed(instagram_id) {
    setState(() => _isLoading = true);
    if(_instagramFeedItems.length == 0){
      _presenter.getInstagramFeed(instagram_id , 0.toString());
    }else{
      _presenter.getInstagramFeed(instagram_id ,_instagramFeedItems[_instagramFeedItems.length -1].cursor);
    }
  }

  void _publishInstagramItem(InstagramFeedItem instagramFeedItem){
    setState(() => _isPublishing = true);
    showDialog(
      context: _ctx,
      builder: (context) {
        return AlertDialog(
          // Retrieve the text the that user has entered by using the
          // TextEditingController.
          title: Center(child: Text('Publishing on Instagram')),
          content: Wrap( children: [Center(child: new CircularProgressIndicator())]),
        );
      },
    );
    _presenter.publishInstagramFeedItem(instagramFeedItem);
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
    int instagram_id = ModalRoute.of(_ctx).settings.arguments;

    if(!_showInstagramItems){
      _getInstagramFeed(instagram_id);
    }

    var instagramFeedList = InstagramFeedWidget(_instagramFeedItems, _publishInstagramItem);

    var container = new Container(
        child:  _showInstagramItems ? instagramFeedList : new Text('nada')
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
                color: Colors.yellowAccent,
              ),
            ),
            ListTile(
              title: Text('Cuentas Instagram'),
              onTap: () {
                Navigator.pop(_ctx);
                Navigator.of(_ctx).pushReplacementNamed("/home");
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      appBar: new AppBar(title: new Text("Home"),),
      body:  new Center( child:  _isLoading ? new CircularProgressIndicator() : container )

      );
  }
  @override
  void onGetInstagramFeedError(String errorTxt) {
    _showSnackBar(errorTxt);
    setState(() => _isLoading = false);
  }

  @override
  void onGetInstagramFeedSuccess(List<InstagramFeedItem> instagramFeedItems) async {
    print(instagramFeedItems);
    _instagramFeedItems.addAll(instagramFeedItems);
    setState((){
      _isLoading = false;
      _showInstagramItems = true;
    });
  }

  @override
  void onPublishInstagramItemError(String errorTxt) {
    setState((){
      _isPublishing = false;
      _showInstagramItems = true;
    });
    Navigator.pop(context);

      showDialog(
        context: _ctx,
        builder: (context) {
          return AlertDialog(
            // Retrieve the text the that user has entered by using the
            // TextEditingController.
            title: Center(child: Text('error' + errorTxt)),
            content: Wrap(
                children: [ Text('error' + errorTxt)]),
          );
        },
      );

    print('onPublishInstagramItemError -> ' + errorTxt);
  }

  @override
  void onPublishInstagramItemSuccess(InstagramFeedItem instagramFeedItem) {
    _instagramFeedItems.remove(instagramFeedItem);
    setState((){
      _isPublishing = false;
      _showInstagramItems = true;
    });
    print('onPublishInstagramItemSuccess -> ');

    Navigator.pop(context);
    showDialog(
      context: _ctx,
      builder: (context) {
        return AlertDialog(
          // Retrieve the text the that user has entered by using the
          // TextEditingController.
            title: Center(child: Text('Post Ok')),
            content: Wrap(
                children: [  Text('Post Ok')]),
        );
      },
    );

  }

}

