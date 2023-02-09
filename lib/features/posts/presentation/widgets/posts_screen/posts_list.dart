import 'package:bloc_app_example/features/posts/domain/entities/post.dart';
import 'package:bloc_app_example/features/posts/presentation/blocs/posts/posts_bloc.dart';
import 'package:bloc_app_example/features/posts/presentation/widgets/posts_screen/post_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsList extends StatefulWidget {
  const PostsList({super.key, required this.posts, required this.canFetch});
  final List<PostEntity> posts;
  final bool canFetch;
  @override
  State<PostsList> createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  late ScrollController _controller;
  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_setListener);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.removeListener(_setListener);
    _controller.dispose();
  }

  void _setListener() async {
    if (_controller.position.maxScrollExtent == _controller.offset) {
      setState(() {
        context.read<PostsBloc>().add(GetPostsEvent(posts: widget.posts));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _controller,
      itemCount: widget.posts.length + 1,
      itemBuilder: (context, index) {
        return index < widget.posts.length
            ? PostTile(post: widget.posts[index])
            : widget.canFetch
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const SizedBox.shrink();
      },
    );
  }
}
