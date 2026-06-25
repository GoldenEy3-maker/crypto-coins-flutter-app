import "package:flutter/material.dart";
import "package:flutter_application_1/core/widgets/custom_error_widget/custom_error_widget.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../blocs/blocs.dart";
import "../widgets/widgets.dart";

class PostsListView extends StatefulWidget {
  const PostsListView({super.key});

  @override
  State<PostsListView> createState() => _PostsListViewState();
}

class _PostsListViewState extends State<PostsListView> {
  final _scrollController = ScrollController();

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<PostsBloc>().add(PostsFetchRequested());
    }
  }

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsBloc, PostsState>(
      builder: (context, state) {
        switch (state.status) {
          case .initial:
            return const Center(child: CircularProgressIndicator());
          case .failure:
            return CustomErrorWidget(
              error: state.error.toString(),
              onRetry: () {
                context.read<PostsBloc>().add(PostsFetchRequested());
              },
            );
          case .success:
            return CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: _scrollController,
              slivers: [
                SliverList.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: state.posts.length,
                  itemBuilder: (context, index) {
                    final post = state.posts[index];

                    return PostTile(post: post);
                  },
                ),
                if (!state.hasReachedMax)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: .symmetric(vertical: 16),
                      child: BottomLoader(),
                    ),
                  ),
              ],
            );
        }
      },
    );
  }
}
