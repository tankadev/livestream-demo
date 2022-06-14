import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:video_stream/camera.dart';

import 'package:hitalive/configs/configs.dart';

import 'app/app.dart';
import 'app/bloc_observer.dart';

// Global variable for storing the list of available cameras
List<CameraDescription> cameras = [];

Future<void> _messageHandler(RemoteMessage message) async {
  print('background message ${message.notification!.body}');
}

void main() async {
  // init environment
  const String? environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: Environment.dev,
  );
  Environment().initConfig(environment);

  WidgetsFlutterBinding.ensureInitialized();

  // Get the available device cameras
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    debugPrint(e.toString());
  }

  Dio dio = Dio();
  FlutterSecureStorage storage = const FlutterSecureStorage();

  await Firebase.initializeApp();
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );
  FirebaseMessaging.onBackgroundMessage(_messageHandler);

  BlocOverrides.runZoned(
    () => runApp(ChtApp(dio: dio, storage: storage)),
    blocObserver: AppBlocObserver(),
  );
}
