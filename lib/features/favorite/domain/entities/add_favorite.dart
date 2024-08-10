class AddFavorite {
  final String id;
  final List<String> products;
  final String user;
  final DateTime createdAt;
  final DateTime updatedAt;

  AddFavorite({
    required this.id,
    required this.products,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
  });
}
