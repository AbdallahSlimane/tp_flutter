import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_flutter/blocs/post_bloc.dart';
import 'package:tp_flutter/datasource/fake_posts_data_source.dart';
import 'package:tp_flutter/repository/posts_repository.dart';
import 'package:tp_flutter/screens/posts_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final fakePostsDataSource = FakePostsDataSource();
    final postsRepository = PostsRepository(postsDataSource: fakePostsDataSource);

    return RepositoryProvider(
      create: (context) => postsRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
            PostBloc(context.read<PostsRepository>()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'bisou',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const PostsListScreen(),
        ),
      ),
    );
  }
}
