import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

import 'TrainingView.dart';
import 'home.dart';

class VideoPlay extends StatefulWidget {
  final String url;
  final String tuteName;
  final String tuteID;
  final String ref;
  const VideoPlay({Key key, this.url, this.tuteName, this.tuteID, this.ref}) : super(key: key);

  @override
  _VideoPlayState createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay> {
  String attempt = "1";
  String uName="Nipuna Munasinghe";
  String uid="yw0JEx7MidNW6noKuwo71ZPOgs72";
  String tuteName;
  String refTuteRep;
  String tuteID;

  VideoPlayerController _controller;

  @override
  void initState() {
    //getAttempt();
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Upload Your Training Video",
          ),
          backgroundColor: Colors.deepPurple,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Container(
          child: Column(children: [
            Center(
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : Container(),
            ),
            SizedBox(
              height: 10.0,
            ),
            Center(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0)),
                        primary: Colors.deepPurple,
                      ),
                      child: Container(
                          width: MediaQuery.of(context).size.width / 3,
                          height: 44.0,
                          child: Center(
                              child: Text(
                            "Cancel",
                            style: TextStyle(fontSize: 18.0),
                          ))),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Fluttertoast.showToast(msg: "Please remain on the page until we uplaod the video",toastLength: Toast.LENGTH_LONG);
                        //uploadDataToFirebase();
                        Timer(
                            Duration(seconds: 6),
                                () => {
                                Fluttertoast.showToast(msg: "Report has been added to the section",toastLength: Toast.LENGTH_LONG)
                            });
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return SessionSingle(title: "Exercise 1",video: "https://firebasestorage.googleapis.com/v0/b/mobileapphackathon-e3c33.appspot.com/o/IMG_7503.MOV?alt=media&token=78d33fed-6caa-4b9e-aaa3-1d424822dc80",description: "Learn to do exercises within 15 seconds",tuteID: "D2GY1tW7suIJJigGo74h",ref: "https://storage.googleapis.com/mobileapphackathon-e3c33.appspot.com/Reports/D2GY1tW7suIJJigGo74h/D2GY1tW7suIJJigGo74h.csv",done: true,);
                          }),
                        );

    },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0)),
                        primary: Colors.deepPurple,
                      ),
                      child: Container(
                          width: MediaQuery.of(context).size.width / 3,
                          height: 44.0,
                          child: Center(
                              child: Text(
                            "Submit",
                            style: TextStyle(fontSize: 18.0),
                          ))),
                    ),
                  ]),
            ),
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  // uploadDataToFirebase() async {
  //   tuteName = widget.tuteName;
  //   refTuteRep = widget.ref;
  //   tuteID = widget.tuteID;
  //
  //   String imgdownUrl1 = await uploadVideo(File(widget.url));
  //
  //   saveItemInfo(imgdownUrl1);
  // }

  // Future<String> uploadVideo(image2) async {
  //   final StorageReference storageReference =
  //   FirebaseStorage.instance.ref().child("Reports/"+uid+"/"+tuteID+"/"+attempt+"/");
  //   StorageUploadTask uploadTask2 =
  //   storageReference.child("training_$tuteID.mp4").putFile(image2);
  //   StorageTaskSnapshot taskSnapshot2 = await uploadTask2.onComplete;
  //   String downloadUrl2 = await taskSnapshot2.ref.getDownloadURL();
  //   return downloadUrl2;
  // }
  //
  // saveItemInfo(String downUrl1) async {
  //   attempt  = await getAttempt();
  //   final response = await createReport(downUrl1,tuteID,refTuteRep,tuteName,attempt,uid,uName);
  //
  //   if (response.statusCode == 200){
  //     print("All Done");
  //     Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //             builder: (c) => ProductPage(
  //               itemModel: widget.itemModel,
  //               bought: true,
  //             )));
  //     Fluttertoast.showToast(
  //     msg: 'Report added to your profile\nPlease visit your profile section',
  //     toastLength: Toast.LENGTH_LONG,
  //     gravity: ToastGravity.BOTTOM,
  //     timeInSecForIos: 1,
  //     backgroundColor: Colors.deepPurple,
  //     textColor: Colors.white
  // );
  //   }else{
  //     print(response.body);
  //   }
  // }
  //
  // Future<http.Response> createReport(String video,String tuteID,String refTuteRep,String tuteName, String attempt, String uid, String uName) {
  //   return http.post(
  //     Uri.parse('http://34.126.164.58/users'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, String>{
  //       'video': video,
  //       'tuteID': tuteID,
  //       'refTuteRep':refTuteRep,
  //       'tuteName':tuteName,
  //       'attempt':attempt,
  //       'uid':uid,
  //       'uName':uName
  //     }),
  //   );
  // }
  //
  // Future<String> getAttempt() async{
  //   int count = 1;
  //   tuteID = widget.itemModel.id;
  //   await Firestore.instance.collection("users").document(uid).collection("Reports").document(tuteID).collection("attempts").getDocuments().then((value) => {
  //     if (value.documents.length != 0){
  //       count = value.documents.length + 1
  //     }
  //   });
  //   print(count);
  //   attempt = count.toString();
  //   return count.toString();
  // }

}
