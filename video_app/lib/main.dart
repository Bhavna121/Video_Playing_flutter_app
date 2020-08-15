import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(MyApp());
}


myDownloadToast()
  {
    Fluttertoast.showToast(
        msg: "Downloaded successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white10,
        textColor: Colors.white,
        fontSize: 10.0
    );
  }

myFavToast()
  {
    Fluttertoast.showToast(
        msg: "Added to favourites!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white10,
        textColor: Colors.white,
        fontSize: 10.0
    );
  }

var mylogo=Image.asset('images/musicwhite.png');

var downloadicon=Icon(Icons.file_download);
var favouriteicon=Icon(Icons.favorite_border);
//var myplayicon=Icon(Icons.tap_and_play);


var mydownload=IconButton(
  icon: downloadicon,
  onPressed: myDownloadToast,
);

var myfav=IconButton(
  icon: favouriteicon,
  onPressed: myFavToast,
);

class MyApp extends StatefulWidget {
MyApp() :super();
final String title= "Video App";

  @override
  VideoDemoState createState() => VideoDemoState();
}

class VideoDemoState extends State<MyApp> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState(){
    _controller=VideoPlayerController.network("https://github.com/Bhavna121/video_song_for_app/blob/master/video.mp4?raw=true");
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(1.0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: mylogo,
          title:Text("My Playlist",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontFamily: "Times New Roman",
            color: Colors.white70,
          ),
          ),
          actions: <Widget>[
            mydownload,
            myfav,
          ],
        ),
        body: Container(
          color: Colors.black,
            child: Column(
            children: <Widget>[
              Container(
                height:75,
                color: Colors.black,
              ),
              Container(
                height: 200,
                margin:EdgeInsets.all(30),
                 child: FutureBuilder( 
                  future: _initializeVideoPlayerFuture,
                  builder: (context,snapshot){
                    if(snapshot.connectionState == ConnectionState.done){
                      return AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child:VideoPlayer(_controller),
                      );
                    }
                    else{
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 135, 70),
          child: FloatingActionButton(

            backgroundColor: Colors.white10,
           onPressed: (){
              setState(() {
                if(_controller.value.isPlaying){
                  _controller.pause();
                }
                else{
                  _controller.play();
                }
              });
            },
            child: Icon(_controller.value.isPlaying ? Icons.pause: Icons.play_arrow),
          ),
        ),
        
      ),
    );
  }
}