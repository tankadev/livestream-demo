import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sizer/sizer.dart';

import 'package:hitalive/configs/configs.dart';
import 'package:hitalive/blocs/blocs.dart';
import 'package:hitalive/repositories/repositories.dart';
import 'package:hitalive/repositories/storage_repository.dart';
import 'package:hitalive/http/http.dart';
import 'package:hitalive/providers/providers.dart';

import 'firebase_app.dart';
import 'theme.dart';

class ChtApp extends StatefulWidget {
  final Dio dio;
  final FlutterSecureStorage storage;

  const ChtApp({Key? key, required this.dio, required this.storage})
      : super(key: key);

  @override
  State<ChtApp> createState() => _ChtAppState();
}

class _ChtAppState extends State<ChtApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<StorageRepository>(
          create: (context) => StorageRepository(widget.storage),
        ),
        RepositoryProvider<HttpClient>(
          create: (context) => HttpClient(
              dio: widget.dio,
              storage: RepositoryProvider.of<StorageRepository>(context)),
        ),
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(
            authProvider:
                AuthProvider(RepositoryProvider.of<HttpClient>(context)),
            storage: RepositoryProvider.of<StorageRepository>(context),
          ),
        ),
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(
              userProvider:
                  UserProvider(RepositoryProvider.of<HttpClient>(context))),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (BuildContext context) => AuthBloc(
                authRepository: RepositoryProvider.of<AuthRepository>(context)),
          ),
          BlocProvider<PrivatesNavBloc>(
            create: (BuildContext context) => PrivatesNavBloc(),
          ),
          BlocProvider<AccountBloc>(
            create: (BuildContext context) => AccountBloc(
                userRepository: RepositoryProvider.of<UserRepository>(context)),
          ),
          BlocProvider<FirebaseBloc>(
            create: (BuildContext context) => FirebaseBloc(
                userRepository: RepositoryProvider.of<UserRepository>(context)),
          ),
          BlocProvider<VerifyInfoBloc>(
            create: (BuildContext context) => VerifyInfoBloc(
                userRepository: RepositoryProvider.of<UserRepository>(context)),
          ),
        ],
        child: Sizer(builder: (context, orientation, deviceType) {
          return MaterialApp(
            theme: theme,
            navigatorKey: _navigatorKey,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: RouteGenerator.generateRoute,
            initialRoute: Routes.splash,
            builder: (context, child) {
              return FirebaseApp(
                navigatorKey: _navigatorKey,
                child: child,
              );
            },
          );
        }),
      ),
    );
  }
}
