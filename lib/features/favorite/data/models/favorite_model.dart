class FavoriteData {
  final List<String> products;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;

  const FavoriteData({
    required this.products,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FavoriteData.fromJson(Map<String, dynamic> json) {
    return FavoriteData(
      products: List<String>.from(json['products'] ?? []),
      id: json['_id'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'products': products,
      '_id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
