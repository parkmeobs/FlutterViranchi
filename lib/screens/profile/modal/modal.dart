import 'package:flutter/material.dart';

class ProfileSection {
  final String title;
  final List<ProfileItem> items;

  ProfileSection({
    required this.title,
    required this.items,
  });
}

class ProfileItem {
  final String name;
  final IconData icon;
  final VoidCallback? onTap;
  final Widget? trailing;

  ProfileItem({
    required this.name,
    required this.icon,
    this.onTap,
    this.trailing,
  });
}