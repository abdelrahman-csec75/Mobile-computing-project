import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/equipment.dart';
import '../providers/cart_provider.dart';

void addToCart(BuildContext context, Equipment e, {int qty = 1}) {
  final added = context.read<CartProvider>().add(e, qty: qty);
  final messenger = ScaffoldMessenger.of(context);
  messenger.hideCurrentSnackBar();
  messenger.showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 1500),
      content: Text(added > 0
          ? 'Added $added × ${e.name} to cart'
          : 'No more units available for ${e.name}'),
    ),
  );
}
