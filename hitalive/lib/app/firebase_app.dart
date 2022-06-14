import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hitalive/blocs/blocs.dart';
import 'package:hitalive/configs/configs.dart';
import 'package:hitalive/enums/enums.dart';

class FirebaseApp extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final Widget? child;

  const FirebaseApp({Key? key, required this.navigatorKey, this.child})
      : super(key: key);

  @override
  _FirebaseAppState createState() => _FirebaseAppState();
}

class _FirebaseAppState extends State<FirebaseApp> {
  late FirebaseMessaging _messaging;
  bool _initialized = false;

  NavigatorState get _navigator => widget.navigatorKey.currentState!;

  @override
  void initState() {
    super.initState();
    initFirebase();
    initDataForApp();
  }

  void initDataForApp() async {
  }

  Future<void> initFirebase() async {
    _messaging = FirebaseMessaging.instance;

    if (!_initialized) {
      // On iOS, this helps to take the user permissions
      NotificationSettings settings = await _messaging.requestPermission(
        alert: true,
        badge: true,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        _messaging.getToken().then((value) {
          print('tokenFcm: ${value}');
          if (value != null && value.isNotEmpty) {
            context.read<FirebaseBloc>().add(UpdateTokenFirebase(token: value));
          }
        });
        FirebaseMessaging.onMessage.listen((RemoteMessage event) async {
          print("message recieved");
          // Parse the message received
          print(event.notification!.title);
          print(event.notification!.body);
          print(event.data.values);
          context.read<AccountBloc>().add(const FetchUser());
        });
        FirebaseMessaging.onMessageOpenedApp.listen((message) {
          print('Message clicked!');
        });
        _initialized = true;
      } else {
        print('User declined or has not accepted permission');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == EAuthStatus.authenticated) {
          context.read<AccountBloc>().add(const FetchUser());
          context.read<FirebaseBloc>().add(const SaveTokenFirebase());
        }

        switch (state.status) {
          case EAuthStatus.authenticated:
            _navigator.pushNamedAndRemoveUntil<void>(
              Routes.privates,
              (route) => false,
            );
            break;
          case EAuthStatus.unauthenticated:
            _navigator.pushNamedAndRemoveUntil<void>(
              Routes.login,
              (route) => false,
            );
            break;
          default:
            break;
        }
      },
      child: widget.child,
    );
  }
}
