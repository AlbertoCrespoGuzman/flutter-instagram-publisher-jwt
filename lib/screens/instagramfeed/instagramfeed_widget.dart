import 'package:flutter/material.dart';
import 'package:memezitos_land_admin/models/instagramfeed_item.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';


typedef void PublishInstagramItemCallback(InstagramFeedItem instagramFeedItem);

class InstagramFeedWidget extends StatefulWidget {

  final List<InstagramFeedItem> instagramFeed;
  final PublishInstagramItemCallback publishInstagramItemCallback;

  InstagramFeedWidget(this.instagramFeed, this.publishInstagramItemCallback);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new InstagramFeedWidgetState(this.instagramFeed, this.publishInstagramItemCallback);
  }
}

class InstagramFeedWidgetState extends State<InstagramFeedWidget> {



  BuildContext _ctx;
  List <VideoPlayerController> videoPlayers = [];
  List<ChewieController> controllers = [];

  List<TextEditingController> _textFieldControllers = new List();


   List<InstagramFeedItem> instagramFeed;
   PublishInstagramItemCallback publishInstagramItemCallback;


  InstagramFeedWidgetState(List<InstagramFeedItem> instagramFeedGlobal, PublishInstagramItemCallback publishInstagramItemCallbackGlobal){
    instagramFeed = instagramFeedGlobal;
    publishInstagramItemCallback = publishInstagramItemCallbackGlobal;
  }


  Widget _buildInstagramFeedWidgetItem(BuildContext context, int index) {
    _ctx = context;
    final TextEditingController _controller = new TextEditingController();
    _textFieldControllers.add(_controller);

    if(index < instagramFeed.length){
      print(index.toString() + '/' + instagramFeed.length.toString());

    if (instagramFeed[index].video.length > 0) {
      final videoPlayerController = VideoPlayerController.network(
          instagramFeed[index].video);

      final chewieController = ChewieController(
          videoPlayerController: videoPlayerController,
          aspectRatio: 3 / 3,
          autoPlay: false,
          looping: true,
          autoInitialize: true
      );

      videoPlayers.add(videoPlayerController);
      controllers.add(chewieController);


      return Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            new Row(mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Chewie(
                        controller: chewieController,
                      ),
                    ),
                  ),
                ]),
            new Row(mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Flexible(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                            instagramFeed[index].caption != null ? instagramFeed[index].caption : '' )
                      ],

                    ),
                  )
                ]),
            new Row(mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                      width: 150, child:
                    new TextField(
                      autofocus: false,
                      controller: _textFieldControllers[index],
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          icon: Icon(Icons.face),
                          hintText: "Customize your caption",
                          hintStyle: TextStyle(fontWeight: FontWeight.normal,
                              fontSize: 12 /*, color: Colors.red */),
                          border: OutlineInputBorder()
                      ),
                    ),
                    ),
                  ),
                ]
            ),
            new Row(mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new RaisedButton(
                  onPressed: () =>
                      _postInInstagramFeed(instagramFeed[index], index),
                  child: new Text("Post"),
                  color: Colors.green,
                ),
                new RaisedButton(
                  onPressed: () => _editInstagramAccount(''),
                  child: new Text("Story"),
                  color: Colors.orange,
                )
              ],)
          ],
        ),
      );
    } else {
      return Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          children: <Widget>[
            new Row(mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Image.network(
                  instagramFeed[index].image != null ? instagramFeed[index]
                      .image : 'no va',
                  fit: BoxFit.fill,
                  height: 250,
                width: 300,)
                ]),
            new Row(mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Flexible(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                            instagramFeed[index].caption != null ? instagramFeed[index].caption : '' )
                      ],

                    ),
                  )
                ]),
            new Row(mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                      width: 150,

                      child:
                      new TextField(
                        autofocus: false,
                        controller: _textFieldControllers[index],
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            icon: Icon(Icons.face),
                            hintText: "Customize your caption",
                            hintStyle: TextStyle(fontWeight: FontWeight.normal,
                                fontSize: 12 /*, color: Colors.red */),
                            border: OutlineInputBorder()
                        ),
                      ),
                    ),
                  ),
                ]
            ),
            new Row(mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new RaisedButton(
                  onPressed: () =>
                      _postInInstagramFeed(instagramFeed[index], index),
                  child: new Text("Post "),
                  color: Colors.green,
                ),
                new RaisedButton(
                  onPressed: () => _editInstagramAccount(''),
                  child: new Text("Story"),
                  color: Colors.orange,
                )
              ],)
          ],
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        margin: EdgeInsets.all(10),
      );
    }

    }else{
      print('button ! =>' + index.toString() + '/' + instagramFeed.length.toString());
      return  RaisedButton(
        onPressed: () => _editInstagramAccount(''),
        child: new Text("Cargar mas"),
        color: Colors.orange,
      );
    }

  }

  @override
  void dispose() {
    _textFieldControllers.forEach((textField) => {textField.dispose()});

    videoPlayers.forEach((videoPlayerController) =>
        videoPlayerController.dispose());
    controllers.forEach((chewieController) => chewieController.dispose());
    // super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: _buildInstagramFeedWidgetItem,
      itemCount: instagramFeed.length + 1,
    );
  }

  void _postInInstagramFeed(InstagramFeedItem instagramFeedItem, int index) {
    //Navigator.of(_ctx).pushReplacementNamed("/instagram/feed/", arguments: instagram_id );
    showDialog(
      context: _ctx,
      builder: (context) {
        return AlertDialog(
          // Retrieve the text the that user has entered by using the
          // TextEditingController.
            title: Center(child: Text('Post in Instagram Feed')),
            content: Wrap(
                children: [
                  _textFieldControllers[index].text.length == 0 ? Text(
                      instagramFeedItem.caption) : Text(
                      _textFieldControllers[index].text),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new RaisedButton(
                          onPressed: () =>
                              _confirmPostInInstagramFeed(
                                  instagramFeedItem, context),
                          child: new Text("Post"),
                          color: Colors.green,
                        ),
                        new RaisedButton(
                          child: new Text("Cancel"),
                          color: Colors.orange,
                          onPressed: () => Navigator.pop(context),
                        )
                      ]
                  )
                ]
            )
        );
      },
    );
  }

  void _confirmPostInInstagramFeed(InstagramFeedItem instagramFeedItem,
      context) {
    Navigator.pop(context);
    publishInstagramItemCallback(instagramFeedItem);

  }

  void _editInstagramAccount(String _id) {
    Navigator.of(_ctx).pushReplacementNamed(
        "/instagram_account/edit/", arguments: _id);
  }

  void _deleteInstagramAccount(String _id) {
    //Navigator.of(_ctx).pushReplacementNamed("/instagram/feed/" + _id );
    print('delete');
  }
}