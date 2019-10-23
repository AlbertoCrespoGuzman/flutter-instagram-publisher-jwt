import 'package:flutter/material.dart';
import 'package:memezitos_land_admin/models/instagram_account.dart';

class InstagramAccountsWidget extends StatelessWidget {
  final List<InstagramAccount> instagramAccounts;
  InstagramAccountsWidget(this.instagramAccounts);
  BuildContext _ctx;
  int instagram_id;

  Widget _buildInstagramAccountWidgetItem(BuildContext context, int index) {
    _ctx = context;

    return Card(
      child: Column(
        children: <Widget>[
          Text(instagramAccounts[index].name, style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold, fontSize: 30.0)),
          new Row(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                child: new Text('Get Images:' + instagramAccounts[index].get_images.toString(),
                    style: new TextStyle(color: Color(0xFF2E3233))),
                onTap: () {},
              ),
              GestureDetector(
                child: new Text('Get Videos:' + instagramAccounts[index].get_videos.toString(),
                    style: new TextStyle(color: Color(0xFF2E3233))),
                onTap: () {},
              ),
              GestureDetector(
                child: new Text('Get Caption:' + instagramAccounts[index].get_caption.toString(),
                    style: new TextStyle(color: Color(0xFF2E3233))),
                onTap: () {},
              )
            ],),
          new Row(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new RaisedButton(
                onPressed: () => _getInstagramFeed(instagramAccounts[index].instagram_id),
                child: new Text("Ver instagram"),
                color: Colors.green,
              ),
              new RaisedButton(
                onPressed: () => _editInstagramAccount(instagramAccounts[index].id),
                child: new Text("Edit"),
                color: Colors.orange,
              ),
              new RaisedButton(
                onPressed: () => _deleteInstagramAccount(instagramAccounts[index].id),
                child: new Text("Delete"),
                color: Colors.red,
              ),
            ],)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: _buildInstagramAccountWidgetItem,
      itemCount: instagramAccounts.length,
    );
  }

  void _getInstagramFeed(int instagram_id){
    this.instagram_id = instagram_id;
    Navigator.of(_ctx).pushReplacementNamed("/instagram/feed", arguments: this.instagram_id );
  }
  void _editInstagramAccount(String _id){
    Navigator.of(_ctx).pushReplacementNamed("/instagram_account/edit", arguments: _id );
  }
  void _deleteInstagramAccount(String _id){
    //Navigator.of(_ctx).pushReplacementNamed("/instagram/feed/" + _id );
    print('delete');
  }
}