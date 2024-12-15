import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_flutter/repository/posts_repository.dart';

import '../models/post.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostsRepository postsRepository;
  PostBloc(this.postsRepository) : super(const PostState()) {
    on<GetAllPosts>(_getAllPosts);
    on<CreatePost>(_createPost);
    on<UpdatePost>(_updatePost);
  }

  Future<void> _getAllPosts(GetAllPosts event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.loading));
    try {
      await _reloadPosts(emit);
    } catch (error) {
      emit(state.copyWith(status: PostStatus.error, errorMessage: 'Erreur : $error'));
    }
  }

  Future<void> _createPost(CreatePost event, Emitter<PostState> emit) async {
    if (event.post.title.isEmpty || event.post.description.isEmpty) {
      emit(state.copyWith(
        status: PostStatus.error,
        errorMessage: 'Le titre et la description ne peuvent pas être vides',
      ));
      return;
    }

    emit(state.copyWith(status: PostStatus.loading));
    try {
      await postsRepository.createPost(event.post);
      await _reloadPosts(emit);
    } catch (error) {
      emit(state.copyWith(status: PostStatus.error, errorMessage: 'Erreur : $error'));
    }
  }

  Future<void> _updatePost(UpdatePost event, Emitter<PostState> emit) async {
    if (event.updatedPost.title.isEmpty || event.updatedPost.description.isEmpty) {
      emit(state.copyWith(
        status: PostStatus.error,
        errorMessage: 'Le titre et la description ne peuvent pas être vides',
      ));
      return;
    }

    emit(state.copyWith(status: PostStatus.loading));
    try {
      await postsRepository.updatePost(event.updatedPost);
      await _reloadPosts(emit);
    } catch (error) {
      emit(state.copyWith(status: PostStatus.error, errorMessage: 'Erreur : $error'));
    }
  }

  Future<void> _reloadPosts(Emitter<PostState> emit) async {
    try {
      final posts = await postsRepository.getAllPosts();
      emit(state.copyWith(status: PostStatus.success, posts: posts));
    } catch (e) {
      emit(state.copyWith(status: PostStatus.error, errorMessage: 'Erreur : $e'));
    }
  }

}
