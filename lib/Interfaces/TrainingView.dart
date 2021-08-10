import 'package:app/Interfaces/capture.dart';
import 'package:app/Interfaces/report.dart';
import 'package:app/Services/widget/advanced_overlay_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:video_player/video_player.dart';

class SessionSingle extends StatefulWidget {
  final String video;
  final String title;
  final String description;
  final String tuteID;
  final String ref;
  final bool done;
  const SessionSingle({Key key, this.video, this.title, this.description, this.tuteID, this.ref, this.done}) : super(key: key);

  @override
  _SessionSingleState createState() => _SessionSingleState();
}

class _SessionSingleState extends State<SessionSingle> {
  VideoPlayerController controller;

  TextEditingController reviewT = TextEditingController();
  int numOfItems = 1;

  Orientation target;

  @override
  void initState() {
    super.initState();

    controller = VideoPlayerController.network(widget.video)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize();

    NativeDeviceOrientationCommunicator()
        .onOrientationChanged(useSensor: true)
        .listen((event) {
      final isPortrait = event == NativeDeviceOrientation.portraitUp;
      final isLandscape = event == NativeDeviceOrientation.landscapeLeft ||
          event == NativeDeviceOrientation.landscapeRight;
      final isTargetPortrait = target == Orientation.portrait;
      final isTargetLandscape = target == Orientation.landscape;

      if (isPortrait && isTargetPortrait || isLandscape && isTargetLandscape) {
        target = null;
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    setOrientation(true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF545D68)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Training View',
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 20.0,
                color: Color(0xFF545D68))),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications_none, color: Color(0xFF545D68)),
            onPressed: () {},
          ),
        ],
      ),

      body: ListView(
          children: [
            SizedBox(height: 15.0),
            Container(
                height: 200.0,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.topCenter,
                child: buildVideo()
              //
            ),
            SizedBox(height: 20.0),
            SizedBox(height: 10.0),
            Center(
              child: Text(widget.title,
                  style: TextStyle(
                      color: Color(0xFF575E67),
                      fontFamily: 'Varela',
                      fontSize: 24.0)),
            ),
            SizedBox(height: 20.0),
            Center(
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width - 50.0,
                child: Text(
                    widget.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 16.0,
                        color: Color(0xFFB4B8B9))
                ),
              ),
            ),
            SizedBox(height: 20.0),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return Capture(video: widget.video,title: widget.title,desc: widget.description,);
                }));
              },
              child: Center(
                  child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width - 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: Color(0xFFF17532)
                      ),
                      child: Center(
                          child: Text('View',
                            style: TextStyle(
                                fontFamily: 'Varela',
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),
                          )
                      )
                  )
              ),
            ),
            SizedBox(height: 20.0,),
            widget.done ?             InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return ReportPage(attempt: "1",name: widget.title,);
                }));
              },
              child: Center(
                  child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width - 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: Color(0xFFF17532)
                      ),
                      child: Center(
                          child: Text('View Report',
                            style: TextStyle(
                                fontFamily: 'Varela',
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),
                          )
                      )
                  )
              ),
            )
                : Container(),
          ]
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
  Widget buildVideo() => OrientationBuilder(
    builder: (context, orientation) {
      final isPortrait = orientation == Orientation.portrait;

      setOrientation(isPortrait);

      return Stack(
        fit: isPortrait ? StackFit.loose : StackFit.expand,
        children: <Widget>[
          buildVideoPlayer(),
          Positioned.fill(
            child: AdvancedOverlayWidget(
              controller: controller,
              onClickedFullScreen: () {
                target = isPortrait
                    ? Orientation.landscape
                    : Orientation.portrait;

                // if (isPortrait) {
                //   AutoOrientation.landscapeRightMode();
                // } else {
                //   AutoOrientation.portraitUpMode();
                // }
              },
            ),
          ),
        ],
      );
    },
  );

  Widget buildVideoPlayer() {
    final video = AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: VideoPlayer(controller),
    );

    return buildFullScreen(child: video);
  }

  Widget buildFullScreen({
    @required Widget child,
  }) {
    final size = controller.value.size;
    final width = size?.width ?? 0;
    final height = size?.height ?? 0;

    return FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(width: width, height: height, child: child),
    );
  }

  void setOrientation(bool isPortrait) {
    if (isPortrait) {

      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    } else {

      SystemChrome.setEnabledSystemUIOverlays([]);
    }
  }
}
