import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/catalog_provider.dart';
import '../../utils/app_theme.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/equipment_card.dart';
import '../../widgets/search_bar_with_actions.dart';
import '../../widgets/voice_search_sheet.dart';
import 'barcode_scanner_screen.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _apply(String value) {
    _controller.text = value;
    _controller.selection = TextSelection.collapsed(offset: value.length);
    context.read<CatalogProvider>().setQuery(value);
  }

  Future<void> _voice() async {
    final text = await showVoiceSearchSheet(context);
    if (text != null && mounted) _apply(text);
  }

  Future<void> _scan() async {
    final code = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => const BarcodeScannerScreen()),
    );
    if (code != null && mounted) _apply(code);
  }

  @override
  Widget build(BuildContext context) {
    final catalog = context.watch<CatalogProvider>();
    final results = catalog.results;

    Widget content;
    if (catalog.query.trim().isEmpty) {
      content = Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Try searching for',
              style: TextStyle(
                  fontWeight: FontWeight.w800, color: AppTheme.navy),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final s in ['Racket', 'Balls', 'Shoes', 'Bag', 'Overgrip'])
                  ActionChip(
                    label: Text(s),
                    backgroundColor: Colors.white,
                    side: BorderSide.none,
                    onPressed: () => _apply(s),
                  ),
              ],
            ),
            const Spacer(),
            const Center(
              child: Text(
                'Search by text, voice or barcode',
                style: TextStyle(color: AppTheme.muted),
              ),
            ),
            const Spacer(),
          ],
        ),
      );
    } else if (results.isEmpty) {
      content = const EmptyState(
        icon: Icons.search_off,
        title: 'No results found',
        message: 'Try a different name, or scan the barcode.',
      );
    } else {
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
            child: Text(
              '${results.length} result${results.length == 1 ? '' : 's'}',
              style: const TextStyle(color: AppTheme.muted),
            ),
          ),
          Expanded(child: EquipmentGrid(items: results)),
        ],
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
          child: SearchBarWithActions(
            controller: _controller,
            onChanged: catalog.setQuery,
            onMic: _voice,
            onBarcode: _scan,
          ),
        ),
        Expanded(child: content),
      ],
    );
  }
}
