import 'package:flutter/material.dart';

class BottomNavBarItem {
  final IconData icon;
  final String label;
  final bool showBadge;
  final int badgeNumber;

  BottomNavBarItem(
      {required this.icon,
      required this.label,
      this.showBadge = false,
      this.badgeNumber = 0});
}
