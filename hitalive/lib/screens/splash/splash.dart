import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:hitalive/configs/configs.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColor.white,
        width: 100.w,
        height: 100.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.appLogo,
              width: SizerUtil.deviceType == DeviceType.mobile ? 60.w : 300.0,
              height: SizerUtil.deviceType == DeviceType.mobile ? 60.w : 300.0,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 5.h,),
            const CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
