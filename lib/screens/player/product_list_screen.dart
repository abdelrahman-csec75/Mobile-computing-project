import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/category.dart';
import '../../providers/catalog_provider.dart';
import '../../utils/app_theme.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/equipment_card.dart';

class ProductListScreen extends StatelessWidget {
  final Category category;

  const ProductListScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final items = context.watch<CatalogProvider>().byCategory(category.id);

    return AppScaffold(
      title: category.name,
      showBack: true,
      body: items.isEmpty
          ? const EmptyState(
              icon: Icons.inventory_2_outlined,
              title: 'No equipment yet',
              message: 'Nothing is available in this category right now.',
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                  child: Text(
                    '${items.length} items available',
                    style: const TextStyle(color: AppTheme.muted),
                  ),
                ),
                Expanded(child: EquipmentGrid(items: items)),
              ],
            ),
    );
  }
}
