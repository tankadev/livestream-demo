import 'package:flutter/material.dart';

import 'package:hitalive/configs/configs.dart';

import 'model/bottom_navigation_bar_item.dart';

class BottomNavItem extends StatelessWidget {
  final BottomNavBarItem item;
  final int index;
  final int menuLength;
  final VoidCallback? onTap;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final double iconSize;
  final bool isActive;

  const BottomNavItem(
      {Key? key,
      required this.item,
      required this.index,
      required this.menuLength,
      this.onTap,
      this.selectedItemColor,
      this.unselectedItemColor,
      this.isActive = false,
      this.iconSize = 27.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: index == 0
            ? const BorderRadius.only(
                topLeft: Radius.circular(18.0),
                bottomLeft: Radius.circular(18.0),
              )
            : (index == menuLength - 1
                ? const BorderRadius.only(
                    topRight: Radius.circular(18.0),
                    bottomRight: Radius.circular(18.0),
                  )
                : BorderRadius.zero),
        child: Material(
          color: AppColor.white,
          child: InkWell(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 1.0),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      clipBehavior: Clip.none,
                      children: [
                        Icon(
                          item.icon,
                          color: isActive
                              ? selectedItemColor
                              : unselectedItemColor,
                          size: iconSize,
                        ),
                        item.showBadge && item.badgeNumber > 0
                            ? Positioned(
                                right: -6,
                                top: -6,
                                child: Container(
                                  padding: const EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 18,
                                    minHeight: 18,
                                  ),
                                  child: Center(
                                    child: Text(
                                      item.badgeNumber <= 99
                                          ? '${item.badgeNumber}'
                                          : '99+',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  Text(
                    item.label,
                    style: TextStyle(
                      fontSize: 12,
                      color: isActive ? selectedItemColor : unselectedItemColor,
                    ),
                  )
                ],
              ),
            ),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
