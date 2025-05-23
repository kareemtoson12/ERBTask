class InventoryItem {
  int? id;
  String name;
  String sku;
  String category;
  String subcategory;
  String brand;
  bool isActive;

  InventoryItem({
    this.id,
    required this.name,
    required this.sku,
    required this.category,
    required this.subcategory,
    required this.brand,
    this.isActive = true,
  });

  factory InventoryItem.empty() {
    return InventoryItem(
      id: null,
      name: '',
      sku: '',
      category: '',
      subcategory: '',
      brand: '',
      isActive: true,
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
      'isActive': isActive,
    };
  }

  InventoryItem copyWith({
    int? id,
    String? name,
    String? sku,
    String? category,
    String? subcategory,
    String? brand,
    bool? isActive,
  }) {
    return InventoryItem(
      id: id ?? this.id,
      name: name ?? this.name,
      sku: sku ?? this.sku,
      category: category ?? this.category,
      subcategory: subcategory ?? this.subcategory,
      brand: brand ?? this.brand,
      isActive: isActive ?? this.isActive,
    );
  }

  factory InventoryItem.fromJson(Map<String, dynamic> json) {
    return InventoryItem(
      id: json['id'],
      name: json['name'],
      sku: json['sku'],
      category: json['category'],
      subcategory: json['subcategory'],
      brand: json['brand'],
      isActive: (json['isActive'] ?? 1) == 1,
    );
  }
}
