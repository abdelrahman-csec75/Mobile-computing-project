import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/equipment.dart';
import '../providers/catalog_provider.dart';
import '../screens/player/product_details_screen.dart';
import '../utils/app_theme.dart';
import '../utils/cart_feedback.dart';
import '../utils/formatters.dart';

class EquipmentCard extends StatelessWidget {
  final Equipment equipment;

  const EquipmentCard({super.key, required this.equipment});

  @override
  Widget build(BuildContext context) {
    final category =
        context.read<CatalogProvider>().categoryOf(equipment.categoryId);

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(equipment: equipment),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    equipment.image,
                    fit: BoxFit.cover,
                    cacheWidth: 600,
                    errorBuilder: (context, error, stack) {
                      return Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFFE3ECF8), Color(0xFFCFDDF0)],
                          ),
                        ),
                        child: Center(
                          child: Icon(category.icon,
                              size: 54, color: AppTheme.court),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${equipment.availableQty} left',
                        style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.navy),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    equipment.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, color: AppTheme.navy),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    category.name,
                    style:
                        const TextStyle(fontSize: 12, color: AppTheme.muted),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          money(equipment.price),
                          style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              color: AppTheme.court),
                        ),
                      ),
                      InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () => addToCart(context, equipment),
                        child: Container(
                          width: 34,
                          height: 34,
                          decoration: const BoxDecoration(
                            color: AppTheme.ball,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.add,
                              size: 20, color: AppTheme.navy),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EquipmentGrid extends StatelessWidget {
  final List<Equipment> items;
  final bool shrinkWrap;
  final EdgeInsetsGeometry padding;

  const EquipmentGrid({
    super.key,
    required this.items,
    this.shrinkWrap = false,
    this.padding = const EdgeInsets.all(20),
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: shrinkWrap,
      physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
      padding: padding,
      itemCount: (items.length + 1) ~/ 2,
      separatorBuilder: (_, _) => const SizedBox(height: 14),
      itemBuilder: (_, row) {
        final first = row * 2;
        final second = first + 1;
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: EquipmentCard(equipment: items[first])),
              const SizedBox(width: 14),
              Expanded(
                child: second < items.length
                    ? EquipmentCard(equipment: items[second])
                    : const SizedBox(),
              ),
            ],
          ),
        );
      },
    );
  }
}