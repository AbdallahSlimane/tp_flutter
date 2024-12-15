import 'package:tp_flutter/datasource/posts_data_source.dart';
import 'package:uuid/uuid.dart';

import '../models/post.dart';

class FakePostsDataSource extends PostsDataSource {
  final List<Post> _posts = [
    Post(id: '1', title: 'Mélissa', description: 'Merci Abdallah d\'exister'),
    Post(id: '2', title: 'Corentin', description: 'Merci Abdallah d\'exister'),
    Post(id: '3', title: 'Abdallah', description: 'Pas de soucis guys :)'),
  ];

  @override
  Future<Post> createPost(Post post) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final newPost = Post(
          id: const Uuid().v4(),
          description: post.description,
          title: post.title
      );
      _posts.add(newPost);
      return newPost;
    } catch (error) {
      throw Exception('Erreur lors de la création du post $error');
    }
  }

  @override
  Future<List<Post>> getAllPosts() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return _posts;
    } catch (error) {
      throw Exception('Erreur lors de la récupération des posts $error');
    }
  }

  @override
  Future<Post> updatePost(Post updatedPost) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final index = _posts.indexWhere((post) => post.id == updatedPost.id);
      if(index == -1) {
        throw Exception('Post non trouvé');
      }
      _posts[index] = updatedPost;
      return updatedPost;
    } catch (error) {
      throw Exception('Erreur lors de la mise à jour du post $error');
    }
  }
}
