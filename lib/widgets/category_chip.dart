import 'package:flutter/material.dart';
import '../models/category.dart';
import '../utils/app_theme.dart';

class CategoryChip extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;

  const CategoryChip({super.key, required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(category.icon, size: 18, color: AppTheme.court),
              const SizedBox(width: 8),
              Text(
                category.name,
                style: const TextStyle(
                    fontWeight: FontWeight.w600, color: AppTheme.navy),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final Category category;
  final int itemCount;
  final VoidCallback onTap;

  const CategoryTile({
    super.key,
    required this.category,
    required this.itemCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: AppTheme.soft,
              backgroundImage: category.image != null
                  ? AssetImage(category.image!)
                  : null,
              child: category.image == null
                  ? Icon(category.icon, size: 30, color: AppTheme.court)
                  : null,
            ),
            const SizedBox(height: 14),
            Text(
              category.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.w700, color: AppTheme.navy),
            ),
            const SizedBox(height: 2),
            Text(
              '$itemCount items',
              style: const TextStyle(fontSize: 12, color: AppTheme.muted),
            ),
          ],
        ),
      ),
    );
  }
}
