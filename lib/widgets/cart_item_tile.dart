import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_item.dart';
import '../providers/cart_provider.dart';
import '../providers/catalog_provider.dart';
import '../utils/app_theme.dart';
import '../utils/formatters.dart';
import 'quantity_stepper.dart';

class CartItemTile extends StatelessWidget {
  final CartItem item;

  const CartItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartProvider>();
    final e = item.equipment;
    final category = context.read<CatalogProvider>().categoryOf(e.categoryId);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppTheme.soft,
              borderRadius: BorderRadius.circular(16),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.asset(
              e.image,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stack) {
                return Center(
                  child: Icon(category.icon, size: 32, color: AppTheme.court),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  e.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, color: AppTheme.navy),
                ),
                const SizedBox(height: 2),
                Text(
                  '${money(e.price)} each',
                  style: const TextStyle(fontSize: 12, color: AppTheme.muted),
                ),
                const SizedBox(height: 8),
                QuantityStepper(
                  value: item.qty,
                  onMinus:
                      item.qty > 1 ? () => cart.decrement(e.id) : null,
                  onPlus: item.qty < e.availableQty
                      ? () => cart.increment(e.id)
                      : null,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                tooltip: 'Remove',
                onPressed: () => cart.remove(e.id),
                icon: const Icon(Icons.delete_outline),
                color: Colors.redAccent,
                constraints:
                    const BoxConstraints.tightFor(width: 36, height: 36),
                padding: EdgeInsets.zero,
              ),
              const SizedBox(height: 24),
              Text(
                money(item.subtotal),
                style: const TextStyle(
                    fontWeight: FontWeight.w800, color: AppTheme.court),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
