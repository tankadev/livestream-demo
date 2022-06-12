import 'package:flutter/material.dart';

import 'package:hitalive/configs/configs.dart';

class LiveScreen extends StatelessWidget {
  const LiveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: Center(
          child: Text('Live'),
        ),
      ),
    );
  }
}
