
import 'package:camera_deep_ar/camera_deep_ar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  late CameraDeepArController cameraDeepArController;
  int currentPage = 0;
  final vp = PageController(viewportFraction: .24);
  Effects currentEffect = Effects.none;
  Filters currentFilter = Filters.none;
  Masks currentMask = Masks.none;
  bool isRecording = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('DeepAR Camera Example'),
        ),
        body: Stack(
          children: [
            CameraDeepAr(
                onCameraReady: (isReady) {
                  _platformVersion = "Camera status $isReady";
                  setState(() {});
                },
                onImageCaptured: (path) {
                  _platformVersion = "Image Taken @ $path";
                  setState(() {});
                },
                onVideoRecorded: (path) {
                  _platformVersion = "Video Recorded @ $path";
                  isRecording = false;
                  setState(() {});
                },
                androidLicenceKey:
                "aba4ced7dab46746075a6f0044f2d93c9c58d46636f90d6b2782289d655ae588ca873fd3c1b90873",
                iosLicenceKey:
                "6ce1078f5f6250205ec4dd962d76861e8197543cf1bcc433a2541ffb3cc4571ea30360f1dc768829",
                cameraDeepArCallback: (c) async {
                  cameraDeepArController = c;
                  setState(() {});
                }),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(20),
                //height: 250,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Response >>> : $_platformVersion\n',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: FlatButton(
                            onPressed: () {
                              if (null == cameraDeepArController) return;
                              if (isRecording) return;
                              cameraDeepArController.snapPhoto();
                            },
                            child: Icon(Icons.camera_enhance_outlined),
                            color: Colors.white,
                            padding: EdgeInsets.all(15),
                          ),
                        ),
                        if (isRecording)
                          Expanded(
                            child: FlatButton(
                              onPressed: () {
                                if (null == cameraDeepArController) return;
                                cameraDeepArController.stopVideoRecording();
                                isRecording = false;
                                setState(() {});
                              },
                              child: Icon(Icons.videocam_off),
                              color: Colors.red,
                              padding: EdgeInsets.all(15),
                            ),
                          )
                        else
                          Expanded(
                            child: FlatButton(
                              onPressed: () {
                                if (null == cameraDeepArController) return;
                                cameraDeepArController.startVideoRecording();
                                isRecording = true;
                                setState(() {});
                              },
                              child: Icon(Icons.videocam),
                              color: Colors.green,
                              padding: EdgeInsets.all(15),
                            ),
                          ),
                      ],
                    ),
                    SingleChildScrollView(
                      padding: EdgeInsets.all(15),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(Masks.values.length, (p) {
                          bool active = currentPage == p;
                          return GestureDetector(
                            onTap: () {
                              currentPage = p;
                              cameraDeepArController.changeMask(p);
                              setState(() {});
                            },
                            child: Container(
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(12),
                                width: active ? 100 : 80,
                                height: active ? 100 : 80,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color:
                                    active ? Colors.orange : Colors.white,
                                    shape: BoxShape.circle),
                                child: Text(
                                  "$p",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: active ? 16 : 14,
                                      color: Colors.black),
                                )),
                          );
                        }),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
