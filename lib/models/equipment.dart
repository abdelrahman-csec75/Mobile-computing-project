class Equipment {
  final String id;
  final String name;
  final String categoryId;
  final double price;
  final int availableQty;
  final String barcode;
  final String description;

  /// Asset path to the product image, e.g. 'assets/images/products/e1.png'.
  /// Falls back to the category icon when null/missing on disk.
  final String image;

  const Equipment({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.price,
    required this.availableQty,
    required this.barcode,
    required this.description,
    required this.image,
  });
}
