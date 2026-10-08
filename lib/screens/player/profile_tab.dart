import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';
import '../../providers/nav_provider.dart';
import '../../providers/user_provider.dart';
import '../../utils/app_theme.dart';
import '../auth/login_screen.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  Future<void> _editName(BuildContext context) async {
    final user = context.read<UserProvider>();
    final newName = await showDialog<String>(
      context: context,
      builder: (_) => _EditNameDialog(initial: user.user.name),
    );
    if (newName != null && context.mounted) {
      user.updateName(newName);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated')),
      );
    }
  }

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
    final user = context.watch<UserProvider>().user;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppTheme.court, AppTheme.courtDark],
            ),
          ),
          child: Column(
            children: [
              CircleAvatar(
                radius: 42,
                backgroundColor: AppTheme.ball,
                child: Text(
                  user.name.isEmpty ? '?' : user.name[0].toUpperCase(),
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.courtDark,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                user.name,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 2),
              Text(user.email,
                  style: const TextStyle(color: Colors.white70)),
              const SizedBox(height: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                decoration: BoxDecoration(
                  color: AppTheme.ball,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  user.role,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.navy),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              _InfoRow(
                  icon: Icons.person_outline,
                  label: 'Full name',
                  value: user.name),
              const Divider(height: 1, indent: 56),
              _InfoRow(
                  icon: Icons.email_outlined,
                  label: 'Email',
                  value: user.email),
              const Divider(height: 1, indent: 56),
              _InfoRow(
                icon: Icons.cake_outlined,
                label: 'Birthdate',
                value: DateFormat('dd MMM yyyy').format(user.birthdate),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
            foregroundColor: AppTheme.court,
            side: const BorderSide(color: AppTheme.court),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
          ),
          onPressed: () => _editName(context),
          icon: const Icon(Icons.edit_outlined),
          label: const Text('Edit profile'),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
            foregroundColor: Colors.redAccent,
            side: const BorderSide(color: Colors.redAccent),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
          ),
          onPressed: () => _logout(context),
          icon: const Icon(Icons.logout),
          label: const Text('Log out'),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.court),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        fontSize: 12, color: AppTheme.muted)),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, color: AppTheme.navy),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EditNameDialog extends StatefulWidget {
  final String initial;
  const _EditNameDialog({required this.initial});

  @override
  State<_EditNameDialog> createState() => _EditNameDialogState();
}

class _EditNameDialogState extends State<_EditNameDialog> {
  late final TextEditingController _ctrl =
      TextEditingController(text: widget.initial);
  String? _error;

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _save() {
    if (_ctrl.text.trim().length < 3) {
      setState(() => _error = 'Enter your full name');
      return;
    }
    Navigator.pop(context, _ctrl.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit profile'),
      content: TextField(
        controller: _ctrl,
        autofocus: true,
        decoration: InputDecoration(
          labelText: 'Full name',
          errorText: _error,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(minimumSize: const Size(0, 44)),
          onPressed: _save,
          child: const Text('Save'),
        ),
      ],
    );
  }
}
