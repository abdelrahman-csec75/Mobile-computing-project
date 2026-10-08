import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';
import '../../providers/nav_provider.dart';
import '../../utils/app_theme.dart';
import '../../utils/formatters.dart';
import '../../widgets/cart_item_tile.dart';
import '../../widgets/empty_state.dart';

class CartTab extends StatelessWidget {
  const CartTab({super.key});

  Future<void> _submit(BuildContext context) async {
    final cart = context.read<CartProvider>();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm rental'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final i in cart.items)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  children: [
                    Expanded(child: Text('${i.qty} × ${i.equipment.name}')),
                    const SizedBox(width: 8),
                    Text(money(i.subtotal)),
                  ],
                ),
              ),
            const Divider(height: 24),
            Row(
              children: [
                const Expanded(
                  child: Text('Total',
                      style: TextStyle(fontWeight: FontWeight.w800)),
                ),
                Text(
                  money(cart.total),
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(minimumSize: const Size(0, 44)),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      cart.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Rental request submitted')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    if (cart.isEmpty) {
      return EmptyState(
        icon: Icons.shopping_bag_outlined,
        title: 'Your cart is empty',
        message: 'Add rackets, balls and more to start a rental.',
        actionLabel: 'Browse equipment',
        onAction: () => context.read<NavProvider>().setIndex(0),
      );
    }

    final items = cart.items;

    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (_, i) => CartItemTile(item: items[i]),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text('Items',
                        style: TextStyle(color: AppTheme.muted)),
                  ),
                  Text('${cart.totalQuantity}',
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Total rental cost',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.navy),
                    ),
                  ),
                  Text(
                    money(cart.total),
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.court),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              FilledButton(
                onPressed: () => _submit(context),
                child: const Text('Submit rental request'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
