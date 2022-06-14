import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hitalive/configs/colors.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_stream/camera.dart';
import 'package:wakelock/wakelock.dart';

import 'package:hitalive/main.dart';

class StreamingScreen extends StatefulWidget {
  const StreamingScreen({Key? key}) : super(key: key);

  @override
  State<StreamingScreen> createState() => _StreamingScreenState();
}

class _StreamingScreenState extends State<StreamingScreen> {
  CameraController? _controller;

  bool _isCameraPermissionGranted = false;
  bool _isCameraInitialized = false;
  bool _isInitializing = false;
  bool _isStreaming = false;
  bool _isFrontCamSelected = true;

  Timer? _timer;
  String? _durationString;
  final _stopwatch = Stopwatch();

  _getPermissionStatus() async {
    await Permission.camera.request();
    var status = await Permission.camera.status;

    if (status.isGranted) {
      print('Camera Permission: GRANTED');
      setState(() {
        _isCameraPermissionGranted = true;
      });
      // Set and initialize the new camera
      // with front camera
      _onNewCameraSelected(cameras[1]);
    } else {
      print('Camera Permission: DENIED');
    }
  }

  _onNewCameraSelected(CameraDescription cameraDescription) async {
    setState(() {
      _isCameraInitialized = false;
    });

    final previousCameraController = _controller;

    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.high,
      enableAudio: true,
      androidUseOpenGL: true,
    );

    await previousCameraController?.dispose();

    if (mounted) {
      setState(() {
        _controller = cameraController;
      });
    }

    _controller!.addListener(() {
      _isStreaming = _controller!.value.isStreamingVideoRtmp;
      _isCameraInitialized = _controller!.value.isInitialized;

      if (_isStreaming) {
        _startTimer();
        Wakelock.enable();
      } else {
        _stopTimer();
        Wakelock.disable();
      }

      if (mounted) setState(() {});
    });

    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      print('Error initializing camera: $e');
    }
  }

  _startTimer() {
    //
  }

  _stopTimer() {
    //
  }

  @override
  void initState() {
    _getPermissionStatus();

    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    _stopwatch.stop();
    _timer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (_controller == null || !_controller!.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      _controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (_controller != null) {
        _onNewCameraSelected(_controller!.description!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            _isCameraPermissionGranted
                ? _isCameraInitialized
                    ? Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: AspectRatio(
                              aspectRatio: _controller!.value.aspectRatio,
                              child: CameraPreview(_controller!),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: 5,
                            child: IconButton(
                              icon: Icon(Icons.close, color: AppColor.black, size: 30.0,),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                          _isStreaming
                              ? const SizedBox()
                              : AspectRatio(
                                  aspectRatio: _controller!.value.aspectRatio,
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 16.0,
                                        bottom: 16.0,
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          _isFrontCamSelected
                                              ? _onNewCameraSelected(cameras[0])
                                              : _onNewCameraSelected(
                                                  cameras[1]);

                                          setState(() {
                                            _isFrontCamSelected =
                                                !_isFrontCamSelected;
                                          });
                                        },
                                        child: const CircleAvatar(
                                          radius: 30,
                                          backgroundColor: Colors.black54,
                                          child: Center(
                                            child: Icon(
                                              Icons.flip_camera_android,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(),
                      const Text(
                        'Permission denied',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          _getPermissionStatus();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Give permission',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
