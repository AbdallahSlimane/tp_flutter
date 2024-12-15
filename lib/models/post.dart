class Post {
  final String id;
  final String description;
  final String title;

  Post({required this.id, required this.description, required this.title});

  Post copyWith({
    String? id,
    String? title,
    String? description,
  }) {
    return Post(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description
    );
  }
}