import '../models/post.dart';

abstract class PostsDataSource {
    Future<List<Post>> getAllPosts();
    Future<Post> createPost(Post post);
    Future<Post> updatePost(Post updatedPost);
}