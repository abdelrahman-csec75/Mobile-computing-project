import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/catalog_provider.dart';
import '../../providers/nav_provider.dart';
import '../../providers/user_provider.dart';
import '../../utils/app_theme.dart';
import '../../widgets/category_chip.dart';
import '../../widgets/equipment_card.dart';
import '../../widgets/search_bar_with_actions.dart';
import 'product_list_screen.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final catalog = context.watch<CatalogProvider>();
    final nav = context.read<NavProvider>();
    final firstName = context.watch<UserProvider>().firstName;
    final popular = catalog.equipment.take(6).toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      children: [
        RichText(
          text: TextSpan(
            style: const TextStyle(fontSize: 26, color: AppTheme.navy),
            children: [
              const TextSpan(
                  text: 'Hello ',
                  style: TextStyle(fontWeight: FontWeight.w300)),
              TextSpan(
                  text: '$firstName,',
                  style: const TextStyle(fontWeight: FontWeight.w800)),
            ],
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'What would you like to rent today?',
          style: TextStyle(color: AppTheme.muted),
        ),
        const SizedBox(height: 16),
        SearchBarWithActions(readOnly: true, onTap: () => nav.setIndex(2)),
        const SizedBox(height: 20),
        const _Banner(),
        const SizedBox(height: 24),
        _SectionHeader(
          title: 'Categories',
          action: 'See all',
          onAction: () => nav.setIndex(1),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 44,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: catalog.categories.length,
            separatorBuilder: (_, _) => const SizedBox(width: 10),
            itemBuilder: (_, i) {
              final c = catalog.categories[i];
              return CategoryChip(
                category: c,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductListScreen(category: c),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 24),
        const _SectionHeader(title: 'Popular equipment'),
        const SizedBox(height: 12),
        EquipmentGrid(
          items: popular,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
        ),
      ],
    );
  }
}

class _Banner extends StatelessWidget {
  const _Banner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppTheme.court, AppTheme.courtDark],
        ),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gear up for your\nnext match',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    height: 1.25,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Rent rackets, balls, shoes and more.',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          const CircleAvatar(
            radius: 30,
            backgroundColor: AppTheme.ball,
            child: Icon(Icons.sports_tennis,
                size: 30, color: AppTheme.courtDark),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String? action;
  final VoidCallback? onAction;

  const _SectionHeader({required this.title, this.action, this.onAction});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppTheme.navy),
          ),
        ),
        if (action != null)
          TextButton(onPressed: onAction, child: Text(action!)),
      ],
    );
  }
}
