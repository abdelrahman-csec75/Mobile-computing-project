import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/equipment.dart';

/// داتا تجريبية للعرض فقط. هتتبدل بـ Firestore لاحقاً.
class CatalogProvider extends ChangeNotifier {
  final List<Category> categories = const [
    Category(
      id: 'c1',
      name: 'Padel Rackets',
      icon: Icons.sports_tennis,
      image: 'assets/images/categories/c1.png',
    ),
    Category(
      id: 'c2',
      name: 'Balls',
      icon: Icons.sports_baseball,
      image: 'assets/images/categories/c2.png',
    ),
    Category(
      id: 'c3',
      name: 'Shoes',
      icon: Icons.directions_run,
      image: 'assets/images/categories/c3.png',
    ),
    Category(
      id: 'c4',
      name: 'Bags',
      icon: Icons.backpack,
      image: 'assets/images/categories/c4.png',
    ),
    Category(
      id: 'c5',
      name: 'Accessories',
      icon: Icons.watch,
      image: 'assets/images/categories/c5.png',
    ),
  ];

  final List<Equipment> equipment = const [
    Equipment(
      id: 'e1',
      name: 'Bullpadel Vertex 04',
      categoryId: 'c1',
      price: 220,
      availableQty: 6,
      barcode: '6221000000011',
      description:
          'Power-oriented racket with a diamond shape and a firm feel. Great for aggressive players.',
      image: 'assets/images/products/e1.png',
    ),
    Equipment(
      id: 'e2',
      name: 'Nox AT10 Luxury',
      categoryId: 'c1',
      price: 200,
      availableQty: 5,
      barcode: '6221000000012',
      description:
          'Balanced racket with a comfortable sweet spot, suitable for all-round play.',
      image: 'assets/images/products/e2.png',
    ),
    Equipment(
      id: 'e3',
      name: 'Adidas Metalbone 3.3',
      categoryId: 'c1',
      price: 240,
      availableQty: 4,
      barcode: '6221000000013',
      description: 'Lightweight racket built for speed and strong smashes.',
      image: 'assets/images/products/e3.png',
    ),
    Equipment(
      id: 'e4',
      name: 'Babolat Technical Viper',
      categoryId: 'c1',
      price: 210,
      availableQty: 3,
      barcode: '6221000000014',
      description:
          'Control-focused racket with a round head, ideal for defensive and technical play.',
      image: 'assets/images/products/e4.png',
    ),
    Equipment(
      id: 'e5',
      name: 'HEAD Delta Pro',
      categoryId: 'c1',
      price: 190,
      availableQty: 7,
      barcode: '6221000000015',
      description:
          'Easy-to-handle racket recommended for beginners and intermediate players.',
      image: 'assets/images/products/e5.png',
    ),
    Equipment(
      id: 'e6',
      name: 'Head Pro S Balls (3 pack)',
      categoryId: 'c2',
      price: 45,
      availableQty: 20,
      barcode: '6221000000021',
      description: 'Tube of three pressurized padel balls with consistent bounce.',
      image: 'assets/images/products/e6.png',
    ),
    Equipment(
      id: 'e7',
      name: 'Bullpadel Premium Pro Balls',
      categoryId: 'c2',
      price: 50,
      availableQty: 15,
      barcode: '6221000000022',
      description: 'Tournament-grade balls with a durable felt.',
      image: 'assets/images/products/e7.png',
    ),
    Equipment(
      id: 'e8',
      name: 'Dunlop Padel Balls',
      categoryId: 'c2',
      price: 40,
      availableQty: 25,
      barcode: '6221000000023',
      description: 'Reliable everyday balls for training and casual matches.',
      image: 'assets/images/products/e8.png',
    ),
    Equipment(
      id: 'e9',
      name: 'Adidas Adipower Shoes',
      categoryId: 'c3',
      price: 150,
      availableQty: 8,
      barcode: '6221000000031',
      description: 'Court shoes with a herringbone sole for grip and stability.',
      image: 'assets/images/products/e9.png',
    ),
    Equipment(
      id: 'e10',
      name: 'Asics Gel-Padel Pro',
      categoryId: 'c3',
      price: 140,
      availableQty: 6,
      barcode: '6221000000032',
      description: 'Cushioned shoes designed for quick lateral movement.',
      image: 'assets/images/products/e10.png',
    ),
    Equipment(
      id: 'e11',
      name: 'Bullpadel Paletero Bag',
      categoryId: 'c4',
      price: 90,
      availableQty: 5,
      barcode: '6221000000041',
      description:
          'Spacious bag that fits two rackets, shoes and accessories.',
      image: 'assets/images/products/e11.png',
    ),
    Equipment(
      id: 'e12',
      name: 'Nox Pro Racket Bag',
      categoryId: 'c4',
      price: 80,
      availableQty: 4,
      barcode: '6221000000042',
      description: 'Compact racket bag with a padded main compartment.',
      image: 'assets/images/products/e12.png',
    ),
    Equipment(
      id: 'e13',
      name: 'Overgrip Set (3 pcs)',
      categoryId: 'c5',
      price: 25,
      availableQty: 30,
      barcode: '6221000000051',
      description: 'Sweat-absorbing overgrips for a secure hold.',
      image: 'assets/images/products/e13.png',
    ),
    Equipment(
      id: 'e14',
      name: 'Wristbands Pair',
      categoryId: 'c5',
      price: 20,
      availableQty: 25,
      barcode: '6221000000052',
      description: 'Soft cotton wristbands to keep your hands dry.',
      image: 'assets/images/products/e14.png',
    ),
    Equipment(
      id: 'e15',
      name: 'Racket Protector Tape',
      categoryId: 'c5',
      price: 15,
      availableQty: 40,
      barcode: '6221000000053',
      description: 'Protective tape for the racket frame.',
      image: 'assets/images/products/e15.png',
    ),
  ];

  String _query = '';
  String get query => _query;

  void setQuery(String value) {
    _query = value;
    notifyListeners();
  }

  Category categoryOf(String id) =>
      categories.firstWhere((c) => c.id == id);

  List<Equipment> byCategory(String categoryId) =>
      equipment.where((e) => e.categoryId == categoryId).toList();

  List<Equipment> get results {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return [];
    return equipment.where((e) {
      return e.name.toLowerCase().contains(q) ||
          categoryOf(e.categoryId).name.toLowerCase().contains(q) ||
          e.barcode.contains(q);
    }).toList();
  }
}
