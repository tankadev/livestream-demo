import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'package:hitalive/common/common.dart';
import 'package:hitalive/configs/configs.dart';
import 'package:hitalive/enums/enums.dart';
import 'package:hitalive/utilities/utilities.dart';
import 'package:hitalive/blocs/blocs.dart';

import 'widgets/w_form.dart';

class VerifyInfoScreen extends StatelessWidget {
  const VerifyInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: const AWCustomAppBar(
          title: '',
        ),
        body: SizedBox(
          height: 100.h,
          width: double.infinity,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 3.w),
                      child: BlocListener<VerifyInfoBloc, VerifyInfoState>(
                        listener: (context, state) {
                          if (state.status == EBlocStateStatus.inProgress) {
                            LoadingOverlay.of(context).show();
                          }

                          if (state.status == EBlocStateStatus.success ||
                              state.status == EBlocStateStatus.failure) {
                            LoadingOverlay.of(context).hide();
                          }

                          if (state.status == EBlocStateStatus.success) {
                            context.read<AccountBloc>().add(const FetchUser());
                            DialogUtil.showAlert(
                              context,
                              type: DialogAlertType.success,
                              title: 'Gửi thành công',
                              content:
                                  'Yêu cầu xác thực của bạn đã được gửi, vui lòng chờ duyệt',
                              btnConfirmText: 'OK',
                              onConfirm: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                            );
                          }

                          if (state.status == EBlocStateStatus.failure) {
                            DialogUtil.showAlert(
                              context,
                              type: DialogAlertType.error,
                              title: 'Thông báo',
                              content: state.errorCode,
                              btnConfirmText: 'OK',
                              onConfirm: () {
                                Navigator.pop(context);
                              },
                            );
                          }
                        },
                        child: WVerifyInfoForm(),
                      ),
                    ),
                    const SizedBox(
                      height: 100.0,
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.h),
                  color: AppColor.white,
                  child: SizedBox(
                    width: double.infinity,
                    child: Builder(builder: (contextRegister) {
                      return ElevatedButton(
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          contextRegister.read<VerifyInfoBloc>().add(
                                const VerifyInfoSubmitted(),
                              );
                        },
                        child: Text(
                          'GỬI YÊU CẦU',
                          style: AppTextStyle.normalTextWhite,
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
