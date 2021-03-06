import 'package:app/Services/widget/advanced_overlay_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

class ReportPage extends StatefulWidget {
final String attempt;
final String name;

  const ReportPage(
      {Key key, this.attempt, this.name})
      : super(key: key);

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  VideoPlayerController controller;

  TextEditingController reviewT = TextEditingController();
  int numOfItems = 1;

  Orientation target;

  @override
  void initState() {
    super.initState();

    controller = VideoPlayerController.network("https://firebasestorage.googleapis.com/v0/b/mobileapphackathon-e3c33.appspot.com/o/5%20second%20countdown%20with%20sound%20effect%20(1).mp4?alt=media&token=88d7b96e-4c30-4d31-892d-97b0f38ce195")
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

  List overallInfo = [];

  @override
  Widget build(BuildContext context) {
    getAttemptOverall();
    List<_SalesData> data = [
      _SalesData("Session 1", 78),
      _SalesData("Session 2", 72)
    ];

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 30.0,
          title: Text(widget.name + " Attempt " + widget.attempt),
          centerTitle: true,
          backgroundColor: Colors.orange,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Tutorial Date: 2021.07.30",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Overall Performance: 78%",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Center(
                      heightFactor: 1.1,
                      child: SfSparkBarChart(
                        color: Colors.orange,
                        data: <double>[
                          89,
                          87,
                          67,
                          89,
                          87,
                          67,
                          89,
                          87,
                          67,
                          89,
                          87,
                          65
                        ],
                      )),
                ),
                Text(
                  "Bars from left to right",
                  style: TextStyle(fontSize: 14.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, bottom: 8.0, top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 180.0,
                        child: Column(
                          children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "1.Right Shoulder: 89%",
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold),
                                )),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "2.Right Elbow: 87%",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                )),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "3.Right Wrist: 67%",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                )),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "4.Right Hip: 89%",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                )),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "5.Right Knee: 87%",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                )),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "6.Right Ankle: 67%",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                )),
                          ],
                        ),
                      ),
                      Container(
                        width: 174.0,
                        child: Column(
                          children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "7.Left Shoulder: 89%",
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold),
                                )),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "8.Left Elbow: 87%",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                )),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "9.Left Wrist: 67%",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                )),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "10.Left Hip: 67%",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                )),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "11.Left Knee: 89%",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                )),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "12.Left Ankle: 87%",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
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
                            "Download PDF",
                            style: TextStyle(fontSize: 18.0),
                          ))),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        //launch(widget.url);
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
                            "Overall report",
                            style: TextStyle(fontSize: 18.0),
                          ))),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  // height: 30.0,
                  child: Column(children: [
                    //Initialize the chart widget
                    SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        // Chart title
                        title: ChartTitle(text: 'Your Overall Performance'),
                        // Enable legend
                        legend: Legend(isVisible: true),
                        // Enable tooltip
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <ChartSeries<_SalesData, String>>[
                          LineSeries<_SalesData, String>(
                              dataSource: data,
                              xValueMapper: (_SalesData sales, _) => sales.year,
                              yValueMapper: (_SalesData sales, _) =>
                                  sales.sales,
                              name: '',
                              // Enable data label
                              dataLabelSettings:
                                  DataLabelSettings(isVisible: true))
                        ]),
                  ]),
                ),
                // Container(
                //     height: 600.0,
                //     padding: EdgeInsets.all(8.0),
                //     width: MediaQuery.of(context).size.width,
                //     alignment: Alignment.topCenter,
                //     child: buildVideo()
                //     //
                //     ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getAttemptOverall() async {
    // List temp = [];
    // await Firestore.instance
    //     .collection("users")
    //     .document(
    //         EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
    //     .collection("Reports")
    //     .document(widget.tuteID)
    //     .collection("attempts")
    //     .orderBy("attempt")
    //     .getDocuments()
    //     .then((value) => {
    //           value.documents.forEach((element) {
    //             temp.add({
    //               'attempt': element['attempt'],
    //               'overall': element['overall']
    //             });
    //           })
    //         });
    // setState(() {
    //   overallInfo = temp;
    // });
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
      Wakelock.disable();
      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    } else {
      Wakelock.enable();
      SystemChrome.setEnabledSystemUIOverlays([]);
    }
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
