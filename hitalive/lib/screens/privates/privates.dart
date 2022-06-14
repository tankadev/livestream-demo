import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hitalive/screens/privates/account/account.dart';
import 'package:hitalive/screens/privates/live/live.dart';
import 'package:hitalive/common/common.dart';
import 'package:hitalive/blocs/blocs.dart';

class PrivatesScreen extends StatelessWidget {
  const PrivatesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> tabScreens = [
      const LiveScreen(),
      const AccountScreen(),
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const AWNoAppBar(),
      extendBody: true,
      endDrawerEnableOpenDragGesture: false,
      bottomNavigationBar: BlocBuilder<PrivatesNavBloc, PrivatesNavState>(
        builder: (context, state) {
          return BottomNavBar(
            items: <BottomNavBarItem>[
              BottomNavBarItem(icon: Icons.fiber_smart_record, label: 'Live'),
              BottomNavBarItem(
                  icon: CupertinoIcons.person_fill, label: 'Tài khoản')
            ],
            currentIndex: state.currentBottomBar,
            onTap: (int index) {
              context.read<PrivatesNavBloc>().add(
                    OnChangeHomeBottomBar(bottomBar: index),
                  );
            },
          );
        },
      ),
      body: BlocBuilder<PrivatesNavBloc, PrivatesNavState>(
          builder: (context, state) {
        return IndexedStack(
          index: state.currentBottomBar,
          children: tabScreens,
        );
      }),
    );
  }
}
