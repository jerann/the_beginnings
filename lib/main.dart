import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
  int _counter = 0;

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

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
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
                child: Container(
                    color: Colors.blueAccent,
                    child: _videoController.value.initialized
                        ? AspectRatio(
                      aspectRatio: _videoController.value.aspectRatio,
                      child: VideoPlayer(_videoController),
                    )
                        : Container())),
            Expanded(
                flex: 1,
                child: Container(
                    color: Colors.black,
                    alignment: Alignment.centerLeft,
                    child: LayoutBuilder(builder: (context, constraints) {
                      return Row(
                        children: <Widget>[
                          SizedBox(
                            width: constraints.maxWidth * (_videoController
                                .value.position.inMilliseconds /
                                _videoController.value.duration.inMilliseconds),
                            child: Container(color: Colors.red),
                          ),
                          SizedBox(
                            height: constraints.maxHeight,
                            width: constraints.maxHeight,
                            child: Container(decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),)
                          )
                        ],
                      );
                    },)
                )),
            Expanded(flex: 36, child: Container(color: Colors.green))
          ])),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _videoController.value.isPlaying
              ? _videoController.pause()
              : _videoController.play();
        },
        tooltip: _videoController.value.isPlaying ? "Pause" : "Play",
        child: Icon(
            _videoController.value.isPlaying ? Icons.pause : Icons.play_arrow),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
  }
}
