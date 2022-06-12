import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:hitalive/configs/configs.dart';

class WRegisterHeader extends StatelessWidget {
  const WRegisterHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          AppAssets.appBanner,
          width: SizerUtil.deviceType == DeviceType.mobile ? 50.w : 80.0,
          fit: BoxFit.cover,
        ),
        SizedBox(
          height: 2.h,
        ),
        const Text(
          'Đăng ký tài khoản mới',
          style: AppTextStyle.mediumText,
        )
      ],
    );
  }
}
