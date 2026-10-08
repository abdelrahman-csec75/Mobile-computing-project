import 'equipment.dart';

class CartItem {
  final Equipment equipment;
  int qty;

  CartItem({required this.equipment, this.qty = 1});

  double get subtotal => equipment.price * qty;
}
