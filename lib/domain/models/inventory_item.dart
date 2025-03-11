class InventoryItem {
  int? id;
  String name;
  String sku;
  String category;
  String subcategory;
  String brand;

  InventoryItem({
    this.id,
    required this.name,
    required this.sku,
    required this.category,
    required this.subcategory,
    required this.brand,
  });
  factory InventoryItem.empty() {
    return InventoryItem(
      id: null,
      name: '',
      sku: '',
      category: '',
      subcategory: '',
      brand: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sku': sku,
      'category': category,
      'subcategory': subcategory,
      'brand': brand,
    };
  }

  factory InventoryItem.fromJson(Map<String, dynamic> json) {
    return InventoryItem(
      id: json['id'],
      name: json['name'],
      sku: json['sku'],
      category: json['category'],
      subcategory: json['subcategory'],
      brand: json['brand'],
    );
  }
}
