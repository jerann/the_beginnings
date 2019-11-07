import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'CommentBox.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.network(
        "https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4")
      ..initialize().then((_) {
        setState(() {});
      });

    _videoController.addListener(() {
      setState(() {});
    });

    _videoController.setLooping(true);
  }

  _toggleVideoPlayback() {
    _videoController.value.isPlaying
        ? _videoController.pause()
        : _videoController.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(children: [
          Expanded(
            flex: 24,
            child: GestureDetector(
              onTap: _toggleVideoPlayback,
              child: Container(
                color: Colors.blueAccent,
                child: _videoController.value.initialized
                    ? AspectRatio(
                        aspectRatio: _videoController.value.aspectRatio,
                        child: VideoPlayer(_videoController),
                      )
                    : Container(),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.black,
              alignment: Alignment.centerLeft,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Row(
                    children: <Widget>[
                      SizedBox(
                        width: _videoController.value.position !=
                                Duration(seconds: 0)
                            ? constraints.maxWidth *
                                (_videoController
                                        .value.position.inMilliseconds /
                                    _videoController
                                        .value.duration.inMilliseconds)
                            : 0,
                        child: Container(color: Colors.red),
                      ),
                      SizedBox(
                        height: constraints.maxHeight,
                        width: constraints.maxHeight,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 36,
            child: Container(
              color: Colors.green,
              child: ListView(
                children: [
                  CommentBox(
                    userName: "falafelSandwich",
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
  }
}
