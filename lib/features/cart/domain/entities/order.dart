class Order {
  final String userId;
  final List<String> products;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;

  Order({
    required this.userId,
    required this.products,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });
}
