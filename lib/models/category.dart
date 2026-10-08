import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final IconData icon;

  /// Asset path to the category image, e.g. 'assets/images/categories/c1.png'.
  /// When non-null, UI may render this image instead of (or alongside) [icon].
  final String? image;

  const Category({
    required this.id,
    required this.name,
    required this.icon,
    this.image,
  });
}
