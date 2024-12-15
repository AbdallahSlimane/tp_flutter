part of 'post_bloc.dart';

@immutable
sealed class PostEvent {
  const PostEvent();
}

final class GetAllPosts extends PostEvent {}

class CreatePost extends PostEvent {
  final Post post;

  const CreatePost(this.post);
}

class UpdatePost extends PostEvent {
  final Post updatedPost;

  const UpdatePost(this.updatedPost);
}


