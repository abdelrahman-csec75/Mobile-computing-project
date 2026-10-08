import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../models/equipment.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, CartItem> _items = {};

  List<CartItem> get items => _items.values.toList();
  bool get isEmpty => _items.isEmpty;

  int get totalQuantity => _items.values.fold(0, (sum, i) => sum + i.qty);
  double get total => _items.values.fold(0.0, (sum, i) => sum + i.subtotal);

  int qtyOf(String equipmentId) => _items[equipmentId]?.qty ?? 0;

  int add(Equipment e, {int qty = 1}) {
    final allowed = math.min(qty, e.availableQty - qtyOf(e.id));
    if (allowed <= 0) return 0;
    final existing = _items[e.id];
    if (existing != null) {
      existing.qty += allowed;
    } else {
      _items[e.id] = CartItem(equipment: e, qty: allowed);
    }
    notifyListeners();
    return allowed;
  }

  void increment(String id) {
    final item = _items[id];
    if (item == null || item.qty >= item.equipment.availableQty) return;
    item.qty++;
    notifyListeners();
  }

  void decrement(String id) {
    final item = _items[id];
    if (item == null || item.qty <= 1) return;
    item.qty--;
    notifyListeners();
  }

  void remove(String id) {
    if (_items.remove(id) != null) notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
