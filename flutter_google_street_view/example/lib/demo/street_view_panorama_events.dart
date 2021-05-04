import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_google_street_view/flutter_google_street_view.dart';
import 'package:flutter_google_street_view_example/const/const.dart';

class StreetViewPanoramaEventsDemo extends StatefulWidget {
  StreetViewPanoramaEventsDemo({Key key}) : super(key: key);

  @override
  _StreetViewPanoramaEventsDemoState createState() =>
      _StreetViewPanoramaEventsDemoState();
}

class _StreetViewPanoramaEventsDemoState
    extends State<StreetViewPanoramaEventsDemo> {
  StreetViewController _controller;

  var _onPanoramaClickListenerCnt = 0;
  var _onPanoramaLongClickListenerCnt = 0;

  var _onCameraChangeListenerInfo =
      "Camera Change, bearing: N/A, tilt: N/A, zoom: N/A";
  var _onPanoramaChangeListenerInfo = "Pano Change, position: N/A";
  var _onPanoramaClickListenerInfo = "Click cnt:0";
  var _onPanoramaLongClickListenerInfo = "Long click cnt:0";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Street View Events Demo'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              FlutterGoogleStreetView(
                initPos: SYDNEY,
                onStreetViewCreated: (controller) {
                  setState(() {
                    _controller = controller;
                  });
                },
                onCameraChangeListener: (camera) {
                  setState(() {
                    _onCameraChangeListenerInfo =
                        "Camera Change:\nbearing: ${camera.bearing.toStringAsFixed(3)}, tilt: ${camera.tilt.toStringAsFixed(3)}, zoom: ${camera.zoom.toStringAsFixed(3)}";
                  });
                },
                onPanoramaChangeListener: (location) {
                  setState(() {
                    _onPanoramaChangeListenerInfo =
                        "Pano Change position:\n${location.position.latitude.toStringAsFixed(7)}, ${location.position.longitude.toStringAsFixed(7)}\nPanoId: ${location.panoId}";
                  });
                },
                onPanoramaClickListener: (orientation) {
                  _onPanoramaClickListenerCnt++;
                  _controller
                      .orientationToPoint(orientation)
                      .then((value) => setState(() {
                            _onPanoramaClickListenerInfo =
                                "Click cnt:$_onPanoramaClickListenerCnt, click point:$value";
                          }));
                },
                onPanoramaLongClickListener: (orientation) {
                  _onPanoramaLongClickListenerCnt++;
                  _controller
                      .orientationToPoint(orientation)
                      .then((value) => setState(() {
                            _onPanoramaLongClickListenerInfo =
                                "Long click cnt:$_onPanoramaLongClickListenerCnt, click point:$value";
                          }));
                },
              ),
              if (_controller != null)
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Card(
                    color: Colors.white.withOpacity(0.8),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_onCameraChangeListenerInfo),
                          SizedBox(
                            height: 8,
                          ),
                          Text(_onPanoramaChangeListenerInfo),
                          SizedBox(
                            height: 8,
                          ),
                          Text(_onPanoramaClickListenerInfo),
                          SizedBox(
                            height: 8,
                          ),
                          Text(_onPanoramaLongClickListenerInfo)
                        ],
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}