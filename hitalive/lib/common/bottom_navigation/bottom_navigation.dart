import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import 'package:hitalive/configs/configs.dart';

import 'bottom_navigation_item.dart';
import 'model/bottom_navigation_bar_item.dart';

class BottomNavBar extends StatelessWidget {
  final List<BottomNavBarItem> items;
  final ValueChanged<int>? onTap;
  final int currentIndex;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final double iconSize;

  const BottomNavBar(
      {Key? key,
      required this.items,
      this.onTap,
      this.currentIndex = 0,
      this.selectedItemColor = AppColor.primaryColor,
      this.unselectedItemColor = AppColor.grey,
      this.iconSize = 27.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.only(bottom: 16, left: 18, right: 18),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: const BorderRadius.all(Radius.circular(18)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items
            .mapIndexed((index, item) => BottomNavItem(
                  item: item,
                  index: index,
                  menuLength: items.length,
                  selectedItemColor: selectedItemColor,
                  unselectedItemColor: unselectedItemColor,
                  isActive: currentIndex == index,
                  onTap: () {
                    onTap?.call(index);
                  },
                ))
            .toList(),
      ),
    );
  }
}
