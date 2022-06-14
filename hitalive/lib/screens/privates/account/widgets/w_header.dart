import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hitalive/blocs/blocs.dart';
import 'package:hitalive/configs/configs.dart';
import 'package:hitalive/enums/enums.dart';

class WAccountHeader extends StatelessWidget {
  const WAccountHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 90.0,
                height: 90.0,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: AppColor.grey70,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
               '${state.user?.firstName} ${state.user?.lastName}',
                style: AppTextStyle.mediumText,
              ),
              const SizedBox(
                height: 2.0,
              ),
              Text(
                '${state.user?.email}',
                style: AppTextStyle.smallTextBlack,
              ),
              const SizedBox(
                height: 2.0,
              ),
              Text(
                 _renderText(state.user?.verifyStatus),
                style: AppTextStyle.smallTextBlack,
              ),
              const SizedBox(
                height: 2.0,
              ),
              Text(
                '${state.user?.address}',
                style: AppTextStyle.smallTextBlack,
              ),
            ],
          ),
        );
      },
    );
  }

  String _renderText(EAccountVerifyStatus? status) {
    String output = '';
    switch (status) {
      case EAccountVerifyStatus.pending:
        output = 'Chờ xác nhận';
        break;
      case EAccountVerifyStatus.rejected:
        output = 'Từ chối';
        break;
      case EAccountVerifyStatus.approved:
        output = 'Đã xác nhận';
        break;
      case EAccountVerifyStatus.init:
        output = 'Chưa xác nhận';
        break;
      default:
        output = 'Không xác định';
    }

    return output;
  }
}
