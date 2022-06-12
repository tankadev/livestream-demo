import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';

import 'package:hitalive/configs/configs.dart';

import 'app/app.dart';
import 'app/bloc_observer.dart';

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

  Dio dio = Dio();
  FlutterSecureStorage storage = const FlutterSecureStorage();

  await Firebase.initializeApp();
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  FirebaseMessaging.onBackgroundMessage(_messageHandler);

  BlocOverrides.runZoned(
    () => runApp(ChtApp(dio: dio, storage: storage)),
    blocObserver: AppBlocObserver(),
  );
}
