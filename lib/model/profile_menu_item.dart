import 'package:flutter/material.dart';

class ProfileMenuItem {
  final IconData icon;
  final String title;
  final String route;
  final int? argument;

  const ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.route,
    this.argument,
  });
}
