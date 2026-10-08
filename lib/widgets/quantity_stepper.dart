import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class QuantityStepper extends StatelessWidget {
  final int value;
  final VoidCallback? onMinus;
  final VoidCallback? onPlus;

  const QuantityStepper({
    super.key,
    required this.value,
    this.onMinus,
    this.onPlus,
  });

  Widget _button(IconData icon, VoidCallback? onTap) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon),
      iconSize: 18,
      color: AppTheme.navy,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints.tightFor(width: 36, height: 36),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.soft,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _button(Icons.remove, onMinus),
          SizedBox(
            width: 28,
            child: Center(
              child: Text(
                '$value',
                style: const TextStyle(
                    fontWeight: FontWeight.w700, color: AppTheme.navy),
              ),
            ),
          ),
          _button(Icons.add, onPlus),
        ],
      ),
    );
  }
}
