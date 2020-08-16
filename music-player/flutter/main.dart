import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(MyApp());
}

const buttonColor = Colors.grey;
const activeButtonColor = Colors.black12;
const controllerBgColor = Colors.white;
const controllerShadowColor = Colors.black12;
const progressBgColor = Colors.black45;
const progressColor = Colors.pink;
const albumTitle = TextStyle(color: Colors.black87, fontSize: 12);
const albumSubTitle = TextStyle(color: Colors.black54, fontSize: 11);

class Album {
  final String title;
  final String subTitle;
  final String imageSrc;

  Album({
    @required this.subTitle,
    @required this.imageSrc,
    @required this.title,
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Player Simple V1',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Simple Music Player UI'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  final Map<String, dynamic> settings = {
    'duration': Duration(milliseconds: 500),
    'curves': Curves.easeOutQuad
  };

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  bool _isPlaying = false;
  AnimationController _controller;
  AnimationController _rotateController;
  double _progressValue = 0.0;
  Timer _progressController;
  int _count = 1;

  Album _album = Album(
      subTitle: 'Imagine Dragons',
      imageSrc:
          'https://upload.wikimedia.org/wikipedia/en/b/b5/ImagineDragonsEvolve.jpg',
      title: 'Thunder');

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _rotateController = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  //! Controller Action

  // Previous Track
  void _previousTrack() {
    // TODO: Add functionality to play previous track.
  }
  // Play-Pause
  void _playPause() {
    _togglePlay();
    //? Handel Progress Controller
  }

  // Next Track
  void _nextTrack() {
    // TODO: Add functionality to play next track here.
  }

  void _togglePlay() {
    _isPlaying = !_isPlaying;
    if (_progressController == null) {
      _progressController =
          new Timer.periodic(Duration(milliseconds: 100), (timer) {
        if (_progressValue >= 1.0) {
          _progressValue = 0.0;
          _count = 1;
        } else {
          _progressValue = _count / 100;
          _count++;
        }
        setState(() {});
      });
    }

    if (_isPlaying) {
      _controller.forward();
      _rotateController.repeat();
    } else {
      _controller.reverse();
      _rotateController.reset();
      _progressController.cancel();
      _progressController = null;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Center(
          child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: controllerShadowColor,
            offset: Offset(0.0, 10.0),
            blurRadius: 10.0,
          ),
        ]),
        child: Stack(
          alignment: Alignment.center,
          overflow: Overflow.visible,
          children: <Widget>[
            _albumDetals(),
            _playerControlls(),
            _discWidget(),
          ],
        ),
      )),
    );
  }

  Widget _albumDetals() {
    return AnimatedPositioned(
      duration: widget.settings['duration'],
      curve: widget.settings['curves'],
      top: _isPlaying ? -70 : 0,
      left: 10,
      child: Container(
        height: 75,
        width: 250,
        decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0))),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          // mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: 100,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _album.title,
                  style: albumTitle,
                ),
                Text(
                  _album.subTitle,
                  style: albumSubTitle,
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: 110,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        height: 5,
                        child: LinearProgressIndicator(
                          value: _progressValue, // percent filled
                          valueColor:
                              AlwaysStoppedAnimation<Color>(progressColor),
                          backgroundColor: progressBgColor,
                        ),
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _playerControlls() {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          color: controllerBgColor, borderRadius: BorderRadius.circular(10.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 100,
          ),
          IconButton(
              padding: const EdgeInsets.all(0.0),
              icon: const Icon(
                Icons.fast_rewind,
                size: 40,
                color: buttonColor,
              ),
              onPressed: _previousTrack),
          Container(
            decoration: BoxDecoration(
                color: _isPlaying ? activeButtonColor : Colors.transparent,
                borderRadius: BorderRadius.circular(10.0)),
            child: IconButton(
                padding: const EdgeInsets.all(0.0),
                color: Colors.amber,
                icon: AnimatedIcon(
                  size: 40,
                  icon: AnimatedIcons.play_pause,
                  color: buttonColor,
                  progress: _controller,
                ),
                onPressed: _playPause),
          ),
          IconButton(
              padding: const EdgeInsets.all(0.0),
              icon: const Icon(
                Icons.fast_forward,
                size: 40,
                color: buttonColor,
              ),
              onPressed: _nextTrack),
        ],
      ),
    );
  }

  Widget _discWidget() {
    return AnimatedPositioned(
      duration: widget.settings['duration'],
      curve: widget.settings['curves'],
      top: _isPlaying ? -40 : -30,
      left: _isPlaying ? 22 : 26,
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: controllerShadowColor,
            offset: Offset(0.0, 8.0),
            blurRadius: 10.0,
          )
        ]),
        child: ClipOval(
          child: AnimatedContainer(
              duration: widget.settings['duration'],
              curve: widget.settings['curves'],
              color: Colors.red,
              width: _isPlaying ? 100 : 85,
              height: _isPlaying ? 100 : 85,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned.fill(
                    child: DiscRotateAnimation(
                      animation: _rotateController,
                      child: Image.network(
                        _album.imageSrc,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  ClipOval(
                    child: Container(
                      color: Colors.white,
                      width: _isPlaying ? 20 : 16,
                      height: _isPlaying ? 20 : 16,
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

class DiscRotateAnimation extends AnimatedWidget {
  final Widget child;
  final Animation animation;

  DiscRotateAnimation({Key key, this.child, @required this.animation})
      : assert(child != null),
        super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: animation.value * 2.0 * math.pi,
      child: child,
    );
  }
}
