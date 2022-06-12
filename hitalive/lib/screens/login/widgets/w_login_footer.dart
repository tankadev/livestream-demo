import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hitalive/configs/configs.dart';

import 'package:hitalive/blocs/blocs.dart';

class WLoginFooter extends StatelessWidget {
  const WLoginFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Bạn chưa có tài khoản,',
                  style: AppTextStyle.normalText,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      Routes.register,
                    );
                  },
                  child: Text(
                    'đăng ký ngay',
                    style: AppTextStyle.normalTextBoldPrimary,
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
