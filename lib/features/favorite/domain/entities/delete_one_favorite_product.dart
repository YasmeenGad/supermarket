class DeleteOneFavoriteProduct {
  final String id;
  final List<String> products;
  final String user;
  final DateTime createdAt;
  final DateTime updatedAt;

  DeleteOneFavoriteProduct({
    required this.id,
    required this.products,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
  });
}
