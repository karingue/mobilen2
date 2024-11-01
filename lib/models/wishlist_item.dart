class WishlistItem {
  String id;
  String title;
  String description;

  WishlistItem({
    required this.id,
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
    };
  }

  static WishlistItem fromMap(String id, Map<String, dynamic> map) {
    return WishlistItem(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
    );
  }
}
