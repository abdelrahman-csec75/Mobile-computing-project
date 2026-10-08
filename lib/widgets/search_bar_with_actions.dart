import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class SearchBarWithActions extends StatefulWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onMic;
  final VoidCallback? onBarcode;
  final VoidCallback? onTap;
  final bool readOnly;

  const SearchBarWithActions({
    super.key,
    this.controller,
    this.onChanged,
    this.onMic,
    this.onBarcode,
    this.onTap,
    this.readOnly = false,
  });

  @override
  State<SearchBarWithActions> createState() => _SearchBarWithActionsState();
}

class _SearchBarWithActionsState extends State<SearchBarWithActions> {
  late final TextEditingController _c;
  late final bool _owns;

  @override
  void initState() {
    super.initState();
    _owns = widget.controller == null;
    _c = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (_owns) _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE3EAF3)),
      ),
      child: ListenableBuilder(
        listenable: _c,
        builder: (context, _) => Row(
          children: [
            const Icon(Icons.search, color: AppTheme.muted),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: _c,
                readOnly: widget.readOnly,
                onTap: widget.onTap,
                onChanged: widget.onChanged,
                textInputAction: TextInputAction.search,
                cursorColor: AppTheme.court,
                decoration: const InputDecoration(
                  hintText: 'Search rackets, balls, shoes...',
                  hintStyle: TextStyle(color: AppTheme.muted),
                  filled: false,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            if (_c.text.isNotEmpty && !widget.readOnly)
              IconButton(
                icon: const Icon(Icons.close, size: 20),
                color: AppTheme.muted,
                onPressed: () {
                  _c.clear();
                  widget.onChanged?.call('');
                },
              ),
            IconButton(
              tooltip: 'Voice search',
              icon: const Icon(Icons.mic_none),
              color: AppTheme.court,
              onPressed: widget.onMic ?? widget.onTap,
            ),
            IconButton(
              tooltip: 'Scan barcode',
              icon: const Icon(Icons.qr_code_scanner),
              color: AppTheme.court,
              onPressed: widget.onBarcode ?? widget.onTap,
            ),
          ],
        ),
      ),
    );
  }
}
