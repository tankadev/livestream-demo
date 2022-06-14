import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hitalive/blocs/blocs.dart';
import 'package:hitalive/configs/configs.dart';
import 'package:hitalive/enums/enums.dart';

class LiveScreen extends StatelessWidget {
  const LiveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: Center(
          child: BlocBuilder<AccountBloc, AccountState>(
            builder: (context, state) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onPressed: () {
                  if (state.user?.verifyStatus == EAccountVerifyStatus.init ||
                      state.user?.verifyStatus ==
                          EAccountVerifyStatus.rejected) {
                    Navigator.of(context).pushNamed(Routes.verifyInfo);
                  }

                  if (state.user?.verifyStatus == EAccountVerifyStatus.approved) {
                    Navigator.of(context).pushNamed(Routes.streaming);
                  }
                },
                child: state.status == EBlocStateStatus.inProgress
                    ? const SizedBox(
                        child: CircularProgressIndicator(color: AppColor.white,),
                        height: 20.0,
                        width: 20.0,
                      )
                    : Text(
                        state.user?.verifyStatus == EAccountVerifyStatus.pending
                            ? 'Chờ xác nhận'
                            : 'LIVE ngay',
                        style: AppTextStyle.normalTextWhite,
                      ),
              );
            },
          ),
        ),
      ),
    );
  }
}
