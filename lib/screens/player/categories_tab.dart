import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/catalog_provider.dart';
import '../../widgets/category_chip.dart';
import 'product_list_screen.dart';

class CategoriesTab extends StatelessWidget {
  const CategoriesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final catalog = context.watch<CatalogProvider>();

    return GridView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: catalog.categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 1,
      ),
      itemBuilder: (_, i) {
        final c = catalog.categories[i];
        return CategoryTile(
          category: c,
          itemCount: catalog.byCategory(c.id).length,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ProductListScreen(category: c)),
          ),
        );
      },
    );
  }
}
