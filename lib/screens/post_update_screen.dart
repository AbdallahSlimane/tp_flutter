import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_flutter/screens/posts_list_screen.dart';
import 'package:tp_flutter/screens/widget/input_text.dart';

import '../blocs/post_bloc.dart';
import '../models/post.dart';

class PostUpdateScreen extends StatefulWidget {
  const PostUpdateScreen({super.key, required this.post});

  final Post post;

  @override
  State<PostUpdateScreen> createState() => _PostUpdateScreenState();
}

class _PostUpdateScreenState extends State<PostUpdateScreen> {
  late String title;
  late String description;

  @override
  void initState() {
    super.initState();
    title = widget.post.title;
    description = widget.post.description;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostBloc, PostState>(
      listener: _onPostBlocListener,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Modifier "${widget.post.title}"',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color(0xFF003366),
          elevation: 0,
        ),
        body: Container(
          color: const Color(0xFFF5F5F5),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputText(
                label: 'Titre du post à modifier',
                hintText: 'Modifier le titre',
                maxLines: 1,
                maxLength: 50,
                initialValue: widget.post.title,
                onChanged: (value) {
                  title = value.trim();
                },
              ),
              const SizedBox(height: 16),
              InputText(
                label: 'Description du post à modifier',
                hintText: 'Modifier la description',
                maxLines: 4,
                maxLength: 144,
                initialValue: widget.post.description,
                onChanged: (value) {
                  description = value.trim();
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _updatePost(context);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PostsListScreen(),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A90E2),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 12.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Modifier',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updatePost(BuildContext context) {
    if (title.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Les champs ne peuvent pas être vides')),
      );
      return;
    }
    final updatedPost = widget.post.copyWith(
      title: title,
      description: description,
    );

    context.read<PostBloc>().add(UpdatePost(updatedPost));
  }

  void _onPostBlocListener(BuildContext context, PostState state) {
    if (state.status == PostStatus.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur : ${state.errorMessage}'),
        ),
      );
    }
    if (state.status == PostStatus.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Post modifié avec succès'),
        ),
      );
    }
  }
}
