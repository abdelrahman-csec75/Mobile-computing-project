import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/equipment.dart';
import '../../providers/cart_provider.dart';
import '../../providers/catalog_provider.dart';
import '../../utils/app_theme.dart';
import '../../utils/cart_feedback.dart';
import '../../utils/formatters.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/quantity_stepper.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Equipment equipment;

  const ProductDetailsScreen({super.key, required this.equipment});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _qty = 1;

  @override
  Widget build(BuildContext context) {
    final e = widget.equipment;
    final category = context.read<CatalogProvider>().categoryOf(e.categoryId);
    final inCart = context.watch<CartProvider>().qtyOf(e.id);
    final remaining = e.availableQty - inCart;
    final qty = remaining <= 0 ? 0 : math.min(_qty, remaining);

    return AppScaffold(
      title: 'Details',
      showBack: true,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                // الصورة بتملا العرض كله (من غير شرايط فاضية على الجنب)
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: AspectRatio(
                    aspectRatio: 1.1,
                    child: Image.asset(
                      e.image,
                      fit: BoxFit.cover,
                      cacheWidth: 1000,
                      errorBuilder: (context, error, stack) {
                        return Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFFE3ECF8),
                                Color(0xFFCFDDF0),
                              ],
                            ),
                          ),
                          child: Center(
                            child: Icon(category.icon,
                                size: 96, color: AppTheme.court),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        e.name,
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.navy),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      money(e.price),
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.court),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _InfoChip(icon: category.icon, label: category.name),
                    _InfoChip(
                      icon: Icons.inventory_2_outlined,
                      label: '${e.availableQty} available',
                    ),
                    _InfoChip(icon: Icons.qr_code, label: e.barcode),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Description',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.navy),
                ),
                const SizedBox(height: 6),
                Text(
                  e.description,
                  style: const TextStyle(color: AppTheme.muted, height: 1.5),
                ),
                if (inCart > 0) ...[
                  const SizedBox(height: 16),
                  Text(
                    '$inCart already in your cart',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, color: AppTheme.court),
                  ),
                ],
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Row(
              children: [
                QuantityStepper(
                  value: qty,
                  onMinus:
                      qty > 1 ? () => setState(() => _qty = qty - 1) : null,
                  onPlus: qty > 0 && qty < remaining
                      ? () => setState(() => _qty = qty + 1)
                      : null,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: FilledButton(
                    onPressed: remaining <= 0
                        ? null
                        : () {
                            addToCart(context, e, qty: qty);
                            setState(() => _qty = 1);
                          },
                    child: Text(
                      remaining <= 0
                          ? 'All units in cart'
                          : 'Add to cart · ${money(e.price * qty)}',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppTheme.court),
          const SizedBox(width: 6),
          Text(label,
              style: const TextStyle(fontSize: 12, color: AppTheme.navy)),
        ],
      ),
    );
  }
}