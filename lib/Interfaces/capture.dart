import 'dart:io';

import 'package:app/Interfaces/TrainingView.dart';
import 'package:app/Interfaces/videotest.dart';
import 'package:app/Services/widget/orientation/landscape_player_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pip_view/pip_view.dart';

import '../main.dart';

class Capture extends StatefulWidget {
  final String title;
  final String video;
  final String desc;
  final String tuteID;
  final String ref;
  const Capture({Key key, this.title, this.video, this.desc, this.tuteID, this.ref}) : super(key: key);

  @override
  _CaptureState createState() => _CaptureState();
}

class _CaptureState extends State<Capture> {
  CameraController cameraController;
  String videoPath;
  final picker = ImagePicker();
  bool isRecording = false;

  @override
  void initState() {
    super.initState();
    cameraController = CameraController(cameras[1], ResolutionPreset.medium);
    cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PIPView(builder: (context, isFloating) {
      return WillPopScope(
          onWillPop: () {
            // Navigator.pushReplacement(
            //     context, MaterialPageRoute(builder: (c) => StoreHome()));
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text("Training View"),
              centerTitle: true,
              backgroundColor: Colors.deepPurple,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (c) => SessionSingle(
                            title: widget.title,
                            video: widget.video,
                            done: false,
                            ref: widget.ref,
                            tuteID: widget.tuteID,
                            description: widget.desc,
                          )));
                },
              ),
            ),
            body: Center(
              child: Container(
                padding: EdgeInsets.only(top: 20.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AspectRatio(
                        aspectRatio: cameraController.value.aspectRatio,
                        child: CameraPreview(cameraController)),
                    InkWell(
                        onTap: () {
                          print(isRecording);
                          if (isRecording == false) {
                            startRecord();
                            PIPView.of(context).presentBelow(
                                LandscapePlayerPage(widget.video));
                          } else if (isRecording == true) {
                            stopRecord();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => VideoPlay(
                                      url: videoPath,
                                      tuteName: widget.title,
                                      tuteID: widget.tuteID,
                                      ref: widget.ref,
                                    )));
                          }
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera,
                              size: 50.0,
                              color: Colors.deepPurple,
                            )
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ));
    });
  }
  Future setLandscape() async {
    await SystemChrome.setEnabledSystemUIOverlays([]);
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  void startRecord() async {
    print("Started: ");

    final Directory appDirectory = await getTemporaryDirectory();
    final String videoDirectory = '${appDirectory.path}/Videos';
    await Directory(videoDirectory).create(recursive: true);
    final String currentTime = DateTime.now().millisecondsSinceEpoch.toString();
    final String filePath = '$videoDirectory/$currentTime.mp4';

    try {
      await cameraController.startVideoRecording(filePath);
      print('File path: ' + filePath);
      videoPath = filePath;
      isRecording = true;
    } on CameraException catch (e) {
      print(e);
    }
  }

  void stopRecord() async {
    print("Ended");
    try {
      await cameraController.stopVideoRecording();
      isRecording = false;
    } on CameraException catch (e) {
      print(e);
    }
  }
}
