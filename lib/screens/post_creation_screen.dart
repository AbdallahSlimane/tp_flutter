import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_flutter/screens/widget/input_text.dart';

import '../blocs/post_bloc.dart';
import '../models/post.dart';

class PostCreationScreen extends StatefulWidget {
  const PostCreationScreen({super.key});

  @override
  State<PostCreationScreen> createState() => _PostCreationScreenState();
}

class _PostCreationScreenState extends State<PostCreationScreen> {
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostBloc, PostState>(
      listener: _onPostBlocListener,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Créer un post',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
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
                label: 'Titre du post',
                hintText: 'Entrez le titre',
                maxLength: 50,
                onChanged: (value) {
                  title = value.trim();
                },
              ),
              const SizedBox(height: 16),
              InputText(
                label: 'Description',
                hintText: 'Entrez la description',
                maxLength: 144,
                maxLines: 4,
                onChanged: (value) {
                  description = value.trim();
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () => _createPost(context, title, description),
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
                    'Publier',
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

  void _createPost(BuildContext context, String title, String description) {
    if (title.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Les champs ne peuvent pas être vides')),
      );
      return;
    }

    final newPost = Post(
      id: '',
      title: title,
      description: description,
    );
    context.read<PostBloc>().add(CreatePost(newPost));
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
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Post créé avec succès'),
        ),
      );
    }
  }
}
