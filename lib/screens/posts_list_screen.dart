import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_flutter/blocs/post_bloc.dart';
import 'package:tp_flutter/screens/post_creation_screen.dart';
import 'package:tp_flutter/screens/post_detail_screen.dart';

import '../models/post.dart';

class PostsListScreen extends StatefulWidget {
  const PostsListScreen({super.key});

  @override
  State<PostsListScreen> createState() => _PostsListScreenState();
}

class _PostsListScreenState extends State<PostsListScreen> {
  @override
  void initState() {
    super.initState();
    _getAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostBloc, PostState>(
      listener: _onPostBlocListener,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Bienvenue!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color(0xFF003366),
          elevation: 0,
        ),
        body: Container(
          color: const Color(0xFFF5F5F5),
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<PostBloc, PostState>(
                  builder: (context, state) {
                    return switch (state.status) {
                      PostStatus.loading || PostStatus.initial =>
                          _buildLoading(context),
                      PostStatus.error =>
                          _buildError(context, state.errorMessage),
                      PostStatus.success => _buildSuccess(context, state.posts),
                    };
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF4A90E2),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const PostCreationScreen()),
          ),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Color(0xFF003366),
      ),
    );
  }

  Widget _buildError(BuildContext context, String? errorMessage) {
    return Center(
      child: Text(
        'Erreur : $errorMessage',
        style: const TextStyle(
          color: Colors.redAccent,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildSuccess(BuildContext context, List<Post> posts) {
    return RefreshIndicator(
      onRefresh: () async {
        _getAllPosts();
      },
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => PostDetailScreen(post: post)),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFCCCCCC),
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF003366),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    post.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _getAllPosts() {
    context.read<PostBloc>().add(GetAllPosts());
  }

  void _onPostBlocListener(BuildContext context, PostState state) {
    if (state.status == PostStatus.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur : ${state.errorMessage}'),
        ),
      );
    }
  }
}
