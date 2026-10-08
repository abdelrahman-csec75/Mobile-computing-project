import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/nav_provider.dart';
import '../utils/app_theme.dart';
import '../screens/auth/login_screen.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final bool showBack;

  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.showBack = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppNavBar(title: title, showBack: showBack),
      body: body,
      bottomNavigationBar: const AppBottomBar(),
    );
  }
}

class AppNavBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;

  const AppNavBar({super.key, required this.title, this.showBack = false});

  @override
  Size get preferredSize => const Size.fromHeight(64);

  Future<void> _logout(BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Log out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(minimumSize: const Size(0, 44)),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Log out'),
          ),
        ],
      ),
    );
    if (ok == true && context.mounted) {
      context.read<CartProvider>().clear();
      context.read<NavProvider>().setIndex(0);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 64,
      automaticallyImplyLeading: false,
      backgroundColor: AppTheme.court,
      foregroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      leadingWidth: 64,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Center(
          child: showBack
              ? Material(
                  color: AppTheme.ball,
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () => Navigator.pop(context),
                    child: const SizedBox(
                      width: 38,
                      height: 38,
                      child: Icon(Icons.chevron_left,
                          color: AppTheme.navy, size: 26),
                    ),
                  ),
                )
              : const CircleAvatar(
                  radius: 19,
                  backgroundColor: AppTheme.ball,
                  child: Icon(Icons.sports_tennis,
                      size: 20, color: AppTheme.courtDark),
                ),
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
      actions: [
        IconButton(
          tooltip: 'Log out',
          icon: const Icon(Icons.logout),
          onPressed: () => _logout(context),
        ),
        const SizedBox(width: 6),
      ],
    );
  }
}

class AppBottomBar extends StatelessWidget {
  const AppBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavProvider>();
    final count = context.watch<CartProvider>().totalQuantity;

    return NavigationBarTheme(
      data: NavigationBarThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        indicatorColor: AppTheme.ball,
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? AppTheme.navy
                : AppTheme.muted,
          ),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => TextStyle(
            fontSize: 12,
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w700
                : FontWeight.w500,
            color: states.contains(WidgetState.selected)
                ? AppTheme.navy
                : AppTheme.muted,
          ),
        ),
      ),
      child: NavigationBar(
        selectedIndex: nav.index,
        onDestinationSelected: (i) {
          nav.setIndex(i);
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          const NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view),
            label: 'Categories',
          ),
          const NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Badge(
              backgroundColor: AppTheme.court,
              isLabelVisible: count > 0,
              label: Text('$count'),
              child: const Icon(Icons.shopping_bag_outlined),
            ),
            selectedIcon: Badge(
              backgroundColor: AppTheme.court,
              isLabelVisible: count > 0,
              label: Text('$count'),
              child: const Icon(Icons.shopping_bag),
            ),
            label: 'Cart',
          ),
          const NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
