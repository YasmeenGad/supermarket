class AddFavoriteDataModel {
  final List<String> products;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AddFavoriteDataModel({
    required this.products,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AddFavoriteDataModel.fromJson(Map<String, dynamic> json) {
    return AddFavoriteDataModel(
      products: List<String>.from(json['products'] ?? []),
      id: json['_id'] ?? 'unknown',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
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
