import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/nav_provider.dart';
import '../../widgets/app_scaffold.dart';
import 'cart_tab.dart';
import 'categories_tab.dart';
import 'home_tab.dart';
import 'profile_tab.dart';
import 'search_tab.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key});

  static const _titles = ['Padel Rental', 'Categories', 'Search', 'My Cart', 'My Profile'];

  @override
  Widget build(BuildContext context) {
    final index = context.watch<NavProvider>().index;

    return AppScaffold(
      title: _titles[index],
      body: IndexedStack(
        index: index,
        children: const [
          HomeTab(),
          CategoriesTab(),
          SearchTab(),
          CartTab(),
          ProfileTab(),
        ],
      ),
    );
  }
}
