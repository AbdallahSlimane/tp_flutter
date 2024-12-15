import 'package:tp_flutter/datasource/posts_data_source.dart';
import 'package:tp_flutter/models/post.dart';

class PostsRepository {
  final PostsDataSource postsDataSource;

  PostsRepository({required this.postsDataSource});

  Future<List<Post>> getAllPosts() async {
    try {
      final posts = await postsDataSource.getAllPosts();
      return posts;
    } catch (error) {
      throw Exception('Erreur dans le repository lors de la récupération des posts : $error');
    }
  }

  Future<Post> createPost(Post post) async {
    try {
      final newPost = await postsDataSource.createPost(post);
      return newPost;
    } catch (error) {
      throw Exception('Erreur dans le repository lors de la création du post : $error');
    }
  }

  Future<Post> updatePost(Post updatedPost) async {
    try {
      final post = await postsDataSource.updatePost(updatedPost);
      return post;
    } catch (error) {
      throw Exception('Erreur dans le repository lors de la mise à jour du post : $error');
    }
  }
}
