import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hitalive/blocs/blocs.dart';
import 'package:hitalive/configs/configs.dart';

class WAccountFooter extends StatelessWidget {
  const WAccountFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 18.0,
      ),
      decoration: const BoxDecoration(
        color: AppColor.white,
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                context.read<AuthBloc>().add(
                      AuthLogoutRequested(),
                    );
              },
              child: Text(
                'ĐĂNG XUẤT',
                style: AppTextStyle.normalTextWhite,
              ),
            ),
          )
        ],
      ),
    );
  }
}
