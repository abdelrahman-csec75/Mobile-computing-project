import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _birthCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  DateTime? _birthdate;
  String _role = 'player'; // player | owner

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _birthCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickBirthdate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _birthdate ?? DateTime(now.year - 18, now.month, now.day),
      firstDate: DateTime(1940),
      lastDate: now,
      helpText: 'Select your birthdate',
    );
    if (picked != null) {
      setState(() {
        _birthdate = picked;
        _birthCtrl.text = DateFormat('dd MMM yyyy').format(picked);
      });
    }
  }

  void _register() {
    if (!_formKey.currentState!.validate()) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Account created')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Create your account',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 6),
              Text(
                'Sign up to start renting padel equipment.',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
              ),
              const SizedBox(height: 24),
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(
                    value: 'player',
                    label: Text('Player'),
                    icon: Icon(Icons.sports_tennis),
                  ),
                  ButtonSegment(
                    value: 'owner',
                    label: Text('Facility owner'),
                    icon: Icon(Icons.storefront_outlined),
                  ),
                ],
                selected: {_role},
                onSelectionChanged: (s) => setState(() => _role = s.first),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _nameCtrl,
                label: 'Full name',
                icon: Icons.person_outline,
                textInputAction: TextInputAction.next,
                validator: (v) => (v == null || v.trim().length < 3)
                    ? 'Enter your full name'
                    : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _emailCtrl,
                label: 'Email',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: (v) {
                  final value = v?.trim() ?? '';
                  if (value.isEmpty) return 'Enter your email';
                  if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _birthCtrl,
                label: 'Birthdate',
                icon: Icons.cake_outlined,
                readOnly: true,
                onTap: _pickBirthdate,
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Select your birthdate' : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _passwordCtrl,
                label: 'Password',
                icon: Icons.lock_outline,
                isPassword: true,
                textInputAction: TextInputAction.next,
                validator: (v) => (v == null || v.length < 6)
                    ? 'Use at least 6 characters'
                    : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _confirmCtrl,
                label: 'Confirm password',
                icon: Icons.lock_outline,
                isPassword: true,
                textInputAction: TextInputAction.done,
                validator: (v) =>
                    v != _passwordCtrl.text ? 'Passwords do not match' : null,
              ),
              const SizedBox(height: 28),
              FilledButton(
                onPressed: _register,
                child: const Text('Create account'),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Log in'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
